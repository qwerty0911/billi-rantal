package com.billi.frontcontroller;

import java.util.Map;

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
