package com.billi.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.billi.frontcontroller.CommonControllerInterface;
import com.billi.model.BoardsService;

public class BoardListController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String page = "boardlist.jsp";
		String method=(String) data.get("method");
		HttpServletRequest request =(HttpServletRequest)data.get("request");
		if(method.equals("GET")) {
			//페이지번호 출력
			int currentPage = Integer.parseInt(request.getParameter("pageNum"));

			BoardsService service = new BoardsService();
			String pagelist = service.readList(currentPage,request);
			request.setAttribute("pagelist", pagelist);

		}
		return page;
	}

}
