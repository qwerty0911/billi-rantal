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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<p>${board} </p>
<link rel="stylesheet" href="../css/boardAvgRating.css" type="text/css">

</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>
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
				<td name="금액"><fmt:formatNumber value="${board.price}" pattern="#,###"/>원</td>
			</tr>
			<tr>
				<td name="카테고리">${board.category}</td>
			</tr>
			<tr>
				<td name="주소">${board.address}</td>
			</tr>
		</table>
<button id="btnchat" onclick="location.href='<%=request.getContextPath() %>/chat/chat.do?board=${board.board_id}&buyer=${loginUser.nickname }&seller=${board.board_writer }'">채팅</button>
<form action="../rental/rentalRegist.do" method="post">
<p>start Date: <input type="text" name="rental_date" readOnly class="calander" id="startDate" ></p>
<p>end Date: <input type="text" name = "exp_date" readOnly class="calander" id="expireDate"></p>
<input type="text" name="board_id" value="${board.board_id}">
<input type="text" name="board_writer" value="${board.board_writer}">
<input type="hidden" id="myInput" name="insurance_fee" value="0">
<input type="submit" value = "대여신청">
</form>
<script src="../js/slide.js"></script>

<p>보험상품 (빌리케어?)</p>
<p>보험에 가입하면 물건을 파손/분실해도 배상금을 내지 않아도 된다!</p>
<p>보험에 가입하시겠습니까? &nbsp;+ <fmt:formatNumber value="${board.price*0.1}" pattern="#,###"/>원</p> 
예 <input type="radio" id="insuranceOn" name="insurancecheck" value="y" onclick="updateInputValue(this)">
아니오 <input type="radio" id="insuranceOff" name="insurancecheck" value="n" onclick="updateInputValue(this)" checked="checked"><br> 
<span id="myInput2">총 가격 : <fmt:formatNumber value="${board.price}" pattern="#,###"/>원</span>
<p>(보험료는 물건 가격의 n%(현재는 10%로 설정)이며 체크하면 보험료가 가격에 포함됩니다.)</p>

<c:if test="${loginUser.nickname==board.board_writer}">
<button class="btnDel" data-del="${board.board_id}">게시글 삭제</button>
<button onclick="location.href='../board/boardupdate.do?board_id=${board.board_id}'">게시글 수정</button>
</c:if>

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
<script>
	//라디오 버튼을 누르면 값이 바뀜
	function updateInputValue(radioBtn) {
	    var inputValue = document.getElementById("myInput");
	    var inputValue2 = document.getElementById("myInput2");
	    var fmtpriceY = "<fmt:formatNumber value="${board.price*1.1}" pattern="#,###"/>";
	    var fmtpriceN = "<fmt:formatNumber value="${board.price}" pattern="#,###"/>";
	    var insurance_fee_y = ${board.price*0.1}
	    var insurance_fee_n = 0
	    if (radioBtn.value === "y") {
	      inputValue.value = insurance_fee_y;
	      inputValue2.innerHTML= "총 가격 : " + fmtpriceY + "원";
	    } else {
	      inputValue.value = insurance_fee_n;
	      inputValue2.innerHTML= "총 가격 : " + fmtpriceN + "원";
	    }
	  }
	
</script>
<script>
$(function () {
	$(".btnDel").on("click", function () {
		location.href = "../board/boarddelete.do?num=" + $(this).attr("data-del");
	})
});
</script>
</body>
</html>