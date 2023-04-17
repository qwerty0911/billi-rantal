package com.billi.frontcontroller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.billi.model.MembersService;

public class idDupCheckController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		String mem_id = request.getParameter("mem_id");
		System.out.println(mem_id);
		
		MembersService service = new MembersService();
		int result = service.idDupCheck(mem_id);
		
		return "responseBody:" + result;
	}

}
