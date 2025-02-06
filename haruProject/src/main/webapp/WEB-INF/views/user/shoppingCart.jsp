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
	border: 1px solid var(--haru);
	border-radius: 15px;
	margin: 12px 0;
}

.sc-icon, .sc-content {
	padding: 8px;
}

.sc-icon {
	display: flex;  
	align-items: center; 
	padding-bottom: 0;
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

.sc-info-name {
	width: 240px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

#order-total {
    position: fixed;
    bottom: 130px;
    width: 90%;
    padding: 10px 0;
    background-color: white;
}

#graph-line {
	flex-grow: 1;
    height: 1.5px;
    background-color: black;
    margin: 4px 8px;
}

#total-money p {
	margin: 8px 0;
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
    
    // 변경된 수량 DB에 업데이트
    updateSquantity(pno, $input.val());
}

/* DB에 수량 update
	pno 상품번호
	updateSquantity 업데이트할 상품 수량 
*/
function updateSquantity(pno, updateSquantity) {
	$.ajax({
		type: "POST",
		url: "/api/updateSquantity",
		data: {
			pno: pno,
			squantity: updateWquantity
		},
		success: function(response) {
			console.log("수량 업데이트 성공: ", response);
			// 화면에 표시
		},
		error: function(error) {
	        console.error("수량 업데이트 실패:", error);
	        alert("수량 변경 중 오류가 발생했습니다.");
	    }
	});
	
}


// 체크박스 하나라도 눌린 게 있으면 주문하기 버튼 활성화
$(() => {
    const checkboxes = document.querySelectorAll(".sc-checkbox");
    const btn = document.getElementById("order-btn");

    // 체크박스 상태를 확인하는 함수
    // 하나라도 체크되어 있으면 > 주문하기 버튼 활성화, 총 결제금액 display=block
    const updateButtonState = () => {
        const isChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);
        
        if (isChecked) {
            btn.disabled = false;
            btn.style.backgroundColor = "var(--haru)";
            document.getElementById("order-total").style.display="block";
        } else {
            btn.disabled = true;
            btn.style.backgroundColor = "#d9d9d9";
            document.getElementById("order-total").style.display="none";
        }
    };

    // 체크박스 상태가 변경될 때마다 실행
    checkboxes.forEach(checkbox => {
        checkbox.addEventListener("change", updateButtonState);
    });

    // 초기 상태 설정
    updateButtonState();
});



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
					<div class="sc-icon">
						<input type="checkbox" class="sc-checkbox" style="width: 20px; height: 20px;">
						<i id="sc-del" class="fa-solid fa-xmark" 
							style="font-size: 20px; margin-left: auto; margin-right: 4px;"></i>
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
							<p class="sc-info-brand" style="font-size: 13px;">${sc.pbrand}</p>
							<p class="sc-info-name"  style="font-size: 16px;">${sc.pname}adffadf adfasdf</p>
							<p><fmt:formatNumber value="${sc.pprice }" pattern="#,###" />원</p>
						</div>
					</div>
					
					<!-- 수량, 가격 -->
					<div>
						<div class="product-shop-quantity" style="background-color: white; margin: 0;">
							<!-- 수량에 따른 가격 pprice * (pop_out value) -->
							<div class="product-total-price">
								<p>가격</p>
							</div>
							<div class="product-quantity-btn">
						        <button type="button" onclick="fnCalCount('m', this, ${sc.pquantity},'${sc.pno}');">-</button>
						        <input type="text" name="pop_out" value="${sc.squantity}" readonly="readonly"/>
								<button type ="button" onclick="fnCalCount('p',this, ${sc.pquantity},'${sc.pno}');">+</button>
							</div>
						</div>				
					</div>
				</div>
			
			</c:forEach>
		
			<!-- 버튼이랑 안 겹치게 -->
			<div style="margin: 150px 0;"></div>
			<div>
				<div id="order-total">
					<div id="graph-line"></div>
					<div id="total-money" style="display: flex; justify-content: space-between;padding: 0 16px;">
						<p>총 결제금액</p>
						<p style="color: var(--haru);">total원</p>
					</div>		
				</div>
				
				<button class="user-btn-primary" id="order-btn" type="button" style="background-color: #d9d9d9;" onclick="">주문하기</button>
			</div>
		 
		</div>
		<!-- body contents end -->
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
</div>

</body>
</html>