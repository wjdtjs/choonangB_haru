<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제하기</title>
</head>

<style>

h3 {
	margin: 0;
	margin-bottom: 4px;
}

.sc-product-img {
	width: 80px;
	height: 80px;
	background-color: #d9d9d9;
	border-radius: 10px;
}

p {
	margin: 0;
}

.sc-info {
	display: flex;
    justify-content: center;
    flex-direction: column;
    margin: 8px 0;
}

.sc-info p {
	margin: 0 8px;
	padding: 0;
}

.page-btn {
	position: absolute;
	right: 10px;
	top: 5px;
}

.p-container {
	/* display: flex; */
	padding-bottom: 0;
	margin: 8px 0;
}

/* 결제 방법 */
.pay-type {
	margin: 8px;
	display: block;
}

.pay-type label {
	display: flex;
	margin: 4px 0;
	font-size: 14px;
}

.p-paytype {
	margin: 4px;
}

/* 약관 동의 */
#graph-line {
	flex-grow: 1;
    height: 1.5px;
    background-color: #6F7173;
    margin: 4px 8px;
}

.p-agree {
	padding: 0 12px; 
	font-size: 12px;
}

.p-agree div {
	display: flex; 
	justify-content: space-between;
	margin-right: 4px;
}


/* 총 결제 금액 */
.p-total {
	display: flex; 
	justify-content: space-between; 
	padding: 0 8px; 
	margin-bottom: 12px;
}

.p-total p {
	font-weight: bold;
}

</style>

<script type="text/javascript">

$(() => {
	// 총 결제 금액 표시
	let totalPrice = 0;
	
	
	
	updateButtonState();
	
	// 라디오 버튼 상태 변경될 때마다 실행
    $(".p-paytype").on("change", function() {
    	updateButtonState();
    });
	
	// 체크박스 상태 변경될 때마다 실행
	$("#a-check").on("change", function() {
		updateButtonState();
	});
})

// 라디오버튼, 체크박스 상태를 확인하는 함수
function updateButtonState() {
	const ptRadio = document.querySelectorAll(".p-paytype");
	const btn = document.getElementById("purchase-btn");
	const isptChecked = Array.from(ptRadio).some(radio => radio.checked);
	console.log("결제 방법 선택 여부: ", isptChecked);
	
	const aCheck = document.getElementById("a-check");
	const isaChecked = aCheck.checked;
	console.log("결제 약관 동의 여부: ", isaChecked);
		
    if (isptChecked && isaChecked) {
        btn.disabled = false;
        btn.style.backgroundColor = "var(--haru)";
    } else {
        btn.disabled = true;
        btn.style.backgroundColor = "#d9d9d9";
    }
}




// 결제하기
function purchase() {
	console.log("purchase start ,,,");
	
	// 결제 방법 가져오기 (필수 값)
    const paymentMethod = document.querySelector('input[name="opayment_mcd"]:checked');
    if (!paymentMethod) {
        alert("결제 방법을 선택해주세요.");
        return;
    }
    const opayment_mcd = paymentMethod.value;

    // 총 결제 금액 가져오기
    const ototal_price = document.querySelector('input[name="ototal_price"]').value;

    // 상품 목록 만들기
    let purchaseList = [];
    document.querySelectorAll("input[name='pno']").forEach((pnoElement, index) => {
        let purchaseData = {
            pno: pnoElement.value,
            squantity: document.querySelectorAll("input[name='squantity']")[index].value,
            pprice: document.querySelectorAll("input[name='pprice']")[index].value,
            pname: document.querySelectorAll("input[name='pname']")[index].value,
            opayment_mcd: opayment_mcd, // 공통 값
            ototal_price: ototal_price  // 공통 값
        };
        purchaseList.push(purchaseData);
    });

    console.log("전송할 데이터: ", purchaseList);

    // 주문하기
    let apiUrl;
    
    if(opayment_mcd === "300") {
    	apiUrl = `${contextPath}/api/user/k-purchase`;
    } else if(opayment_mcd === "400") {
    	apiUrl = `${contextPath}/api/user/s-purchase`;
    } else {
    	alert("유효하지 않은 결제 방법입니다.");
    	return;
    }
    	
    
    $.ajax({
    	type: 'POST',
    	url: apiUrl,
    	data: JSON.stringify(purchaseList),
    	contentType: 'application/json',
    	success: function(response) {
    		alert("결제 요청이 완료되었습니다.");
    		console.log("응답 데이터: ",response);
    		
    		if(opayment_mcd === "300") {
		    	// 카카오페이 api
		    	console.log("카카오페이 주문 완료");
    			location.href = response.next_redirect_pc_url;
    		} else if(opayment_mcd === "400") {
		    	// 매장결제 api
				console.log("매장결제 주문 완료");
    		}
    		
    	},
    	error: function(xhr, status, error) {
            console.error("결제 요청 실패:", error);
            alert("결제 요청 중 오류가 발생했습니다.");
        }
    });
    
}


