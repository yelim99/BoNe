package com.reviewboard.service;

import java.util.List;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.find.model.IntroduceVO;
import com.reviewboard.mapper.ReviewBoardMapper;
import com.reviewboard.model.ReplyVO;
import com.reviewboard.model.ReviewBoardVO;

@Service("reviewBoardService")
@Repository
public class ReviewBoardServiceImpl implements ReviewBoardService {
	
	@Autowired
	private ReviewBoardMapper reviewBoardMapper;

	@Override
	public int insertReviewBoard(ReviewBoardVO rb) {
		return this.reviewBoardMapper.insertReviewBoard(rb);
	}

	@Override
	public List<ReviewBoardVO> selectReviewBoard() {
		return this.reviewBoardMapper.selectReviewBoard();
	}

	@Override
	public ReviewBoardVO selectReviewByRno(int rno) {
		return this.reviewBoardMapper.selectReviewByRno(rno);
	}

	@Override
	public String findNicknameByRno(int rno) {
		return this.reviewBoardMapper.findNicknameByRno(rno);
	}

	@Override
	public int insertReply(ReplyVO rp) {
		return this.reviewBoardMapper.insertReply(rp);
	}

	@Override
	public List<ReplyVO> selectReplyByRno(int rno) {
		return this.reviewBoardMapper.selectReplyByRno(rno);
	}

	@Override
	public int getTotalReply(int rno) {
		return this.reviewBoardMapper.getTotalReply(rno);
	}

	@Override
	public int updateReview(ReviewBoardVO rb) {
		return this.reviewBoardMapper.updateReview(rb);
	}

	@Override
	public int deleteReview(int rno) {
		return this.reviewBoardMapper.deleteReview(rno);
	}

	@Override
	public int deleteReReview(int rno) {
		return this.reviewBoardMapper.deleteReReview(rno);	// rno에 해당하는 댓글 다 지우기 (리뷰 없애려고)
	}

	@Override
	public int deleteReply(int rrno) {
		return this.reviewBoardMapper.deleteReply(rrno); // rrno에 해당하는 댓글 하나만 지우기
	}

	@Override
	public int updateReply(ReplyVO rp) {
		return this.reviewBoardMapper.updateReply(rp);
	}

	@Override
	public List<IntroduceVO> selectIntroduce() {
		return this.reviewBoardMapper.selectIntroduce();
	}

	@Override
	public List<ReviewBoardVO> selectReviewByNickname(String nickname) {
		return this.reviewBoardMapper.selectReviewByNickname(nickname);
	}

	@Override
	public String getSnicknameByIno(int ino) {
		return this.reviewBoardMapper.getSnicknameByIno(ino);
	}


	
}
