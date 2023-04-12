package com.billi.controller;


import java.util.Map;

import com.billi.frontcontroller.CommonControllerInterface;

public class LoginController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String method = (String)data.get("method");
		String page="";
		if(method.equals("GET")) {
			page = "login.jsp";
		}else { //유저정보 세션에 저장
			
		}
		return page;
	}
}