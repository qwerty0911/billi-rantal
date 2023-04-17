<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$( function() {
    $( ".datepicker" ).datepicker();
  } );
</script>
</head>
<body>
<p>Date: <input type="text" class="datepicker" id="startDate" name ="startDate" ></p>
<p>Date: <input type="text" class="datepicker" id="expireDate" name ="expireDate" ></p>
</body>
</html>