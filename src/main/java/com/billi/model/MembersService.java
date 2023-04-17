package com.billi.model;

import com.billi.vo.MembersVO;

public class MembersService {
	MembersDAO dao = new MembersDAO();
	
	public int membersInsert(MembersVO members) {
		return dao.membersInsert(members);
	}
}
