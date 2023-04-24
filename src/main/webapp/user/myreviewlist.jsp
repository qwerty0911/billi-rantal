<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 후기</title>
</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>
	<h1>내가 쓴 후기</h1>
	<table>
		<thead>
			<tr>
				<th>글번호</th>
				<th>리뷰내용</th>
				<th>평점</th>
				<th>작성일</th>
			</tr>
		</thead>
		
		<tbody>
		<c:forEach items="${reviewlist}" var="review">
			<tr>
				<td> <a href="../board/boarddetail.do?num=${review.board_id}">${review.board_id}</a></td>
				<td>${review.review_content}</td>
				<td>${review.rating}</td>
				<td>${review.review_date}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>