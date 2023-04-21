package com.billi.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.billi.frontcontroller.CommonControllerInterface;
import com.billi.model.RentalManageService;

public class RentalConfirmController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String method = (String)data.get("method");
		String page = "/";
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		
		if(method.equals("GET")) {
			
		}else { 
			//렌탈확정 레코드 추가
			
			int rental_code = Integer.parseInt(request.getParameter("rental_code"));
			RentalManageService rentalManageService= new RentalManageService();
			rentalManageService.rentalConfirm(rental_code);
			
			page = "/user/myrental.do";

		}
		
		return page;
	}

}
