<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/boardAvgRating.css" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../css/tabletextoverflow.css">
<title>내가 쓴 후기</title>
</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>
<div class= "mx-auto mt-5 p-2" style="width: 80%;">
<h1>내가 쓴 후기</h1>

	<table class="table table-striped ">
		<thead>
			<tr>
				<th>글제목</th>
				<th>리뷰내용</th>
				<th>평점</th>
				<th style="max-width:100px">작성일</th>
			</tr>
		</thead>
		
		<tbody>
		<c:forEach items="${reviewlist}" var="review">
			<tr>
				<td class="text-nowrap" style="max-width:200px"> <a href="../board/boarddetail.do?num=${review.board_id}">${review.board_title}</a></td>
				<td class="text-nowrap">${review.review_content}</td>
				<td style="max-width:120px" ><div class="rate" ><span style="width: ${(review.rating/5)*100}%" ></span></div> </td>
				<td>${review.review_date}</td>
				<td><button class="btn btn-danger btn-sm" data-del="${review.review_id}">삭제</button></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</body>
<script>
$(function () {
	$(".btnDel").on("click", function () {
		location.href = "../user/reviewdelete.do?review_id=" + $(this).attr("data-del");
	})
});
</script>
</html>