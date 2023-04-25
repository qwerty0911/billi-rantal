<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" integrity="sha512-RpydOy+vXP/22Mv/0QXOah/Bzq3GqNSZJhWWefmT1mE0xU6JmU6v4mi4X+g6lJlW0s4sHwMgDChsk+EhHUUvQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.min.js" integrity="sha512-rz5Z5xnwrgCJnif1RyF/AokM75aqf+DXeQbTVXhmqBN1qJACqAHufPk1Sj6AbOUU6Pds2WnpyU6Fou4zNLsUHg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<title>내가 쓴 후기</title>
</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>
<div class= "mx-auto p-2" style="width: 80%;">
<h1>내가 쓴 후기</h1>
	<table class="table table-striped ">
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
</div>
	
</body>
</html>