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
		System.out.println(method);
		if(method.equals("GET")) {
			int id = Integer.parseInt(request.getParameter("num"));

			BoardsService service = new BoardsService();
			BoardsVO board = service.selectById(id);
			System.out.println("-------------------");
			System.out.println(board);
			request.setAttribute("board", board);
			
			//이미지 여러장 배열 처리
			System.out.println( board.getPictures());
			if(board.getPictures()==null) {
				request.setAttribute("images", null);
			}
			else {
//				String[] images = board.getPictures().split(",");
//				System.out.println(board.getPictures());
//				System.out.println(images.toString());
//				request.setAttribute("images", images);
			}
			

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
