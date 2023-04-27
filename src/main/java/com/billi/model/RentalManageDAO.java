package com.billi.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.billi.dbutil.OracleUtil;
import com.billi.vo.Board_RentalVO;
import com.billi.vo.RentalManageVO;

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
	
	public List<Integer> confirmedRentalList(String nickName){
		List<Integer> confirmedRentalList = new ArrayList<>();
		String sql ="""
				select rental_code
				from rental join rental_confirm using (rental_code)
				where owner = ?
				""";
		conn = OracleUtil.getConnection();
		
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, nickName);
			rs = pst.executeQuery();
			
			while(rs.next()) {
				confirmedRentalList.add(rs.getInt("rental_code"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		
		return confirmedRentalList;
	}
	
	public List<Integer> confirmedReturnList(String nickName){
		List<Integer> confirmedReturnList = new ArrayList<>();
		String sql ="""
				select rental_code
				from rental join return_confirm using (rental_code)
				where owner = ?
				""";
		conn = OracleUtil.getConnection();
		
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, nickName);
			rs = pst.executeQuery();
			
			while(rs.next()) {
				confirmedReturnList.add(rs.getInt("rental_code"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		
		return confirmedReturnList;
	}

	public int rejectRental(int rental_code) {
		
		String sql ="delete from rental where rental_code = ? ";
		conn = OracleUtil.getConnection();
		
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, rental_code);
			resultCount = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			OracleUtil.dbDisconnect(null, pst, conn);
		}
		
		return resultCount;
	}
}
