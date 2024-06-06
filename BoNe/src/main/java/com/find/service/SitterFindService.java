package com.find.service;

import java.util.List;

import com.find.model.IntroduceVO;
import com.find.model.PagingVO;

public interface SitterFindService {
	
	int getTotalCount(PagingVO paging);
		
	// 지역 별로 펫시터 보여주기
	public List<IntroduceVO> selectByAddr(String addr);
	
	// 페이징 처리하여 보여주기
	List<IntroduceVO> selectPaging(PagingVO paging);

	List<IntroduceVO> selectByReviewCount(PagingVO paging);

	List<IntroduceVO> selectByStarHigh(PagingVO paging);
	
}
