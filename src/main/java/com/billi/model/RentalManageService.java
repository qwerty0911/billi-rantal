package com.billi.model;

import java.util.List;

import com.billi.vo.RentalManageVO;

public class RentalManageService {
	RentalManageDAO dao = new RentalManageDAO();
	
	public int rentalConfirm(int rental_code) {
		return dao.rentalConfirm(rental_code);
	}
	
	public int returnConfirm(int return_code) {
		return dao.returnConfirm(return_code);
	}
	
	public List<Integer> confirmedRentalList(String nickName){
		return dao.confirmedRentalList(nickName);
	}
	
	public List<Integer> confirmedReturnList(String nickName){
		return dao.confirmedReturnList(nickName);
	}
	
	public int rejectRental(int rental_code) {
		return dao.rejectRental(rental_code);
	}
}
