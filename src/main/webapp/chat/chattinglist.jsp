<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
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
</head>
<body class="bd-example-row" style="position: fixed;top: 0;right: 0;bottom: 0;left: 0; background-color:pink">
<h1>${loginUser.nickname }님의 채팅방</h1>
<input type="hidden" id="chattingUser" value="${loginUser.nickname }">
<div class="row" style="height:80%">
  <div class="col-4 h-100 p-5" style="background-color: #eee;">
	  <div class="container border rounded h-100" style="background-color: white; overflow:auto">
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
  <div class="col-8 h-100 p-5" style="background-color: #2f9;">
    <iframe id="inlineFrameExample"
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