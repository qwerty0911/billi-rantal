package com.billi.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.billi.dbutil.OracleUtil;
import com.billi.vo.Board_RentalVO;
import com.billi.vo.InsuranceVO;
import com.billi.vo.MembersVO;

public class InsuranceDAO {
	Connection conn;
	Statement st;
	PreparedStatement pst;
	ResultSet rs;
	int resultCount;
	CallableStatement cst;
	
	//보험 개수 불러오기
	public int countInsurance(int rental_code) {
		String sql ="""
				select count(*) count
				from insurance 
				where rental_code = ?
				""";
		int insurancecount = 0;
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, rental_code);
			rs = pst.executeQuery();
			while(rs.next()) {
				insurancecount = rs.getInt("count");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		return insurancecount;
	}
	
	//보험금 청구 신청하기
		public int InsuranceCharge(InsuranceVO insurance) {
			String sql = """
					insert into insurance 
					values(insurance_seq.nextval, sysdate, ?, ?, ?, ?)
					""";
			conn = OracleUtil.getConnection();
			
			System.out.println(insurance);
			try {
				pst = conn.prepareStatement(sql);
				
				pst.setString(1, insurance.getCharge_type());
				pst.setString(2, insurance.getPicture());
				pst.setString(3, insurance.getCharge_content());
				pst.setInt(4, insurance.getRental_code());
				
				resultCount = pst.executeUpdate();
			} catch (SQLException e) {
				resultCount = -1;
				e.printStackTrace();
			} finally {
				OracleUtil.dbDisconnect(null, pst, conn);
			}
			return resultCount;
		}
		
		//신청한 보험 내역 보기
		public List<InsuranceVO> myInsuranceList(int rental_code) {
			String sql ="""
					select * 
					from insurance join rental using(rental_code)
					where rental_code = ?
					""";
			List<InsuranceVO> myinsurancelist = new ArrayList<>();
			conn = OracleUtil.getConnection();
			try {
				pst = conn.prepareStatement(sql);
				pst.setInt(1, rental_code);
				rs = pst.executeQuery();
				while(rs.next()) {
					InsuranceVO insurance = makeinsurance(rs);
					myinsurancelist.add(insurance);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				OracleUtil.dbDisconnect(rs, pst, conn);
			}
			return myinsurancelist;
		}

		private InsuranceVO makeinsurance(ResultSet rs) throws SQLException {
			InsuranceVO insurance = new InsuranceVO();
			insurance.setRental_code(rs.getInt("rental_code"));
			insurance.setInsurance_code(rs.getInt("insurance_code"));
			insurance.setCharge_date(rs.getDate("charge_date"));
			insurance.setCharge_type(rs.getString("charge_type"));			
			insurance.setPicture(rs.getString("picture"));
			insurance.setCharge_content(rs.getString("charge_content"));			
			insurance.setNickname(rs.getString("nickname"));			
			insurance.setRental_date(rs.getDate("rental_date"));
			insurance.setExp_date(rs.getDate("exp_date"));
			insurance.setBoard_id(rs.getInt("board_id"));
			insurance.setOwner(rs.getString("owner"));
			insurance.setInsurance_fee(rs.getInt("insurance_fee"));
			
			return insurance;
		}
		
}
