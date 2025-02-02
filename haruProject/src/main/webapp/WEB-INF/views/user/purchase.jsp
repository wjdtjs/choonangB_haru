<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제하기</title>
</head>
<body>


<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i> 
				결제
				<div style="width:30px"></div>
			</div>
		</div>	
		
		
		<!-- body contents -->
		<div class="user-body-container" id="mypage-background">
		
				
		
			<div>
				<button class="user-btn-primary" onclick="">결제하기</button>
			</div>
		 
		</div>
		<!-- body contents end -->
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
</div>

</body>
</html>