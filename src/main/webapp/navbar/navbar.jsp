<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Billi rental</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>">Home</a>
        </li>
        <li class="nav-item">
          <%-- <a class="nav-link" href="<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=all">대여하기</a> --%>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            대여하기
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=all&local=0">전체</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=toy&local=0">유아용/완구</a></li>
            <li><a class="dropdown-item" href="<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=digital&local=0">가전/디지털</a></li>
            <li><a class="dropdown-item" href="<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=sports&local=0">레저/스포츠</a></li>
            <li><a class="dropdown-item" href="<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=life&local=0">주방/생활용품</a></li>
            <li><a class="dropdown-item" href="<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=hobby&local=0">취미/악기/게임</a></li>
            <li><a class="dropdown-item" href="<%=request.getContextPath() %>/board/boardlist.do?pageNum=1&category=interior&local=0">가구/인테리어</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled">Disabled</a>
        </li>
      </ul>
       <form class="d-flex" method="get" action="<%=request.getContextPath()%>/board/boardlist.do">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="search">
        <input type="hidden" name="pageNum" value=1>
        <input type="hidden" name="category" value="all">
        <input type="hidden" name="local" value=0>
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
      <div class="d-flex">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <c:if test="${loginUser!=null}">
		  <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            ${loginUser.mem_name}
            </a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="<%=request.getContextPath()%>/user/myboardlist.do">내가 쓴 글</a></li>
              <li><a class="dropdown-item" href="<%=request.getContextPath()%>/user/myreview.do">내가 쓴 후기</a></li>
              <li><a class="dropdown-item" href="<%=request.getContextPath()%>/user/myrental.do">렌탈 관리</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="<%=request.getContextPath()%>/auth/membersDetail.do">회원 정보 수정</a></li>
            </ul>
          </li>
          
          <li class="nav-item">
            <a class="nav-link" href = "<%=request.getContextPath() %>/auth/logout.do">로그아웃</a>
          </li>
		</c:if>
          
        <c:if test="${loginUser==null}">
		  <li class="nav-item">
            <a class="nav-link" href = "<%=request.getContextPath() %>/auth/loginCheck.do">로그인</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href = "<%=request.getContextPath() %>/auth/signUp.do">회원가입</a>
          </li>
		</c:if>
          
          
        
      </ul>
       
       
       
       
      </div>
    </div>
  </div>
</nav>
</body>
</html>