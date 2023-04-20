<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰작성</title>
</head>
<body>
	<h2>리뷰작성</h2>
	<form action="../user/reviewwrite.do" method="post">
		<p>${loginUser.nickname}</p>
		<input type="text" name="rating" id="rating" placeholder="평점 입력" required="required"> <br>
		<textarea name="review_content" id="review_content" placeholder="내용을 입력해주세요" required="required"></textarea>
		<input type="hidden" name="review_writer" id="review_writer" value="${loginUser.nickname}">
		<input type="hidden" name="board_id" id="board_id" value="${param.num}">
		<input type="submit" id="reviewwritebtn" value="후기 작성" onclick="location.href='../board/boarddetail.do?num=${param.num}'">
		
	</form>
</body>
</html>