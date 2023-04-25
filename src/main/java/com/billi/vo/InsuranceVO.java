package com.billi.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter

public class InsuranceVO {
	private int insurance_code;
	private Date charge_date;
	private String charge_type;
	private String picture;
	private String charge_content;
	private int rental_code;
	
	//rental vo 추가
	String nickname;
	Date rental_date;   
	Date exp_date;
	int board_id;
	String owner;
	private int insurance_fee;
}
