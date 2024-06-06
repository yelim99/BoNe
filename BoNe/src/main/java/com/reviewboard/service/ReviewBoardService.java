package com.reviewboard.service;

import java.util.List;


import java.util.Map;

import org.springframework.stereotype.Service;

import com.find.model.IntroduceVO;
import com.reviewboard.model.ReplyVO;
import com.reviewboard.model.ReviewBoardVO;

@Service
public interface ReviewBoardService {

	int insertReviewBoard(ReviewBoardVO rb); // 리뷰 넣기
	
 	List<ReviewBoardVO> selectReviewBoard(); // 리뷰 갖고오기
 	
	ReviewBoardVO selectReviewByRno(int rno); // 후기글번호에 해당하는 리뷰 가져오기
	
	String findNicknameByRno(int rno); // 리뷰 상세페이지에서 펫시터 넥네임 갖고오기
	
	// 리뷰 수정 & 삭제 ---------
	int updateReview(ReviewBoardVO rb); // 리뷰 수정
	int deleteReview(int rno);
	int deleteReReview(int rno);
	
	// 리뷰 댓글--------
	int insertReply(ReplyVO rp); // 리뷰에 댓글 넣기
	
	List<ReplyVO> selectReplyByRno(int rno); // rno리뷰의 댓글들 갖고오기
	
	int getTotalReply(int rno); // rno에 해당하는 리뷰의 댓글 개수 가져오기

	int deleteReply(int rrno); // rrno에 해당하는 댓글 삭제

	int updateReply(ReplyVO rp); // rrno에 해당하는 댓글 수정

	List<ReviewBoardVO> selectReviewByNickname(String nickname);
	
	List<IntroduceVO> selectIntroduce(); // 메인페이지에 info 넣기

	String getSnicknameByIno(int ino);
	
}
