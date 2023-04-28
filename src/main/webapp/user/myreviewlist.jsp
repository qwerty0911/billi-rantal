<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/boardAvgRating.css" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" integrity="sha512-RpydOy+vXP/22Mv/0QXOah/Bzq3GqNSZJhWWefmT1mE0xU6JmU6v4mi4X+g6lJlW0s4sHwMgDChsk+EhHUUvQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.min.js" integrity="sha512-rz5Z5xnwrgCJnif1RyF/AokM75aqf+DXeQbTVXhmqBN1qJACqAHufPk1Sj6AbOUU6Pds2WnpyU6Fou4zNLsUHg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<title>내가 쓴 리뷰</title>
</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>
<div class= "mx-auto p-2" style="width: 80%;">
<h1>내가 쓴 리뷰</h1>
	<table class="table table-striped ">
		<thead>
			<tr>
				<th>글제목</th>
				<th>리뷰내용</th>
				<th>평점</th>
				<th>작성일</th>
			</tr>
		</thead>
		
		<tbody>
		<c:forEach items="${reviewlist}" var="review">
			<tr>
				<td> <a href="../board/boarddetail.do?num=${review.board_id}">${review.board_title}</a></td>
				<td>${review.review_content}</td>
				<td><div class="rate"><span style="width: ${(review.rating/5)*100}%"></span></div> </td>
				<td>${review.review_date}</td>
				<td><button class="btn btn-danger btn-sm" data-del="${review.review_id}">삭제</button></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
<script>
$(function () {
	$(".btnDel").on("click", function () {
		location.href = "../user/reviewdelete.do?review_id=" + $(this).attr("data-del");
	})
});
</script>
</html>