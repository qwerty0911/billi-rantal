<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>billi</title>
<link rel="stylesheet" type="text/css" href="css/tabletextoverflow.css">
<style>
.col{width:100%;}
p {
text-decoration: none !important;
}
.categoryimg {
width:150px;
height:150px;
}
.hitImg{
width:150px;
height:150px;
}
a {
text-decoration:none !important; 
color:black;
}
</style>
</head>



<body>

<%@ include file="/navbar/navbar.jsp"%>
<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="<%=request.getContextPath()%>/images/home1.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="<%=request.getContextPath()%>/images/home2.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="<%=request.getContextPath()%>/images/home3.jpg" class="d-block w-100" alt="...">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

<div class="container-fluid" >
  <div class="row p-3">
	<div class="col text-center" >
	  <a href="<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=toy&local=0">
	  <img src="<%=request.getContextPath()%>/images/category_img/toy2.png" class="mx-auto p-2   categoryimg">
	  <p class="text-center" style="text-decoration:none; color:black;">유아용/완구</p>
	  </a>
	</div>
	<div class="col text-center" >
	  <a href="<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=digital&local=0">
	  <img src="<%=request.getContextPath()%>/images/category_img/digital2.png" class="mx-auto p-2  categoryimg">
	  <p class="text-center" style="text-decoration:none; color:black;">가전/디지털</p>
	  </a>
	</div>
	<div class="col text-center" >
	  <a href="<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=sports&local=0">
	  <img src="<%=request.getContextPath()%>/images/category_img/sports2.png" class="mx-auto p-2  categoryimg">
	  <p class="text-center" style="text-decoration: none; color:black;">레저/스포츠</p>
	  </a>
	</div>
	<div class="col text-center" >
	  <a href="<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=life&local=0">
	  <img src="<%=request.getContextPath()%>/images/category_img/life2.png" class="mx-auto p-2  categoryimg">
	  <p class="text-center" style="text-decoration:none; color:black;">주방/생활용품</p>
	  </a>
	</div>
	<div class="col text-center" >
	  <a href="<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=hobby&local=0">
	  <img src="<%=request.getContextPath()%>/images/category_img/hobby2.png" class="mx-auto p-2  categoryimg">
	  <p class="text-center" style="text-decoration:none color:black;">취미/악기/게임</p>
	  </a>
	</div>
	<div class="col text-center" >
	  <a href="<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=interior&local=0">
	  <img src="<%=request.getContextPath()%>/images/category_img/interior2.png" class="mx-auto p-2  categoryimg">
	  <p class="text-center" style="text-decoration:none; color:black;">가구/인테리어</p>
	  </a>
	</div>
  </div>
</div>

<div class="container-fluid" >
  <div class="row p-3 ">
	<div class="col border  mx-5 p-3" >
	  <h2>인기 게시물</h2>
	  <div id="hits">
	    <table class="table">
		<thead>
			<tr>
				<th>글제목</th>
				<th></th>
			</tr>
		</thead>
		
		<tbody>
		
			<c:forEach items="${hitsList}" var="hit">
			<tr>
			<td><a href="board/boarddetail.do?num=${hit.board_id}"  class="text-nowrap">${hit.board_title}</a></td>
			<td  class="fw-lighter">${hit.board_date}</td>
			</tr>
			
	        </c:forEach>
		</tbody>
		</table>
	  </div>
	</div>
    
    
    <div class="col border mx-5 p-3" >
	  <h2>최근 게시물</h2>
	  <div id="hits">
	    <table class="table">
		<thead>
			<tr>
				<th>글제목</th>
				<th></th>
			</tr>
		</thead>
		
		<tbody>
		
			<c:forEach items="${latestList}" var="latest">
			<tr>
			<td><a href="board/boarddetail.do?num=${latest.board_id}" class="text-nowrap">${latest.board_title}</a></td>
			<td  class="fw-lighter">${latest.board_date}</td>
			
	        </c:forEach>
		</tbody>
		</table>
	  </div>
    </div>
  </div>
</div>
</body>
</html>