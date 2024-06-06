package com.user.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.find.model.IntroduceVO;
import com.find.model.WishVO;
import com.find.service.SitterFindService;
import com.find.service.WishService;
import com.reserve.service.ReserveService;
import com.reviewboard.model.ReviewBoardVO;
import com.reviewboard.service.ReviewBoardService;
import com.sitter.model.SitterVO;
import com.user.model.UserModelVO;
import com.user.model.UserVO;
import com.user.service.GeneralService;
import com.user.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/general/user")
@Log4j
public class GeneralPageController {
	
	@Resource(name="GeneralService")
	private GeneralService service;

	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="wishService")
	private WishService wishService;
	
	@Resource(name = "sitterFindService")
	private SitterFindService sitterFindService;
	
	@Resource(name = "ReserveService")
	private ReserveService reserveService;
	
	@Resource(name="reviewBoardService")
	private ReviewBoardService rbService;
	
	
	@GetMapping("/page")
	public String generalPage(Model m, HttpSession session) {
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		String unickname_fk = loginUser.getNickname();
		
		// 펫 정보 보여주기
		UserModelVO mypet = this.service.selectOnePet(unickname_fk);
		log.info("mypet: "+mypet);
		
		
		m.addAttribute("mypet", mypet);
		
		// 찜 목록 보여주기
		List<WishVO> wishList = wishService.wishList(unickname_fk);
		m.addAttribute("wishList", wishList);
		
		
		// 이용내역 가져오기
		List<SitterVO> used = this.service.getUsedHistory(unickname_fk);
		m.addAttribute("used", used);
		
		// 내가 쓴 리뷰 가져오기
		List<ReviewBoardVO> rbData = rbService.selectReviewByNickname(unickname_fk);
		m.addAttribute("reviewBoard", rbData);
			
		List<String> snicknames = new ArrayList<>();
				
		for (ReviewBoardVO review : rbData) {
		    int ino = review.getIno();
		    String snickname = rbService.getSnicknameByIno(ino);
		    snicknames.add(snickname);
			}
				
		m.addAttribute("snicknames", snicknames);
		
		return "general/mypage_user";
	}
	
	
	
	
	
	@GetMapping("/petinfo")
	public String myPetInfo(Model m, @ModelAttribute UserModelVO pet, HttpSession session) {
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		String unickname_fk = loginUser.getNickname();
		
		List<UserModelVO> mypet = this.service.selectAllPet(unickname_fk);
		
		log.info("mypet: "+mypet);
		
		m.addAttribute("mypet", mypet);
		
		return "general/mypage_user2";
	}
	
	@GetMapping("/petregi")
	public String myPetRegi() {
		
		return "general/pet_Info";
	}
	 
	
	@RequestMapping(value="/petregi", method=RequestMethod.POST)
	public String petregiProcess(Model m, @ModelAttribute UserModelVO um, HttpSession session,
			@RequestParam("pfile") MultipartFile mfilename, HttpServletRequest req) {
		
		log.info("um=="+um);
		
		// 유효성 체크
		if (um.getPname()==null || um.getPname().trim().isEmpty()) {
			return "redirect:petinfo";
		}
		
		ServletContext app=req.getServletContext();
		String upDir=app.getRealPath("resources/pet_upload");
		File dir=new File(upDir);
		if(!dir.exists())
			dir.mkdirs();
		
		System.out.println("mfilename : "+mfilename);
		System.out.println("upDir : "+upDir);
		
		//1. 파일정보(파일명, 파일크기, 첨부 여부) 알아내기 (DB에 저장하기 위해)
		if(!mfilename.isEmpty()) {
			
			String filename=mfilename.getOriginalFilename();
			
			UUID uid = UUID.randomUUID();
			String pfile = uid.toString() + "_" + filename;
			
			um.setImage(pfile);
			
			//2. 파일업로드 처리
			try {
				mfilename.transferTo(new File(upDir, pfile));
			} catch (IOException e) {				
				log.info("업로드 실패 : "+e);
				log.error(e);
			}
		}
		
		
		int n = this.service.insertGeneral(um);
		String str = (n>0)? "펫 등록 성공":"펫 등록 실패";
		String loc = (n>0)? "page":"javascript:history.back()";
		
		log.info(str+" / "+loc);
		m.addAttribute("msg",str);
		m.addAttribute("loc",loc);
		
		return "message";
	}
	
	
	// 펫 정보 수정
	// 수정 폼 보여주기
	@PostMapping("/editPet")
	public String petEditForm(Model m, @ModelAttribute UserModelVO pet, HttpSession session,
								@RequestParam int pno) {
		
		UserModelVO petInfo = this.service.getPetInfo(pno);
		
		m.addAttribute("petInfo", petInfo);
		
		return "general/pet_Info_edit";
	}
	
	
	// 수정 처리
	@RequestMapping(value="/updatePet", method=RequestMethod.POST)
	public String petEditProcess(Model m, @ModelAttribute UserModelVO pet,
				@RequestParam("pfile") MultipartFile mfilename, HttpServletRequest req) {
		
		ServletContext app=req.getServletContext();
		String upDir=app.getRealPath("resources/pet_upload");
		File dir=new File(upDir);
		if(!dir.exists())
			dir.mkdirs();
		
		System.out.println("mfilename : "+mfilename);
		System.out.println("upDir : "+upDir);
		//1. 파일정보(파일명, 파일크기, 첨부 여부) 알아내기 (DB에 저장하기 위해)
		if(!mfilename.isEmpty()) {
			String filename=mfilename.getOriginalFilename();
			
			UUID uid = UUID.randomUUID();
			String pfile = uid.toString() + "_" + filename;
			
			pet.setImage(pfile);
			
			//2. 파일업로드 처리
			try {
				mfilename.transferTo(new File(upDir, pfile));
			} catch (IOException e) {				
				log.info("업로드 실패 : "+e);
				log.error(e);
			}
		}
		
		int n = service.editPetInfo(pet);
		String str = (n>0)? "반려동물 정보 수정 완료":"반려동물 정보 수정 실패";
		String loc = (n>0)? "petinfo":"javascript:history.back()";
		
		log.info(str+" / "+loc);
		m.addAttribute("msg", str);
		m.addAttribute("loc", loc);
		
		return "message";
	}
	
	
	// 삭제 처리
	@PostMapping("/deletePet")
	public String delPetInfo(Model m, @RequestParam("pno") int pno, HttpSession session) {
		
		UserModelVO petInfo = this.service.getPetInfo(pno);
		
		int n = service.delPetInfo(petInfo);
		
		String upDir = session.getServletContext().getRealPath("/resources/pet_upload");
		
		//서버에 첨부한 파일이 있다면 서버에서 삭제 처리
		if(n>0 && petInfo.getImage()!=null) {
			File f = new File(upDir, petInfo.getImage());
			if(f.exists()) {
				boolean b = f.delete();
				log.info("파일 삭제 여부: "+ b);
			}
		}
		
		String str = (n>0)? "반려동물 정보 삭제 완료":"반려동물 정보 삭제 실패";
		String loc = (n>0)? "petinfo":"javascript:history.back()";
		
		log.info(str+" / "+loc);
		m.addAttribute("msg", str);
		m.addAttribute("loc", loc);
		
		return "message";
		
	}
	
	
	
	// 리뷰쓰기로 이동
	 @PostMapping("/reviewBoardWrite") 
	 public String goReview(Model m, @RequestParam("snickname") String snickname) {
		 
		 int ino = reserveService.getInoBySnickname(snickname);
		 
		 m.addAttribute("snickname", snickname);
		 m.addAttribute("ino", ino);
		 
		 return "review/reviewBoardWrite"; 
	 }
	 
	 
	 // 회원정보 수정
	@RequestMapping(value="/editG", method=RequestMethod.GET)
	public String generalEditForm(Model model,@ModelAttribute UserVO user, HttpSession session) {
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		int loginIdx = loginUser.getIdx();
		log.info("loginIdx: "+loginIdx);
		
		if (loginUser.getIdx() == 0) {
			return "redirect:page";
		}
		
		user = service.getUserInfo(loginIdx);
		log.info("user=="+user);
		
		model.addAttribute("user", user);
		
		return "general/gmember_edit";
	}
		
		
	@RequestMapping(value="/editG", method=RequestMethod.POST)
	public String editProcess(Model m, @ModelAttribute UserVO user) {
		
		int n = service.editUserInfo(user);
		String str = (n>0)? "회원정보 수정 완료":"회원정보 수정 실패";
		String loc = (n>0)? "page":"javascript:history.back()";
		
		log.info(str+" / "+loc);
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
	
	
	// 찜
	@ResponseBody
	@GetMapping(value="/heart.do", produces="application/json")
	public ModelMap wishAdd(@RequestParam int ino, HttpSession session, Model m) {
		ModelMap map=new ModelMap();
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		if(loginUser==null) {
			map.put("result", -2);
			return map;
		}
		String unickname_fk ="";
		if(loginUser!=null) {
			unickname_fk=loginUser.getNickname();
		}
		IntroduceVO wishSitterInfo = wishService.wishSitterInfo(ino);
		
		WishVO wish = new WishVO();
		wish.setIno(ino);
		wish.setUnickname(unickname_fk);
		wish.setSnickname(wishSitterInfo.getNickname());
		wish.setSaddr(wishSitterInfo.getAddr());
		wish.setTitle(wishSitterInfo.getTitle());

		log.info("wish: "+wish);
		
		int check = wishService.wishCheck(wish);
		int n = 0;
		
		if (check == 0) {
			n = wishService.addWish(wish);
			log.info("n: "+n);
		}
		
		
		map.put("result", n);
		
		
		return map;
	}
	
	
	@ResponseBody
	@GetMapping(value="/removeHeart.do", produces="application/json")
	public ModelMap wishDel(@RequestParam int ino, HttpSession session) {
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		String unickname_fk = loginUser.getNickname();
		
		WishVO wish = new WishVO();
		wish.setIno(ino);
		wish.setUnickname(unickname_fk);
		log.info("vo: "+wish);
		
		int n = wishService.delWish(wish);
		log.info("n: "+n);
		
		ModelMap map = new ModelMap();
		map.put("result", n);
		
		return map;
	}
	
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
