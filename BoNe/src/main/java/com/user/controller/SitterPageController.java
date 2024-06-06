package com.user.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.reserve.model.ReserveVO;
import com.reserve.service.ReserveService;
import com.sitter.model.PriceVO;
import com.sitter.model.SitterVO;
import com.sitter.service.SitterService;
import com.user.model.UserModelVO;
import com.user.model.UserVO;
import com.user.service.GeneralService;
import com.user.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/sitter/user")
@Log4j
public class SitterPageController {
	
	@Resource(name="GeneralService")
	private GeneralService service;
	
	@Inject
	private SitterService sitterService;
	
	@Inject
	private UserService userService;
	
	@Inject
	private ReserveService reserveService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, false));
	}
	
		
	@GetMapping("/schedule")
	public String SitterSchedule() {
		
		return "sitter/schedule";
	}
	
	@GetMapping("/page")
	public String SitterPage(Model m, HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		UserVO usvo = (UserVO) session.getAttribute("loginUser");
		String mid = usvo.getMid();		
		String nickname = sitterService.getUserNickname(mid);
		
		List<SitterVO> svo = sitterService.getSitterIntroduce(nickname);
		List<SitterVO> svo2 = sitterService.getSitterUsed(nickname);
		
		Integer icheck = this.sitterService.icheck(nickname);
		m.addAttribute("icheck", icheck);

		req.setAttribute("sittervo", svo2);
		m.addAttribute("svo", svo);
		m.addAttribute("svo2", svo2);
		m.addAttribute("nickname", nickname);
		m.addAttribute("mid",mid);
		
		List<ReserveVO> reserveData = this.reserveService.selectTemBySnickname(nickname); // 펫시터 본인 마이페이지임..
		m.addAttribute("reserve", reserveData);
		
		int total = reserveService.getTotalReserve(nickname);
		m.addAttribute("total", total);
		
		// 이용 요금 보여주기
		PriceVO price = this.sitterService.getPrice(nickname);
		m.addAttribute("price", price);
		
		return "sitter/myPagePetSitter";
	}
	
	@GetMapping("/introduce")
	public String SitterIntroduce() {
		
		return "sitter/petSitterIntroduce";
	}
	
	
	@GetMapping("/introduceEdit")
	public String SitterIntroduceEdit(Model m, HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		UserVO usvo = (UserVO) session.getAttribute("loginUser");
		String mid = usvo.getMid();		
		String nickname = sitterService.getUserNickname(mid);
		
		List<SitterVO> svo = sitterService.getSitterIntroduce(nickname);
		String arr = svo.get(0).getService();		
		String [] arr2 = arr.split(",");
		m.addAttribute("svo",svo);
		m.addAttribute("arr2",arr2);
		
		return "sitter/petSitterIntroduceEdit";
	}
	
	@PostMapping("/introduceDel")
	public String introduceDel(Model m, int ino) {

		System.out.println(ino);

		int n = sitterService.delIntroduce(ino);
		String str = (n > 0) ? "내 소개 삭제 완료" : "내 소개 삭제 실패";
		String loc = (n > 0) ? "page" : "javascript:history.back()";

		m.addAttribute("msg", str);
		m.addAttribute("loc", loc);
		return "message";
	}
	
	
	@GetMapping("/price")
	public String SitterPrice() {
		
		return "sitter/priceSetting";
	}
	
	
	@PostMapping("/price")
	public String priceProcess(Model m, @ModelAttribute PriceVO price, HttpSession session) {
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		String unickname_fk = loginUser.getNickname();
		
		int ino = sitterService.icheck(unickname_fk);
		
		price.setIno(ino);
		price.setNickname(unickname_fk);
		
		int n = sitterService.addPrice(price);
		
		String str = (n>0)? "이용요금 설정 완료":"이용요금 설정 실패";
		String loc = (n>0)? "page":"javascript:history.back()";
		
		m.addAttribute("msg", str);
		m.addAttribute("loc", loc);
		
		return "message";
	}
	
	
	
	@GetMapping("/introDetail")
	public String SitterIntroDetail(Model m, HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		UserVO usvo = (UserVO) session.getAttribute("loginUser");
		String mid = usvo.getMid();		
		String nickname = sitterService.getUserNickname(mid);
		
		List<SitterVO> svo = sitterService.getSitterIntroduce(nickname);
		
		m.addAttribute("svo", svo);
		m.addAttribute("nickname", nickname);
		m.addAttribute("mid",mid);
		
		return "sitter/introDetail";
	}
		
	@RequestMapping(value="/info", method=RequestMethod.POST)
	public String introProcess(Model m, @ModelAttribute SitterVO sitter,
			@RequestParam("ufile") MultipartFile mfilename, HttpServletRequest req) {
		HttpSession session = req.getSession();
		UserVO usvo = (UserVO) session.getAttribute("loginUser");
		String mid = usvo.getMid();		

		String nickname = sitterService.getUserNickname(mid);
		sitter.setNickname(nickname);

		ServletContext app = req.getServletContext();
		String upDir = app.getRealPath("resources/upload");
		File dir = new File(upDir);
		if (!dir.exists())
			dir.mkdirs();

		System.out.println("mfilename : " + mfilename);
		System.out.println("upDir : " + upDir);
		// 1. 파일정보(파일명, 파일크기, 첨부 여부) 알아내기 (DB에 저장하기 위해)
		if (!mfilename.isEmpty()) {
			UUID uid=UUID.randomUUID();
			String uidStr=uid.toString();
			String filename=uidStr+"_"+mfilename.getOriginalFilename();//파일명
			sitter.setIfile(filename);

			// 2. 파일업로드 처리
			try {
				mfilename.transferTo(new File(upDir, filename));
			} catch (IOException e) {
				log.info("업로드 실패 : " + e);
				log.error(e);
			}
		}

		int n = sitterService.sitterIntroduce(sitter);
		String str = (n > 0) ? "정보 수정/등록 완료" : "정보 수정/등록 실패";
		String loc = (n > 0) ? "page" : "javascript:history.back()";

		m.addAttribute("msg", str);
		m.addAttribute("loc", loc);
		return "message";
	}
	
	

	// 소개 수정 폼
	
	
	
	
	@RequestMapping(value="/editS", method=RequestMethod.GET)
	public String sitterEditForm(Model model,@ModelAttribute UserVO user, HttpSession session) {
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		int loginIdx = loginUser.getIdx();
		log.info("loginIdx: "+loginIdx);
		
		if (loginUser.getIdx() == 0) {
			return "redirect:page";
		}
		
		user = sitterService.getUserInfo(loginIdx);
		log.info("user=="+user);
		
		model.addAttribute("user", user);
		
		return "sitter/smember_edit";
	}
	
	
	@RequestMapping(value="/editS", method=RequestMethod.POST)
	public String editProcess(Model m, @ModelAttribute UserVO user,HttpSession session) {
		
//		user = (UserVO)session.getAttribute("loginUser");
		int n = sitterService.editUserInfo(user);
		
		String str = (n>0)? "회원정보 수정 완료":"회원정보 수정 실패";
		String loc = (n>0)? "page":"javascript:history.back()";
		
		System.out.println(user+" / "+loc);
		m.addAttribute("msg", str);
		m.addAttribute("loc", loc);
		
		return "message";
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
	
	
	@GetMapping("/used")
	public String SitterUsed(Model m, HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		UserVO usvo = (UserVO) session.getAttribute("loginUser");
		String mid = usvo.getMid();
		String nickname = sitterService.getUserNickname(mid);
		
		List<SitterVO> uvo2 = sitterService.getSitterUsed(nickname);

		m.addAttribute("uvo", uvo2);

		return "sitter/used";
	}

	@GetMapping("/usedEdit")
	public String usedEditForm(Model m, @RequestParam(defaultValue = "0") int uno) {
		if (uno == 0) {
			System.out.println("0이라서 안넘어감");
			return "redirect:care";
		}
		SitterVO uvo2 = sitterService.getUsedNO(uno);
		Date date1 = uvo2.getSdate();
		Date date2 = uvo2.getFdate();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String xDate = simpleDateFormat.format(date1);
		String yDate = simpleDateFormat.format(date2);

		m.addAttribute("yDate", yDate);
		m.addAttribute("xDate", xDate);

		m.addAttribute("uvo2", uvo2);

		return "sitter/usedEdit";
	}

	@RequestMapping(value = "/usedEdit", method = RequestMethod.POST)
	public String usedEdit(Model m, @ModelAttribute SitterVO sitter) {
				
		String unickname = sitter.getUnickname();
		String pname = sitter.getPname();
		
		List<SitterVO> uvo3 = sitterService.getMembersInfo();
		List<SitterVO> uvo4 = sitterService.getPname(unickname);		
		
		int i = 0;
		int j = 0;
		
		for (SitterVO u : uvo3) {
			
			if (unickname.equals(u.getNickname())) {
				i++;
			}			
		}
		
		for (SitterVO u2 : uvo4) {
			
			if (pname.equals(u2.getPname())) {
				j++;
			}
		}
		
		if (i < 1) {

			String str = "등록되어있지 않은 유저 닉네임입니다";
			String loc = "javascript:history.back()";

			m.addAttribute("msg", str);
			m.addAttribute("loc", loc);
			return "message";

		} else if(j < 1) {
			
			String str = "등록되어있지 않은 펫 닉네임입니다";
			String loc = "javascript:history.back()";

			m.addAttribute("msg", str);
			m.addAttribute("loc", loc);
			return "message";
			
		} else {

			int n = sitterService.updateUsed(sitter);
			String str = (n > 0) ? "돌봄 일정 수정 완료" : "돌봄 일정 수정 실패";
			String loc = (n > 0) ? "used" : "javascript:history.back()";

			m.addAttribute("msg", str);
			m.addAttribute("loc", loc);
			return "message";
		}

	}

	@GetMapping("/usedAdd")
	public String usedAddForm() {

		return "sitter/usedAdd";
	}


	@RequestMapping(value = "/usedAdd", method = RequestMethod.POST)
	public String usedAdd(Model m, @ModelAttribute SitterVO sitter, HttpServletRequest req) {
		
		String unickname = sitter.getUnickname();
		String pname = sitter.getPname();
		
		List<SitterVO> uvo5 = sitterService.getMembersInfo();
		List<SitterVO> uvo6 = sitterService.getPname(unickname);
		
		HttpSession session = req.getSession();
		UserVO usvo = (UserVO) session.getAttribute("loginUser");
		String mid = usvo.getMid();
		String nickname = sitterService.getUserNickname(mid);
		
		sitter.setSnickname(nickname);


		int i = 0;
		int j = 0;		
		
		for (SitterVO u : uvo5) {
			if (unickname.equals(u.getNickname())) {
				i++;
			}
		}
		for (SitterVO u2 : uvo6) {
			if (pname.equals(u2.getPname())) {
				j++;
			}
		}
		if (i < 1) {

			String str = "등록되어있지 않은 유저 닉네임입니다";
			String loc = "javascript:history.back()";

			m.addAttribute("msg", str);
			m.addAttribute("loc", loc);
			return "message";

		}else if(j < 1) {
			
			String str = "등록되어있지 않은 펫 닉네임입니다";
			String loc = "javascript:history.back()";

			m.addAttribute("msg", str);
			m.addAttribute("loc", loc);
			return "message";
			
		} else {

			int n = sitterService.addUsed(sitter);
			String str = (n > 0) ? "돌봄 일정 저장 완료" : "돌봄 일정 저장 실패";
			String loc = (n > 0) ? "used" : "javascript:history.back()";

			m.addAttribute("msg", str);
			m.addAttribute("loc", loc);
			return "message";
		}
	}

	@PostMapping("/delUsed")
	public String delUsed(Model m, int uno) {

		System.out.println(uno);

		int n = sitterService.delUsed(uno);
		String str = (n > 0) ? "돌봄 일정 삭제 완료" : "돌봄 일정 삭제 실패";
		String loc = (n > 0) ? "page" : "javascript:history.back()";

		m.addAttribute("msg", str);
		m.addAttribute("loc", loc);
		return "message";
	}
	
	
	// 돌봄일정에서 펫 이름 눌렀을 때 펫 정보 보여주기
	@GetMapping("/userAlert")
	public String userPetInfoAlert(Model m, HttpSession session, @RequestParam int pno) {

		
		// 펫 정보 받아오기
		UserModelVO pet = this.sitterService.petInfo(pno);
		
		m.addAttribute("pno", pno);
		m.addAttribute("pet", pet);
		
		
		
		return "sitter/userAlert";
	}
	
	// 시터 전용
		@PostMapping(value = "/kakaoPlus", produces = "application/json")
		public ResponseEntity<Map<String, String>> kakaoPlus(@RequestBody Map<String, String> requestBody, HttpSession session) {
			
			Map<String, String> response = new HashMap<>();
			// 이미 로그인 되어있는 상태에서, 카카오 연동하기 버튼을 누르고 카카오톡 로그인 했을 때,
			// members테이블의 kakao컬럼에 kakao email 이 삽입됨.
			String kakao = requestBody.get("email");
			
			// 이미 db에 있으면 연동 안됨..
			// 사용자의 카카오 정보를 조회
		    UserVO kakaoUser = userService.getUserByKakao(kakao);
		    
		    // 카카오 정보가 이미 존재하는 경우에 대한 처리
		    if (kakaoUser != null) {
		        // 이미 있으니까 있는걸로 로그인하셈
				response.put("msg", "이미 등록된 카카오 계정입니다.");
			    response.put("loc", "/general/user/page");
		    } else {
				// 세션에서 로그인된 사용자의 ID 가져오기
				UserVO uvo = (UserVO) session.getAttribute("loginUser");
			    uvo.setKakao(kakao);
			    
			    // Kakao 이메일 정보와 사용자 ID를 서비스로 전달하여 처리
			    service.insertKakao(uvo);	
			    response.put("loc", "/general/user/page");
		    }
			
		    return ResponseEntity.ok(response);
		    
		}
}
