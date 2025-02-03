<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매내역</title>
</head>
<style>
body{
 -ms-overflow-style: none;
 }
 
::-webkit-scrollbar {
  display: none;
}

.selete-order > select{
	background-color: #D0E3E7;
    border: none;
    width: 30%;
    height: 35px;
    border-radius: 12px;
    padding: 10px;
}
.purchase-info{
	background-color: white;
	border-radius: 10px;
	margin-bottom: 10px;
	padding: 12px;
	
}

.purchase-info .purchase-info-top{
	display: flex;
	justify-content: space-between;
}

.purchase-info .purchase-info-top > .status-content{
	font-size: 12px;
	text-align: right; /* 오른쪽 정렬 */
    /* flex: 1; */ /* Flexbox 비율 지정 (공간 나눔) */
    border-radius: 20px;
   	padding: 6px 12px;
}

.purchase-product{

	margin-top: 12px;
	
}
.purchase-product-info{
	display: flex;
	margin-bottom: 8px;

}
.purchase-product-info > img{
	width: 5.5rem;
	height: 5.5rem;
	border-radius: 12px;
	background-color: #eee;
	margin-right: 5px;

}

.purchase-product-info .productInfo{
	min-height: 5.5rem;
	width: 100%;
	margin-right: 5px;
	padding: 3px;

}

.border-btn {
	width: 100%;
	height: 45px;
	position: relative;
	color: var(--haru);
	font-size: 1rem;
	background-color: white;
	border: 1px solid var(--haru);
	bottom: 0;
}

.bgcolor-btn {
	width: 100%;
	height: 45px;
	position: relative;
	color: var(--haru);
	font-size: 1rem;
	background-color: #D0E3E7;
	bottom: 0;
}

</style>
<body class="box" style="overflow-y: scroll;">
	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				구매내역
				<div style="width:30px"></div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container" >
			<div class="selete-order">
				<select name="selected">
					<option value="1">최근순</option>
					<option value="2">오래된순</option>
				</select>
			</div>
			<div  style="margin-top: 0.5rem; ">
				<!-- 구매번호별 내역 -->
				<c:forEach var="purchase" items="${purchaseList}">
					<div class="purchase-info" data-ostatus="${purchase.ostatus_mcd }">
						<div class="purchase-info-top">
							<div><fmt:formatDate value="${purchase.odate}" pattern="yyyy-MM-dd"/></div>
							<div class="status-content">${purchase.ostatus_content}</div>
						</div>
						<c:forEach var="product" items="${purchase.productList }">
							<div class="purchase-product">
								<input type="hidden" value="${product.orderno }">
								<input type="hidden" value="${product.pno }">
								<div class="purchase-product-info">
									<img alt="prodictimg" src="${product.pimg_main }">
									<div class="productInfo">
										<div >${product.pbrand }</div>
										<div>${product.pname }</div>
										<div>${product.oquantity }개 / ${product.pprice }</div>
									</div>
								</div>
								<div class="btn-review" style="display: hidden;">
									<c:choose>
										<c:when test="${product.bno == 0 }">
											<button class="border-btn" onclick="location.href='/user/writeProductReview?orderno=${product.orderno}&pno=${product.pno }'" > 리뷰작성  </button>
										</c:when>
										<c:when test="${product.bno != 0 }">
											<button class="bgcolor-btn" onclick="location.href='/user/productReview?orderno=${product.orderno}&pno=${product.pno }'"> 리뷰보기  </button>
										</c:when>
									</c:choose>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:forEach>
			</div>
		</div>
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
</body>
<script type="text/javascript">
	$(()=>{
		
		$('.purchase-info').each(function () {
			const ostatus =  $(this).data('ostatus'); // data-ostatus 값 읽기
			console.log("ostatus: "+ostatus);
			console.log($(this)); // 현재 요소 확인

	        if (ostatus == 100) { // 주문완
	            $(this).css('box-shadow', '0px 3px 12px #D0E3E7');
	            $(this).css('border','2px solid #D0E3E7');
	            $(this).find('.status-content').css('border','2px solid #D0E3E7');
	            $(this).find('.status-content').css('color','#666');
	            $(this).find('.btn-review').css('display', 'none');     
	        }    
	        else if (ostatus == 200) { // 픽업준비완
	            $(this).css('box-shadow', '0px 0px 5px #D0E3E7');
	          	$(this).css('border', '2px solid #D0E3E7');
	            $(this).find('.status-content').css('background-color','#D0E3E7');
	            $(this).find('.status-content').css('color','#666');
	            $(this).find('.btn-review').css('display', 'none');     
	        }
	        else if (ostatus == 300) { // 픽업완
	            $(this).css('border', '2px solid var(--haru)');
	            $(this).find('.status-content').css('background-color','var(--haru)');
	            $(this).find('.status-content').css('color','white');
	            $(this).find('.btn-review').css('display', 'block');    
	        }
	        else { // 주문취소
	            $(this).css('border', '1px solid #eee');
	            $(this).find('.status-content').css('background-color','#eee');
	            $(this).find('.btn-review').css('display', 'none');
	        }

		});
	});
</script>
</html>