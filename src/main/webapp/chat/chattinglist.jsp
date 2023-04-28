<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Billi chat</title>

<script>
function changeChat(element){
		var buyerElem = element.querySelector('.buyer');
		var buyer = buyerElem ? buyerElem.textContent : document.getElementById("chattingUser").value;
		
		var sellerElem = element.querySelector('.seller');
		var seller = sellerElem ? sellerElem.textContent : document.getElementById("chattingUser").value;
		
		var board_id = element.querySelector('.board_id').value;
		
		document.getElementById('inlineFrameExample').setAttribute('src', "chat.do?board="+board_id+"&buyer="+buyer+"&seller="+seller);

	}


</script>
<style>
p{ color:white;
}
</style>
</head>
<body class="bd-example-row" style="position: fixed;top: 0;right: 0;bottom: 0;left: 0; background-color:white">
<%@ include file="/navbar/navbar.jsp"%>
<h1><%-- ${loginUser.nickname }님의 채팅방 --%>&nbsp; </h1>
<input type="hidden" id="chattingUser" value="${loginUser.nickname }">
<div class="row rounded border mx-5" style="height:80%">
  <div class="col-4 h-100 py-5 ps-5 rounded" style="background-color: #364048;">
	  <div class="container border rounded h-100 py-3" style="background-color: #424954; overflow:auto">
		<div>
		<c:forEach var="item" items="${chattinglist}">
		<div class="selectChat" onclick="changeChat(this)">
		<%-- <a href='<%=request.getContextPath() %>/chat/chat.do?board=${item.board_id}&buyer=${item.buyer}&seller=${item.seller }'> --%>
			<c:if test="${loginUser.nickname eq item.seller}">
			<p >${item.board_title}</p>
			<input type="hidden" class="board_id" value="${item.board_id}">
			<p class="buyer">${item.buyer}</p>
			<hr>
			</c:if>
			<c:if test="${loginUser.nickname eq item.buyer}">
			<p >${item.board_title}</p>
			<input type="hidden" class="board_id" value="${item.board_id}">
			<p class="seller">${item.seller}</p>
			<hr>
			</c:if>
		</div>
		</c:forEach>
		</div>
	  </div>
    
  </div>
  <div class="col-8 h-100 py-5 pe-5 rounded" style="background-color: #FFFFFF;">
    <iframe id="inlineFrameExample" class="rounded border"
    title="Inline Frame Example"
    width="100%"
    height="100%">
   <%--  src='<%=request.getContextPath()%>/chat/chat.do?board=92&buyer=alive&seller=alive'> --%>
</iframe>
  </div>
</div>
<script>

</script>
</body>
</html>