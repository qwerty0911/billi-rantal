package com.billi.model;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.billi.vo.BoardsVO;
import com.billi.vo.MembersVO;

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
	
	//내가 쓴 글 조회
	public List<BoardsVO> selectByWriter(String board_writer) {
		return dao.selectByWriter(board_writer);
	}
	
	//게시판 페이지번호 출력
	public String printPageList(int page, HttpServletRequest request, String category, int local, String search) throws Exception {
		return dao.printPageList(page, request, category, local, search);
	}
	
	//페이지번호에 따른 게시물 출력
	public void printBoard(int page, HttpServletRequest request, String categoryParam, int local, String search) {
		dao.printBoard(page, request, categoryParam, local, search);
	}

	//board_id의 가장 큰 값 가져와서 board_id 설정
	public int setBoardSeq() {
		return dao.setBoardSeq();
	}
	
	//board_id로 board_title 가져오기
	public String TitleById(int board_id) {
		return dao.TitleById(board_id);
	}
	
	//유저와 가까운 위치의 리스트 생성
	public List<BoardsVO> selectCloseDistance(MembersVO member,float distance) {
		return dao.selectCloseDistance(member, distance);
	}
}