package com.billi.frontcontroller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.billi.model.RentalManageService;
import com.billi.model.RentalService;
import com.billi.model.ReviewsService;
import com.billi.vo.Board_RentalVO;
import com.billi.vo.MembersVO;
import com.billi.vo.RentalManageVO;

public class MyrentalController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		HttpSession session = request.getSession();
		
		MembersVO user_vo = (MembersVO) session.getAttribute("loginUser");
		String user_nick = user_vo.getNickname();
		
		//빌린 내력, 내 물건 관리
		RentalService service = new RentalService();
		List<Board_RentalVO> borrowlist = service.myRental(user_nick);
		List<Board_RentalVO> lentList = service.myLentList(user_nick);
		
		request.setAttribute("borrowllist", borrowlist);
		request.setAttribute("lentList", lentList);
		
		//확정내역, 반납내역
		RentalManageService manageservice = new RentalManageService();
		List<Integer> rentalConfirmList = manageservice.confirmedRentalList(user_nick);
		List<Integer> returnConfirmList = manageservice.confirmedReturnList(user_nick);
		
		request.setAttribute("rentalConfirmList", rentalConfirmList);
		request.setAttribute("returnConfirmList", returnConfirmList);
		
		
		//ReviewsService reviewservice = new ReviewsService(); int myReviewCount =
		//reviewservice.myReviewCount(0, user_nick);
		
		return "myrentallist.jsp";
	}

}
