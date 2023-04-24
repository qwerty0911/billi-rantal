<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<title>SignUp Page</title>
<link rel="stylesheet" href="../css/googleMap.css" type="text/css">
<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script src="../googleMapAPI/googleMap.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<script>
$(function () {
	
	$("#idDupCheck").on("click", function () {
		//페이지 이동없이 서버에 요청을 보내고 응답 받기 : ajax
		//method 생략하면 get 방식 method:"get" 이렇게 써도 됨
		$.ajax({
			url:"idDupCheck.do",
			data:{"mem_id":$("#mem_id").val()},
			success:function(responseData){
				//alert(responseData); //변수이름은 내가 정하는 것 (순서는 정해져 있음)
				var message = responseData==1?"이미 존재하는 아이디입니다.":"사용 가능한 아이디입니다.";
				/* $("#idMessage").text(message); */
				${"#toast"}.append(`
						<div class="toast align-items-center" role="alert" aria-live="assertive" aria-atomic="true">
						  <div class="d-flex">
						    <div class="toast-body">
						      Hello, world! This is a toast message.
						    </div>
						    <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
						  </div>
						</div>
						`);
				if(responseData==1) {
					$("#mem_id").val("");
					$("#mem_id").focus();
				}					
																				
			},
			error:function(message){
				alert(message);
			}
		});
	})
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
<body>
<%@ include file="/navbar/navbar.jsp"%>
<div class="container mx-auto">
<h1>회원가입</h1>

<div id ="toast">
<p></p>
</div>



<form action="../auth/signUp.do" method="post">
<div class="row">
	<div class="col-sm-6">
		<table>
		<tr>
			<td>아이디</td>
			<td> <input type="text" name="mem_id" required="required" id="mem_id"
						placeholder="내용을 입력해주세요" autofocus="autofocus"> </td>
			<td> <input type="button" id="idDupCheck" value="중복체크"> </td>
			<td> <span id="idMessage"></span> </td>
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
			
		
		<tr>
		<td> <span id="hidden" style="color: #999; display: none"></span> </td>
		<td> <input type="hidden" id="sample4_extraAddress" placeholder="참고항목"> </td>
		
	</tr>
		<tr>
			<td>닉네임</td>
			<td> <input type="text" name="nickname" required="required" id="nickname"
						placeholder="내용을 입력해주세요" > </td>
			<td> <input type="button" id="nicknameDupCheck" value="중복체크"> </td>
			<td> <span id="nicknameMessage"></span> </td>
			<td>
			</td>
		</tr>
		<tr>
		<td><input type="text" value="" name="latitude" id="myInputLat" ></td>
		<td><input type="text" value="" name="longitude" id="myInputLng" ></td>
		</tr>
		
		<tr>
		<td colspan="2"> <input type="text" readOnly id="formattedAddress" name="formattedAddress" > </td> 
		</tr>
	</table>
	
	</div>
<div class="col-sm-6">
	<div id="map" ></div>
</div>
 </div>
	
	<input type="submit" class="btn btn-primary" value="회원가입">
</form>
</div>
	
		
		
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD0S8EfdDKR8QDgHXcR08Jel6_UJdGa198&callback=initMap&v=weekly" defer></script>
		

</body>
</html>