package com.billi.model;

import com.billi.vo.RentalVO;

public class RentalService {
	
	RentalDAO rentalDAO = new RentalDAO();
	
	public int registRental(RentalVO rentalvo) {
		return rentalDAO.registRental(rentalvo);
	}
}
