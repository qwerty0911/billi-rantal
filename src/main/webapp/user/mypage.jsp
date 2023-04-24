<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ include file="../common/commonfile.jsp" %> --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>
	<h1>마이페이지</h1>
	<button onclick="location.href='../auth/membersDetail.do'">회원정보 확인 및 수정</button> <br>
	<button id="btnLogout">로그아웃</button> <br>
	<button onclick="location.href='../user/myrental.do'">대여내역</button> <br>
	<button onclick="location.href='../user/myreview.do'">내가 쓴 후기</button> <br>
	<button onclick="location.href='../user/myboardlist.do'">내가 쓴 글</button> <br>
</body>
<script>
	$(function () {
		$("#btnLogout").on("click", function () {
			$.ajax({
				url:"../auth/logout.do",
				success:function(responseData){
					alert(responseData+"로그아웃 되었습니다.");
					location.href="../auth/loginCheck.do"
				},
				error:function(message){
					alert(message);
					console.log(message);
				}
			});
		});
	});
</script>
</html>