package com.billi.frontcontroller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.billi.model.BoardsService;
import com.billi.vo.BoardsVO;
import com.billi.vo.MembersVO;

public class SelectbynicknameController implements CommonControllerInterface {
	@Override
	public String excute(Map<String, Object> data) throws Exception {
		
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		HttpSession session = request.getSession();
		MembersVO user_vo = (MembersVO) session.getAttribute("loginUser");
		String user_nick = user_vo.getNickname();
		
		BoardsService service = new BoardsService();
		List<BoardsVO> boardlist = service.selectByWriter(user_nick);
			
		request.setAttribute("boardlist", boardlist);
		return "mypostlist.jsp";
	}

}
