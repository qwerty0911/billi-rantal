<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!--  <link rel="stylesheet" href="../css/login.css" type="text/css"> -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<script>
var message = "${sessionScope.message}";
	if(message!="") {
	alert(message);
	
	}
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<c:set var="message" value="" scope="session"></c:set>
</head>

<body>
<%@ include file="/navbar/navbar.jsp"%>

<div class="container">
<h1>로그인</h1>
<form action="<%=request.getContextPath()%>/auth/loginCheck.do" method="post" >
	<div class="mb-3">
	  <label for="inputId" class="form-label">id</label>
	  <input type="text" class="form-control" id="inputId" name="mem_id">
	</div>
	
	<label for="inputPassword" class="form-label">Password</label>
	<input type="password" id="inputPassword" name="pw" class="form-control" aria-labelledby="passwordHelpBlock">
		
	
	<button id="btnWriteBoard" class="btn btn-primary">로그인</button>

</form>
</div>

</body>
</html>