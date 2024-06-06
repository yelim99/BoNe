package com.find.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.find.mapper.SitterFindMapper;
import com.find.mapper.WishMapper;
import com.find.model.IntroduceVO;
import com.find.model.PagingVO;

@Service("sitterFindService")
public class SitterFindServiceImpl implements SitterFindService {

	@Inject
	private SitterFindMapper sitterFindMapper;
	
	@Inject
	private WishMapper wishMapper;
	
	
	@Override
	public int getTotalCount(PagingVO paging) {

		return this.sitterFindMapper.getTotalCount(paging);
	}
	

	@Override
	public List<IntroduceVO> selectByAddr(String addr) {
		
		return this.sitterFindMapper.selectByAddr(addr);
	}
	
	
	@Override
	public List<IntroduceVO> selectPaging(PagingVO paging) {
		
		return this.sitterFindMapper.selectPaging(paging);
	}


	@Override
	public List<IntroduceVO> selectByReviewCount(PagingVO paging) {

		return this.sitterFindMapper.selectByReviewCount(paging);
	}


	@Override
	public List<IntroduceVO> selectByStarHigh(PagingVO paging) {
		
		return this.sitterFindMapper.selectByStarHigh(paging);
	}


}
