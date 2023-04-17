package com.billi.controller;

import java.util.Map;

import com.billi.frontcontroller.CommonControllerInterface;

public class BoardListController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String page = "boardlist.jsp";
		return page;
	}

}
