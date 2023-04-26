package com.billi.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter@Setter@ToString
public class ReviewsVO {
	private int review_id;
	private String review_content;
	private String review_writer;
	private Date review_date;
	private double rating;
	private int board_id;
	private int rentalconfirm_code;
}
