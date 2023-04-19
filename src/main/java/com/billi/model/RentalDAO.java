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
import com.billi.vo.Board_RentalVO;
import com.billi.vo.RentalVO;
import com.billi.vo.ReviewsVO;


public class RentalDAO {
	
	Connection conn;
	PreparedStatement pst;
	ResultSet rs;
	
	//대여내역
	public List<Board_RentalVO> myRental(String nickname) {
		String sql ="""
				select *
				from boards join rental using (board_id)
				where nickname = ?
				""";
		List<Board_RentalVO> rentallist = new ArrayList<>();
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, nickname);
			rs = pst.executeQuery();
			while(rs.next()) {
				Board_RentalVO rental = makeRental(rs);
				rentallist.add(rental);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		return rentallist;
	}
	
	private Board_RentalVO makeRental(ResultSet rs) throws SQLException {
		Board_RentalVO rental = new Board_RentalVO();
		rental.setBoard_id(rs.getInt("board_id"));
		rental.setBoard_title(rs.getString("board_title"));
		rental.setBoard_contents(rs.getString("board_contents"));
		rental.setBoard_writer(rs.getString("board_writer"));
		rental.setBoard_date(rs.getDate("board_date"));
		rental.setPrice(rs.getInt("price"));
		rental.setPictures(rs.getString("pictures"));
		rental.setAddress(rs.getString("address"));
		rental.setCategory(rs.getString("category"));
		
		rental.setRental_code(rs.getInt("rental_code"));
		rental.setNickname(rs.getString("nickname"));
		rental.setRental_date(rs.getDate("rental_date"));
		rental.setExp_date(rs.getDate("exp_date"));
		rental.setOwner(rs.getString("owner"));
						
		return rental;
	}

	public int registRental(RentalVO rentalvo) {
		int result = 0;
		String sql = "insert into rental(rental_code,nickname,RENTAL_DATE,EXP_DATE,BOARD_ID,owner)"
				+ " values(rental_id_seq.nextval,? ,?, ?, ?, ?)";
		//
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, rentalvo.getNickname());
			pst.setDate(2, rentalvo.getRental_date());
			pst.setDate(3, rentalvo.getExp_date());
			pst.setInt(4, rentalvo.getBoard_id());
			pst.setString(5, rentalvo.getOwner_nick());
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
