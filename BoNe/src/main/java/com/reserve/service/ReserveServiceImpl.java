package com.reserve.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import com.reserve.model.ReserveVO;
import com.reserve.mapper.ReserveMapper;

@Service("ReserveService")
@Repository
public class ReserveServiceImpl implements ReserveService {
	
	@Autowired
	private ReserveMapper reserveMapper;

	@Override
	public List<ReserveVO> selectTemBySnickname(String snickname) {
		return this.reserveMapper.selectTemBySnickname(snickname);
	}

	@Override
	public int getTotalReserve(String snickname) {
		return this.reserveMapper.getTotalReserve(snickname); // snickname
	}

	@Override
	public int makeReserve(ReserveVO reserveVO) {
		return this.reserveMapper.makeReserve(reserveVO);
	}

	@Override
	public String getSnicknameByIno(int ino) {
		return this.reserveMapper.getSnicknameByIno(ino);
	}

	@Override
	public int accept(ReserveVO reserveVO) {
		return this.reserveMapper.accept(reserveVO);
	}

	@Override
	public int reject(int tno) {
		return this.reserveMapper.reject(tno);
	}

	@Override
	public int getInoBySnickname(String snickname) {
		return this.reserveMapper.getInoBySnickname(snickname);
	}

	@Override
	public String getPnameByNickname(String nickname) {
		return this.reserveMapper.getPnameByNickname(nickname);
	}

	@Override
	public int getPnoByUnickname(String unickname) {
		return this.reserveMapper.getPnoByUnickname(unickname);
	}
	
}
