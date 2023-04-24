<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<form action="../rental/rentalRegist.do" method="post">
<p>start Date: <input type="text" name="rental_date" readOnly class="calander" id="startDate" ></p>
<p>end Date: <input type="text" name = "exp_date" readOnly class="calander" id="expireDate"></p>
<input type="text" name="board_id" value="${board.board_id}">
<input type="text" name="board_writer" value="${board.board_writer}">
<input type="submit" value = "대여신청">

</form>