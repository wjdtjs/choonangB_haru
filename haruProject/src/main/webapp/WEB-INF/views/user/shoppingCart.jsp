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
	border: 2px solid var(--haru);
	border-radius: 15px;
	margin: 12px 0;
}

.sc-scontainer {
	background-color: #ececec;
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

.sc-info {
	display: flex;
    justify-content: center;
    flex-direction: column;
}

.sc-info p {
	margin: 0 0 0 8px;
	padding: 0;
}

.sc-product-img {
	width: 60px;
	height: 60px;
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

.product-shop-quantity .product-quantity-btn > button {
	width: 25px;
	height: 25px;
}


.order-div {
	position: fixed;
    bottom: 69px;
    width: 350px;
    height: 62px;
    background-color: white;
}


</style>

<script type="text/javascript">

/**
 * input number 증감 버튼 커스텀
 */
function fnCalCount(type, ths, tEqCount, pprice){
	console.log("type: ", type, ", tEqCount: ", tEqCount, ", pprice: ", pprice);
    let $input = $(ths).closest(".product-quantity-btn").find("input[name='pop_out']");
    let tCount = Number($input.val());//해당 상품의 남은 수량
    console.log("tCount: ", tCount);
    let $pno = $(ths).closest(".product-quantity-btn").find("input[name='cart-pno']");
    let pno = Number($pno.val());
    
    
    // 품목 수량 변경
    if(type=='p'){
        if(tCount < tEqCount) {
        	tCount ++;
        	console.log("tCount(+):", tCount);
        }
    } else{
        if(tCount > 0) {
        	tCount --;
        	console.log("tCount(-):", tCount);
        }
    }
    
    $input.val(tCount);
    
    // 품목 수량 변경에 따른 총 가격 변경
    let totalPrice = tCount * pprice;
    console.log("pprice: ", pprice);
    console.log("totalPrice: ", totalPrice);
    let $priceElement = $(ths).closest(".product-shop-quantity").find("#p-total-price");
    $priceElement.text(totalPrice.toLocaleString() + "원");
    
    // 변경된 수량 DB update    
    updateSquantity(pno, tCount);
    
    // 총 결제 금액 update
    updateTotalPrice();
    
}

/* DB에 수량 update
	pno 상품번호
	updateSquantity 업데이트할 상품 수량 
*/
function updateSquantity(pno, updateSquantity) {
	$.ajax({
		type: "POST",
		url: `${contextPath}/api/updateSquantity`,
		data: {
			pno: pno,
			squantity: updateSquantity
		},
		success: function(response) {
			console.log("수량 업데이트 성공: ", response);
		},
		error: function(error) {
	        console.error("수량 업데이트 실패:", error);
	        alert("수량 변경 중 오류가 발생했습니다.");
	    }
	});
	
}


$(() => {	
    // 주문하기 버튼, 총 결제금액 > 초기 상태 설정
    updateButtonState();
    updateTotalPrice();
    
    // 체크박스 상태가 변경될 때마다 실행
    $(".sc-checkbox").on("change", function() {
    	updateButtonState();
   	    updateTotalPrice();
    });
    
    // 체크박스 상태가 checked이면 실행
   	$(".sc-checkbox:checked").each(function() {
   		updateButtonState();
   	    updateTotalPrice();
   	});
  
});


// 체크박스 상태를 확인하는 함수
function updateButtonState() {
	const checkboxes = document.querySelectorAll(".sc-checkbox");
	const btn = document.getElementById("order-btn");
	const isChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);
	console.log("isChecked: ", isChecked);
	
    if (isChecked) {
        btn.disabled = false;
        btn.style.backgroundColor = "var(--haru)";
        document.getElementById("order-total").style.display="block";
    } else {
        btn.disabled = true;
        btn.style.backgroundColor = "#d9d9d9";
        document.getElementById("order-total").style.display="none";
    }
}

// 전체선택
function selectAll(ths) {
	const checkboxes = document.querySelectorAll('input[type="checkbox"]');
	console.log("checkboxes : ", checkboxes);
	checkboxes.forEach((checkbox) => {
		checkbox.checked = ths.checked;
		console.log("체크");
	})
	
}

// 체크박스 선택시 선택된 품목 총 금액 표시
function updateTotalPrice() {
	let totalPrice = 0;
	
	$(".sc-checkbox:checked").each(function() {
		let $scContainer = $(this).closest(".sc-container");
		let quantity = Number($scContainer.find("input[name='pop_out']").val());
		let price = Number($scContainer.find("input[name='pprice']").val());
		console.log("quantity: ",quantity, ", price: ",price);
		
		totalPrice += quantity * price;
	});
	
	console.log("totalPrice: ",totalPrice);
	$("#total-money p:last-child").text(totalPrice.toLocaleString() + " 원");
}


// x 버튼 누르면 장바구니에서 제거
function delsc(ths) {
	if(confirm('장바구니에서 삭제하시겠습니까?')) {
		console.log("장바구니에서 제거 시작");
	    let $pno = $(ths).closest(".sc-icon").find("input[name='del-pno']");
	    let pno = Number($pno.val());
	    console.log("삭제할 pno: ", pno);
	    
	    location.href=`/user/deleteSP?pno=\${pno}`;
	}
}

// 장바구니 -> 주문하기
function orderProduct() {
	console.log("order start ,,,");
	
	let pnoList = [];
    
    $(".sc-checkbox:checked").each(function() {
		let $pno = $(this).closest(".sc-icon").find("input[name='del-pno']");
	    let pno = Number($pno.val());
	    console.log("pno: ", pno);
	    pnoList.push(pno);
	});
    
    console.log("선택된 상품 목록 (pnoList): ", pnoList);   	
    
	location=`/user/purchaseView?pnoList=\${pnoList.join(",")}`;
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
		<div class="sc-body-container" >		
		
		<c:choose>
			<c:when test="${fn:length(sList) > 0 }">
				<div class="total-check" id="total-check" style="display: flex; /* justify-content: flex-end; */">
					<label style="display: flex;">
						<input type="checkbox" class="sc-checkbox" style="width: 16px; height: 16px;" onclick="selectAll(this)">
						<p style="margin: 0 4px; font-size: 14px;">전체 상품 선택하기</p>
					</label>
				</div>
			<c:forEach var="sc" items="${sList }">
			
				<div class=
					<c:choose>
						<c:when test="${sc.pstatus_mcd eq 100}">
							"sc-container"
						</c:when>
						<c:when test="${sc.pstatus_mcd eq 200}">
							"sc-scontainer"
						</c:when>
					</c:choose>				
				>
					<!-- 체크박스, 삭제 -->
					<div class="sc-icon">
						<input type="hidden" name="del-pno" value="${sc.pno}">
						<input type="hidden" name="pprice" value="${sc.pprice}">
						<!-- 체크박스 -->
						<input type="checkbox" class="sc-checkbox" style="width: 20px; height: 20px;"
								<c:if test='${sc.pstatus_mcd eq 200}'>disabled</c:if> >
						<!-- 삭제 -->
						<i id="sc-del" class="fa-solid fa-xmark" 
							style="font-size: 20px; margin-left: auto; margin-right: 4px;"
							onclick="delsc(this)"></i>
					</div>
					
					<!-- 상품 내용 -->
					<div class="sc-content" style="display: flex; padding-bottom: 0;">
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
						<div class="sc-info" onclick="location.href='/user/details-product?pno='+${sc.pno}">
							<p class="sc-info-brand" style="font-size: 12px;">${sc.pbrand}</p>
							<p class="sc-info-name"  style="font-size: 14px;">${sc.pname}</p>
							<p style="font-size: 13px;"><fmt:formatNumber value="${sc.pprice }" pattern="#,###" />원</p>
						</div>
					</div>
					
					<!-- 수량, 가격 -->
					<div>
						<div class="product-shop-quantity" 
							 style="background-color: rgba(0, 0, 0, 0); margin: 4px 0;">
							<!-- 수량에 따른 가격 pprice * (pop_out value) -->
							<div class="product-total-price">
								<p id="p-total-price" style="margin: auto 0; font-size: 14px;">
									<c:if test='${sc.pstatus_mcd eq 100}'>
										<fmt:formatNumber value="${sc.squantity * sc.pprice}" pattern="#,###" />원
									</c:if>
									<c:if test='${sc.pstatus_mcd eq 200}'>
										품절
									</c:if>
								</p>
							</div>
							<div class="product-quantity-btn">
						        <button type="button" onclick="fnCalCount('m', this, ${sc.pquantity}, ${sc.pprice});"
						        		style="<c:if test='${sc.pstatus_mcd eq 200}'>background: #d9d9d9;</c:if>"
						        		<c:if test='${sc.pstatus_mcd eq 200}'>disabled</c:if>
								>-</button>
						        <input type="hidden" name="cart-pno" value="${sc.pno}">
						        <input type="text" name="pop_out" value="${sc.squantity}" readonly="readonly"/>
								<button type="button" onclick="fnCalCount('p', this, ${sc.pquantity}, ${sc.pprice});"
						        		style="<c:if test='${sc.pstatus_mcd eq 200}'>background: #d9d9d9;</c:if>"
						        		<c:if test='${sc.pstatus_mcd eq 200}'>disabled</c:if>
								>+</button>
							</div>
						</div>				
					</div>
				</div>
			
			</c:forEach>
			</c:when>
			<c:otherwise>
				<div style="margin-top: 2rem; color:#6F7173; text-align: center">장바구니에 등록된 품목이 없습니다.</div>
			</c:otherwise>
		</c:choose>
		
			<!-- 버튼이랑 안 겹치게 -->
			<div style="margin: 150px 0;"></div>
			
			<div class="order-div">
				<div id="order-total">
					<div id="graph-line"></div>
					<div id="total-money" style="display: flex; justify-content: space-between;padding: 0 16px;">
						<p>총 결제금액</p>
						<p style="color: var(--haru);"></p>
					</div>		
				</div>
				
				
				<button class="user-btn-primary" id="order-btn" type="button" style="background-color: #d9d9d9;" onclick="orderProduct(this)">주문하기</button>
			</div>
		</div>
		</div>
		<!-- body contents end -->
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
</div>

</body>
</html>