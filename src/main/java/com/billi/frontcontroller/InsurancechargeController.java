package com.billi.frontcontroller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.billi.model.InsuranceService;
import com.billi.vo.InsuranceVO;

public class InsurancechargeController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String page="";
		String method = (String)data.get("method");
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		
		if(method.equals("GET")) {
			page = "myrentallist.jsp";
		}else {
			InsuranceVO insurance = makeInsurance(request);
			InsuranceService service = new InsuranceService();
			String result = service.InsuranceCharge(insurance);
			String path = request.getContextPath();
			
			page = "redirect:"+ path + "/user/myrental.do";
		}
		
		return page;
	}
	private InsuranceVO makeInsurance(HttpServletRequest request) {
		String charge_type = request.getParameter("charge_type");
		String picture = request.getParameter("picture");
		String charge_content = request.getParameter("charge_content");
		int rental_code = Integer.parseInt(request.getParameter("rental_code"));
		
		InsuranceVO insurance = new InsuranceVO();
		insurance.setCharge_type(charge_type);
		insurance.setPicture(picture);
		insurance.setCharge_content(charge_content);
		insurance.setRental_code(rental_code);
		
		return insurance;
	}
}
