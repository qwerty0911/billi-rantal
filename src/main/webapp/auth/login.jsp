<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
 <link rel="stylesheet" href="../css/login.css" type="text/css">
 
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
<c:set var="message" value="" scope="session"></c:set>
</head>

<body>
<div id="form-container">
      <div id="form-inner-container">
        <!-- Sign up form -->
        <div id="sign-up-container">
          <h3>로그인</h3>
          <form action="../auth/loginCheck.do" method="post">
            <label for="mem_id">아이디</label>
            <input type="text" name="mem_id" id="mem_id" placeholder="아이디">

            <label for="password">비밀번호</label>
            <input type="password" name="pw" id="pw" placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;">

            <div id="form-controls">
              <button type="submit">로그인하기</button>
              <br>
              <button type="button" onclick="location.href='../auth/signUp.do'">회원가입</button>
            </div>
            
            <input type="checkbox" name="terms" id="terms">
            <label for="terms">I agree to the 
            <a href="#" class="termsLink">Terms of service</a>
            and <a href="#" class="termsLink">Privacy Policy</a>.
            </label>
          </form>
        </div>
</body>

  <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
  <script type="text/JavaScript" src="./my-script.js"></script>
</html>