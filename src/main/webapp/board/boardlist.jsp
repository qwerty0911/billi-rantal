<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<script>
		$.ajax({
			url:"boardlistAjax.do",
			data:{"pageNum":${param.pageNum}, "category":"${param.category}", "local":${param.local}, "search":"${param.search}"},
			method:"get",
			success:function(responseData){
				console.log(responseData);
				
				var datas = JSON.parse(responseData);
				var arr = datas.boardlist;
				var output="";
				$.each(arr, function(index, item){
					output+=`
						<div class="card call m-3" style="width: 18rem;" onclick="location.href='boarddetail.do?num=${"${item['board_id']}"}' ">
				  			<img src="https://billi-boards-img.s3.ap-northeast-2.amazonaws.com/board/b_${"${item['board_id']}"}_1.jpg" class="card-img-top" height="180"
				  				alt="이미지 대체 텍스트" onerror="this.onerror=null; this.src='https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png'">
				  			<div class="card-body">
				    		<h5 class="card-title">${"${item['board_title']}"}</h5
				    		<p class="card-text">${"${item['board_contents']}"}</p>
				  		</div>
				  		<ul class="list-group list-group-flush">
				    		<li class="list-group-item">${"${item['address']}"}</li>
				    		<li class="list-group-item">${"${item['price']}"}&#8361;/day</li>
				  		</ul>
				  			<div class="card-body">
				  			</div>
						</div>
					`
				});
				$("#list").prepend(output);
				
			},
			error:function(message){
				alert("오류"+message);
				console.log(message);
			}
		});
</script>
</head>
<body>
<%@ include file="/navbar/navbar.jsp"%>

    <div class="container">
    <h2>${category }</h2>
    <c:if test="${loginUser.nickname ne null }">
    	<button onclick="location.href='<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=${param.category}&local=1&search=${param.search}'" class="btn btn-primary ">동네 보기</button>
    </c:if>
    <div class="d-flex justify-content-end">
	    <button onclick="location.href='<%=request.getContextPath() %>/board/boardwrite.do'" class="btn btn-primary ">글 작성</button>
    </div>
     
      <div class="row row-cols-4" id="list">
			
      </div>
     <div class="mx-auto p-2" style="width: 200px;">
		<nav aria-label="...">
		<ul class="pagination pagination-sm">
		${pagelist}
		</ul>
		</nav>
		
	  </div>
    </div>
</body>
</html>