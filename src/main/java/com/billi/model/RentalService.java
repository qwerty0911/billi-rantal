package com.billi.model;

import java.sql.Date;
import java.util.HashSet;

import com.billi.vo.RentalVO;

public class RentalService {
	
	RentalDAO rentalDAO = new RentalDAO();
	
	public int registRental(RentalVO rentalvo) {
		return rentalDAO.registRental(rentalvo);
	}
	
	public HashSet<Date> extractDisabledDates(int num){
		return rentalDAO.extractDisabledDates(num);
	}
}
