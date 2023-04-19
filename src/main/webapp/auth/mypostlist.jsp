<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글</title>
</head>
<body>
	<h1>내가 쓴 글</h1>
	<table>
		<thead>
			<tr>
				<th>글번호</th>
				<th>글제목</th>
				<th>작성일</th>
			</tr>
		</thead>
		
		<tbody>
		<c:forEach items="${boardlist}" var="writer">
			<tr>
				<td>${writer.board_id}</td>
				<td>${writer.board_title}</td>
				<td>${writer.board_date}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>