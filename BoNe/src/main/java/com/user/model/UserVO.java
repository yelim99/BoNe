package com.user.model;

import lombok.Data;

@Data
public class UserVO {
	
	
	private String mid;
	private String nickname;
	private String pwd; 
	private String email;
	private String uname;
	
	
	private String tel1;
	private String tel2;
	private String tel3;
	
	private String birthday;
	private String addr1;
	private String addr2;
	private String addr3;
	
	private String slicense;
	private String lfile;
	private int idx;
	private String post;
	
	private String experience;
	private String ucheck;

	private String kakao;
	
	public UserVO() {
		
	}
	
	public String getAllTel() {
		return tel1+"-"+tel2+"-"+tel3;
	}
	
	public String getAllAddr() {
		return addr1+" "+addr2;
	}

}	/////////////////////////////////
