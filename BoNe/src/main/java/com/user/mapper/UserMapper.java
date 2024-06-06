package com.user.mapper;

import java.util.List;

import com.user.model.NotUserException;
import com.user.model.UserModelVO;
import com.user.model.UserVO;

public interface UserMapper {

	int createUser(UserVO user);

	int createUserS(UserVO user);

	Integer idCheck(String mid);
	
	Integer nickCheck(String nickname);

	UserVO loginCheck(String mid, String pwd) throws NotUserException;

	UserVO getUser(int idx);

	UserVO findUser(UserVO user);

	UserVO getUserByKakao(String kakao);

	String getIdByEmail(String searchEmail);

	UserVO getUserByEmail(String searchEmail);


}