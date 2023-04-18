package com.billi.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.billi.dbutil.OracleUtil;
import com.billi.util.DateUtil;
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
				select BOARD_ID,
					BOARD_TITLE,
					BOARD_CONTENTS,
					BOARD_WRITER,
					BOARD_DATE,
					PRICE,
					PICTURES,
					ADDRESS,
					CATEGORY
				from boards 
				order by board_date desc
				""";
		List<BoardsVO> boardlist = new ArrayList<>();
		conn = OracleUtil.getConnection();
		try {
			st=conn.createStatement();
			rs=st.executeQuery(sql);
			
			while(rs.next()) {
				BoardsVO board = makeBoard(rs);
				boardlist.add(board);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, st, conn);
		}
		return boardlist;
	}
	
	private BoardsVO makeBoard(ResultSet rs) throws SQLException {
		BoardsVO board=new BoardsVO();
		board.setAddress(rs.getString("address"));
		board.setBoard_contents(rs.getString("board_contents"));
		board.setBoard_id(rs.getInt("board_id"));
		board.setBoard_title(rs.getString("board_title"));
		board.setBoard_writer(rs.getString("board_writer"));
		board.setCategory(rs.getString("category"));
		board.setPictures(rs.getString("pictures"));
		board.setPrice(rs.getInt("price"));

		return board;
	}
}