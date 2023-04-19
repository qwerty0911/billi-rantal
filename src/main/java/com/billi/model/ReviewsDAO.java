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
import com.billi.vo.ReviewsVO;

public class ReviewsDAO {
	Connection conn;
	Statement st;
	PreparedStatement pst; //?지원
	ResultSet rs;
	int resultCount; //insert,update,delete 건수
	CallableStatement cst;
	
	//내가 쓴 후기
	public List<ReviewsVO> myReview(String review_writer) {
		String sql ="""
				select *
				from reviews
				where review_writer = ?
				""";
		List<ReviewsVO> reviewlist = new ArrayList<>();
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, review_writer);
			rs = pst.executeQuery();
			while(rs.next()) {
				ReviewsVO review = makeReview(rs);
				reviewlist.add(review);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		return reviewlist;
	}

	private ReviewsVO makeReview(ResultSet rs) throws SQLException {
		ReviewsVO review = new ReviewsVO();
		review.setReview_id(rs.getInt("review_id"));
		review.setReview_content(rs.getString("review_content"));
		review.setReview_writer(rs.getString("review_writer"));
		review.setReview_date(rs.getDate("review_date"));
		review.setRating(rs.getDouble("rating"));
		review.setBoard_id(rs.getInt("board_id"));
		return review;
	}
	
}
