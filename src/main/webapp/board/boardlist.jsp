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
			data:{"pageNum":${param.pageNum}, "category":"${param.category}"},
			method:"get",
			success:function(responseData){
				console.log(responseData);
				
				var datas = JSON.parse(responseData);
				var arr = datas.boardlist;
				var output="<ul>";
				$.each(arr, function(index, item){
					/* output+=`<li><a href='boarddetail.do?num=${"${item['board_id']}"}'>${"${item['board_title']}"} >> ${"${item['address']}"} >> ${"${item['price']}"}</a></li>`; */
					output+=`
						<div class="col-lg-3 col-md-4 col-sm-6">
						<div class="card" style="width: 18rem;">
				  			<img src="..." class="card-img-top" alt="...">
				  			<div class="card-body">
				    		<h5 class="card-title">${"${item['board_title']}"}</h5>
				    		<p class="card-text">내용</p>
				  		</div>
				  		<ul class="list-group list-group-flush">
				    		<li class="list-group-item">${"${item['address']}"}</li>
				    		<li class="list-group-item">${"${item['price']}"}&#8361;/day</li>
				  		</ul>
				  			<div class="card-body">
				    			<a href='boarddetail.do?num=${"${item['board_id']}"}' class="card-link btn btn-primary">자세히</a>
				  			</div>
						</div>
						</div>
					`
				});
				$("#list").html(output);
				
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

<h2>${category }</h2>
<div class="container">
  <div class="row" id="list">
    
  </div>
</div>

<ul>
${pagelist}
</ul>
<button onclick="location.href='<%=request.getContextPath() %>/board/boardwrite.do'">글 작성</button>
</body>
</html>