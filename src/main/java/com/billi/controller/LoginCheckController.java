package com.billi.controller;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.connector.Response;

import com.billi.frontcontroller.CommonControllerInterface;
import com.billi.model.MembersService;
import com.billi.vo.MembersVO;

public class LoginCheckController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String method = (String)data.get("method");
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		HttpSession session = request.getSession();
		String page="";
		if(method.equals("GET")) {
			page = "login.jsp";
		}else { //유저정보 세션에 저장
			
			String mem_id = request.getParameter("mem_id");
			String pw = request.getParameter("pw");
			MembersService service = new MembersService();
			MembersVO member = service.loginCheck(mem_id, pw);
			
			ServletContext app = request.getServletContext();
			
			Object obj = (List<MembersVO>)app.getAttribute("userList");
			List<MembersVO> userList = null;
			if(member!=null) {
				if(obj==null) {
					userList = new ArrayList<>();
				} else {
					userList = (List<MembersVO>)obj;
				}
				userList.add(member);
				app.setAttribute("userList", userList);
				System.out.println("-----------로그인한 사람 리스트-----------------");
				for(MembersVO vo : userList) {
					System.out.println(vo);
				}
				System.out.println("---------------------------------------------");
				//로그인 성공
				session.setAttribute("loginUser", member);
				session.setAttribute("message", "");
				String path = request.getContextPath();
				page = "redirect:"+ path + "/board/boardlist.do";
			} else {
				//로그인 실패
				session.setAttribute("message", "잘못된 ID 또는 비밀번호입니다.");
				page = "redirect:loginCheck.do";
			}
			
		}
		return page;
	}
}