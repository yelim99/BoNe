package com.find.service;

import java.util.List;

import com.find.model.IntroduceVO;
import com.find.model.WishVO;
import com.reviewboard.model.ReviewBoardVO;

public interface FindService {

	String selectNickname(int num);
	String selectTitle(int num);
	String selectAddr(int num);
	String selectContent(int num);
	String selectShortContent(int num);
	String addr1(String nickname);
	
	String selectLicense(int num);
	
	String selectImg(int num);
	
	int selectSPetDayPrice(int num);
	int selectSPetAllPrice(int num);
	int selectMPetDayPrice(int num);
	int selectMPetAllPrice(int num);
	int selectLPetDayPrice(int num);
	int selectLPetAllPrice(int num);
	
	int getSumStar(int ino);
	int getCntStar(int ino);
	
	int insertHeart(WishVO wishvo);
	int deleteHeart(int num);
	
	int getWish(int num);
	
	String selectService(int num);
	
	int getCntReple(int num);
	List<ReviewBoardVO> selectRepleAll(int num);

	IntroduceVO selectIntroduceByIno(int ino);

}
