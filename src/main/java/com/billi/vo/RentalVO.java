package com.billi.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class RentalVO {
	
	int rental_code;
	String nickname;
	Date rental_date;   
	Date exp_date;
	int board_id;
	String owner;
}
