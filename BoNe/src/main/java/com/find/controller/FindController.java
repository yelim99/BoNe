package com.find.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.find.model.IntroduceVO;
import com.find.model.PagingVO;
import com.find.model.WishVO;
import com.find.service.FindService;
import com.find.service.SitterFindService;
import com.find.service.WishService;
import com.reviewboard.model.ReviewBoardVO;
import com.sitter.model.SitterVO;
import com.sitter.service.SitterService;
import com.user.model.UserVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/shop")
@Log4j
public class FindController {

	@Autowired
	@Resource(name = "FindService")
	private FindService fService;

	@Resource(name = "sitterFindService")
	private SitterFindService sitterFindService;
	
	@Resource(name="wishService")
	private WishService wishService;
	
	@Inject
	private SitterService sitterService;
	

	// 페이징
	@GetMapping("/find")
	public String findSitterPaging(Model m, HttpServletRequest req, @ModelAttribute PagingVO paging) {

		HttpSession session = req.getSession();

		// 1. 총 게시글 수 가져오기 or 검색한 게시글 수 가져오기
		int total = sitterFindService.getTotalCount(paging);
		paging.setTotalCount(total);
		paging.setPagingBlock(5);

		paging.paging(session);

		log.info("paging: " + paging);

		// 2. 게시글 목록 가져오기 or 검색한 게시글 목록 가져오기
		List<IntroduceVO> introduce = sitterFindService.selectPaging(paging);
		String myctx = req.getContextPath();
		String loc = "shop/find";

		// 3. 페이지 네비게이션 문자열 받아오기
		String pageNavi = paging.pageNavi(myctx, loc);

		m.addAttribute("paging", paging);
		m.addAttribute("introduce", introduce);
		m.addAttribute("pageNavi", pageNavi);

		return "shop/find";

	}

