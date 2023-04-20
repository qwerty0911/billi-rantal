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
import com.billi.vo.MembersVO;
import com.billi.vo.ReviewsVO;

public class ReviewsDAO {
	Connection conn;
	Statement st;
	PreparedStatement pst; //?지원
	ResultSet rs;
	int resultCount; //insert,update,delete 건수
	CallableStatement cst;
	
	//후기 개수 불러오기
	public int countReview(int board_id) {
		String sql ="""
				select count(*) count
				from reviews 
				where board_id = ?
				""";
		int reviewcount = 0;
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, board_id);
			rs = pst.executeQuery();
			while(rs.next()) {
			reviewcount = rs.getInt("count");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		return reviewcount;
	}
	//게시글의 리뷰 불러오기
		public List<ReviewsVO> boardReview(int board_id) {
			String sql ="""
					select *
					from reviews
					where board_id = ?
					order by review_id desc
					""";
			List<ReviewsVO> reviewlist = new ArrayList<>();
			conn = OracleUtil.getConnection();
			try {
				pst = conn.prepareStatement(sql);
				pst.setInt(1, board_id);
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
	
	//리뷰작성
		public int reviewWrite(ReviewsVO reviews) {
			String sql = """
					insert into reviews values (review_id_sequence.nextval, ?, ?, sysdate, ?, ?)
					""";
			conn = OracleUtil.getConnection();
			
			try {
				pst = conn.prepareStatement(sql);
				
				pst.setString(1, reviews.getReview_content());
				pst.setString(2, reviews.getReview_writer());
				pst.setDouble(3, reviews.getRating());
				pst.setInt(4, reviews.getBoard_id());		
				
				resultCount = pst.executeUpdate();
			} catch (SQLException e) {
				resultCount = -1;
				e.printStackTrace();
			} finally {
				OracleUtil.dbDisconnect(null, pst, conn);
			}
			return resultCount;
		}
	
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
