package com.chat.service;

import java.util.List;

import com.chat.model.ChatMessageVO;
import com.chat.model.ChatRoomVO;
import com.user.model.UserVO;

public interface ChatService {
	
	// 채팅방 생성
	int insertChatRoom(ChatRoomVO room);
	
	// 특정 방 번호에 해당하는 채팅방 찾기
	ChatRoomVO findChatRoom(int roomId);
	
	int insertMessage(ChatMessageVO chat);		// 채팅 메시지 넣기
	List<ChatMessageVO> selectMessage(int roomId);	// 특정 방 번호에 해당하는 채팅 내역 가져오기
	
	// 이용자 닉네임 가져오기
	String selectNick(int uno);		// uno로 이용자 닉네임 가져오기??
	
	// 시터, 이용자가 이전에 한 채팅방이 있는지 확인
	int chatCheck(String sender_nick, String nick2);
	
	// 시터, 이용자의 채팅방번호 가져오기 ??
	Integer findRoomId(String sender_nick, String nick2);
	
	// 유저 닉네임으로 해당 채팅방리스트 가져오기
	List<ChatRoomVO> roomList(String user_nickname);
	List<ChatRoomVO> roomList2(String nick2);
	
	// 닉네임 검색해서 유저 찾기
	List<UserVO> findUser(ChatRoomVO croom);
	
	// 룸 아이디로 채팅상대 닉네임 가져오기
	String selectNick2(int roomId);

}
