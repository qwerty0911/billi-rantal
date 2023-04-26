package com.billi.frontcontroller;

import java.sql.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.billi.model.BoardsService;
import com.billi.model.MembersService;
import com.billi.util.DateUtil;
import com.billi.vo.BoardsVO;
import com.billi.vo.MembersVO;

public class BoardupdateController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String method = (String)data.get("method");
		String page = "boardupdate.jsp";
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		
		if(method.equals("GET")) {
			int board_id = Integer.parseInt(request.getParameter("board_id"));
			BoardsService service = new BoardsService();
			BoardsVO board = service.selectByBoardid(board_id);
			request.setAttribute("board", board);
			request.setAttribute("clist", service.selectCategory());
			
		} else {
			BoardsVO board = makeBoards(request);
			BoardsService service = new BoardsService();
			String message = service.boardUpdate(board);
			page = "redirect:boardlist.do?pageNum=1&category=all";
		}
		return page;
	}
	
	private BoardsVO makeBoards(HttpServletRequest request) {
		int board_id = Integer.parseInt(request.getParameter("board_id"));
		String board_title = request.getParameter("board_title");
		String board_contents = request.getParameter("board_contents");
		String board_writer = request.getParameter("board_writer");
		Date board_date = DateUtil.convertToDate(request.getParameter("board_date"));
		String address = request.getParameter("address");
		String category = request.getParameter("category");
		int price = Integer.parseInt(request.getParameter("price"));
		String pictures = request.getParameter("pictures");
		
		BoardsVO board = new BoardsVO();
		board.setBoard_id(board_id);
		board.setBoard_title(board_title);
		board.setBoard_contents(board_contents);
		board.setBoard_writer(board_writer);
		board.setBoard_date(board_date);
		board.setAddress(address);
		board.setCategory(category);
		board.setPictures(pictures);
		board.setPrice(price);
		
		return board;
	}

}
