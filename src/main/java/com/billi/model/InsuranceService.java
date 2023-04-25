package com.billi.model;

import java.util.List;

import com.billi.vo.InsuranceVO;

public class InsuranceService {
	InsuranceDAO dao = new InsuranceDAO();
	
	public int countInsurance(int rental_code) {
		return dao.countInsurance(rental_code);
	}
	public String InsuranceCharge(InsuranceVO insurance) {
		int result = dao.InsuranceCharge(insurance);
		return result > 0?"insert성공":"insert실패";
	}
	public List<InsuranceVO> myInsuranceList(int rental_code) {
		return dao.myInsuranceList(rental_code);
	}
}