</script>

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
		
		<!-- 주문 상품 정보 -->
			<div style="border: 1px solid var(--haru); border-radius: 20px; padding: 12px; margin: 8px 0;">
				<div style="display: flex; justify-content: space-between; position: relative;">
					<h3>주문 상품</h3>
					<div>
						<p>${totalSquantity} 개</p>
						<!-- <p><i class="fa-solid fa-chevron-right page-btn" style="transform: rotate(90deg);"></i> </p> -->
					</div>
				</div>
					
				<c:forEach var="purchase" items="${sList }" varStatus="status">
					<input type="hidden" name="pno" value="${purchase.pno}">
					<input type="hidden" name="squantity" value="${purchase.squantity}">
					<input type="hidden" name="pprice" value="${purchase.pprice}">
					<input type="hidden" name="pname" value="${purchase.pname}">
				
					<div class="p-container">
						<!-- 상품 이미지 -->
						<c:choose>
							<c:when test="${not empty purchase.pimg_main }">
								<div class="sc-product-img" style="background: url(${purchase.pimg_main}); background-size: cover;"></div>						
							</c:when>
							<c:otherwise>
								<div class="sc-product-img"></div>
							</c:otherwise>
						</c:choose>
						<!-- 상품 내용 -->
						<div class="sc-info" onclick="location.href='/user/details-product?pno='+${purchase.pno}">
							<p class="sc-info-brand" style="font-size: 13px;">${purchase.pbrand}</p>
							<p class="sc-info-name"  style="font-size: 16px;">${purchase.pname}</p>
						</div>
					</div>
					
					<div style="display: flex; justify-content: space-between;">
						<div style="display: flex; font-size: 13px; margin-left: 8px;">
							<p><fmt:formatNumber value="${purchase.pprice }" pattern="#,###" />원 &nbsp;/&nbsp;</p>
							<p>${purchase.squantity} 개</p>
						</div>
						<p style="font-size: 16px;"><fmt:formatNumber value="${purchase.squantity * purchase.pprice }" pattern="#,###" />원</p>
					</div>

					<!-- 구분선 -->					
					<c:if test="${!status.last}">
				        <hr style="border: 0; height: 1px; background: #d9d9d9; margin: 10px 0;">
				    </c:if>
				    
				</c:forEach>
			</div>		
		
			<!-- 결제 방법 -->
			<div style="background-color: rgba(208, 227, 231, 0.3); border-radius: 20px; padding: 12px; margin: 12px 0;">
				<div style="display: flex; justify-content: space-between; position: relative;">
					<h3>결제 방법</h3>
					<!-- <p><i class="fa-solid fa-chevron-right page-btn" style="transform: rotate(90deg);"></i> </p> -->
				</div>
				
				<div class="pay-type">
					<label>
						<input type="radio" class="p-paytype" name="opayment_mcd" value="300">
						<p style="margin-left: 4px;">카카오페이</p>
					</label>
					<label>
						<input type="radio" class="p-paytype" name="opayment_mcd" value="400">
						<p style="margin-left: 4px;">매장 결제</p>
					</label>		
				</div>
			</div>
			
			<!-- 총 결제금액 + 약관동의 체크박스 -->
			<div id="graph-line" style="margin: 20px 0;"></div>
			
			<div style="width: 100%;">
				<div class="p-total">
					<input type="hidden" name="ototal_price" value="${totalPrice}">
					<p>총 결제금액</p>
					<p style="color: var(--haru);"><fmt:formatNumber value="${totalPrice}" pattern="#,###" />&nbsp;원</p>
				</div>
				
				<div class="p-agree">
					<div>
						<p>개인정보 수집 및 약관 동의</p>
						<p style="text-decoration: underline;">약관 보기</p>					
					</div>
					<div>
						<p>개인정보 제 3자 제공 동의</p>
						<p style="text-decoration: underline;">약관 보기</p>					
					</div>
				</div>
					<label style="display: flex; margin: 16px 4px; font-size: 14px;">
						<input type="checkbox" id="a-check" style="width: 16px; height: 16px; margin-right: 8px; ">
						<p>위 주문 내역을 확인했으며, 약관 전체에 동의합니다.</p>
					</label>			
			</div>
		
				
			<!-- 버튼이랑 안 겹치게 -->
			<div style="margin: 80px 0;"></div>
			
			<div>
				<button class="user-btn-primary" onclick="purchase()" id="purchase-btn">결제하기</button>
			</div>
		 
		</div>
		<!-- body contents end -->
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
</div>

</body>
</html>