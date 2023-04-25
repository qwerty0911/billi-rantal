<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<title>회원정보 확인 및 수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>
<h1>회원정보 확인 및 수정</h1>
<form action="../auth/membersDetail.do" method="post">
  <div class="mb-3 row">
   <label for="staticId" class="col-sm-2 col-form-label">ID</label>
   <div class="col-sm-10">
     <input type="text" readonly name="mem_id" class="form-control-plaintext" id="staticId" value="${loginUser.mem_id}">
   </div>
 </div>
 
 <div class="mb-3 row">
   <label for="inputPassword" class="col-sm-2 col-form-label">Password</label>
   <div class="col-sm-10">
     <input type="password" class="form-control" id="inputPassword" name="pw" value="${loginUser.pw}">
   </div>
 </div>
 
 <div class="mb-3 row">
   <label for="inputName" class="col-sm-2 col-form-label">이름</label>
   <div class="col-sm-10">
     <input type="text" class="form-control" id="inputName" name="mem_name" value="${loginUser.mem_name}">
   </div>
 </div>
 
 <div class="mb-3 row">
   <label for="inputphone" class="col-sm-2 col-form-label">전화번호</label>
   <div class="col-sm-10">
     <input type="text" class="form-control" id="inputphone" name="phone" value="${loginUser.phone}">
   </div>
 </div>
 
 <div class="mb-3 row">
   <label for="inputaddress" class="col-sm-2 col-form-label">주소</label>
   <div class="col-sm-10">
     <input type="text" class="form-control" readOnly id="inputaddress" name="address" value="${loginUser.address}">
   </div>
 </div>
 
 <div class="mb-3 row">
   <label for="inputnickname" class="col-sm-2 col-form-label">닉네임</label>
   <div class="col-sm-10">
     <input type="text" class="form-control" id="inputnickname" name="nickname" value="${loginUser.nickname}">
   </div>
 </div>
<input type="button" id="nicknameDupCheck" value="중복체크">
<span id="nicknameMessage"></span>
<input type="submit" class = "btn btn-primary" value="회원정보수정">
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