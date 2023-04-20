package com.billi.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString

public class MembersVO {
	private String mem_id;
	private String pw;
	private String mem_name;
	private String phone;
	private String address;
	private String nickname;
	private float latitude;
	private float longitude;
}
