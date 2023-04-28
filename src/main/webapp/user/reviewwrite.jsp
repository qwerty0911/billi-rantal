<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰작성</title>
<link rel="stylesheet" href="../css/reviewWriteRating.css" type="text/css">
</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>
<div class="container mx-auto mt-5 p-3 border rounded">
	<h2>리뷰작성</h2>
	<form action="../user/reviewwrite.do" method="post">
		<p>${loginUser.nickname}</p>
		
	
		<fieldset class="rate"><span>별점 :&nbsp;</span>
    	<input type="radio" id="rating10" name="rating" value="5"><label for="rating10" title="5점"></label>
    	<input type="radio" id="rating9" name="rating" value="4.5"><label class="half" for="rating9" title="4.5점"></label>
    	<input type="radio" id="rating8" name="rating" value="4"><label for="rating8" title="4점"></label>
    	<input type="radio" id="rating7" name="rating" value="3.5"><label class="half" for="rating7" title="3.5점"></label>
    	<input type="radio" id="rating6" name="rating" value="3"><label for="rating6" title="3점"></label>
    	<input type="radio" id="rating5" name="rating" value="2.5"><label class="half" for="rating5" title="2.5점"></label>
		<input type="radio" id="rating4" name="rating" value="2"><label for="rating4" title="2점"></label>
    	<input type="radio" id="rating3" name="rating" value="1.5"><label class="half" for="rating3" title="1.5점"></label>
    	<input type="radio" id="rating2" name="rating" value="1"><label for="rating2" title="1점"></label>
    	<input type="radio" id="rating1" name="rating" value="0.5"><label class="half" for="rating1" title="0.5점"></label>
		</fieldset>
		<br>
		<div class="mb-3">
		  <label for="review_content" class="form-label">내용</label>
		  <textarea class="form-control" name="review_content" id="review_content" placeholder="내용을 입력해주세요" rows="5" required></textarea>
		</div>
		<!-- <textarea name="review_content" id="review_content" placeholder="내용을 입력해주세요" required="required"></textarea> -->
		<input type="hidden" name="review_writer" id="review_writer" value="${loginUser.nickname}">
		<input type="hidden" name="board_id" id="board_id" value="${param.num}">
		<input type="hidden" name="rentalconfirm_code" id="rentalconfirm_code" value="${param.rental_code}">
		<input class="btn btn-primary" type="submit" id="reviewwritebtn" value="후기 작성" onclick="location.href='../board/boarddetail.do?num=${param.num}'">
		
	</form>
</div>
</body>
</html>