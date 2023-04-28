<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
 @license
 Copyright 2019 Google LLC. All Rights Reserved.
 SPDX-License-Identifier: Apache-2.0
-->
<html>
  <head>
    <title>Geocoding Service</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <script>
      /**
       * @license
       * Copyright 2019 Google LLC. All Rights Reserved.
       * SPDX-License-Identifier: Apache-2.0
       */
      let map;
      let marker;
      let geocoder;
      let responseDiv;
      let response;

      function initMap() {
        map = new google.maps.Map(document.getElementById("map"), {
          zoom: 17,
          center: { lat: 37.557527, lng: 126.9244669 },
          mapTypeControl: false,
        });
        
        /* input 태그에 위도 경도 삽입하는 리스너 */
        var myInputLat = document.getElementById("myInputLat");
        var myInputLng = document.getElementById("myInputLng");
        
        map.addListener('click', function(event) {
    	    var myInputLat = document.getElementById("myInputLat");
	        var myInputLng = document.getElementById("myInputLng");
	        var myInputAddress = document.getElementById("formattedAddress");
	        
	        // 클릭한 위치의 위도와 경도 추출
    	    var latitude = event.latLng.lat();
    	    var longitude = event.latLng.lng();
    	    
    	    myInputLat.value = latitude;
    	    myInputLng.value = longitude;
    	    
    	    var geocoder = new google.maps.Geocoder();
    	    geocoder.geocode({ 'location': event.latLng }, function(results, status) {
				if (status === 'OK') {
					if (results[0]) {
						/* var formattedAddress = results[0].formatted_address; */
						var addressComponents = results[0].address_components;
				        var formattedAddress = "";
				        /* for (var i = 0; i < addressComponents.length; i++) { */
				        for (var i = addressComponents.length-1; i > 0; i--) {
				          var types = addressComponents[i].types;
				          if (types.includes('locality') || types.includes('sublocality')) {
				            formattedAddress += addressComponents[i].long_name;
				            if (i < addressComponents.length - 2) {
				              formattedAddress += " ";
				            }
				          }
				        }
						myInputAddress.value = formattedAddress;
						
						
					}else {
						console.log('No results found');
					}
				}else {
					/* console.log('Geocoder failed due to: ' + status); */
				}
			});
    	    
    	    
    	    
    	});
        
        geocoder = new google.maps.Geocoder();

        const inputText = document.createElement("input");

        inputText.type = "text";
        inputText.placeholder = "Enter a location";

        const submitButton = document.createElement("input");

        submitButton.type = "button";
        submitButton.value = "검색";
        submitButton.classList.add("button", "button-primary1");

        const clearButton = document.createElement("input");

        clearButton.type = "button";
        clearButton.value = "초기화";
        clearButton.classList.add("button", "button-secondary1");
        response = document.createElement("pre");
        response.id = "response";
        response.innerText = "";
        responseDiv = document.createElement("div");
        responseDiv.id = "response-container";
        responseDiv.appendChild(response);

        const instructionsElement = document.createElement("p");

        instructionsElement.id = "instructions";
        instructionsElement.innerHTML =
          "<strong>안내</strong>: 주소를 입력하고 확인버튼을 눌러주세요.";
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(inputText);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(submitButton);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(clearButton);
        map.controls[google.maps.ControlPosition.LEFT_TOP].push(
          instructionsElement
        );
        /* map.controls[google.maps.ControlPosition.LEFT_TOP].push(responseDiv); */
        marker = new google.maps.Marker({
          map,
        });
        map.addListener("click", (e) => {
          geocode({ location: e.latLng });
        });
        submitButton.addEventListener("click", () =>
          geocode({ address: inputText.value })
        );
        clearButton.addEventListener("click", () => {
          clear();
        });
        clear();
      }
      
      function printLongLat(result){
    	  console.log(result)
    	  
      }

      function clear() {
        marker.setMap(null);
      }
      
     

      function geocode(request) {
        clear();
        geocoder
          .geocode(request)
          .then((result) => {
            const { results } = result;

            map.setCenter(results[0].geometry.location);
            marker.setPosition(results[0].geometry.location);
            marker.setMap(map);
            response.innerText = JSON.stringify(result, null, 2);
            return results;
          })
          .catch((e) => {
            alert("Geocode was not successful for the following reason: " + e);
          });
      }
      
      

      window.initMap = initMap;
    </script>
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
				if(responseData==1) {
					$("#idHelp").html("이미 존재하는 아이디입니다.");
					
					$("#mem_id").val("");
					$("#mem_id").focus();
				}else{
					$("#idHelp").html("사용가능한 아이디입니다.");
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
				if(responseData==1) {
					$("#nicknameHelp").html("이미 존재하는 닉네임입니다.");
					
					$("#nickname").val("");
					$("#nickname").focus();
				}
				else{
					$("#nicknameHelp").html("사용가능한 닉네임입니다.");
				}
																				
			},
			error:function(message){
				alert(message);
			}
		});
	})
});
</script>
    <style>
      /**
       * @license
       * Copyright 2019 Google LLC. All Rights Reserved.
       * SPDX-License-Identifier: Apache-2.0
       */
      /**
       * Always set the map height explicitly to define the size of the div element
       * that contains the map. 
       */
      #map {
        height: 100%;
        width: 100%;
      }

      /* Optional: Makes the sample page fill the window. */
      html,
      body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      
      input[type="button"]:hover {
        background: rgb(235, 235, 235);
      }
      
      input[type="text"] {
        background-color: #fff;
        border: 0;
        border-radius: 2px;
        box-shadow: 0 1px 4px -1px rgba(0, 0, 0, 0.3);
        margin: 10px;
        padding: 0 0.5em;
        font: 400 18px Roboto, Arial, sans-serif;
        overflow: hidden;
        line-height: 40px;
        margin-right: 0;
        min-width: 25%;
      }
      
      input[type="button"] {
        background-color: #fff;
        border: 0;
        border-radius: 2px;
        box-shadow: 0 1px 4px -1px rgba(0, 0, 0, 0.3);
        margin: 10px;
        padding: 0 0.5em;
        font: 400 18px Roboto, Arial, sans-serif;
        overflow: hidden;
        height: 40px;
        cursor: pointer;
        margin-left: 5px;
      }

      #response-container {
        background-color: #fff;
        border: 0;
        border-radius: 2px;
        box-shadow: 0 1px 4px -1px rgba(0, 0, 0, 0.3);
        margin: 10px;
        padding: 0 0.5em;
        font: 400 18px Roboto, Arial, sans-serif;
        overflow: hidden;
        overflow: auto;
        max-height: 50%;
        max-width: 90%;
        background-color: rgba(255, 255, 255, 0.95);
        font-size: small;
      }

      #instructions {
        background-color: #fff;
        border: 0;
        border-radius: 2px;
        box-shadow: 0 1px 4px -1px rgba(0, 0, 0, 0.3);
        margin: 10px;
        padding: 0 0.5em;
        font: 400 18px Roboto, Arial, sans-serif;
        overflow: hidden;
        padding: 1rem;
        font-size: medium;
      }
    </style>
  </head>
  <body>
  <%@ include file="/navbar/navbar.jsp"%>
  <div class="container mx-auto mt-3">
	  <div class="row">
		<div class="col" >
		  <h1>회원가입</h1>
		  <form action="../auth/signUp.do" method="post" id=form>
			  <div class="mb-3">
			  <label for="mem_id" class="form-label">아이디</label>
			  <input type="text" name="mem_id" class="form-control" id="mem_id" placeholder="" required="required" >
			  <div id="idHelp" class="form-text">중복을 체크해주세요</div>
			  <input type="button" id="idDupCheck" value="중복체크" class="btn btn-light btn-sm">
			</div>
			<div class="mb-3">
			  <label for="mem_pw" class="form-label">비밀번호</label>
			  <input type="password" name="pw" class="form-control" id="mem_pw" placeholder="" required="required" >
			</div>
			<div class="mb-3">
			  <label for="mem_name" class="form-label">이름</label>
			  <input type="text" name="mem_name" class="form-control" id="mem_name" placeholder="홍길동" required="required" >
			</div>
			<div class="mb-3">
			  <label for="phone" class="form-label">전화번호</label>
			  <input type="text" name="phone" class="form-control" id="phone" placeholder="010-0000-1111" required="required" >
			</div>
			<div class="mb-3">
			  <label for="nickname" class="form-label">닉네임</label>
			  <input type="text" name="nickname" class="form-control" id="nickname" required="required" >
			  <div id="nicknameHelp" class="form-text">중복을 체크해주세요</div>
			  <input type="button" id="nicknameDupCheck" value="중복체크" class="btn btn-light btn-sm"> 
			</div>
			<div>
			
			<div class="mb-3">
			  <label for="formattedAddress" class="form-label">주소</label>
			  <input type="text" readOnly id="formattedAddress" name="formattedAddress" class="form-control" required="required" >
			</div>
			<input type="hidden" value="" name="latitude" id="myInputLat" >
			<input type="hidden" value="" name="longitude" id="myInputLng" >
			</div>
			<input type="submit" class="btn btn-primary" value="회원가입">
		  </form>
		</div>
	  <div class="col" >
		<div id="map" ></div>
		</div>
	  </div>
 </div>
    <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD0S8EfdDKR8QDgHXcR08Jel6_UJdGa198&callback=initMap&v=weekly" defer></script>

  </body>
</html>