<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대여 리스트</title>
<script
  src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
function hideButton2() {
	  var button = document.getElementById("review_write_btn");
	  button.style.display = "none";
	}
function hideButton() {
	  var button = document.getElementById("myButton");
	  button.style.display = "none";
	}
</script>
</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>
<div class="container mt-5 mx-auto">
  <div class="row">
    <div class="col-5">
	<h2>빌린 내역</h2>
		<table class="table">
		<thead>
			<tr>
				<th>글제목</th>
				<th>대여일</th>
				<th>반납일</th>
				<th></th>
			</tr>
		</thead>
		
		<tbody>
		
		<c:forEach items="${borrowllist}" var="borrow">
			<tr>
				<td><a href="../board/boarddetail.do?num=${borrow.board_id}"> ${borrow.board_title}</a></td>
				<td>${borrow.rental_date}</td>
				<td>${borrow.exp_date}</td>

				<%-- <td><input type="button" onclick="location.href='../user/reviewwrite.do?num=${borrow.board_id}'" value="리뷰작성" class="btn btn-primary btn-sm"></td> --%>

				<td>
				    <c:if test="${borrow.review_count==0}">
				   	 <input type="button" 
				   	 		class="btn btn-primary btn-sm"
						    onclick="location.href='../user/reviewwrite.do?num=${borrow.board_id}&rental_code=${borrow.rental_code}'"
						    value="리뷰작성">						  				 
				    </c:if>
					
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
    </div>
    <div class="col-7">
      <h2>내 물건 관리</h2>		
		<table class="table">
		<thead>
			<tr>
				<th>신청자</th>
				<th>글제목</th>
				<th>대여일</th>
				<th>반납일</th>
				<th></th>
				<th></th>
				
			</tr>
		</thead>
		
		<tbody>
		 
		<c:forEach items="${lentList}" var="lent">
			<tr>
			<td><p>${lent.nickname}</p></td>
				<td><a href="../board/boarddetail.do?num=${lent.board_id}"> ${lent.board_title}</a></td>
				<td>${lent.rental_date}</td>
				<td>${lent.exp_date}</td>
							
				<td>
				<!-- 대여 확정 전 -->
				<c:set var="selectedrental_code" value="${lent.rental_code}"/>
				<c:if test="${not rentalConfirmList.contains(selectedrental_code)}">
				<form action="rentalconfirm.do" method="post">
				<input type="hidden" name="rental_code"  value="${lent.rental_code}"/>
				<input type="submit" value="렌탈확정" class="btn btn-primary btn-sm"/>
				</form>
				</td>
				<td>
				<form action="rentalreject.do" method="post">
				<input type="hidden" name="rental_code"  value="${lent.rental_code}"/>
				<input type="submit" value="거절" class="btn btn-danger btn-sm"/>
				</form>
				</c:if>
				
				<!-- 대여확정했지만 반납안함 -->
				<form action="returnconfirm.do" method="post">
				<input type="hidden" name="rental_code"  value="${lent.rental_code}"/>
				<c:set var="selectedrental_code" value="${lent.rental_code}"/>
				<c:if test="${rentalConfirmList.contains(selectedrental_code) and not returnConfirmList.contains(selectedrental_code)}">
				<input type="submit" value="반납확정" class="btn btn-success btn-sm"></input>
				</c:if>
				</form>
				
				<!-- 반납까지 마친상태 -->
				<c:set var="selectedrental_code" value="${lent.rental_code}"/>
				<c:if test="${rentalConfirmList.contains(selectedrental_code) and returnConfirmList.contains(selectedrental_code)}">
				<button type="button" class="btn btn-secondary btn-sm" disabled>반납완료</button>
				</c:if>
				</td>
				
				<td>
				<c:if test="${rentalConfirmList.contains(selectedrental_code) and returnConfirmList.contains(selectedrental_code)
				and lent.insurance_fee>0 and lent.insurance_code==0}">
						<button type="button" class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal"
					 	data-bs-whatever="@mdo" data-rentalcode ="${lent.rental_code}" >보험금 청구</button>
			 	     
				</c:if>
				<c:if test="${lent.insurance_code!=0}">
						<button type="button" class="btn btn-secondary btn-sm" data-bs-toggle="modal" 
						data-bs-target="#exampleModal2"
						data-insurance_code="${lent.insurance_code}"
					 	data-rentalcode ="${lent.rental_code}" 
					 	data-charge_date = "${lent.charge_date}"
					 	data-charge_type = "${lent.charge_type}"
					 	data-picture = "${lent.picture}"
					 	data-charge_content = "${lent.charge_content}"
					 	data-nickname = "${lent.nickname}"
					 	data-owner = "${lent.owner}"
					 	data-rental_date = "${lent.rental_date}"
					 	data-exp_date = "${lent.exp_date}"
					 	>청구내역</button>
					 	  			 	  
				</c:if>				
				</td>				 
			</tr>
		</c:forEach>
		</tbody>
	</table>
    </div>
  </div>
