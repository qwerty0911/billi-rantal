<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>main page</h1>
<button onclick="location.href='<%=request.getContextPath() %>/auth/loginCheck.do'">로그인</button>
<button onclick="location.href='<%=request.getContextPath() %>/auth/signUp.do'">회원가입</button>
<button onclick="location.href='<%=request.getContextPath() %>/board/boardlist.do'">게시판 목록</button>
<button onclick="location.href='<%=request.getContextPath() %>/user/mypage.do'">마이페이지</button>
</body>
</html>