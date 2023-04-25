package com.billi.model;

import java.util.List;

import com.billi.vo.ChatRoomVO;
import com.billi.vo.ChatVO;

public class ChattingService {
	ChattingDAO dao = new ChattingDAO();

	//대여자가 이미 생성한 채팅방이 있는지 확인하기 위함
	public int countByChatId(int board_id, String buyer) {
		return dao.countByChatId(board_id, buyer);
	}

	//특정 채팅방 찾기
	public List<ChatVO> findChatById(int room_id) {
		return dao.findChatById(room_id);
	}
	
	// 채팅방 가져오기
	public ChatRoomVO findRoom(int board_id, String buyer) {
		return dao.findRoom(board_id, buyer);
	}
	
	//채팅방 생성
	public void addChatRoom(ChatRoomVO chatRoom) {
		dao.addChatRoom(chatRoom);
	}
	
	// 채팅내용 저장
	public void addChat(ChatVO chat) {
		dao.addChat(chat);
	}
	
	// 내 채팅방 목록 가져오기
	public List<ChatRoomVO> findRoomList(String nickname) {
		return dao.findRoomList(nickname);
	}
}
