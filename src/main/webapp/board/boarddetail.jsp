<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<title>boarddetail</title>
</head>
<body>
<table>
			<tr>
				<td name="제목">${board.board_title}</td>
			</tr>
<<<<<<< HEAD
			<%-- <tr>
				<td name="내용">${board.mem_id}</td>
			</tr> --%>
=======
			<tr>
				<td name="작성자">${board.board_writer}</td>
			</tr>
			<tr>
				<td name="작성일">${board.board_date}</td>
			</tr>
>>>>>>> 0952b5f03efecff2800349ab4b1aec3aa93a1f34
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
			<td name="사진">${board.pictures}</td>
			</tr>
		</table>
<button id="btnchat" onclick="location.href='<%=request.getContextPath() %>/chat/chat.do'" >채팅</button>
<button id="btnrental">대여신청</button>
<hr>
<h2>후기</h2>

</body>
</html>