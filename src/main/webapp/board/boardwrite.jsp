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
	<h1>글 작성</h1>
	<form method="post" action="<%=request.getContextPath() %>/board/boardwrite.do">
		<table>
			<tr>
				<td>제목</td>
				<td><input type="text" name="board_title" required="required"
					placeholder="제목을 입력해주세요" autofocus="autofocus"></td>
			</tr>
			<tr>
				<td>글 내용</td>
				<td><textarea name="board_contents"></textarea></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="number" name="price" required="required"
					placeholder="가격을 입력해주세요"></td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td><select id="category_id" name="category_id">
						<c:forEach items="${clist}" var="category" varStatus="status">
							<option value="${category}">${category}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
			<td>사진</td>
			<td><input type="text" name="board_pictures"
					 placeholder="내용을 입력해주세요" value="pictures"></td>
			</tr>
		</table>
		<input type="hidden" name="board_writer" value="${loginUser.nickname}"/>
		<input type="hidden" name="address" value="${loginUser.address}"/>
		<button id="btnWriteBoard">작성</button>

	</form>
</body>
</html>