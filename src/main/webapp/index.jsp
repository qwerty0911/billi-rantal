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
<<<<<<< HEAD
<button onclick="location.href='<%=request.getContextPath() %>/board/boardlist.do?pageNum=1'">게시판 목록</button>
=======
<button onclick="location.href='<%=request.getContextPath() %>/board/boardlist.do'">게시판 목록</button>
<button onclick="location.href='<%=request.getContextPath() %>/user/mypage.do'">마이페이지</button>
>>>>>>> f2ac3b6cc1595e88e62865b9dcd8e318cdf22865
</body>
</html>