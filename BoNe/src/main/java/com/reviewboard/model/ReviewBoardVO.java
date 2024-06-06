package com.reviewboard.model;

import java.sql.Date;
import lombok.Data;

@Data
public class ReviewBoardVO {
	
	private String mode;
	//글쓰기: write, 답변글쓰기: rewrite, 글수정:edit
	
	private int rno; // 리뷰 번호 
	private int ino; // 소개글 번호 ()
	private String nickname; // 펫주인 닉네임 ()
	private Date wdate; // 작성일
	
	private String title; // 제목
	private String content; // 내용
	
	private String rfile;// 물리적 파일명 uuid_파일명
	private String star; // 별점
	
	private String originFilename;//원본 파일명
	private long filesize;
	private String old_filename;//예전에 첨부한 파일명 -글수정시 필요
	
	private String st_nickname;

}
