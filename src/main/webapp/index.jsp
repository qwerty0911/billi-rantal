<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

</script>
</head>
<body>
<h1>main page</h1>
<button onclick="location.href='<%=request.getContextPath() %>/auth/logincheck.do'">로그인</button>
<button onclick="location.href='<%=request.getContextPath() %>/auth/signup.do'">회원가입</button>
<button onclick="location.href='<%=request.getContextPath() %>/board/boardwrite.do'">게시판</button>
</body>
</html>