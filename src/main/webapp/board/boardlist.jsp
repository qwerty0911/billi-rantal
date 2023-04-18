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
			method:"get",
			success:function(responseData){
				console.log(responseData);
				
				var datas = JSON.parse(responseData);
				var arr = datas.boardlist;
				var output="<ul>";
				$.each(arr, function(index, item){
					var b = item['board_title'];
					output+=`<li><a href='boarddetail.do?num=${"${item['board_id']}"}'>${"${item['board_title']}"} >> ${"${item['address']}"} >> ${"${item['price']}"}</a></li>`;
							
				});
				$("#list").html(output+"</ul>");
				
			},
			error:function(message){
				alert("오류"+message);
				console.log(message);
			}
		});
</script>
</head>
<body>
<h1>board</h1>
<h2>카테고리</h2>
<div id="list">

</div>
</body>
</html>