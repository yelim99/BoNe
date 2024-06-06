package com.find.mapper;

import java.util.List;

import com.find.model.IntroduceVO;
import com.find.model.WishVO;

public interface WishMapper {
	
	// 찜목록 보여주기
	List<WishVO> selectWno(int wno);

	// 찜 목록 추가 및 삭제
	int addWish(WishVO wish);
	int delWish(WishVO wish);
	
	// 이미 찜 했는지 확인
	int wishCheck(WishVO wish);
	
	// 특정 회원이 찜한 목록 가져오기
	List<WishVO> wishList(String unickname);
	
	// 소개글 번호로 시터 정보 받아오기
	IntroduceVO wishSitterInfo(int ino);
	
}
