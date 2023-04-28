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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>


<div class="container mt-5 mx-auto">
<h1>게시글 수정 </h1>
	<form action="../board/boardupdate.do" method="post">
	<div class="mb-3">
	  <label for="board_title" class="form-label">제목</label>
	  <input type="text" class="form-control" name="board_title" id="board_title" name="board_title" value="${board.board_title}">
	</div>
	<%-- <label for="board_title">제목</label>
	<input type="text" name="board_title" id="board_title" value="${board.board_title}"><br> --%>
	
	<div class="mb-3">
	  <label for="board_contents" class="form-label">내용</label>
	  <textarea class="form-control" name="board_contents" id="board_contents" value="${board.board_contents}" rows="12"></textarea>
	</div>
	<%-- <label for="board_contents">내용</label>
	<input type="text" name="board_contents" id="board_contents" value="${board.board_contents}"><br> --%>
	
	<div class="mb-3">
	  <label for="price" class="form-label">가격</label>
	  <input type="text" class="form-control" name="price" id="price" value="${board.price}">
	</div>
	<%-- <label for="price">가격</label>
	<input type="text" name="price" id="price" value="${board.price}"><br> --%>
	
	
	<div class="form-floating">
		<select class="form-select" id="category_id" name="category_id" aria-label="Floating label select example">
			<c:forEach items="${clist}" var="category" varStatus="status">
			<option value="${category}">${category}</option>
			</c:forEach>
		</select>
		<label for="floatingSelect">카테고리</label>
	</div>
		
	<%-- <label for="category_id">카테고리</label>
	<select id="category_id" name="category_id" aria-label="Floating label select example">
		<c:forEach items="${clist}" var="category" varStatus="status">
			<option value="${category}">${category}</option>
		</c:forEach>
	</select> <br> --%>
		
	<div class="mb-3">
		<label for="formFile" class="form-label">사진</label>
		<input class="form-control" type="file" name="pictures" id="formFile" value="${board.pictures}" multiple>
	</div>	
	
	<%-- <label for="pictures">사진</label>
	<input type="file" name="pictures" id="pictures" value="${board.pictures}"><br> --%>
	
	<input type="hidden" name="board_id" value="${board.board_id}">
	<input type="hidden" name="board_writer" value="${board.board_writer}">
	<input type="hidden" name="board_date" value="<fmt:formatDate value="${board.board_date}" pattern="yyyy/MM/dd"/>">
	<input type="hidden" name="address" value="${board.address}">
	<input type="submit" value="수정하기" class="btn btn-success text-right">
	
	</form>
</div>
	
</body>
</html>