package com.billi.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import com.billi.dbutil.OracleUtil;
import com.billi.vo.MembersVO;

public class MembersDAO {
	Connection conn;
	Statement st;
	PreparedStatement pst;
	ResultSet rs;
	int resultCount;
	CallableStatement cst;
	
	//회원가입
	public int membersInsert(MembersVO members) {
		String sql = """
				insert into members(mem_id, pw, mem_name, phone, address, nickname, latitude, longitude) values(?, ?, ?, ?, ?, ?, ? , ?)
				""";
		conn = OracleUtil.getConnection();
		
		System.out.println(members);
		try {
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, members.getMem_id());
			pst.setString(2, members.getPw());
			pst.setString(3, members.getMem_name());
			pst.setString(4, members.getPhone());
			pst.setString(5, members.getAddress());
			pst.setString(6, members.getNickname());
			pst.setFloat(7, members.getLatitude());
			pst.setFloat(8, members.getLongitude());
			
			resultCount = pst.executeUpdate();
		} catch (SQLException e) {
			resultCount = -1;
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(null, pst, conn);
		}
		return resultCount;
	}
	
	//아이디 중복체크
	public int idDupCheck(String mem_id) {
		int count = 0;
		String sql = "select count(*) from members where mem_id =?";
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, mem_id);

			rs = pst.executeQuery();
			while (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		return count;

	}
	
	//닉네임 중복체크
	public int nicknameDupCheck(String nickname) {
		int count = 0;
		String sql = "select count(*) from members where nickname =?";
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, nickname);

			rs = pst.executeQuery();
			while (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
				e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		return count;

		}
	
	//로그인
	public MembersVO loginCheck(String mem_id, String pw) {
		MembersVO user = null;
		String sql = "select * from members where mem_id =? and pw =? ";

		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, mem_id);
			pst.setString(2, pw);

			rs = pst.executeQuery();
			while (rs.next()) {
				user = new MembersVO();
				user.setMem_id(mem_id);
				user.setPw(pw);
				user.setMem_name(rs.getString("mem_name"));
				user.setPhone(rs.getString("phone"));
				user.setAddress(rs.getString("address"));						
				user.setNickname(rs.getString("nickname"));
				user.setLongitude(rs.getFloat("longitude"));
				user.setLatitude(rs.getFloat("latitude"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		return user;

	}
	//회원정보확인
	public MembersVO selectByid(String mem_id) {
		String sql ="select * from members where mem_id = " + mem_id;
		MembersVO members = null;
		conn = OracleUtil.getConnection();
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			while(rs.next()) {
				members = makeMembers(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, st, conn);
		}
		return members;
	}
	
	//회원정보수정
	public int membersUpdate(MembersVO members) {
		String sql ="""
				update members
				set 	 
				pw =?, 
				mem_name=?, 
				phone=?, 
				address = ?, 
				nickname =? 
				where mem_id = ?
				""";
		conn = OracleUtil.getConnection();
		
		try {
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, members.getPw());
			pst.setString(2, members.getMem_name());
			pst.setString(3, members.getPhone());
			pst.setString(4, members.getAddress());
			pst.setString(5, members.getNickname());
			pst.setString(6, members.getMem_id());
						
			resultCount =  pst.executeUpdate(); //DML 문장 실행한다, 영향을 받은 건수가 리턴됨
			System.out.println(resultCount);
			
		} catch (SQLException e) {
			resultCount = -1;
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(null, pst, conn);
		}
		System.out.println("업데이트 결과 : " + resultCount);
		return resultCount;
	}
	
	private MembersVO makeMembers(ResultSet rs) throws SQLException {
		MembersVO members = new MembersVO();
		members.setMem_id(rs.getString("mem_id"));
		members.setPw(rs.getString("pw"));
		members.setMem_name(rs.getString("mem_name"));
		members.setPhone(rs.getString("phone"));
		members.setAddress(rs.getString("address"));
		members.setNickname(rs.getString("nickname"));
		
		System.out.println(members);
		
		return members;
	}
}
