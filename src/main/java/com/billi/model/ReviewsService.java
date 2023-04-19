package com.billi.model;

import java.util.List;

import com.billi.vo.ReviewsVO;

public class ReviewsService {
	ReviewsDAO dao = new ReviewsDAO();
	
	public List<ReviewsVO> myReview(String review_writer) {
		return dao.myReview(review_writer);
	}
}
