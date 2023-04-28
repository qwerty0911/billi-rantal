<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>

<%
LocalDate today = LocalDate.now();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
String current_date = today.format(formatter);
%>
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
<%-- <p>${board} </p> --%>
<link rel="stylesheet" href="../css/boardAvgRating.css" type="text/css">

</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>

<div class="container bd-example-border-utils mt-5">
  <div class="row p-3 border">
  <!-- 그림 -->
    <div class="col border mx-2 p-3" >
		<c:if test="${images!=null}">
		<div class="slideshow-container">
			<c:forEach items="${images}" var="image" varStatus="status">
		<div class="mySlides fade2">
			<img class="main_slideImg" src="https://billi-boards-img.s3.ap-northeast-2.amazonaws.com/board/${image}">
			<div class="text">Caption Text</div>
		</div>
		<c:set var="dotCount" value="${status.count}"/>
		</c:forEach>
		
		<!-- <a class="prev" onclick="plusSlides(-1)">❮</a>
		<a class="next"onclick="plusSlides(1)">❯</a> -->
		</div>
		<br>
		<div style="text-align: center">
		<c:forEach var="i" begin="1" end="${dotCount}">
		<span class="dot" onclick="currentSlide(${i})"></span>
		</c:forEach>
		</div>
		</c:if>
    </div>
    
    <div class="col border mx-2 p-3">
      <table>
			<tr>
				<td ><!-- name="제목"> -->
				<p class="fw-bold">${board.board_title}</p>
				</td>
			</tr>
			<tr>
				<td ><!-- name="작성자"> -->
				<p class="fw-normal">${board.board_writer}</p>
				</td>
			</tr>
			<tr>
				<td ><!-- name="작성일"> -->
				<p class="fw-light">${board.board_date}</p></td>
			</tr>
			<tr>
				<td> <!-- name="내용"> -->
				<p class="fst-normal"><pre>${board.board_contents}</pre></p></td>
			</tr>
			<tr>
				<td ><!-- name="금액"> -->
				<p class="fw-normal"><fmt:formatNumber  value="${board.price}" pattern="#,###"/>원</p></td>
			</tr>
			<tr>
				<td> <!-- name="카테고리"> -->${board.category}</td>
			</tr>
			<tr>
				<td ><!-- name="주소"> -->${board.address}</td>
			</tr>
		</table>
		<form action="../rental/rentalRegist.do" method="post">
			
			<input type="hidden" name="board_id" value="${board.board_id}">
			<input type="hidden" name="board_writer" value="${board.board_writer}">
			<input type="hidden" id="myInput" name="insurance_fee" value="0">
			<!-- <input type="submit" value = "대여신청"> -->
			<!-- 모달 컴포넌트 -->
			<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">대여 예약하기</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">

					<p>start Date: <input type="text" name="rental_date" readOnly class="calander" id="startDate" ></p>
					<p>end &nbsp;Date: <input type="text" name = "exp_date" readOnly class="calander" id="expireDate"></p>
					<p>빌리케어</p>
					<p>빌리케어에 가입하면 고장 및 파손은 수리비의 최대 70%까지, 도난 및 분실은 피해액의 최대 50%까지 보상이 가능합니다.</p>
					<p>빌리케어에 가입하시겠습니까? &nbsp;+ <fmt:formatNumber value="${board.price*0.1}" pattern="#,###"/>원</p> 

					예 <input type="radio" id="insuranceOn" name="insurancecheck" value="y" onclick="updateInputValue(this)">
					아니오 <input type="radio" id="insuranceOff" name="insurancecheck" value="n" onclick="updateInputValue(this)" checked="checked"><br> 
					<p>(보험료는 물건 가격의 10%이며 체크하면 보험료가 가격에 포함됩니다.)</p>
					<span id="myInput2">총 가격 : <fmt:formatNumber value="${board.price}" pattern="#,###"/>원</span>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			        <input type="submit" class="btn btn-primary" value="예약하기">
			      </div>
			    </div>
			  </div>
			</div>
			
		</form>
		<button id="btnchat" class="btn btn-primary" onclick="location.href='<%=request.getContextPath() %>/chat/chat.do?board=${board.board_id}&buyer=${loginUser.nickname }&seller=${board.board_writer }'">채팅</button>
		<!-- Button trigger modal -->
		<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
		  예약하기
		</button>

<c:if test="${loginUser.nickname==board.board_writer}">
	<button onclick="location.href='../board/boardupdate.do?board_id=${board.board_id}'">게시글 수정</button>
	<button class="btnDel" data-del="${board.board_id}">게시글 삭제</button>
</c:if>


<hr>

<h2>리뷰 (${reviewcount})</h2>
<h2>평균평점 : ${ratingavg}</h2><br> 
	<div class="rate">
        <span style="width: ${(ratingavg/5)*100}%"></span>

    </div>
  </div>
 </div>
</div>
<div class="container bd-example-border-utils m-5 mx-auto">
</div>

  <div class="container m-5">
	<h2>리뷰 (${reviewcount})</h2>

	<p>평균평점</p>
	<div class="rate">
	    <span style="width: ${(ratingavg/5)*100}%"></span>
	</div>
	<hr>
	<c:forEach items="${boardreviewlist}" var="review">
		<div>
			<p class="fw-bold">${review.review_writer}</p>
			<p class="fw-light">${review.review_date}</p>
			<div class="rate">
			    <span style="width: ${(review.rating/5)*100}%"></span>
			</div>
			<p>${review.review_content}</p>
		</div>
		<hr>
	</c:forEach>
  </div>

<script src="../js/slide.js"></script>
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

var startDateInput = document.getElementById("startDate");
var endDateInput = document.getElementById("expireDate");

startDateInput.addEventListener("change", function() {
  var selectedDate = new Date(startDateInput.value);
  selectedDate.setDate(selectedDate.getDate() + 1);
  var minDate = selectedDate.toISOString().split("T")[0];
  endDateInput.min = minDate;
});
</script>
</body>
</html>