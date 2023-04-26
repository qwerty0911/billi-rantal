<%@page import="com.billi.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>

	<h1>게시글 수정 </h1>
	<p>${board}</p>
	<p>${clist}</p>
	<form action="../board/boardupdate.do" method="post">
	<label for="board_title">제목</label>
	<input type="text" name="board_title" id="board_title" value="${board.board_title}"><br>
	
	<label for="board_contents">내용</label>
	<input type="text" name="board_contents" id="board_contents" value="${board.board_contents}"><br>
	
	<label for="price">가격</label>
	<input type="text" name="price" id="price" value="${board.price}"><br>
	
	<label for="category_id">카테고리</label>
	<select id="category_id" name="category_id" aria-label="Floating label select example">
		<c:forEach items="${clist}" var="category" varStatus="status">
			<option value="${category}">${category}</option>
		</c:forEach>
	</select> <br>
		
	
	<label for="pictures">사진</label>
	<input type="file" name="pictures" id="pictures" value="${board.pictures}"><br>
	
	<input type="hidden" name="board_id" value="${board.board_id}">
	<input type="hidden" name="board_writer" value="${board.board_writer}">
	<input type="hidden" name="board_date" value="<fmt:formatDate value="${board.board_date}" pattern="yyyy/MM/dd"/>">
	<input type="hidden" name="address" value="${board.address}">
	<input type="submit" value="수정하기">
	
	</form>
</body>
</html>