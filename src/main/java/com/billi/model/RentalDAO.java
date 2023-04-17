package com.billi.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.billi.dbutil.OracleUtil;
import com.billi.vo.RentalVO;


public class RentalDAO {
	
	Connection conn;
	PreparedStatement st;
	ResultSet rs;
	
	public int registRental(RentalVO rentalvo) {
		int result = 0;
		String sql = "insert into rental(rental_code,MEM_ID,RENTAL_DATE,EXP_DATE,BOARD_ID)"
				+ " values(rental_id_seq.nextval ,?, ?, ?, ?)";
		//
		conn = OracleUtil.getConnection();
		try {
			st = conn.prepareStatement(sql);
			st.setString(1, rentalvo.getMem_id());
			st.setDate(2, rentalvo.getRental_date());
			st.setDate(3, rentalvo.getExp_date());
			st.setInt(4, rentalvo.getBoard_id());
			result = st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, st, conn);
		}
		
		return result;
	}

}
