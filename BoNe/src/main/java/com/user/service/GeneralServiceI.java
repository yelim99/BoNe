package com.user.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.find.model.IntroduceVO;
import com.find.model.WishVO;
import com.sitter.model.SitterVO;
import com.user.mapper.GeneralMapper;
import com.user.model.UserModelVO;
import com.user.model.UserVO;

/* 일반회원 마이페이지 관련 서비스 임플 */

@Service("GeneralService")
@Repository
public class GeneralServiceI implements GeneralService {
	
	@Autowired
	private GeneralMapper generalmapper;
	
	@Inject
	private BCryptPasswordEncoder passwordEncoder;
	
	
	@Override
	public int insertGeneral(UserModelVO um) {
		return this.generalmapper.insertGeneral(um);
	}

	@Override
	public UserModelVO selectOnePet(String nickname) {
		return this.generalmapper.selectOnePet(nickname);
	}

	@Override
	public List<UserModelVO> selectAllPet(String nickname) {
		return this.generalmapper.selectAllPet(nickname);
	}

	@Override
	public UserVO getUserInfo(int idx) {
		
		return this.generalmapper.getUserInfo(idx);
	}

	@Override
	public int editUserInfo(UserVO user) {
		
		user.setPwd(passwordEncoder.encode(user.getPwd()));
	
		int n=this.generalmapper.editUserInfo(user);
		System.out.println("N: "+n);
		return n;
	}

	@Override
	public UserModelVO getPetInfo(int pno) {
		
		return this.generalmapper.getPetInfo(pno);
	}

	@Override
	public int editPetInfo(UserModelVO pet) {

		return this.generalmapper.editPetInfo(pet);
	}

	@Override
	public int delPetInfo(UserModelVO pet) {

		return this.generalmapper.delPetInfo(pet);
	}

	@Override
	public List<SitterVO> getUsedHistory(String unickname) {

		return this.generalmapper.getUsedHistory(unickname);
	}

	@Override
	public int insertKakao(UserVO user) {

		return this.generalmapper.insertKakao(user);
	}

	@Override
	public int deleteMember(int idx) {
		return this.generalmapper.deleteMember(idx);
	}

	@Override
	public String getNicknameByIdx(int idx) {
		return this.generalmapper.getNicknameByIdx(idx);
	}

	@Override
	public Integer getPnoByNickname(String nickname) {
		return this.generalmapper.getPnoByNickname(nickname);
	}

	@Override
	public int deleteEveryReRepleByNickname(String nickname) {
		return this.generalmapper.deleteEveryReRepleByNickname(nickname);
	}

	@Override
	public int deleteEveryRepleByNickname(String nickname) {
		return this.generalmapper.deleteEveryRepleByNickname(nickname);
	}

	@Override
	public int deleteIntroBySitterNickname(String nickname) {
		return this.generalmapper.deleteIntroBySitterNickname(nickname);
	}
	
}
