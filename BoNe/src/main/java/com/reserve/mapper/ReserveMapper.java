package com.reserve.mapper;

import java.util.List;

import com.reserve.model.ReserveVO;

public interface ReserveMapper {

	List<ReserveVO> selectTemBySnickname(String snickname);

	int getTotalReserve(String snickname);

	int makeReserve(ReserveVO reserveVO);

	String getSnicknameByIno(int ino);

	int accept(ReserveVO reserveVO);

	int reject(int tno);

	int getInoBySnickname(String snickname);

	String getPnameByNickname(String nickname);

	int getPnoByUnickname(String unickname);
}
