package com.billi.model;

public class RentalManageService {
	RentalManageDAO dao = new RentalManageDAO();
	
	public int rentalConfirm(int rental_code) {
		return dao.rentalConfirm(rental_code);
	}
	
	public int returnConfirm(int return_code) {
		return dao.returnConfirm(return_code);
	}
	
}
