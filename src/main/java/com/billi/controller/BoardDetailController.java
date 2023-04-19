package com.billi.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.billi.frontcontroller.CommonControllerInterface;
import com.billi.model.BoardsService;
import com.billi.vo.BoardsVO;

public class BoardDetailController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String method=(String) data.get("method");
		String page="boarddetail.jsp";
		HttpServletRequest request =(HttpServletRequest)data.get("request");
		if(method.equals("GET")) {
			int id = Integer.parseInt(request.getParameter("num"));

			BoardsService service = new BoardsService();
			BoardsVO board = service.selectById(id);
			request.setAttribute("board", board);

		} else {
//			//수정
//			BoardsVO  board = makeBoard(request);
//			BoardsService service = new BoardsService();
//			String message = service.boardUpdate( board);
//
//			page="redirect:boarddetail.do";
		}
		return page;
	}

}
