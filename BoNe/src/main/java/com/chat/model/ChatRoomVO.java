package com.chat.model;

import java.util.HashMap;

import lombok.Data;

@Data
public class ChatRoomVO {
	
	private int roomId;		// 방 번호
	private String roomName;	// 방 이름
	private String nickname;	// 유저 닉네임
	private String nick2;		// 상대 유저 닉네임
	
	private String findNick;	// 검색할 유저 닉네임
	
	
	private HashMap<String, String> userList = new HashMap<>();
	
	public ChatRoomVO create(String roomName) {
		ChatRoomVO chatRoom = new ChatRoomVO();
		chatRoom.roomId = roomId;
		chatRoom.roomName = roomName;
		
		return chatRoom;
	}
	
}
