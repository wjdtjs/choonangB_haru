<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑</title>
</head>
<body>
	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				쇼핑
<!-- 				<div style="width:30px"></div> -->
<!-- 				<i class="fa-solid fa-cart-shopping"></i> -->
				<div class="cart-shopping">
					<img src="/img/Cart.png" alt="shopping_cart" style="width: 27px" onclick="location.href='/user/shopping-cart'">
					<c:if test="${cart_count > 0 }">
						<div class="sc_count">${cart_count }</div>
					</c:if>			
				</div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container">
			<div class="user-notice-contianer">
				
				<div class="shopping-filter">
					<div class="shopping-bcd-div">
						<c:forEach var="bcd" items="${bcdList }">
							<div class="shopping-filter-bcd ${ cBcd == bcd.BCD ? 'active' : '' }" onclick="location.href='/user/shop?bcd=${bcd.BCD}'">${bcd.CONTENT }</div>
						</c:forEach>					
					</div>
					<div class="shopping-mcd-div">
						<span class="shopping-filter-mcd ${ cMcd == 999 ? 'active' : '' }" onclick="location.href='/user/shop?bcd=${cBcd}&mcd=999'">전체</span>
						<c:forEach var="mcd" items="${mcdList }">
							<span class="shopping-filter-mcd ${ cMcd == mcd.MCD ? 'active' : '' }" onclick="location.href='/user/shop?bcd=${cBcd}&mcd=${mcd.MCD}'">${mcd.CONTENT}</span>
						</c:forEach>
					</div>
				</div>
				
				
				<c:choose>
					<c:when test="${fn:length(pList) > 0 }">
						<!-- 상품이 존재할 때 -->
						<div class="shopping-product-list">
							<c:forEach var="pl" items="${pList }">
								<div class="prosduct-info-div" onclick="goDetail(${pl.pno})">
									<c:choose>
										<c:when test="${not empty pl.pimg_main }">
											<div class="product-thumbnail-div" style="background: url(${pl.pimg_main}); background-size: cover;"></div>						
										</c:when>
										<c:otherwise>
											<div class="product-thumbnail-div"></div>
										</c:otherwise>
									</c:choose>
									<div class="product-info-desc">
										<div><c:if test="${pl.pquantity eq 0 }"><span style="color: red">[품절]</span></c:if> ${pl.pbrand }</div>
										<div>${pl.pname }</div>
										<div style="${pl.pquantity eq 0 ? 'text-decoration: line-through':''}"> <fmt:formatNumber value="${pl.pprice }" pattern="#,###" />원</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:when>
					<c:otherwise>
						<div style="margin-top: 2rem; color:#6F7173; text-align: center">판매중인 상품이 없습니다.</div>
					</c:otherwise>
				</c:choose>
					
				
				
			</div>
		</div>
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
	
	<script type="text/javascript">
	
		$(()=>{

		})
		
		

		/**	
		 * 상세페이지 이동
		 */
		function goDetail(pno) {
			console.log(pno);
			
// 			location.href="/user/details-shop?pno="+pno;
		}
		
		
	</script>
</body>
</html>