package com.user.service;

import java.util.List;

import com.find.model.IntroduceVO;
import com.find.model.WishVO;
import com.sitter.model.SitterVO;
import com.user.model.UserModelVO;
import com.user.model.UserVO;

/* 일반회원 마이페이지 관련 서비스 */
public interface GeneralService {

	int insertGeneral(UserModelVO um);
	
	UserModelVO selectOnePet(String nickname);
	
	List<UserModelVO> selectAllPet(String nickname);
	
	// 펫 정보 수정
	UserModelVO getPetInfo(int pno);
	int editPetInfo(UserModelVO pet);
	
	// 펫 정보 삭제
	int delPetInfo(UserModelVO pet);
	
	/* 회원정보 수정 */
	UserVO getUserInfo(int idx);
	int editUserInfo(UserVO user);
	
	// 이용내역
	List<SitterVO> getUsedHistory(String unickname);

	int insertKakao(UserVO user);

	int deleteMember(int idx);

	String getNicknameByIdx(int idx);

	Integer getPnoByNickname(String nickname);

	int deleteEveryReRepleByNickname(String nickname);

	int deleteEveryRepleByNickname(String nickname);

	int deleteIntroBySitterNickname(String nickname);

	
}