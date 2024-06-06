package com.find.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.find.mapper.FindMapper;
import com.find.model.IntroduceVO;
import com.find.model.WishVO;
import com.reviewboard.model.ReviewBoardVO;

@Service("FindService")
public class FindServiceImpl implements FindService{

	@Autowired
	private FindMapper findMapper;

	@Override
	public String selectNickname(int num) {
		return this.findMapper.selectNickname(num);
	}

	@Override
	public String selectTitle(int num) {
		return this.findMapper.selectTitle(num);
	}

	@Override
	public String selectAddr(int num) {
		return this.findMapper.selectAddr(num);
	}
	
	@Override
	public String addr1(String nickname) {

		return this.findMapper.addr1(nickname);
	}

	@Override
	public String selectContent(int num) {
		return this.findMapper.selectContent(num);
	}

	@Override
	public String selectShortContent(int num) {
		return this.findMapper.selectShortContent(num);
	}

	@Override
	public int selectSPetDayPrice(int num) {
		return this.findMapper.selectSPetDayPrice(num);
	}

	@Override
	public int selectSPetAllPrice(int num) {
		return this.findMapper.selectSPetAllPrice(num);
	}

	@Override
	public int selectMPetDayPrice(int num) {
		return this.findMapper.selectMPetDayPrice(num);
	}

	@Override
	public int selectMPetAllPrice(int num) {
		return this.findMapper.selectMPetAllPrice(num);
	}

	@Override
	public int selectLPetDayPrice(int num) {
		return this.findMapper.selectLPetDayPrice(num);
	}

	@Override
	public int selectLPetAllPrice(int num) {
		return this.findMapper.selectLPetAllPrice(num);
	}

	@Override
	public int getSumStar(int ino) {
		return this.findMapper.getSumStar(ino);
	}

	@Override
	public int getCntStar(int ino) {
		return this.findMapper.getCntStar(ino);
	}

	@Override
	public String selectLicense(int num) {
		return this.findMapper.selectLicense(num);
	}
	
	@Override
	public String selectImg(int num) {
		return this.findMapper.selectImg(num);
	}

	@Override
	public int insertHeart(WishVO wishvo) {
		return this.findMapper.insertHeart(wishvo);
	}
	
	@Override
	public int deleteHeart(int num) {
		return this.findMapper.deleteHeart(num);
	}

	@Override
	public int getWish(int num) {
		return this.findMapper.getWish(num);
	}

	@Override
	public String selectService(int num) {
		return this.findMapper.selectService(num);
	}

	@Override
	public int getCntReple(int num) {
		return this.findMapper.getCntReple(num);
	}

	@Override
	public List<ReviewBoardVO> selectRepleAll(int num) {
		return this.findMapper.selectRepleAll(num);
	}

	@Override
	public IntroduceVO selectIntroduceByIno(int ino) {
		return this.findMapper.selectIntroduceByIno(ino);
	}
	
	
}
