<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>
<div class= "mx-auto mt-5 p-2" style="width: 80%;">
	<h1>내가 쓴 글</h1>
	<table class="table table-striped">
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
				<td><a href="../board/boarddetail.do?num=${writer.board_id}">${writer.board_title}</a></td>
				<td>${writer.board_date}</td>
				<td>
				<button class="btn btn-warning btn-sm" onclick="location.href='../board/boardupdate.do?board_id=${writer.board_id}'">수정</button>
				<button class="btnDel btn btn-danger btn-sm" data-del="${writer.board_id}">삭제</button>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
<script>
$(function () {
	$(".btnDel").on("click", function () {
		location.href = "../board/boarddelete.do?num=" + $(this).attr("data-del");
	})
});
</script>
</body>
</html>