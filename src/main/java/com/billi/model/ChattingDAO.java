package com.billi.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import com.billi.dbutil.OracleUtil;
import com.billi.vo.ChatRoomVO;
import com.billi.vo.ChatVO;

public class ChattingDAO {
	Connection conn;
	Statement st;
	PreparedStatement pst;
	ResultSet rs;
	int resultCount;
	CallableStatement cst;

	// 대여자가 이미 생성한 채팅방이 있는지 확인하기 위함
	public int countByChatId(int board_id, String buyer) {
		int result = 0;
		String sql = """
				select count(*) count
				from chatroom
				where board_id =? and buyer = ?
				""";
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, board_id);
			pst.setString(2, buyer);
			rs = pst.executeQuery();
			while (rs.next()) {
				result = rs.getInt("count");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		return result;
	}

	// 채팅방 가져오기
	public ChatRoomVO findRoom(int board_id, String buyer) {
		String sql = """
				select *
				from chatroom
				where board_id=? and buyer=?
				""";
		conn = OracleUtil.getConnection();
		ChatRoomVO chatroom = new ChatRoomVO();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, board_id);
			pst.setString(2, buyer);
			rs = pst.executeQuery();
			while (rs.next()) {
				chatroom = makeChatRoom(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		return chatroom;
	}

	// 채팅 내용 가져오기
	public List<ChatVO> findChatById(int room_id) {
		String sql = """
				select *
				from chatting
				where room_id=?
				order by sendTime asc
				""";
		conn = OracleUtil.getConnection();
		List<ChatVO> chatlist = new ArrayList<>();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, room_id);
			rs = pst.executeQuery();
			while (rs.next()) {
				ChatVO chat = makeChat(rs);
				chatlist.add(chat);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		return chatlist;
	}

	// 채팅방 생성
	public void addChatRoom(ChatRoomVO chatRoom) {
		Timestamp createdDate = Timestamp.valueOf(LocalDateTime.now());

		String sql = """
				insert into chatroom(room_id,seller,buyer,board_id, board_title, update_time)
				values(seq_chatroom.nextval,?,?,?,?,?)
				""";
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, chatRoom.getSeller());
			pst.setString(2, chatRoom.getBuyer());
			pst.setInt(3, chatRoom.getBoard_id());
			pst.setString(4, chatRoom.getBoard_title());
			pst.setTimestamp(5, chatRoom.getUpdate_time());
			// pst.setTimestamp(5, createdDate);
			resultCount = pst.executeUpdate(); // DML문장 실행한다. 영향 받은 건수 return

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			resultCount = -1;
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(null, pst, conn);
		}
		// return resultCount;
	}

	// 채팅내용 저장
	public void addChat(ChatVO chat) {
		Timestamp createdDate = Timestamp.valueOf(LocalDateTime.now());

		String sql = """
				insert into chatting(room_id,sender_name,chat_contents,sendTime)
				values(?,?,?,SYSTIMESTAMP)
				""";
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, chat.getRoom_id());
			pst.setString(2, chat.getSender_name());
			pst.setString(3, chat.getChat_contents());
			resultCount = pst.executeUpdate(); // DML문장 실행한다. 영향 받은 건수 return

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			resultCount = -1;
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(null, pst, conn);
		}
		// return resultCount;
	}

	// 내 채팅방 목록 가져오기
	public List<ChatRoomVO> findRoomList(String nickname) {
		String sql = """
				select *
				from chatroom
				where buyer=? or seller=?
				order by update_time desc
				""";
		conn = OracleUtil.getConnection();
		List<ChatRoomVO> chatroomlist = new ArrayList<>();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, nickname);
			pst.setString(2, nickname);
			rs = pst.executeQuery();
			while (rs.next()) {
				ChatRoomVO room = makeChatRoom(rs);
				chatroomlist.add(room);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		return chatroomlist;
	}

	public ChatRoomVO makeChatRoom(ResultSet rs) throws SQLException {
		ChatRoomVO chatroom = new ChatRoomVO();
		chatroom.setBoard_id(rs.getInt("board_id"));
		chatroom.setBuyer(rs.getString("buyer"));
		chatroom.setRoom_id(rs.getInt("room_id"));
		chatroom.setSeller(rs.getString("seller"));
		chatroom.setBoard_title(rs.getString("board_title"));
		return chatroom;
	}

	public ChatVO makeChat(ResultSet rs) throws SQLException {
		ChatVO chat = new ChatVO();
		chat.setRoom_id(rs.getInt("room_id"));
		chat.setChat_contents(rs.getString("chat_contents"));
		chat.setSendTime(rs.getTimestamp("sendtime"));
		chat.setSender_name(rs.getString("sender_name"));
		return chat;
	}
}
