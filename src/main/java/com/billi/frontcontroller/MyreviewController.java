package com.billi.frontcontroller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.billi.model.ReviewsService;
import com.billi.vo.Board_RentalVO;
import com.billi.vo.MembersVO;
import com.billi.vo.ReviewsVO;

public class MyreviewController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		HttpSession session = request.getSession();
		
		MembersVO user_vo = (MembersVO) session.getAttribute("loginUser");
		String user_nick = user_vo.getNickname();
		
		ReviewsService service = new ReviewsService();
		List<Board_RentalVO> reviewlist = service.myReview(user_nick);
		System.out.println(reviewlist);
		System.out.println("user_vo : " + user_vo);
		
		request.setAttribute("reviewlist", reviewlist);
		return "myreviewlist.jsp";
	}

}