</div>

	
	
	<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title fs-5" id="exampleModalLabel">청구내역</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>		
							</div>
				
				<div class="modal-body">				
						<table>						
							<tr>
								<td>렌탈코드</td>
								<td id="rental_code2"></td>
							</tr>
							<tr>
								<td>보험코드</td>
								<td id="insurance_code"></td>
							</tr>
							<tr>
								<td>신청일</td>
								<td id="charge_date"></td>
							</tr>
							<tr>
								<td>청구유형</td>
								<td id="charge_type"></td>
							</tr>
							<tr>
								<td>사진</td>
								<td id="picture"></td>
							</tr>
							<tr>
								<td>신청사유</td>
								<td id="charge_content"></td>
							</tr>
							<tr>
								<td>빌린사람</td>
								<td id="nickname"></td>
							</tr>
							<tr>
								<td>빌려준사람</td>
								<td id="owner"></td>
							</tr>
							<tr>
								<td>대여기간</td>
								<td id="rental_interval"></td>
							</tr>
							 													
						</table>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
						</div>			
					</div>				
				</div>
			</div>
		</div>
	
	
	
	
	
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">신청하기</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>		
				</div>
				
				<div class="modal-body">
					<form method="post" action="../user/insurancecharge.do"  enctype="multipart/form-data">
						<table>
							<tr>
								<td>청구유형</td>
								<td>
								<select name="charge_type">
								<option value="분실" value="분실">분실</option>
								<option value="파손" value="파손">파손</option>
								</select>
								</td>
							</tr>
							<tr>
								<td>사진</td>
								<td><input type="file" name="picture"></td>
							</tr>
							
							<tr>
								<td>신청사유</td>
								<td>
								<textarea name="charge_content" placeholder="내용을 입력해주세요" required="required"></textarea>
								</td>
							</tr>
							
							<tr>
								<td><input type="hidden" name="rental_code" id="rental_code" value="${lent.rental_code}"></td>
							</tr>
							
						</table>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">보험금 청구</button>
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
						</div>
					</form>
				</div>
				
			</div>
		</div>
	</div>
	
	
	
	
	<%-- <%@ include file="empInsertModal2.jsp" %> --%>
<script>
	$(function(){
		$('#exampleModal').on('show.bs.modal', function(event) {
			var rentalcode = $(event.relatedTarget).data('rentalcode');
			 
			console.log(rentalcode);

			$("#rental_code").val(rentalcode);
		});
		
		$('#exampleModal2').on('show.bs.modal', function(event) {
			var rentalcode = $(event.relatedTarget).data('rentalcode');
			var insurance_code = $(event.relatedTarget).data('insurance_code');
			var charge_date = $(event.relatedTarget).data('charge_date');
			var charge_type = $(event.relatedTarget).data('charge_type');
			var url = $(event.relatedTarget).data('picture');
			var charge_content = $(event.relatedTarget).data('charge_content');
			var nickname = $(event.relatedTarget).data('nickname');
			var owner = $(event.relatedTarget).data('owner');
			var rental_date = $(event.relatedTarget).data('rental_date');
			var exp_date = $(event.relatedTarget).data('exp_date');
			var picture = "https://billi-boards-img.s3.ap-northeast-2.amazonaws.com/insurance/"+url;
			console.log("${picture}");
			$('#picture').html("<img src="+picture+" width='300px'>");
			$("#rental_code2").text(rentalcode);
			$("#insurance_code").text(insurance_code);
			$("#charge_date").text(charge_date);
			$("#charge_type").text(charge_type);
			$("#charge_content").text(charge_content);
			$("#nickname").text(nickname);
			$("#owner").text(owner);
			$("#rental_interval").text(rental_date + " ~ " + exp_date);
			
		});
		
	});
</script>
</body>
</html>