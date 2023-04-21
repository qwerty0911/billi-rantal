package com.billi.model;

import java.util.List;

import com.billi.vo.ReviewsVO;

public class ReviewsService {
	ReviewsDAO dao = new ReviewsDAO();
	
	public List<ReviewsVO> myReview(String review_writer) {
		return dao.myReview(review_writer);
	}
	public int reviewWrite(ReviewsVO reviews) {
		return dao.reviewWrite(reviews);
	}
	public List<ReviewsVO> boardReview(int board_id) {
		return dao.boardReview(board_id);
	}
	public int countReview(int board_id) {
		return dao.countReview(board_id);
	}
	public double avgRating(int board_id) {
		return dao.avgRating(board_id);
	}
}
