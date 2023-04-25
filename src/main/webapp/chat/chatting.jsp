<%@page import="com.billi.model.ChattingService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<style>
.chat_content {color:blue;}
.impress{ color:red;}
.whisper{ color: green;}
</style>
</head>
<body>
	<!-- 로그인한 상태일 경우와 비로그인 상태일 경우의 chat_id설정 -->
	<c:set var="username" value="${loginUser.nickname}" />
	<c:if test="${(username ne '') and !(empty username)}">
		<input type="hidden" value='${username}' id='chat_id' />
	</c:if>
	<!-- 채팅창 -->
	<div id="_chatbox">
		<fieldset>
			<div id="messageWindow">
				<!-- 이전 채팅 기록 가져오기 -->
				<c:forEach var="item" items="${chatHistory}">
					<c:if test="${item.sender_name eq  username }">
						<p class='chat_content'>나 : ${item.chat_contents}</p>
					</c:if>
					<c:if test="${item.sender_name ne username }">
						<p class='chat_content'>${item.sender_name} : ${item.chat_contents}</p>
					</c:if>
				</c:forEach>
			</div>
			<br /> <input id="inputMessage" type="text" onkeyup="enterkey()" />
			<input type="submit" value="send" onclick="send()" />
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
				+ "<p class='chat_content'>" + sender
				+ " : " + content + "</p>");
		 
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
			$("#messageWindow").html($("#messageWindow").html() + "<p class='chat_content'>나 : "
							+ message + "</p>");
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