<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대여 리스트</title>
</head>
<body>
	<h1>대여 리스트</h1>
	<h2>빌린 내역</h2>
		<table>
		<thead>
			<tr>
				<th>글제목</th>
				<th>대여일</th>
				<th>반납일</th>
			</tr>
		</thead>
		
		<tbody>
		
		<c:forEach items="${borrowllist}" var="borrow">
			<tr>
				<td><a href="../board/boarddetail.do?num=${borrow.board_id}"> ${borrow.board_title}</a></td>
				<td>${borrow.rental_date}</td>
				<td>${borrow.exp_date}</td>
				<td><input type="button" onclick="location.href='../user/reviewwrite.do?num=${borrow.board_id}'" value="리뷰작성"></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<hr>
	<h2>내 물건 관리</h2>
	<p>렌탈 확정 코드 리스트 : ${rentalConfirmList}<p>
	<p>반납 확정 코드 리스트 : ${returnConfirmList}</p>
	
		<table>
		<thead>
			<tr>
				<th>rental_code</th>
				<th>빌리는 사람</th>
				<th>글제목</th>
				<th>대여일</th>
				<th>반납일</th>
				<th>대여 및 반납 확정</th>
				
			</tr>
		</thead>
		
		<tbody>
		<c:forEach items="${lentList}" var="lent">
			<tr>
			<td><p>${lent.rental_code}</p></td>
			<td><p>${lent.nickname}</p></td>
				<td><a href="../board/boarddetail.do?num=${lent.board_id}"> ${lent.board_title}</a></td>
				<td>${lent.rental_date}</td>
				<td>${lent.exp_date}</td>
				
				<td>
				<!-- 대여 확정 전 -->
				<form action="rentalconfirm.do" method="post">
				<input type="hidden" name="rental_code"  value="${lent.rental_code}"/>
				<c:set var="selectedrental_code" value="${lent.rental_code}"/>
				<c:if test="${not rentalConfirmList.contains(selectedrental_code)}">
				<input type="submit" value="렌탈확정"></input>
				</c:if>
				</form>
				
				<!-- 대여확정했지만 반납안함 -->
				<form action="returnconfirm.do" method="post">
				<input type="hidden" name="rental_code"  value="${lent.rental_code}"/>
				<c:set var="selectedrental_code" value="${lent.rental_code}"/>
				<c:if test="${rentalConfirmList.contains(selectedrental_code) and not returnConfirmList.contains(selectedrental_code)}">
				<input type="submit" value="반납확정"></input>
				</c:if>
				</form>
				
				<!-- 반납까지 마친상태 -->
				<c:set var="selectedrental_code" value="${lent.rental_code}"/>
				<c:if test="${rentalConfirmList.contains(selectedrental_code) and returnConfirmList.contains(selectedrental_code)}">
				<p>반납완료</p>
				</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>