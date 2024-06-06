package com.reviewboard.model;

import java.sql.Date;
import lombok.Data;

@Data
public class ReplyVO {
	
	private int rrno; // 댓글 번호 
	private int rno; // 리뷰 번호 
	private String nickname; // 댓글 쓴 사람 닉네임
	private String content; // 댓글 내용
	private Date wdate; // 댓글 작성일
	
}
