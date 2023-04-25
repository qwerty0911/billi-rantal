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
	
	//한건의 리뷰 삭제하기
		public int reviewDelete(int review_id) {
			System.out.println(review_id);
			String sql ="""
					delete from reviews
					where review_id = ?						
					""";
			conn = OracleUtil.getConnection();	
			try {
				pst = conn.prepareStatement(sql);					
				pst.setInt(1, review_id);	
				resultCount =  pst.executeUpdate();
			} catch (SQLException e) {
				resultCount = -1;
				e.printStackTrace();
			} finally {
				OracleUtil.dbDisconnect(null, pst, conn);
			}
			System.out.println("딜리트 결과 : " + resultCount);
			return resultCount;
		}
	
	//게시글의 평균 별점 불러오기
		public double avgRating(int board_id) {
			String sql ="""
					select trunc(avg(rating), 2) ratingavg
					from reviews
					where board_id = ?
					""";
			double ratingavg = 0;
			conn = OracleUtil.getConnection();
			try {
				pst = conn.prepareStatement(sql);
				pst.setInt(1, board_id);
				rs = pst.executeQuery();
				while(rs.next()) {
					ratingavg = rs.getDouble("ratingavg");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				OracleUtil.dbDisconnect(rs, pst, conn);
			}
			return ratingavg;
		}
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
	public List<Board_RentalVO> myReview(String review_writer) {
		String sql ="""
				select *
				from reviews join boards using (board_id)
				where review_writer = ?
				order by review_date desc
				""";
		List<Board_RentalVO> reviewlist = new ArrayList<>();
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, review_writer);
			rs = pst.executeQuery();
			while(rs.next()) {
				Board_RentalVO review = makeBoard_Rental(rs);
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
	private Board_RentalVO makeBoard_Rental(ResultSet rs) throws SQLException {
		Board_RentalVO review = new Board_RentalVO();
		review.setReview_id(rs.getInt("review_id"));
		review.setReview_content(rs.getString("review_content"));
		review.setReview_writer(rs.getString("review_writer"));
		review.setReview_date(rs.getDate("review_date"));
		review.setRating(rs.getDouble("rating"));
		review.setBoard_id(rs.getInt("board_id"));
		
		review.setBoard_title(rs.getString("board_title"));
		review.setBoard_contents(rs.getString("board_contents"));
		review.setBoard_writer(rs.getString("board_writer"));
		review.setBoard_date(rs.getDate("board_date"));
		review.setPrice(rs.getInt("price"));
		review.setPictures(rs.getString("pictures"));
		review.setAddress(rs.getString("address"));
		review.setCategory(rs.getString("category"));
		
		return review;
	}
	
}
