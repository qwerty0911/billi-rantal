<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<title>SignUp Page</title>
<link rel="stylesheet" href="../css/googleMap.css" type="text/css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script src="../googleMapAPI/googleMap.js"></script>
</head>

<!-- 다음api -->
<!-- <script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    
                }
            }
        }).open();
    }
</script> -->
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
				$("#idMessage").text(message);
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
	<h1>회원가입</h1>
		<form action="../auth/signUp.do" method="post">
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
					<!-- <td>주소</td>
				
				<td> <input type="text" id="sample4_postcode" placeholder="우편번호"> </td>
				<td> <input type="button" onclick="sample4_execDaumPostcode()"
					value="우편번호 찾기"><br> </td> -->
					
				<tr>
				<td>주소</td>
				<td> <input type="text" readOnly id="formattedAddress" name="formattedAddress" placeholder="주소 확인용"> </td> 
				</tr>
				
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
				<td><input type="text" value="" name="latitude" id="myInputLat" readonly></td>
				<td><input type="text" value="" name="longitude" id="myInputLng" readonly></td>
				</tr>
			</table>
			<input type="submit" value="회원가입">
		</form>
		<div id="map" ></div>
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD0S8EfdDKR8QDgHXcR08Jel6_UJdGa198&callback=initMap&v=weekly" defer></script>
		<!-- <input style="text-align: center" type="button" name="signupBtn" value="회원가입"> -->
		

</body>
</html>