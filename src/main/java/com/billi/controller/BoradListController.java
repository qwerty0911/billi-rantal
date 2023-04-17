package com.billi.controller;

import java.util.Map;

import com.billi.frontcontroller.CommonControllerInterface;

public class BoradListController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String method = (String)data.get("method");
		String page="";
		if(method.equals("GET")) {
			page = "boardlist.jsp";
		}else { 
			
		}
		return page;
	}

}
