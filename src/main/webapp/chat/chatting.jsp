<%@page import="com.billi.model.ChattingService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html style="background-color:#F2F7F8">
<head>
<meta charset="UTF-8">
<title>Billi chat</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<style>
.chat_content {color:white;}
.impress{ color:red;}
.whisper{ color: green;}
.mySpan{background-color:#00E777}
.opSpan{background-color:gray}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!-- 로그인한 상태일 경우와 비로그인 상태일 경우의 chat_id설정 -->
	<c:set var="username" value="${loginUser.nickname}" />
	<c:if test="${(username ne '') and !(empty username)}">
		<input type="hidden" value='${username}' id='chat_id' />
	</c:if>
	<!-- 채팅창 -->
	<div id="_chatbox" >
		<fieldset style="background-color:#F2F7F8">
			<div id="messageWindow" >
				<!-- 이전 채팅 기록 가져오기 -->
				<c:forEach var="item" items="${chatHistory}">
					<c:if test="${item.sender_name eq  username }">
					<p class='chat_content text-end  my-5 mx-3'><span class="border p-3 rounded-4 mySpan">${item.chat_contents}</span></p>
					</c:if>
					<c:if test="${item.sender_name ne username }">
						<p class='chat_content my-5 mx-3'><span class="border p-3 rounded-4 opSpan">${item.sender_name} : ${item.chat_contents}</span></p>
					</c:if>
				</c:forEach>
			</div>
			<br /> 
			<div class="row m-2 fixed-bottom ">
		      <div class="col-11"><input id="inputMessage" type="text" class="form-control float-start" onkeyup="enterkey()" /></div>
		      <div class="col-1"><input type="submit" value="send" onclick="send()" class="btn float-end" style="color:white; background-color:#424952"/></div>
		    </div>
			
			<!-- <input id="inputMessage" type="text" class="form-control float-start" onkeyup="enterkey()" />
			<input type="submit" value="send" onclick="send()" class="btn btn-primary float-end" /> -->
		</fieldset>
	</div>
</body>
<script>
	var webSocket = new WebSocket('ws://192.168.0.100:9090/billi/websocket');
	webSocket.onerror = function(event) {onError(event)};
	webSocket.onopen = function(event) {onOpen(event)};
	webSocket.onmessage = function(event) {onMessage(event)};
	
	function onMessage(event) {
		console.log(event.data);
		var message = event.data.split("|");
		var room_id = message[0];
		var sender = message[1];
		var receiver = message[2]
		var content = message[3];
		if (content == "") return; 
		var originalMessage = $("#messageWindow").html();
		
		$("#messageWindow").html( originalMessage
				+ "<p class='chat_content my-5 mx-3'><span class='border p-3 rounded-4 opSpan'>" + sender
				+ " : " + content + "</span></p>");
		 
	}  
	function onOpen(event) {
		var history = "${chatHistory}";
		if (history=="[]" || !history){
			$("#messageWindow").html("<p class='chat_content'>안녕하세요. 채팅을 시작해보세요.</p>");
		}
	}
	function onError(event) {
		alert(event.data);
	}
	function send() {
		var message = $("#inputMessage").val() ;
		if (message != "") {
			$("#messageWindow").html($("#messageWindow").html() + "<p class='chat_content text-end my-5 mx-3'><span class='border p-3 rounded-4 mySpan'>"
							+ message + "</span></p>");
		}
		
		if("${username}"=="${chatRoom.buyer}"){
			var receiver = "${chatRoomseller}";
		}else{
			var receiver = "${chatRoom.buyer}";
		}
		webSocket.send("${chatRoom.room_id}"+"|"+"${username}"+"|" +receiver + "|" + message);
		
		$("#inputMessage").val("");
	}
	//엔터키를 통해 send함
	function enterkey() {
		if (window.event.keyCode == 13) {
			send();
		}
	}
	//채팅이 많아져 스크롤바가 넘어가더라도 자동적으로 스크롤바가 내려가게함
	window.setInterval(function() {
		var elem = $('#messageWindow');
		elem.scrollTop = elem.scrollHeight;
	}, 0);
</script>

</body>
</html>