	@GetMapping("/info/{ino}")
	public String sitterInfo(Model model, HttpServletRequest req, @ModelAttribute IntroduceVO introVO,
					@RequestParam(defaultValue="1")String nickname,
					@RequestParam(defaultValue="1")String title,
					@RequestParam(defaultValue="1")String addr,
					@RequestParam(defaultValue="1")String addr1,
					@RequestParam(defaultValue="1")String content,
					@RequestParam(defaultValue="1")String short_content,
					@RequestParam(defaultValue="1")String license,
					@RequestParam(defaultValue="0")int sPDP, @RequestParam(defaultValue="0")int sPAP,
					@RequestParam(defaultValue="0")int mPDP, @RequestParam(defaultValue="0")int mPAP,
					@RequestParam(defaultValue="0")int lPDP, @RequestParam(defaultValue="0")int lPAP,
					@RequestParam(defaultValue="1")int sumStar,@RequestParam(defaultValue="1")int cntStar,
					@RequestParam(defaultValue="0")int wish, @RequestParam(defaultValue="0")int cntReple,
					@RequestParam(defaultValue="0")String img,@PathVariable("ino") int ino
			) {
		
		IntroduceVO vo = this.fService.selectIntroduceByIno(ino);
		
		model.addAttribute("vo", vo);
		
		
		nickname = this.fService.selectNickname(ino);
		title = this.fService.selectTitle(ino);
		addr = this.fService.selectAddr(ino);
		
		content = this.fService.selectContent(ino);
		short_content = this.fService.selectShortContent(ino);
		license = this.fService.selectLicense(ino);
		try {
			sPDP = this.fService.selectSPetDayPrice(ino);
			sPAP = this.fService.selectSPetAllPrice(ino);
			mPDP = this.fService.selectMPetDayPrice(ino);
			mPAP = this.fService.selectMPetAllPrice(ino);
			lPDP = this.fService.selectLPetDayPrice(ino);
			lPAP = this.fService.selectLPetAllPrice(ino);
		} catch(Exception e) {
			sPDP = 0;
			sPAP = 0;
			mPDP = 0;
			mPAP = 0;
			lPDP = 0;
			lPAP = 0;
		}
		
		try {
		sumStar = this.fService.getSumStar(ino);
		cntStar = this.fService.getCntStar(ino);
		}catch(Exception e) {
			sumStar=0;
			cntStar=1;
		}
		
		try {
			wish = this.fService.getWish(ino);
		}catch(Exception e) {
			wish = 0;
		}
		System.out.println("wish="+wish);
		try {
			cntReple = this.fService.getCntReple(ino);
		}catch(Exception e) {
			cntReple=0;
		}
		
		img=this.fService.selectImg(ino);
		
		
		addr1 = this.fService.addr1(nickname);
		model.addAttribute("addr1", addr1);
		
		model.addAttribute("selectNickname", nickname);
		model.addAttribute("selectTitle", title);
		model.addAttribute("selectAddr", addr);
		model.addAttribute("selectContent",content);
		model.addAttribute("selectShortContent",short_content);
		model.addAttribute("license",license);
		
		model.addAttribute("sPetDayPrice",sPDP);
		model.addAttribute("sPetAllPrice",sPAP);
		model.addAttribute("mPetDayPrice",mPDP);
		model.addAttribute("mPetAllPrice",mPAP);
		model.addAttribute("lPetDayPrice",lPDP);
		model.addAttribute("lPetAllPrice",lPAP);

		model.addAttribute("SumStar",sumStar);
		model.addAttribute("CntStar",cntStar);
		
		model.addAttribute("getWish",wish);
		model.addAttribute("CntReple",cntReple);
		
		String[] serviceList = this.fService.selectService(ino).split(",");
		
		List<ReviewBoardVO> rvo = this.fService.selectRepleAll(ino);
		
		model.addAttribute("selectRepleAll",rvo);
		model.addAttribute("service",serviceList);
		model.addAttribute("Img",img);
		
		/* 달력 데이터 */
		List<SitterVO> svo = sitterService.getSitterUsed(nickname);
		req.setAttribute("sittervo", svo);

		
		return "shop/detail";
	}
	
	
	@ResponseBody
	@GetMapping(value="info/{ino}/heart.do", produces="application/json")
	public ModelMap wishAdd(@PathVariable("ino") int ino, HttpSession session, Model m) {
		//log.info("ino==="+ino);
		System.out.println("ino=="+ino);
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
	@GetMapping(value="/info/{ino}/removeHeart.do", produces="application/json")
	public ModelMap wishDel(@PathVariable("ino") int ino, HttpSession session) {
		
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

	
		// 리뷰 많은 순
		@GetMapping("/findReviewHigh")
		public String findReviewHighSitterPaging(Model m, HttpServletRequest req, @ModelAttribute PagingVO paging) {

			HttpSession session = req.getSession();

			// 1. 총 게시글 수 가져오기 or 검색한 게시글 수 가져오기
			int total = sitterFindService.getTotalCount(paging);
			paging.setTotalCount(total);
			paging.setPagingBlock(5);

			paging.paging(session);

			log.info("paging: " + paging);

			// 2. 게시글 목록 가져오기 or 검색한 게시글 목록 가져오기
			List<IntroduceVO> introduce = sitterFindService.selectByReviewCount(paging);
			String myctx = req.getContextPath();
			String loc = "shop/findReviewHigh";
			
			// 3. 페이지 네비게이션 문자열 받아오기
			String pageNavi = paging.pageNavi(myctx, loc);

			m.addAttribute("paging", paging);
			m.addAttribute("introduce", introduce);
			m.addAttribute("pageNavi", pageNavi);

			return "shop/findReviewHigh";

		}
		
		// 리뷰 평점 높은 순
		@GetMapping("/findStarHigh")
		public String findStarHighSitterPaging(Model m, HttpServletRequest req, @ModelAttribute PagingVO paging) {

			HttpSession session = req.getSession();

			// 1. 총 게시글 수 가져오기 or 검색한 게시글 수 가져오기
			int total = sitterFindService.getTotalCount(paging);
			paging.setTotalCount(total);
			paging.setPagingBlock(5);

			paging.paging(session);

			log.info("paging: " + paging);

			// 2. 게시글 목록 가져오기 or 검색한 게시글 목록 가져오기
			List<IntroduceVO> introduce = sitterFindService.selectByStarHigh(paging);
			String myctx = req.getContextPath();
			String loc = "shop/findStarHigh";

			// 3. 페이지 네비게이션 문자열 받아오기
			String pageNavi = paging.pageNavi(myctx, loc);

			m.addAttribute("paging", paging);
			m.addAttribute("introduce", introduce);
			m.addAttribute("pageNavi", pageNavi);

			return "shop/findStarHigh";

		}
	
}
