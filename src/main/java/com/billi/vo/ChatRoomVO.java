package com.billi.vo;

import com.billi.model.ChattingService;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter@Setter@ToString
public class ChatRoomVO {
	ChattingService service=new ChattingService();
	
	private int room_id;
	private int board_id;
	private String board_title;
	private String seller; //게시자 nickname
	private String buyer; //대여자 nickname
}
