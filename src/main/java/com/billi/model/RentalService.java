package com.billi.model;

import java.sql.Date;
import java.util.HashSet;
import java.util.List;

import com.billi.vo.Board_RentalVO;
import com.billi.vo.RentalVO;

public class RentalService {
	
	RentalDAO rentalDAO = new RentalDAO();
	
	public int registRental(RentalVO rentalvo) {
		return rentalDAO.registRental(rentalvo);
	}
	
	public HashSet<Date> extractDisabledDates(int num){
		return rentalDAO.extractDisabledDates(num);
	}
	public List<Board_RentalVO> myRental(String nickname) {
		return rentalDAO.myRental(nickname);
	}
	
	public List<Board_RentalVO> myLentList(String nickname) {
		return rentalDAO.myLentList(nickname);
	}
}
