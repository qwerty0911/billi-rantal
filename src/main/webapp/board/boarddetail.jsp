<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<title>boarddetail</title>
<%@ include file="../util/rentalCalenderHeader.jsp" %>
<%-- <%@ include file="../util/rentalCalenderBody.jsp" %> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<p>${board} </p>
</head>
<body>
<table>
			<tr>
				<td name="제목">${board.board_title}</td>
			</tr>
			<tr>
				<td name="작성자">${board.board_writer}</td>
			</tr>
			<tr>
				<td name="작성일">${board.board_date}</td>
			</tr>
			<tr>
				<td name="내용">${board.board_contents}</td>
			</tr>
			<tr>
				<td name="금액">${board.price}</td>
			</tr>
			<tr>
				<td name="카테고리">${board.category}</td>
			</tr>
			<tr>
				<td name="주소">${board.address}</td>
			</tr>
			<tr>
			<td name="사진">${board.pictures}</td>
			</tr>
		</table>
<button id="btnchat" onclick="location.href='<%=request.getContextPath() %>/chat/chat.do'" >채팅</button>
<%@ include file="../util/rentalCalenderBody.jsp" %>

<hr>
<h2>후기 (${reviewcount})</h2>
	<hr>
	
		<c:forEach items="${boardreviewlist}" var="review">
			<p>작성자 : ${review.review_writer}</p>
			<p>작성일 : ${review.review_date}</p>
			<p>평점 : ${review.rating}</p>
			<p>내용 : ${review.review_content}</p>
			<hr>
		</c:forEach>

</body>
</html>