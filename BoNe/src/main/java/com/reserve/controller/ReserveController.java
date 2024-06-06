package com.reserve.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.reserve.model.ReserveVO;
import com.reserve.service.ReserveService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ReserveController {

	@Autowired
	@Resource(name = "ReserveService")
	private ReserveService reserveService;
	
	@PostMapping("/makeReserve")
	public String makeReserve (Model m,  @ModelAttribute ReserveVO reserveVO ,
								@RequestParam("ino") int ino, HttpSession session) {
		
		String snickname = this.reserveService.getSnicknameByIno(ino);
		
		reserveVO.setSnickname(snickname);
		
		if(reserveService.getPnameByNickname(reserveVO.getUnickname()) != null) {
			reserveVO.setPname(reserveService.getPnameByNickname(reserveVO.getUnickname()));
			reserveVO.setPno(reserveService.getPnoByUnickname(reserveVO.getUnickname()));
			
			int n = reserveService.makeReserve(reserveVO);
		
			String str = (n > 0) ? "성공적으로 신청하셨습니다." : "예약 신청에 실패하셨습니다.";
			String loc = (n > 0) ? "javascript:history.back()" : "javascript:history.back()";

			m.addAttribute("msg", str);
			m.addAttribute("loc", loc);
			
			return "message";
			
		} else {
			
			m.addAttribute("msg", "반려동물 정보를 입력해주세요.");
			m.addAttribute("loc", "javascript:history.back()");
			
			return "message";
		}
		
	}
	
	@PostMapping("/accept")
	public String accept (Model m, @ModelAttribute ReserveVO reserveVO ,
							@RequestParam("tno") int tno, HttpSession session) {
		
		reserveVO.setPname(reserveService.getPnameByNickname(reserveVO.getUnickname()));
		reserveVO.setPno(reserveService.getPnoByUnickname(reserveVO.getUnickname()));
		
		int n = reserveService.accept(reserveVO); // accept하면, used로 데이터 넣고
		reserveService.reject(tno);		  	 	  // 	 	    temporary에서 임시예약내역 삭제 ?? 해야되나 
		
		String str = (n > 0) ? "예약을 성공적으로 수락하셨습니다 !" : "예약 수락에 실패하셨습니다.";
		String loc = (n > 0) ? "sitter/user/page" : "javascript:history.back()";

		m.addAttribute("msg", str);
		m.addAttribute("loc", loc);
		
		return "message";
	}
	
	@PostMapping("/reject")
	public String reject(Model m, @ModelAttribute ReserveVO reserveVO,
							@RequestParam("tno") int tno, HttpSession session) {
		
		int n = reserveService.reject(tno);	
		
		String str = (n > 0) ? "예약을 성공적으로 거절하셨습니다 !" : "예약 거절에 실패하셨습니다.";
		String loc = (n > 0) ? "sitter/user/page" : "javascript:history.back()";

		m.addAttribute("msg", str);
		m.addAttribute("loc", loc);
		
		return "message";
		
	}
}
