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
		<c:forEach items="${rentallist}" var="rental">
			<tr>
				<td><a href="../board/boarddetail.do?num=${rental.board_id}"> ${rental.board_title}</a></td>
				<td>${rental.rental_date}</td>
				<td>${rental.exp_date}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>