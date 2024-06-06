package com.chat.app;



import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.chat.model.ChatMessageVO;
import com.chat.model.ChatRoomVO;
import com.chat.service.ChatService;
import com.user.model.UserVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ChatController {
	
	@Autowired
	private SimpMessagingTemplate simpMessage;
	
	@Autowired
	private ChatService cService;

	
	@GetMapping("/room")
	public String RoomList(Model m, HttpSession session,
							@ModelAttribute("chatRoom") ChatRoomVO chatRoom) {
		
		UserVO user = (UserVO) session.getAttribute("loginUser");
		String loginNick = user.getNickname();
		
		chatRoom.setNickname(loginNick);

		List<ChatRoomVO> croomList = cService.roomList(loginNick);
		List<ChatRoomVO> croomList2 = cService.roomList2(loginNick);
		
		m.addAttribute("croom", chatRoom);
		m.addAttribute("croomList", croomList);
		m.addAttribute("croomList2", croomList2);
		
		return "chat/room";
	}
	
	@GetMapping("/room/find")
	public String findRoom(Model m, HttpSession session,
							@ModelAttribute("chatRoom") ChatRoomVO chatRoom,
							@RequestParam(name="findNick") String findNick) {
		
		log.info("nick: "+findNick);
		
		chatRoom.setFindNick(findNick);
		
		List<UserVO> userList = cService.findUser(chatRoom);
		
		log.info("userList: "+userList);
		
		m.addAttribute("nick", findNick);
		m.addAttribute("userList", userList);
		
		UserVO user = (UserVO) session.getAttribute("loginUser");
		String loginNick = user.getNickname();
		
		chatRoom.setNickname(loginNick);
		m.addAttribute("croom", chatRoom);
		
		return "chat/roomFind";
	}
	
	@GetMapping("/chat")
	public String Chatting(Model m, HttpSession session, 
							@RequestParam String nickname) {
		
		UserVO user = (UserVO) session.getAttribute("loginUser");
		String loginNick = user.getNickname();
		
		
		ChatMessageVO cmessage = new ChatMessageVO();
		
		cmessage.setSender_nick(loginNick);
		cmessage.setNick2(nickname);
		
		m.addAttribute("loginNick", loginNick);
		m.addAttribute("cmessage", cmessage);
		
		int roomId;
		
		ChatRoomVO chatRoom = new ChatRoomVO();
		chatRoom.setNickname(loginNick);
		chatRoom.setNick2(nickname);
		
		if (cService.chatCheck(loginNick, nickname) > 0) {
			roomId = cService.findRoomId(loginNick, nickname);
			List<ChatMessageVO> cHistory = cService.selectMessage(roomId);
			m.addAttribute("cHistory", cHistory);
			m.addAttribute("roomId", roomId);
			
			return "chat/chatting";
			
		} 
		else if (cService.chatCheck(nickname, loginNick) > 0) {
			roomId = cService.findRoomId(nickname, loginNick);
			List<ChatMessageVO> cHistory = cService.selectMessage(roomId);
			m.addAttribute("cHistory", cHistory);
			m.addAttribute("roomId", roomId);
			
			return "chat/chatting";
		}
		else {
			int n = cService.insertChatRoom(chatRoom);
			
			String str = (n>0)? "채팅방 생성 - 채팅방으로 이동합니다.":"채팅방 생성 실패";
			String loc = (n>0)? "room":"javascript:history.back()";
			
			m.addAttribute("msg", str);
			m.addAttribute("loc", loc);
			
			return "message";
		}
		
		
	}

	@MessageMapping("/chat/{roomId}")
	@SendTo("/topic/rooms/{roomId}")
	public OutputMessage chat(@DestinationVariable int roomId, ChatMessageVO cmessage) throws Exception {
		
		List<ChatMessageVO> cHistory = cService.selectMessage(roomId);
		
		System.out.println("cHistory: "+cHistory);
		
		String time = new SimpleDateFormat("YYYY-MM-dd HH:mm").format(new Date());
		cService.insertMessage(cmessage);
		System.out.println("roomId: "+cmessage.getRoomId()+" / message: "+cmessage.getMessage());
		System.out.println(cmessage.getSender_nick()+" / "+time);
		
		return new OutputMessage(cmessage.getSender_nick(), cmessage.getMessage(), time, cHistory);
		
	}
	
	
}
