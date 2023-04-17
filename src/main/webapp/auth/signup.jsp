<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
		<form action="#" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td> <input type="text" name="mem_id" required="required" 
								placeholder="내용을 입력해주세요" autofocus="autofocus"> </td>
					<td> <input type="button" id="idDupCheck" value="중복체크"> </td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td> <input type="text" name="pw" required="required" 
								placeholder="내용을 입력해주세요" > </td>
				</tr>
				<tr>
					<td>이름</td>
					<td> <input type="text" name="mem_name" required="required" 
								placeholder="내용을 입력해주세요" > </td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td> <input type="text" name="phone" required="required" 
								placeholder="내용을 입력해주세요" > </td>
				</tr>
				<tr>
					<td>주소</td>
					<td> <input type="text" name="address" required="required" 
								placeholder="내용을 입력해주세요" > </td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td> <input type="text" name="nickname" required="required" 
								placeholder="내용을 입력해주세요" > </td>
					<td> <input type="button" id="nicknameDupCheck" value="중복체크"> </td>
				</tr>
			</table>
			<input type="radio" name="grade" value="personal"> 개인 회원
			<input type="radio" name="grade" value="company"> 전문 업체
			<br>
			<input type="submit" value="가입">
			
		</form>
		<!-- <input style="text-align: center" type="button" name="signupBtn" value="회원가입"> -->
</body>
</html>