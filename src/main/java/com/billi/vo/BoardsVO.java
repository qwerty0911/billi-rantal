package com.billi.vo;

import java.sql.Date;

import com.billi.model.BoardsService;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Setter@Getter@ToString
public class BoardsVO {
	
	BoardsService service=new BoardsService();
	private int board_id;
	private String board_title;
	private String board_contents;
	private String board_writer;
	private Date board_date;
	private int price;
	private String pictures;
	private String address;
	private String category;
	
	//orcle sequence 사용안하고 board_id 값 넣기 위함
	public BoardsVO(int board_id) {
		super();
		this.board_id = service.setBoardSeq();
	}
}
