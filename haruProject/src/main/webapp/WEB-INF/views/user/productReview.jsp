<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품리뷰</title>
</head>
<body>
	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
<%-- 				<i class="fa-solid fa-chevron-left" onclick="location.href='/user/details-product?pno=${pno}'"></i> --%>
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				리뷰
				<div class="cart-shopping">
				</div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container">
				
			<div class="js-product-review">
				<c:forEach var="rl" items="${review }">
					<div style="display: none">${rl.bno }</div>
					<div class="js-p-review-div">
						<div class="p-review-top">
							<div>${rl.mid }</div>
							<div><fmt:formatDate value="${rl.reg_date }" pattern="yyyy-MM-dd"/></div>							
						</div>
						<c:choose>
							<c:when test="${not empty rl.bimg }">
								<img class="p-review-img" src="${rl.bimg }">  <!-- //TODO: 이미지 여러개 처리 -->										
							</c:when>
							<c:otherwise>
								<div></div>
							</c:otherwise>
						</c:choose>
						<div style="margin-top: 10px; font-size: 13px">${rl.bcontents }</div>							
					</div>
				</c:forEach>

			</div>
			
			<div class="js-pl-pagination">
				<c:if test="${pagination.startPage > pagination.blockSize }">
					<i class="haru-pagearrow fa-solid fa-chevron-left" 
						onclick="location.href='/user/shop-reviews?pno=${product.pno}&pageNum=${pagination.startPage-pagination.blockSize}'">
					</i>
				</c:if>
				
				<c:forEach var="i" begin="${pagination.startPage }" end="${pagination.endPage }">
					<div style="cursor: pointer;" class="haru-pagenum" id="pageNum${i}" onclick="location.href='/user/shop-reviews?pno=${product.pno}&pageNum=${i}&bcd=${cBcd}&mcd=${cMcd}'">${i }</div>
				</c:forEach>
				
				<c:if test="${pagination.endPage < pagination.pageCnt }">
					<i class="haru-pagearrow fa-solid fa-chevron-right" 
						onclick="location.href='/user/shop-reviews?pno=${product.pno}&pageNum=${pagination.startPage+pagination.blockSize}&bcd=${cBcd}&mcd=${cMcd}'">
					</i>
				</c:if>
			</div>
			
		</div>

		
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
	
	<script type="text/javascript">
	
		$(()=>{
			$('#pageNum${pagination.currentPage}.haru-pagenum').addClass('active');
		})
		
		
	</script>
</body>
</html>