package com.reviewboard.controller;


import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.reserve.service.ReserveService;
import com.reviewboard.model.ReplyVO;
import com.reviewboard.model.ReviewBoardVO;
import com.reviewboard.service.ReviewBoardService;
import com.user.model.UserVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ReviewBoardController {

	@Autowired
	@Resource(name = "reviewBoardService")
	private ReviewBoardService rbService;

	@Resource(name = "ReserveService")
	private ReserveService reserveService;
	
	@GetMapping("/reviewBig")
	public String reviewBig(Model m, @RequestParam("rno") int rno, HttpSession session, HttpServletResponse response) {

		ReviewBoardVO rbVO = this.rbService.selectReviewByRno(rno);
		String st_nickname = this.rbService.findNicknameByRno(rno);
		List<ReplyVO> rpData = rbService.selectReplyByRno(rno);
		int total = rbService.getTotalReply(rno);
		
		m.addAttribute("reviewBoard", rbVO);
		m.addAttribute("rno", rno);
		m.addAttribute("st_nickname", st_nickname);
		m.addAttribute("reply", rpData);
		m.addAttribute("total", total);
		
		m.addAttribute("ino", reserveService.getInoBySnickname(st_nickname));
		
		UserVO uvo = (UserVO)session.getAttribute("loginUser");
		
		if (uvo != null) {
			session.setAttribute("writer", uvo.getNickname());
		} else {
			session.setAttribute("writer", null);
		}
		
		return "/review/reviewBig";
	}

	@PostMapping("/insertReviewBoard")
	public String insertReviewBoard(Model m, @ModelAttribute ReviewBoardVO rb,
			@RequestParam("mfilename") MultipartFile mf, @RequestParam("star") String star, 
			@RequestParam("ino") int ino, HttpSession session) {

		rb.setIno(ino);
		
		UserVO uvo = (UserVO)session.getAttribute("loginUser");
		session.setAttribute("writer", uvo.getNickname()); //?
		System.out.println(uvo.getNickname());
		
		rb.setNickname(uvo.getNickname());
		
		rb.setStar(star);

		log.info("reviewBoard==" + rb);

		// 1. 파일 업로드 처리 - [1] 업로드 디렉토리 절대경로 얻기(resources/board_upload)
		ServletContext app = session.getServletContext();
		String upDir = app.getRealPath("/resources/board_upload");
		File dir = new File(upDir);

		if (!dir.exists()) {
			dir.mkdirs();// 업로드 디렉토리 생성
		}

		if (!mf.isEmpty()) {// 첨부파일이 있다면

			// [2] 업로드한 파일명과 파일크기 알아내기==>setFilename(파일명), setFilesize(파일크기)
			String fname = mf.getOriginalFilename();// 원본파일명
			long fsize = mf.getSize();// 파일크기

			UUID uid = UUID.randomUUID();
			String rfile = uid.toString() + "_" + fname;

			rb.setRfile(rfile);

			// [3] 업로드 처리
			try {
				mf.transferTo(new File(upDir, rfile));
				log.info("upDir: " + upDir);

			} catch (IOException e) {
				log.error("파일업로드 에러: " + e);
			}

		}
		rbService.insertReviewBoard(rb);

		return "redirect:/general/user/page";
	}

	@PostMapping("/insertReply")
	public String insertReply(Model m, @ModelAttribute ReplyVO rp, @RequestParam("rno") int rno,
			@RequestParam("content") String content, HttpSession session) {

		rp.setRno(rno);
		
		UserVO uvo = (UserVO)session.getAttribute("loginUser");
		rp.setNickname(uvo.getNickname());
		
		rp.setContent(content);

		rbService.insertReply(rp);

		return "redirect:/reviewBig?rno=" + rno;
	}

	// 수정 폼 보여주기
	@PostMapping("/editReview")
	public String editReview(Model m, @ModelAttribute ReviewBoardVO vo, 
								@RequestParam("rno") int rno, @RequestParam("snickname") String snickname) {

		ReviewBoardVO rbVO = this.rbService.selectReviewByRno(rno);

		m.addAttribute("review", rbVO);
		m.addAttribute("snickname", snickname);

		return "review/reviewEdit";
	}// --------------------------------------
	
	// 수정 끝나서 다시 리뷰 보는 페이지로 돌아가기
	@PostMapping("/updateReview")
	public String updateReview(Model m, @ModelAttribute ReviewBoardVO vo, @RequestParam("rno") int rno,
			@RequestParam("mfilename") MultipartFile mf, @RequestParam("star") String star,
			@RequestParam("snickname") String snickname, HttpSession session) {

		vo.setIno(reserveService.getInoBySnickname(snickname));
		
		UserVO uvo = (UserVO)session.getAttribute("loginUser");
		vo.setNickname(uvo.getNickname());
		
		vo.setStar(star);

		// 1. 파일 업로드 처리 - [1] 업로드 디렉토리 절대경로 얻기(resources/board_upload)
		ServletContext app = session.getServletContext();
		String upDir = app.getRealPath("/resources/board_upload");
		File dir = new File(upDir);

		if (!dir.exists()) {
			dir.mkdirs();// 업로드 디렉토리 생성
		}

		if (!mf.isEmpty()) {// 첨부파일이 있다면

			// [2] 업로드한 파일명과 파일크기 알아내기==>setFilename(파일명), setFilesize(파일크기)
			String fname = mf.getOriginalFilename();// 원본파일명
			long fsize = mf.getSize();// 파일크기

			UUID uid = UUID.randomUUID();
			String rfile = uid.toString() + "_" + fname;

			vo.setRfile(rfile);

			// [3] 업로드 처리
			try {
				mf.transferTo(new File(upDir, rfile));
				log.info("upDir: " + upDir);

			} catch (IOException e) {
				log.error("파일업로드 에러: " + e);
			}

		}
		
		rbService.updateReview(vo);
		
		return "redirect:/reviewBig?rno=" + rno;
	}
	
	// 리뷰 삭제
	@PostMapping("/deleteReview")
	public String deleteReview(Model m,@RequestParam("rno") int rno, HttpSession session) {

		//해당 글을 DB에서 가져오기
		ReviewBoardVO vo = this.rbService.selectReviewByRno(rno);

		// db에서 글 삭제처리
		// 댓글이 있는지 확인( re_reple 테이블에 글이 있는 경우에만 삭제 작업 수행 )
		if (rbService.getTotalReply(rno) > 0) {
		    int n = rbService.deleteReReview(rno);
		}
		
		int nn = rbService.deleteReview(rno);
		
		String upDir = session.getServletContext().getRealPath("/resources/board_upload");
		
		//서버에 첨부한 파일이 있다면 서버에서 삭제 처리
		if(nn>0 && vo.getRfile()!=null) {
			File f = new File(upDir, vo.getRfile());
			if(f.exists()) {
				boolean b = f.delete();
				log.info("파일 삭제 여부: "+ b);
			}
		}
		
		return "redirect:/general/user/page";
	}//-----------------------------------
	
	
	// 댓글 삭제
	@PostMapping("/deleteReply")
	public String deleteReply(Model m,@RequestParam("rrno") int rrno , @RequestParam("rno") int rno) {
		
		int n = rbService.deleteReply(rrno);
		
		return "redirect:/reviewBig?rno=" + rno;
	}//-----------------------------------
	
	// 댓글 수정
	@PutMapping(value = "/updateReply/{rrno}", produces="application/json")
	@ResponseBody
	public ModelMap updateReply(@PathVariable("rrno") String rrno, @RequestBody ReplyVO vo )  {
		
		vo.setRrno(Integer.parseInt(rrno));
		rbService.updateReply(vo);
		
		ModelMap map = new ModelMap();
		map.addAttribute("result", "ok");
		
		return map;

	}
	
}
