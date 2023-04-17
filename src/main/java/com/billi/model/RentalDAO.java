package com.billi.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import com.billi.dbutil.OracleUtil;
import com.billi.vo.RentalVO;


public class RentalDAO {
	
	Connection conn;
	PreparedStatement pst;
	ResultSet rs;
	
	public int registRental(RentalVO rentalvo) {
		int result = 0;
		String sql = "insert into rental(rental_code,MEM_ID,RENTAL_DATE,EXP_DATE,BOARD_ID)"
				+ " values(rental_id_seq.nextval ,?, ?, ?, ?)";
		//
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, rentalvo.getMem_id());
			pst.setDate(2, rentalvo.getRental_date());
			pst.setDate(3, rentalvo.getExp_date());
			pst.setInt(4, rentalvo.getBoard_id());
			result = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		
		return result;
	}
	
	public HashSet<Date> extractDisabledDates(int num){
		List<Date> disbledPeriodStart = new ArrayList<>();
		List<Date> disbledPeriodEnd = new ArrayList<>();
		
		String sql = "select rental_date, exp_date from rental where board_id=?";
		//
		conn = OracleUtil.getConnection();
		
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1,num);
			
			rs = pst.executeQuery();
			while(rs.next()) {
				disbledPeriodStart.add(rs.getDate(1)); 
				disbledPeriodEnd.add(rs.getDate(2));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		
		HashSet<Date> uniqueSet = new HashSet<>();
		
		for(int i=0;i<disbledPeriodEnd.size();i++) {
			for(Date date = disbledPeriodStart.get(i); date.before(new Date(disbledPeriodEnd.get(i).getTime() + 86400000L)); date = new Date(date.getTime() + 86400000L)){
	            uniqueSet.add(date);
	        }
		}
		System.out.println(uniqueSet);
		
		return uniqueSet;
	}

}
