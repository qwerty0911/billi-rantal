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
	
	
	//빌려준 아이템
	public List<Board_RentalVO> myLentList(String nickname) {
		String sql ="""
				select *
				from boards join rental on (boards.board_id = rental.board_id)
                left outer join insurance on(rental.rental_code = insurance.rental_code)
				where owner = ?
				order by rental_date desc
				""";
		List<Board_RentalVO> rentallist = new ArrayList<>();
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, nickname);
			rs = pst.executeQuery();
			while(rs.next()) {
				Board_RentalVO rental = makeRental(rs);
				rental.setInsurance_fee(rs.getInt("insurance_fee"));
				rental.setInsurance_code(rs.getInt("insurance_code"));
				rental.setCharge_date(rs.getDate("charge_date"));
				rental.setCharge_type(rs.getString("charge_type"));
				rental.setPicture(rs.getString("picture"));
				rental.setCharge_content(rs.getString("charge_content"));
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
	
	//빌린 아이템
	public List<Board_RentalVO> myRental(String nickname) {
		String sql ="""
				select RENTAL_CONFIRM.* ,boards.*, rental.*, 
					  (select count(*) 
					   from reviews aa 
					   where aa.board_id = board_id and aa.rentalconfirm_code = rental.rental_code) review_count
				from RENTAL_CONFIRM join rental on (RENTAL_CONFIRM.rental_code = rental.rental_code)
					                join boards on (rental.board_id =boards.board_id) 
				where nickname = ?
				order by rental.rental_code desc
				""";
		List<Board_RentalVO> rentallist = new ArrayList<>();
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, nickname);
			rs = pst.executeQuery();
			while(rs.next()) {
				Board_RentalVO rental = makeRental(rs);
				rental.setReview_count(rs.getInt("review_count"));
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
		String sql = "insert into rental(rental_code,nickname,RENTAL_DATE,EXP_DATE,BOARD_ID,owner, insurance_fee)"
				+ " values(rental_id_seq.nextval,? ,?, ?, ?, ?, ?)";
		//
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, rentalvo.getNickname());
			pst.setDate(2, rentalvo.getRental_date());
			pst.setDate(3, rentalvo.getExp_date());
			pst.setInt(4, rentalvo.getBoard_id());
			pst.setString(5, rentalvo.getOwner_nick());
			pst.setInt(6, rentalvo.getInsurance_fee());
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
