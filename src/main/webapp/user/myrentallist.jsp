<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대여 리스트</title>
</head>
<body>
	<h1>대여 리스트</h1>
	<h2>빌린 내역</h2>
		<table>
		<thead>
			<tr>
				<th>글제목</th>
				<th>대여일</th>
				<th>반납일</th>
			</tr>
		</thead>
		
		<tbody>
		
		<c:forEach items="${borrowllist}" var="borrow">
			<tr>
				<td><a href="../board/boarddetail.do?num=${borrow.board_id}"> ${borrow.board_title}</a></td>
				<td>${borrow.rental_date}</td>
				<td>${borrow.exp_date}</td>
				<td><input type="button" onclick="location.href='../user/reviewwrite.do?num=${borrow.board_id}'" value="리뷰작성"></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<hr>
	<h2>내 물건 관리</h2>
		<table>
		<thead>
			<tr>
				<th>글제목</th>
				<th>대여일</th>
				<th>반납일</th>
				<th>확정</th>
				<th>반납</th>
			</tr>
		</thead>
		
		<tbody>
		<c:forEach items="${lentList}" var="lent">
			<tr>
				<td><a href="../board/boarddetail.do?num=${lent.board_id}"> ${lent.board_title}</a></td>
				<td>${lent.rental_date}</td>
				<td>${lent.exp_date}</td>
				<td>
				<form action="rentalconfirm.do" method="post">
				<input type="hidden" name="rental_code"  value="${lent.rental_code}"/>
				<input type="submit" value="렌탈확정"></input>
				</form></td>
				<td><form action="returnconfirm.do" method="post">
				<input type="hidden" name="rental_code"  value="${lent.rental_code}"/>
				<input type="submit" value="반납확정"></input>
				</form></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>