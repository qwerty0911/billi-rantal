package com.billi.controller;

import java.sql.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.billi.frontcontroller.CommonControllerInterface;
import com.billi.model.BoardsService;
import com.billi.model.RentalService;
import com.billi.util.DateUtil;
import com.billi.vo.BoardsVO;
import com.billi.vo.MembersVO;
import com.billi.vo.RentalVO;

public class RentalController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String method = (String)data.get("method");
		String page = "../board/boarddetail.jsp";
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		
		if(method.equals("GET")) {
			
			
		}else { 
			//렌탈정보 레코드 추가
			RentalVO vo = makeRentalVO(request);
			RentalService rentalService = new RentalService();
			rentalService.registRental(vo);
			
			BoardsService boardService = new BoardsService();
			BoardsVO board = boardService.selectByBoardid(vo.getBoard_id());
			request.setAttribute("board", board);
			page = "../board/boarddetail.jsp";

		}
		
		return page;
	}

	private RentalVO makeRentalVO(HttpServletRequest request) {
		
		System.out.println("request"+request);
		
		//날짜
		Date rental_date = DateUtil.convertToDate2(request.getParameter("rental_date"));
		Date exp_date = DateUtil.convertToDate2(request.getParameter("exp_date"));
		
		//user nickname
		HttpSession session = request.getSession();
		MembersVO user = (MembersVO) session.getAttribute("loginUser");
		String user_nick = user.getNickname();
		
		//board_id
		//int board_id = Integer.parseInt((String)request.getAttribute("board_id"))  ;
		int board_id = Integer.parseInt(request.getParameter("board_id")); 
		String owner_nick = request.getParameter("board_writer"); 
		//System.out.println("board_id==>"+request.getParameter("board_id"));
		
		int insurance_fee = Integer.parseInt(request.getParameter("insurance_fee"));
		
		RentalVO vo = new RentalVO();
		vo.setNickname(user_nick);
		vo.setRental_date(rental_date);
		vo.setExp_date(exp_date);
		vo.setBoard_id(board_id);
		vo.setOwner_nick(owner_nick);
		vo.setInsurance_fee(insurance_fee);
		
		return vo;
	}

}
