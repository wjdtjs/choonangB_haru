<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
</head>

<style>
.sc-container {
	/* background-color: rgba(208, 227, 231, 0.5); */
	border: 1px solid var(--haru);
	border-radius: 15px;
	margin: 12px 0;
}

.sc-icon, .sc-content {
	padding: 4px 8px;
}

.sc-info p {
	margin: 0 0 0 8px;
	padding: 0;
}

.sc-product-img {
	width: 80px;
	height: 80px;
	background-color: #d9d9d9;
	border-radius: 10px;
}

</style>

<script type="text/javascript">
/**
 * input number 증감 버튼 커스텀
 */
function fnCalCount(type, ths, tEqCount){
	
    let $input = $(ths).closest(".product-quantity-btn").find("input[name='pop_out']");
    let tCount = Number($input.val());//해당 상품의 남은 수량
    
    if(type=='p'){
        if(tCount < tEqCount) $input.val(Number(tCount)+1);
        
    } else{
        if(tCount > 0) $input.val(Number(tCount)-1);    
    }
}
</script>

<body>


<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i> 
				장바구니
				<div style="width:30px"></div>
			</div>
		</div>	
		
		
		<!-- body contents -->
		<div class="user-body-container" id="mypage-background">
			
			<c:forEach var="sc" items="${sList }">
			
				<div class="sc-container">
					<!-- 체크박스, 삭제 -->
					<div class="sc-icon" style="display: flex;  align-items: center;">
						<input type="checkbox" class="sc-checkbox" style="width: 20px; height: 20px;">
						<i id="sc-del" class="fa-solid fa-xmark" 
							style="font-size: 28px; color: rgba(255, 0, 0, 0.7); margin-left: auto; margin-right: 4px;"></i>
					</div>
					
					<!-- 상품 내용 -->
					<div class="sc-content" style="display: flex;">
						<!-- 상품 이미지 -->
						<c:choose>
							<c:when test="${not empty sc.pimg_main }">
								<div class="sc-product-img" style="background: url(${sc.pimg_main}); background-size: cover;"></div>						
							</c:when>
							<c:otherwise>
								<div class="sc-product-img"></div>
							</c:otherwise>
						</c:choose>
						<!-- 상품 내용 -->
						<div class="sc-info">
							<p>${sc.pbrand}</p>
							<p>${sc.pname}</p>
						</div>
					</div>
					
					<!-- 수량, 가격 -->
					<div>
						<div class="product-shop-quantity" style="background-color: #D0E3E7;">
							<div><fmt:formatNumber value="${sc.pprice }" pattern="#,###" />원</div>
							<div class="product-quantity-btn">
						        <button type="button" onclick="fnCalCount('m', this, ${sc.pquantity});">-</button>
						        <input type="text" name="pop_out" value="0" readonly="readonly"/>
								<button type ="button" onclick="fnCalCount('p',this, ${sc.pquantity});">+</button>
							</div>
						</div>				
					</div>
				</div>
			
			</c:forEach>
		
			<!-- 버튼이랑 안 겹치게 -->
			<div style="margin: 80px 0;"></div>
		
			<div>
				<button class="user-btn-primary" onclick="">주문하기</button>
			</div>
		 
		</div>
		<!-- body contents end -->
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
</div>

</body>
</html>