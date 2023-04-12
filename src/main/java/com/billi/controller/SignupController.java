package com.billi.controller;

import java.util.Map;

import com.billi.frontcontroller.CommonControllerInterface;

public class SignupController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String method = (String)data.get("method");
		String page="";
		if(method.equals("GET")) {
			page = "signup.jsp";
		}else { //db에 유저 정보 저장
			
		}
		return page;
	}

}
