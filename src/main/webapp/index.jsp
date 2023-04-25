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
<button onclick="location.href='<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=all'">게시판 목록</button>
<button onclick="location.href='<%=request.getContextPath() %>/user/mypage.do'">마이페이지</button>
<button onclick="location.href='<%=request.getContextPath() %>/chat/chatlist.do'">채팅 목록</button>

<br>
<button onclick="location.href='<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=toy'">유아동/완구</button>
<button onclick="location.href='<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=digital'">디지털/가전</button>
<button onclick="location.href='<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=sports'">레저/스포츠</button>
<button onclick="location.href='<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=life'">주방/생활용품</button>
<button onclick="location.href='<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=interior'">가구/인테리어</button>
<button onclick="location.href='<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=hobby'">취미/악기/게임</button>
</body>
</html>