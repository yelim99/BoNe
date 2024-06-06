package com.user.service;


import com.user.model.NotUserException;
import com.user.model.UserVO;

/* 회원가입 관련 서비스 */ 
public interface UserService {
	
	int createUser(UserVO user);
	
	int createUserS(UserVO user);

	boolean idCheck(String mid);
	
	UserVO loginCheck(String mid, String pwd) throws NotUserException;

	boolean nickCheck(String nickname);
	
	UserVO findUser(UserVO findUser) throws NotUserException;

	UserVO getUserByKakao(String kakao);

	String getIdByEmail(String searchEmail);

	void sendEmail(UserVO user, String email);

	UserVO getUserByEmail(String searchEmail);
	
}
