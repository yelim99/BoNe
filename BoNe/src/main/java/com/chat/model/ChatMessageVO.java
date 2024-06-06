package com.chat.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatMessageVO {

	private int roomId;				// 방 번호
	private String message;			// 메시지
	private Date mdate;				// 메시지 보낸 날짜
//	private int read_check;			// 메시지 읽었는지 체크 (0, 1)
//	private int sessionCount;
	private String sender_nick;		// 메시지 보낸 사람

	private String nick2;
	private int mno;

}


