<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<title>회원정보 확인 및 수정</title>

</head>
<body>
	<h1>회원정보 확인 및 수정</h1>
	<form action="../auth/membersDetail.do" method="post">
		<table> 
			<tr>
				<td>아이디</td>
				<td> <span>${loginUser.mem_id}</span> </td>
				<td> <input type="hidden" name="mem_id" value="${loginUser.mem_id}"> </td>
			</tr>
			
			<tr>
				<td>비밀번호</td>
				<td> <input type="text" name="pw" value="${loginUser.pw}"> </td>
			</tr>
			
			<tr>
				<td>이름</td>
				<td> <input type="text" name="mem_name" value="${loginUser.mem_name}"> </td>
			</tr>
			
			<tr>
				<td>전화번호</td>
				<td> <input type="text" name="phone" value="${loginUser.phone}"> </td>
			</tr>
			
			<tr>
				<td>주소</td>
				<td> <input type="text" name="address" value="${loginUser.address}"> </td>
			</tr>
			
			<tr>
				<td>닉네임</td>
				<td> <input type="text" name="nickname" value="${loginUser.nickname}" id="nickname"> </td>
				<td> <input type="button" id="nicknameDupCheck" value="중복체크"> </td>
					<td> <span id="nicknameMessage"></span> </td>
			</tr>
			
			<tr>
				<td>잔고</td>
				<td> <span>${loginUser.balance}</span> </td>
				<td> <input type="hidden" name="balance" value="${loginUser.balance}"> </td>
			</tr>
			
			<tr>
				<td>등급</td>
				<td> <span>${loginUser.grade}</span> </td>
				<td> <input type="hidden" name="grade" value="${loginUser.grade}"> </td>
			</tr>
			
			<tr style="text-align: center;">
				<td colspan="2"> <input type="submit" value="회원정보수정"> </td>
			</tr>
			
		</table>
	</form>
</body>
<script>
$(function () {
	
	$("#nicknameDupCheck").on("click", function () {
		//페이지 이동없이 서버에 요청을 보내고 응답 받기 : ajax
		//method 생략하면 get 방식 method:"get" 이렇게 써도 됨
		$.ajax({
			url:"nicknameDupCheck.do",
			data:{"nickname":$("#nickname").val()},
			success:function(responseData){
				//alert(responseData); //변수이름은 내가 정하는 것 (순서는 정해져 있음)
				var message = responseData==1?"이미 존재하는 닉네임입니다.":"사용 가능한 닉네임입니다.";
				$("#nicknameMessage").text(message);
				if(responseData==1) {
					$("#nickname").val("");
					$("#nickname").focus();
				}					
																				
			},
			error:function(message){
				alert(message);
			}
		});
	})
});
</script>
</html>