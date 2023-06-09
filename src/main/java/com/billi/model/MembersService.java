package com.billi.model;

import com.billi.vo.MembersVO;

public class MembersService {
	MembersDAO dao = new MembersDAO();
	
	public int membersInsert(MembersVO members) {
		return dao.membersInsert(members);
	}
	public int idDupCheck(String mem_id) {
		return dao.idDupCheck(mem_id);
	}
	public int nicknameDupCheck(String nickname) {
		return dao.nicknameDupCheck(nickname);
	}
	public MembersVO loginCheck(String mem_id, String pw) {
		return dao.loginCheck(mem_id, pw);
	}
	public MembersVO selectByid(String mem_id) {
		return dao.selectByid(mem_id);
	}
	public String membersUpdate(MembersVO members) {
		int result = dao.membersUpdate(members);
		return result > 0?"수정성공":"수정실패";
	}
}
