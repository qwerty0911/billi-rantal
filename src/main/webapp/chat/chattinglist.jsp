<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>${loginUser.nickname }님의 채팅방</h1>
<ul>
	<c:forEach var="item" items="${chattinglist}">
		<li><a href='<%=request.getContextPath() %>/chat/chat.do?board=${item.board_id}&buyer=${item.buyer}&seller=${item.seller }'>
			<c:if test="${loginUser.nickname eq item.seller}">${item.buyer}--${item.board_title}</c:if>
			<c:if test="${loginUser.nickname eq item.buyer}">${item.seller}--${item.board_title}</c:if>
		</a></li>
	</c:forEach>
</ul>
</body>
</html>