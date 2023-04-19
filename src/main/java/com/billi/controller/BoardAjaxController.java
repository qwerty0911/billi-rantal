package com.billi.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.billi.frontcontroller.CommonControllerInterface;
import com.billi.model.BoardsService;
import com.billi.vo.BoardsVO;

public class BoardAjaxController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		BoardsService service = new BoardsService();
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		
		//현재의 페이지 번호 받아오기
		int currentPage = Integer.parseInt(request.getParameter("pageNum"));
		//카테고리 받아오기
		String category = request.getParameter("category");
		System.out.println(category);
		//페이지번호에 해당하는 게시글 목록 보여주기
		service.printBoard(currentPage, request, category);
		List<BoardsVO> boardlist = (List<BoardsVO>) request.getAttribute("boardlist");
		
		JSONArray arr = new JSONArray();
		for (BoardsVO board : boardlist) {
			JSONObject obj = new JSONObject();
			obj.put("board_id", board.getBoard_id());
			obj.put("board_title", board.getBoard_title());
			obj.put("address", board.getAddress());
			obj.put("price", board.getPrice());
			obj.put("board_date", board.getBoard_date().toString());
			obj.put("board_contents", board.getBoard_contents());
			obj.put("board_writer", board.getBoard_writer());
			obj.put("category", board.getCategory());
			obj.put("pictures", board.getPictures());
			arr.add(obj);
		}
		JSONObject boardsObject = new JSONObject();
		boardsObject.put("boardlist", arr);
		return "responseBody:" + boardsObject.toJSONString();
	}
}