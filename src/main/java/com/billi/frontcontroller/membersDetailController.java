package com.billi.frontcontroller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.billi.model.MembersService;
import com.billi.vo.MembersVO;

public class membersDetailController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String method = (String)data.get("method");
		String page = "membersDetail.jsp";
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		
		if(method.equals("GET")) {
			String mem_id = request.getParameter("mem_id");
			MembersService service = new MembersService();
			MembersVO members = service.selectByid(mem_id);
			request.setAttribute("members", members); 
			
		} else {
			MembersVO members = makeMembers(request);
			MembersService service = new MembersService();
			String message = service.membersUpdate(members);
			
			request.getSession(false).invalidate();
			
			
			page = "redirect:loginCheck.do";
		}
		return page;
	}
	
	private MembersVO makeMembers(HttpServletRequest request) {
		String mem_id = request.getParameter("mem_id");
		String pw = request.getParameter("pw");
		String mem_name = request.getParameter("mem_name");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String nickname = request.getParameter("nickname");
		
		MembersVO members = new MembersVO();
		members.setMem_id(mem_id);
		members.setPw(pw);
		members.setMem_name(mem_name);
		members.setPhone(phone);
		members.setAddress(address);
		members.setNickname(nickname);
		
		return members;
	}
}
