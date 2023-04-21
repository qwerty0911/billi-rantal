<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<title>boarddetail</title>
<%@ include file="../util/rentalCalenderHeader.jsp" %>
<link rel="stylesheet" href="../css/slide.css">
<%-- <%@ include file="../util/rentalCalenderBody.jsp" %> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<p>${board} </p>
<style>
.rate{background: url(https://aldo814.github.io/jobcloud/html/images/user/star_bg02.png) no-repeat;width: 121px;height: 20px;position: relative;}
.rate span{position: absolute;background: url(https://aldo814.github.io/jobcloud/html/images/user/star02.png);width: auto;height: 20px;}
</style>
</head>
<body>
<c:if test="${images!=null}">
	<div class="slideshow-container">
		<c:forEach items="${images}" var="image" varStatus="status">
		<div class="mySlides fade2">
			<img class="main_slideImg" src="https://billi-boards-img.s3.ap-northeast-2.amazonaws.com/board/${image}">
			<div class="text">Caption Text</div>
		</div>
		<c:set var="dotCount" value="${status.count}"/>
		</c:forEach>

		<a class="prev" onclick="plusSlides(-1)">❮</a>
		<a class="next"onclick="plusSlides(1)">❯</a>
	</div>
	<br>
	<div style="text-align: center">
		<c:forEach var="i" begin="1" end="${dotCount}">
			<span class="dot" onclick="currentSlide(${i})"></span>
		</c:forEach>
	</div>
</c:if>
<table>
			<tr>
				<td name="제목">${board.board_title}</td>
			</tr>
			<tr>
				<td name="작성자">${board.board_writer}</td>
			</tr>
			<tr>
				<td name="작성일">${board.board_date}</td>
			</tr>
			<tr>
				<td name="내용">${board.board_contents}</td>
			</tr>
			<tr>
				<td name="금액">${board.price}</td>
			</tr>
			<tr>
				<td name="카테고리">${board.category}</td>
			</tr>
			<tr>
				<td name="주소">${board.address}</td>
			</tr>
		</table>
<button id="btnchat" onclick="location.href='<%=request.getContextPath() %>/chat/chat.do'" >채팅</button>
<%@ include file="../util/rentalCalenderBody.jsp" %>
<script src="../js/slide.js"></script>
<hr>
<h2>후기 (${reviewcount})</h2>
<h2>평균평점 : ${ratingavg}</h2><br> 
	<div class="rate">
        <span style="width: ${(ratingavg/5)*100}%"></span>
    </div>
	<hr>
	
		<c:forEach items="${boardreviewlist}" var="review">
			<p>작성자 : ${review.review_writer}</p>
			<p>작성일 : ${review.review_date}</p>
			<p>평점 : ${review.rating}</p>
			<p>내용 : ${review.review_content}</p>
			<hr>
		</c:forEach>


<hr>
<h2>후기 (${reviewcount})</h2>
<h2>평균평점 : ${ratingavg}</h2><br> 
	<div class="rate">
        <span style="width: ${(ratingavg/5)*100}%"></span>
    </div>
	<hr>
	
		<c:forEach items="${boardreviewlist}" var="review">
			<p>작성자 : ${review.review_writer}</p>
			<p>작성일 : ${review.review_date}</p>
			<p>평점 : ${review.rating}</p>
			<p>내용 : ${review.review_content}</p>
			<hr>
		</c:forEach>

</body>
</html>