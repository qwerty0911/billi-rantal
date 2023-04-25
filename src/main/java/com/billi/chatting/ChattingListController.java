package com.billi.chatting;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.billi.frontcontroller.CommonControllerInterface;
import com.billi.model.ChattingService;
import com.billi.vo.ChatRoomVO;
import com.billi.vo.MembersVO;

public class ChattingListController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {

		String page = "chattinglist.jsp";

		HttpServletRequest request = (HttpServletRequest) data.get("request");
		HttpSession session = request.getSession();

		ChattingService service = new ChattingService();
		MembersVO loginUser = (MembersVO) session.getAttribute("loginUser");
		// 사용자의 채팅방 목록 가져오기
		List<ChatRoomVO> chattinglist = service.findRoomList(loginUser.getNickname());

		request.setAttribute("chattinglist", chattinglist);
		return page;
	}

}
