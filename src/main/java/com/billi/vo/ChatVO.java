package com.billi.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter@Setter@ToString
public class ChatVO {
	private int room_id;
	private String sender_name; //메시지 보낸 사람
	private String chat_contents; //메시지 보낸 내용
    private Timestamp sendTime; ////메시지 보낸 시간
}
