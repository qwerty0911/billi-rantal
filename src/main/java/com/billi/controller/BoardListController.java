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
			String category = request.getParameter("category");

			BoardsService service = new BoardsService();
			String pagelist = service.readList(currentPage,request, category);
			request.setAttribute("pagelist", pagelist);
			
			//카테고리 출력
			category=convertCategory(category);
			request.setAttribute("category", category);

		}
		return page;
	}
	
	//카테고리 변환
	private String convertCategory(String cateNum) {
		String category="";
		switch(cateNum) {
		case "toy": category="유아동/완구"; break;
		case "digital": category="디지털/가전"; break;
		case "sports": category="레저/스포츠"; break;
		case "life": category="주방/생활용품"; break;
		case "interior": category="가구/인테리어"; break;
		case "hobby": category="취미/악기/게임"; break;
		default: category="전체";
		}
		return category;
	}

}
