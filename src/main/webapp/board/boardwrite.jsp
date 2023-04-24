<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>
<div  class="p-3 m-0 border-0 bd-example">
<h1>글 작성</h1>
	<form method="post" action="<%=request.getContextPath() %>/board/boardwrite.do" enctype="multipart/form-data" >
		<div class="mb-3">
		  <label for="titleInput" class="form-label">제목</label>
		  <input type="text" class="form-control" id="titleInput" name="board_title" placeholder="제목을 입력하세요">
		</div>
		<div class="mb-3">
		  <label for="exampleFormControlTextarea1" class="form-label">내용</label>
		  <textarea class="form-control" id="exampleFormControlTextarea1" name="board_contents" rows="3"></textarea>
		</div>
		<div class="mb-3">
		  <label for="priceInput" class="form-label">가격</label>
		  <input type="number" class="form-control" name="price" id="priceInput" >
		</div>
		
		<div class="form-floating">
		<select class="form-select" id="category_id" name="category_id" aria-label="Floating label select example">
			<c:forEach items="${clist}" var="category" varStatus="status">
			<option value="${category}">${category}</option>
			</c:forEach>
		</select>
		<label for="floatingSelect">카테고리</label>
		</div>
		
		<div class="mb-3">
			<label for="formFile" class="form-label">사진</label>
			<input class="form-control" type="file" name="file" id="formFile">
		</div>
		<input type="hidden" name="board_writer" value="${loginUser.nickname}"/>
		<input type="hidden" name="address" value="${loginUser.address}"/>
		<button id="btnWriteBoard" class="btn btn-primary">작성</button>

	</form>
</div>
	
</body>
</html>