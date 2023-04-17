package com.billi.frontcontroller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.billi.model.MembersService;

public class nicknameDupCheckController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		String nickname = request.getParameter("nickname");
		System.out.println(nickname);
		
		MembersService service = new MembersService();
		int result = service.nicknameDupCheck(nickname);
		
		return "responseBody:" + result;
	}

}
