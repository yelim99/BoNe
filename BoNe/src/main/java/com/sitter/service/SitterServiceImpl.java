package com.sitter.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.sitter.mapper.SitterMapper;
import com.sitter.model.PriceVO;
import com.sitter.model.SitterVO;
import com.user.model.UserModelVO;
import com.user.model.UserVO;

@Service("sitterService")
public class SitterServiceImpl implements SitterService {
	
	@Autowired
	private SitterMapper sitterMapper;
	
	@Inject
	private BCryptPasswordEncoder passwordEncoder;
	
	
	@Override
	public Integer sitterIntroduce(SitterVO sitter) {
		
		return sitterMapper.sitterIntroduce(sitter);
	}


	@Override
	public List<SitterVO> getSitterIntroduce(String nickname) {
		
		return sitterMapper.getSitterIntroduce(nickname);
	}

	
	@Override
	public List<SitterVO> getSitterUsed(String nickname) {
		
		return sitterMapper.getSitterUsed(nickname);
	}


	@Override
	public SitterVO getUsedNO(int uno) {
		
		return sitterMapper.getUsedNO(uno);
	}


	@Override
	public int updateUsed(SitterVO used) {
		
		return sitterMapper.updateUsed(used);
	}


	@Override
	public List<SitterVO> getMembersInfo() {
		
		return sitterMapper.getMembersInfo();
	}

	
	@Override
	public int addUsed(SitterVO usedAdd) {
		
		return sitterMapper.addUsed(usedAdd);
	}


	@Override
	public int delUsed(int uno) {
		
		return sitterMapper.delUsed(uno);
	}
	
	@Override
	public List<SitterVO> getPname(String nickname) {

		return sitterMapper.getPname(nickname);
	}

	
	@Override
	public String getUserNickname(String mid) {
		
		return sitterMapper.getUserNickname(mid);
	}


	@Override
	public UserVO getUserInfo(int idx) {
		
		return sitterMapper.getUserInfo(idx);
	}


	@Override
	public int editUserInfo(UserVO user) {
		
		user.setPwd(passwordEncoder.encode(user.getPwd()));
		
		int n=sitterMapper.editUserInfo(user);
		System.out.println("n: "+n);
		return n;
	}


	@Override
	public UserModelVO petInfo(int pno) {
		
		return this.sitterMapper.petInfo(pno);
	}


	@Override
	public Integer icheck(String nickname) {
		
		return this.sitterMapper.icheck(nickname);
	}


	@Override
	public int delIntroduce(int ino) {

		return this.sitterMapper.delIntroduce(ino);
	}


	@Override
	public int addPrice(PriceVO price) {
		
		return this.sitterMapper.addPrice(price);
	}


	@Override
	public PriceVO getPrice(String nickname) {
		
		return this.sitterMapper.getPrice(nickname);
	}


}
