package com.billi.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.billi.frontcontroller.CommonControllerInterface;
import com.billi.model.BoardsService;
import com.billi.model.ReviewsService;
import com.billi.vo.BoardsVO;
import com.billi.vo.ReviewsVO;

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
			
			//이미지 여러장 배열 처리
			System.out.println( board.getPictures());
			if(board.getPictures()==null) {
				request.setAttribute("images", null);
			}
			else {
				String[] images = board.getPictures().split(",");
				request.setAttribute("images", images);
			}
			
			ReviewsService reviewservice = new ReviewsService();
			List<ReviewsVO> boardreviewlist = reviewservice.boardReview(id);
			request.setAttribute("boardreviewlist", boardreviewlist);
			
			int reviewcount = reviewservice.countReview(id);
			request.setAttribute("reviewcount", reviewcount);
			System.out.println("reviewcount : " + reviewcount);
			
			double ratingavg = reviewservice.avgRating(id);
			request.setAttribute("ratingavg", ratingavg);
			
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
