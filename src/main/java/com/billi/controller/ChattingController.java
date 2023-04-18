package com.billi.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.billi.frontcontroller.CommonControllerInterface;

public class ChattingController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String method = (String)data.get("method");
		String page = "/chatting/chatting.jsp";
		if(method.equals("GET")) {
		}else { 
		}
		
		return page;
	}

}
