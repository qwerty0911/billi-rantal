package com.billi.controller;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.billi.frontcontroller.CommonControllerInterface;
import com.billi.model.BoardsService;
import com.billi.vo.BoardsVO;

public class BoradwriteController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String method = (String)data.get("method");
		String page="";
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		HttpSession session = request.getSession();
		if(method.equals("GET")) { //글 작성 입력 폼
			page = "boardwrite.jsp";
			
			BoardsService service = new BoardsService();
			request.setAttribute("clist", service.selectCategory());
		}else { //글 작성 후 저장
			BoardsVO board = makeBoard(request);
			BoardsService service = new BoardsService();
			int result = service.boardInsert(board);
			//재요청하기: Browser로 내려가서 새로운 요청
			page="redirect:boardwrite.do";
		}
		return page;
	}
	
	private BoardsVO makeBoard(HttpServletRequest request) throws UnsupportedEncodingException {
		//board_id, board_date: 자동 입력
		String board_title= request.getParameter("board_title");
		String board_contents= request.getParameter("board_contents");
		String board_writer=  request.getParameter("board_writer"); //세션에 저장된 회원 닉네임
		int price= Integer.parseInt(request.getParameter("price"));
		String pictures= request.getParameter("pictures"); //나중에..
		String address= request.getParameter("address"); //로그인 구현 후
		String category= request.getParameter("category_id");
		
		BoardsVO board = new BoardsVO();
		board.setAddress(address);
		board.setBoard_contents(board_contents);
		board.setBoard_title(board_title);
		board.setBoard_writer(board_writer);
		board.setCategory(category);
		board.setPictures(pictures);
		board.setPrice(price);
		
		System.out.println(board);
		return board;
	}

}