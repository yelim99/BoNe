package com.reserve.model;

import java.sql.Date;
import lombok.Data;

@Data
public class ReserveVO {
	
	int tno; //임시 돌봄 일정 번호
	String unickname; // 사용자
	String snickname; // 시터 닉네임
	String pname; //사용자의 반려동물 이름 //없어도되나 흠
	String tel1;
	String tel2;
	String tel3;
	Date sdate; //시터 이용 시작날짜
	Date fdate; //시터 이용 끝 날짜
	
	int uno; // 수락 시,진짜 돌봄 번호 배정
	int pno; //펫넘버

}
