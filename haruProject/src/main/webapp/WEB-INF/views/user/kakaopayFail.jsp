<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오페이 결제 실패</title>

<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>

<style>
.prImg {
	margin: 0 auto; 
}

h4, h5 {
	margin: 0;
}

.pr-text {
	text-align: center;
    margin: 4px;
}
</style>

<body>

<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title" style="justify-content: center !important;">
				카카오페이 결제 실패
			</div>
		</div>	
		
		
		<!-- body contents -->
		<div class="user-body-container" id="mypage-background">
		
		<div style="width: 100%; height: 85%; display: flex;">
			<div style="width: 100%; margin: auto 0;">
				<div style="display: flex;">
					<i class="fa-solid fa-triangle-exclamation"></i>
				</div>
				
				<div class="pr-text">
					<h3 style="margin: 8px;">카카오페이 - 결제 취소</h3>
				 	<h4 style="margin-bottom: 4px;">${error_code}</h4>
				 	<h4 style="margin-bottom: 4px;">${error_msg}</h4>
				</div>	
			</div>	
		</div>
		
		
		
			<div>
				<button class="user-btn-primary" onclick="location.href='/user/shoppingCart'">장바구니로 돌아가기</button>
			</div>
		 
		</div>
		<!-- body contents end -->
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
</div>

</body>
</html>