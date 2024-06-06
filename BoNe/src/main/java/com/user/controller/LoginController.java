package com.user.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.mail.MailException;
import org.springframework.mail.MailParseException;
import org.springframework.mail.MailSendException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.user.model.NotUserException;
import com.user.model.UserModelVO;
import com.user.model.UserVO;
import com.user.service.GeneralService;
import com.user.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class LoginController {
	
	@Resource(name="GeneralService")
	private GeneralService service;
	
	@Resource(name="userService")
	//@Autowired //@Inject
	private UserService userService;

	@GetMapping("/login")
	public String login() {
		
		return "login/login";
	}
	@PostMapping("/login")
	public String loginProcess(HttpSession session, 
			HttpServletResponse response,
			@ModelAttribute("user") UserVO user,
			@RequestParam(defaultValue="off") String saveId) throws NotUserException {
		
		System.out.println("Id: "+user.getMid()+",pwd:"+user.getPwd()); //
		System.out.println("saveId: "+saveId);
		
		if(user.getMid()==null||user.getPwd()==null||user.getMid().trim().isEmpty()||user.getPwd().trim().isEmpty()) {
			return "redirect:login";
		}
		UserVO loginUser=userService.loginCheck(user.getMid(), user.getPwd());
		if(loginUser!=null) {
			session.setAttribute("loginUser", loginUser);
			Cookie ck=new Cookie("uid", loginUser.getMid());
			if(saveId.equals("on")) {
				ck.setMaxAge(7*24*60*60);
			}else {
				ck.setMaxAge(0);
			}
			ck.setPath("/");
			response.addCookie(ck);
		}
		
		return "redirect:/";
	}//--------------------
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}	
	@ExceptionHandler(NotUserException.class)
	public String exceptionHandler(Exception ex, Model m) {
		ex.printStackTrace();
		m.addAttribute("exception", ex);
		return "login/errorAlert";
	}
	
	@PostMapping(value = "/kakaoLogin", produces = "application/json")
	public ResponseEntity<Map<String, String>> kakaoLogin(@RequestBody Map<String, String> requestBody, HttpSession session) throws NotUserException {

		Map<String, String> response = new HashMap<>();
		
		String kakaoEmail = requestBody.get("email");
		
		// 카카오이메일 통해서 로그인할 유저 정보 얻어오기
		UserVO loginUser = userService.getUserByKakao(kakaoEmail);
		
		if(loginUser!=null) {
			session.setAttribute("loginUser", loginUser);
			response.put("loc", "/");
		} else { // 로그인유저 정보가 없다면 ?
			response.put("msg", "등록된 회원 정보가 없습니다.");
		    response.put("loc", "/login");
		}
		
		return ResponseEntity.ok(response);
	}
	
	@PostMapping("/deleteMb")
	public String deleteMember(Model m, @ModelAttribute  UserVO user, @RequestParam("idx") int idx, HttpSession session) {
		
		// 주인 닉네임 갖고오기
		String nickname = service.getNicknameByIdx(idx);
		
		// 주인이 등록한 펫 pno 갖고오기(null아닐때)
		Integer pno = service.getPnoByNickname(nickname);
		
		if(pno != null) {
			// 펫삭제
			UserModelVO petInfo = service.getPetInfo(pno);
			service.delPetInfo(petInfo);
		}
		
		service.deleteEveryReRepleByNickname(nickname); // 리뷰의 댓글 삭제
		service.deleteEveryRepleByNickname(nickname); // 리뷰 삭제 
		
		// 음....소개글이 있었다면?
		service.deleteIntroBySitterNickname(nickname); 
		
		// 주인 삭제 멤버삭제
		service.deleteMember(idx);
		
		session.invalidate();
		
		String str = "성공적으로 탈퇴되었습니다. ";
		String loc = "redirect:/"; // 이렇게 하면 /deleteMb로 다시 돌아가는데.. app/ 으로 어떻게 돌아가지..
		m.addAttribute("msg",str);
		m.addAttribute("loc",loc);
		
		return "message";
	}
	
	// 아이디 찾기 & 비밀번호 찾기
	@GetMapping("/findId")
	public String findId() {
		
		return "/login/findId";
	}
	
	@GetMapping("/findPw")
	public String findPw() {
		
		return "/login/findPw";
	}

	@PostMapping(value = "/checkEmailFindId", produces = "application/json")
	public ResponseEntity<Map<String, String>> checkEmailFindId(@RequestBody Map<String, String> requestBody, HttpSession session) throws NotUserException {

		Map<String, String> response = new HashMap<>();
		
		String searchEmail = requestBody.get("email");
		String findId = userService.getIdByEmail(searchEmail);
		
		if(findId != null) {
			response.put("userid", findId);
		} 
		
		return ResponseEntity.ok(response);
	}
	
	@PostMapping(value = "/checkEmailFindPw", produces = "application/json")
	public ResponseEntity<Map<String, String>> checkEmailFindPw(@RequestBody Map<String, String> requestBody, HttpSession session) throws NotUserException {

		Map<String, String> response = new HashMap<>();
		
		String searchEmail = requestBody.get("email");
		String findId = userService.getIdByEmail(searchEmail);
		UserVO user = userService.getUserByEmail(searchEmail);
		if(findId != null) {
			userService.sendEmail(user, searchEmail);
			response.put("emailExist", findId);
		} 
		
		return ResponseEntity.ok(response);
	}
	
	

	
}
