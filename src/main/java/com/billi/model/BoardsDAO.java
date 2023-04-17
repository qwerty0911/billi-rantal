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
import com.billi.vo.BoardsVO;

public class BoardsDAO {
	Connection conn;
	Statement st;
	PreparedStatement pst; //?지원
	ResultSet rs;
	int resultCount; //insert,update,delete 건수
	CallableStatement cst; //SP지원
	
	public List<String> selectCategory() {
		String sql="""
				select category_name
				from category
				order by 1
				""";
		List<String> clist = new ArrayList<>();
		conn = OracleUtil.getConnection();
		try {
			st=conn.createStatement();
			rs=st.executeQuery(sql);
			
			while(rs.next()) {
				String category = rs.getString("category_name");
				clist.add(category);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, st, conn);
		}
		return clist;
	}
	
	public int boardInsert(BoardsVO board) {
		String sql="""
				insert into boards 
				values(seq_board.nextval, ?, ?, ?, sysdate, ?, ?, ?, ?)
				""";
		conn=OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, board.getBoard_title());
			pst.setString(2, board.getBoard_contents());
			pst.setString(3,board.getBoard_writer());
			pst.setInt(4, board.getPrice());
			pst.setString(5, board.getPictures());
			pst.setString(6,  board.getAddress());
			pst.setString(7, board.getCategory());
			resultCount = pst.executeUpdate(); //DML문장 실행한다. 영향 받은 건수 return
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			resultCount=-1;
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(null, pst, conn);
		}
		return resultCount;
	}
	
	public List<BoardsVO> selectAll() {
		String sql="""
				select EMPLOYEE_ID,
					FIRST_NAME,
					LAST_NAME,
					EMAIL,
					PHONE_NUMBER,
					HIRE_DATE,
					JOB_ID,
					SALARY,
					COMMISSION_PCT,
					MANAGER_ID,
					DEPARTMENT_ID 
				from employees 
				order by 1
				""";
		List<String> emplist = new ArrayList<>();
		conn = OracleUtil.getConnection();
		try {
			st=conn.createStatement();
			rs=st.executeQuery(sql);
			
			/*칼럼 이름 알아내기
			ResultSetMetaData meta = rs.getMetaData();
			int count = meta.getColumnCount();
			for (int i=1;i<=count;i++) {
				System.out.println("칼럼 이름: "+meta.getColumnName(i));
			}*/
			
			while(rs.next()) {
				BoardsVO emp = makeBoard(rs);
				emplist.add(emp);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, st, conn);
		}
		return emplist;
	}
}
