package com.billi.model;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.billi.vo.BoardsVO;

public class BoardsService {
	BoardsDAO dao = new BoardsDAO();
	
	//카테고리 불러오기
	public List<String> selectCategory() {
		return dao.selectCategory();
	}
	
	//게시글 작성 및 저장
	public int boardInsert(BoardsVO board) {
		return dao.boardInsert(board);
	}
	
	//게시글 전체 불러오기
	public List<BoardsVO> selectAll() {
		return dao.selectAll();
	}
	
	//board_id로 특정 게시글 불러오기
	public BoardsVO selectById(int board_id) {
		return dao.selectById(board_id);
	}
	
	public List<BoardsVO> selectByWriter(String board_writer) {
		return dao.selectByWriter(board_writer);
	}
	
	//게시판 페이지번호 출력
	public String readList(int page, HttpServletRequest request, String category) throws Exception {
		return dao.readList(page, request, category);
	}
	
	//페이지번호에 따른 게시물 출력
	public void printBoard(int page, HttpServletRequest request, String categoryParam) {
		dao.printBoard(page, request, categoryParam);
	}

	//board_id의 가장 큰 값 가져와서 board_id 설정
	public int setBoardSeq() {
		return dao.setBoardSeq();
	}
}