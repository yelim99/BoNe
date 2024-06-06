package com.sitter.model;

import java.util.Date;

import lombok.Data;

@Data
public class SitterVO {
	
	private String title;
	private String short_content;
	private String addr;	
	private String tag;
	private String service;
	private String content;
	private String ifile;
	private String nickname;
	private String unickname;
	private String snickname;
	private String pname;
	private Date sdate;
	private Date fdate;
	private int uno;
	private int pno;
	private int ino;

}