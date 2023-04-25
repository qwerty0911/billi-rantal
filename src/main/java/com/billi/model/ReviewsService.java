package com.billi.model;

import java.util.List;

import com.billi.vo.Board_RentalVO;
import com.billi.vo.ReviewsVO;

public class ReviewsService {
	ReviewsDAO dao = new ReviewsDAO();
	
	public String reviewDelete(int review_id) {
		int result = dao.reviewDelete(review_id);
		return result > 0?"삭제성공":"삭제실패";
	}
	
	public List<Board_RentalVO> myReview(String review_writer) {
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
