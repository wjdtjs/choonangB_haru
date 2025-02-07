<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문완료</title>
</head>
<body>


<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title" style="justify-content: center !important;">
				주문 완료
			</div>
		</div>	
		
		
		<!-- body contents -->
		<div class="user-body-container" id="mypage-background">
			<div>
			<!-- 아이콘 -->
		 	<h3>픽업 준비 완료시 픽업 알림 메일을 보내드립니다.</h3>
		 	<%-- <h5>주문번호 : ${purchase.orderno }</h5> --%>
			</div>
			
			
				
		
			<div>
				<button class="user-btn-primary" onclick="location.href='/user/purchaseHistory'">주문 내역 확인</button>
			</div>
		 
		</div>
		<!-- body contents end -->
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
</div>

</body>
</html>