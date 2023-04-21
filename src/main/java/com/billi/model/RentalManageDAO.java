package com.billi.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.billi.dbutil.OracleUtil;

public class RentalManageDAO {
	
	Connection conn;
	PreparedStatement pst;
	ResultSet rs;
	
	int resultCount;
	
	public int rentalConfirm(int rental_code) {
		String sql = """
				insert into rental_confirm values(?, sysdate)
				""";
		conn = OracleUtil.getConnection();
		
		try {
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, rental_code);
			
			resultCount = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			OracleUtil.dbDisconnect(null, pst, conn);
		}
		
		return resultCount;
	}
	
	public int returnConfirm(int rental_code) {
		String sql = """
				insert into return_confirm values(?, sysdate)
				""";
		conn = OracleUtil.getConnection();
		
		try {
			pst = conn.prepareStatement(sql);
			
			pst.setInt(1, rental_code);
			
			resultCount = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			OracleUtil.dbDisconnect(null, pst, conn);
		}
		
		return resultCount;
	}
}
