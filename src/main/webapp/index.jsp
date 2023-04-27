<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>


<%@ include file="/navbar/navbar.jsp"%>

<body>
<h1>main page</h1>
<button onclick="location.href='<%=request.getContextPath() %>/auth/loginCheck.do'">로그인</button>
<button onclick="location.href='<%=request.getContextPath() %>/auth/signUp.do'">회원가입</button>
<button onclick="location.href='<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=all'">게시판 목록</button>
<button onclick="location.href='<%=request.getContextPath() %>/user/mypage.do'">마이페이지</button>
<button onclick="location.href='<%=request.getContextPath() %>/chat/chatlist.do'">채팅 목록</button>

<hr>
<h2>인기 게시물</h2>
<div id="hits">
<ul>
<c:forEach items="${hitsList}" var="hit">
	<li><a href="board/boarddetail.do?num=${hit.board_id}"><img src="https://billi-boards-img.s3.ap-northeast-2.amazonaws.com/board/b_${hit.board_id}_1.jpg"></a></li>
</c:forEach>
</ul>
</div>

<hr>

<h2>최근 게시물</h2>
<div id="latest">
<c:forEach items="${latestList}" var="latest">
	<li><a href="board/boarddetail.do?num=${latest.board_id}"><img src="https://billi-boards-img.s3.ap-northeast-2.amazonaws.com/board/b_${latest.board_id}_1.jpg"></a></li>
</c:forEach>
</div>
</body>
</html>