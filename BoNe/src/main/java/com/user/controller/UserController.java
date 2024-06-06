package com.user.controller;

import javax.inject.Inject;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.user.model.UserVO;
import com.user.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class UserController {
	
	@Inject
	private UserService userService;
	
	
	@GetMapping("/check")
	public String userCheck() {
		
		return "login/userCheck";
	}
	
	@GetMapping("/joinG")
	public String generalJoin() {
		
		return "member/register";
	}
	
	@GetMapping("/joinS")
	public String sitterJoin() {
		
		return "member/registerSitter";
	}

	
	@RequestMapping(value="/joinG", method=RequestMethod.POST)
	public String joinProcess(Model m, @ModelAttribute UserVO user) {
		
		log.info("user=="+user);
		// 유효성 체크
		if (user.getMid()==null || user.getPwd()==null || user.getNickname()==null || 
			user.getUname()==null || user.getTel1()==null || user.getTel2()==null || user.getTel3()==null ||
			user.getAddr1()==null || user.getAddr2()==null ||
			user.getMid().trim().isEmpty() || user.getPwd().trim().isEmpty() || user.getNickname().trim().isEmpty() || 
			user.getUname().trim().isEmpty() || user.getTel1().trim().isEmpty() || user.getTel2().trim().isEmpty() || 
			user.getTel3().trim().isEmpty() || user.getAddr1().trim().isEmpty() || user.getAddr2().trim().isEmpty()) {
			
			return "redirect:joinG";
		}
		
		int n = userService.createUser(user);
		String str = (n>0)? "회원가입 완료 - 로그인 페이지로 이동합니다.":"회원가입 실패";
		String loc = (n>0)? "login":"javascript:history.back()";
		
		log.info(str+" / "+loc);
		m.addAttribute("msg", str);
		m.addAttribute("loc", loc);
		
		return "message";
	}
	@RequestMapping(value="/joinS", method=RequestMethod.POST)
	public String sjoinProcess(Model m, @ModelAttribute UserVO user) {
		
		log.info("user=="+user);
		// 유효성 체크
		if (user.getMid()==null || user.getPwd()==null || user.getNickname()==null || 
			user.getUname()==null || user.getTel1()==null || user.getTel2()==null || user.getTel3()==null ||
			user.getAddr1()==null || user.getAddr2()==null ||
			user.getMid().trim().isEmpty() || user.getPwd().trim().isEmpty() || user.getNickname().trim().isEmpty() || 
			user.getUname().trim().isEmpty() || user.getTel1().trim().isEmpty() || user.getTel2().trim().isEmpty() || 
			user.getTel3().trim().isEmpty() || user.getAddr1().trim().isEmpty() || user.getAddr2().trim().isEmpty()) {
			
			return "redirect:joinS";
		}
		
		int n = userService.createUserS(user);
		String str = (n>0)? "회원가입 완료 - 로그인 페이지로 이동합니다.":"회원가입 실패";
		String loc = (n>0)? "login":"javascript:history.back()";
		
		log.info(str+" / "+loc);
		m.addAttribute("msg", str);
		m.addAttribute("loc", loc);
		
		return "message";
	}
	
	
	@GetMapping("/idCheck")
	public String idCheckForm() {
		
		return "member/idCheck";
	}
	
	
	@PostMapping("/idCheck")
	public String idCheckResult(Model m, @RequestParam(defaultValue="") String mid) {
		
		boolean isUse = userService.idCheck(mid);
		String result = (isUse)? "success":"fail";
	
		m.addAttribute("result", result);
		m.addAttribute("mid", mid);
		
		return "member/idCheckResult";
	}
	

	@GetMapping("/nickCheck")
	public String nickCheckForm() {
		
		return "member/nickCheck";
	}
	
	
	@PostMapping("/nickCheck")
	public String nickCheckResult(Model m, @RequestParam(defaultValue="") String nickname) {
		
		boolean isUse = userService.nickCheck(nickname);
		String result = (isUse)? "success":"fail";
	
		m.addAttribute("result", result);
		m.addAttribute("nickname", nickname);
		
		return "member/nickCheckResult";
	}

}
