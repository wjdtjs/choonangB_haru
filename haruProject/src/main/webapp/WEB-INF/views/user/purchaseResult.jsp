<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문완료</title>

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

<script>
    window.onbeforeunload = function (event) {
        event.preventDefault();
        event.returnValue = ""; // 대부분의 최신 브라우저에서는 빈 문자열만 허용됨
    };
</script>



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
		
		<div style="width: 100%; height: 85%; display: flex;">
			<div style="width: 100%; margin: auto 0;">
				<div style="display: flex;">
					<img alt="purchaseResult" src="/img/purchaseResult.png" class="prImg">
				</div>
				
				<div class="pr-text">
					<h3 style="margin: 8px;">주문 완료</h3>
				 	<h4 style="margin-bottom: 4px;">픽업 준비 완료시 픽업 알림 메일을 보내드립니다.</h4>
				 	<h5>주문번호 : ${orderno}</h5>
				 	<c:if test="${tid ne null}">
				 		<p style="font-size: 12px; margin-top: 4px;">카카오페이 결제 고유번호 : ${tid}</p>
				 	</c:if>
				</div>	
			</div>	
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