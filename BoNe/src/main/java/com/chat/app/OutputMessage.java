package com.chat.app;

import java.util.List;

import com.chat.model.ChatMessageVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OutputMessage {
	
	String from;
	String text;
	String time;
	List<ChatMessageVO> cHistory;

	
//	int roomId;
//	String sender_nick;
//	String message;
//	Date mdate;
//	String nick2;
	

}
