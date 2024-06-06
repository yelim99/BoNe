package com.chat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chat.mapper.ChatMapper;
import com.chat.model.ChatMessageVO;
import com.chat.model.ChatRoomVO;
import com.user.model.UserVO;

@Service("ChatService")
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	private ChatMapper chatMapper;

	@Override
	public int insertChatRoom(ChatRoomVO room) {
		
		return this.chatMapper.insertChatRoom(room);
	}

	@Override
	public ChatRoomVO findChatRoom(int roomId) {
	
		return this.chatMapper.findChatRoom(roomId);
	}

	@Override
	public int insertMessage(ChatMessageVO chat) {
		
		return this.chatMapper.insertMessage(chat);
	}

	@Override
	public List<ChatMessageVO> selectMessage(int roomId) {

		return this.chatMapper.selectMessage(roomId);
	}

	@Override
	public String selectNick(int uno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int chatCheck(String sender_nick, String nick2) {
		
		return this.chatMapper.chatCheck(sender_nick, nick2);
	}

	@Override
	public Integer findRoomId(String sender_nick, String nick2) {
		
		return this.chatMapper.findRoomId(sender_nick, nick2);
	}

	@Override
	public List<ChatRoomVO> roomList(String user_nickname) {
		
		return this.chatMapper.roomList(user_nickname);
	}

	@Override
	public List<UserVO> findUser(ChatRoomVO croom) {
		
		return this.chatMapper.findUser(croom);
	}

	@Override
	public String selectNick2(int roomId) {
		
		return this.chatMapper.selectNick2(roomId);
	}

	@Override
	public List<ChatRoomVO> roomList2(String nick2) {

		return this.chatMapper.roomList2(nick2);
	}

}
