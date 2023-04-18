package com.billi.model;

import java.util.List;

import com.billi.vo.BoardsVO;

public class BoardsService {
	BoardsDAO dao = new BoardsDAO();
	
	public List<String> selectCategory() {
		return dao.selectCategory();
	}
	
	public int boardInsert(BoardsVO board) {
		return dao.boardInsert(board);
	}
	
	public List<BoardsVO> selectAll() {
		return dao.selectAll();
	}
	
	public BoardsVO selectById(int board_id) {
		return dao.selectById(board_id);
	}
	public List<BoardsVO> selectByWriter(String board_writer) {
		return dao.selectByWriter(board_writer);
	}
}