<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/boardAvgRating.css" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<meta charset="UTF-8">
<title>내가 쓴 후기</title>
</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>
	<h1>내가 쓴 후기</h1>
	<table>
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
				<td>${review.rating} <div class="rate"><span style="width: ${(review.rating/5)*100}%"></span></div> </td>
				<td>${review.review_date}</td>
				<td><button class="btnDel" data-del="${review.review_id}">삭제</button></td>
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