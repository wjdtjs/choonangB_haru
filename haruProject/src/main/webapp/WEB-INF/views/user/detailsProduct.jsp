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
				<div class="cart-shopping">
					<img src="/img/Cart.png" alt="shopping_cart" style="width: 27px" onclick="location.href='/user/shoppingCart'">
					<c:if test="${cart_count > 0 }">
						<div class="sc_count">${cart_count }</div>
					</c:if>			
				</div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container">
			<div style="margin-top: 0.5rem;">
				<c:choose>
					<c:when test="${not empty product.pimg_main }">
						<div class="product-detail-thumb" style="background: url(${product.pimg_main}); background-size: cover;"></div>						
					</c:when>
					<c:otherwise>
						<div class="product-detail-thumb"></div>
					</c:otherwise>
				</c:choose>
				
				<div class="product-detail-info">
					<div class="js-pbrand"><c:if test="${product.pquantity eq 0 }"><span style="color: red">[품절]</span></c:if> ${product.pbrand }</div>
					<div class="js-pname">${product.pname }</div>
				</div>
				
				<!-- 품절이면 수량변경 안보이게 -->
				<c:if test="${product.pquantity ne 0 }">
					<form class="product-shop-quantity" id="productForm" method="post" onsubmit="return validateForm()">
						<input type="hidden" value="${product.pno }" name="pno">
						<div><fmt:formatNumber value="${product.pprice }" pattern="#,###" />원</div>
						<div class="product-quantity-btn">
					        <button type="button" onclick="fnCalCount('m', this);">-</button>
					        <input type="text" name="pquantity" value="0" readonly="readonly"/>
							<button type ="button" onclick="fnCalCount('p',this);">+</button>
						</div>
					</form>				
				</c:if>
				
				
				<!-- 상품상세/후기 노출 div -->
				<div class="product-info-choice">
					
					<!-- 상세설명/후기 선택 라디오버튼 div -->
					<div class="js-pi-radio">
						<div class="pi-radio-btn radio-info">
							<input id="radio-1" type="radio" name="product-info" value="details" checked>
							<label for="radio-1">상세정보</label>
						</div>
						<div class="pi-radio-btn">
							<input id="radio-2" type="radio" name="product-info" value="reviews">
							<label for="radio-2">상품후기(${pagination.totalCnt })</label>
						</div>
					</div>
					<!-- 라디오버튼 div 끝 -->
					
					<!-- 상품상세 -->
					<div class="js-product-details">
						${product.pdetails }
					</div>
					
					<!-- 상품후기 -->
					<div class="js-product-review" style="display: none">
						<c:forEach var="rl" items="${reivew }">
							<div style="display: none">${rl.bno }</div>
							<div class="js-p-review-div">
								<div class="p-review-top">
									<div>${rl.memail }</div>
									<div><fmt:formatDate value="${rl.reg_date }" pattern="yyyy-MM-dd"/></div>							
								</div>
								<c:choose>
									<c:when test="${not empty rl.bimg }">
										<img class="p-review-img" src="${rl.bimg }">	<!-- //TODO: 이미지 여러개 처리 -->								
									</c:when>
									<c:otherwise>
										<div></div>
									</c:otherwise>
								</c:choose>
								<div style="margin-top: 10px; font-size: 13px">${rl.bcontents }</div>							
							</div>
						</c:forEach>
						
						<c:if test="${pagination.pageCnt > 1 }">
							<div class="go-whole-review" onclick="location.href='/user/shop-reviews?pno=${product.pno}'">리뷰 전체 보기 ${pagination.totalCnt }</div>
						</c:if>
					</div>
					<!-- 상품후기 끝 -->
					
					
				</div>
				<!-- 상세/후기 끝 -->
				
			</div>
			
			
		</div>
	
		<!-- 품절이면 구매버튼 안보이게 -->
		<c:if test="${product.pquantity ne 0 }">
			<div class="js-shop-btn-div">
				<button class="btn-sub" type="submit" form="productForm" onclick="javascript: form.action='/user/updateCart'">장바구니</button>
				<button class="btn-primary" onclick="directPurchase()">주문하기</button>
			</div>			
		</c:if>
		
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
	
	<script type="text/javascript">
		window.onpageshow = function (event){     //뒤로가기로 페이지 접근했는지 확인
		    if(!event.persisted && !(window.performance && window.performance.navigation.type == 2) && !(window.performance.getEntriesByType("navigation")[0].type == "back_forward")){
	
		    	if(${result==0}){
					alert('이미 장바구니에 추가된 상품입니다.\n장바구니에서 수량을 변경 해주세요.');
				} else if(${result==1}){
					alert('해당 상품이 장바구니에 추가되었습니다.');
				}
		        
		    }
		}
		
		function validateForm() {
			let result = true;
			
			let quantity = $('input[name=pquantity]').val();
			if(quantity == null || quantity == 0) {
				alert('수량을 선택해 주세요.');
				result = false;
			}
			
			return result;
		}
		
		
		
		
		function directPurchase() {
			console.log("direct order start ,,,");
			
			let pno = Number($("input[name='pno']").val());
			let squantity = Number($("input[name='pquantity']").val());
			
			console.log("pno ->",pno, ", squantity ->", squantity);
			
			location.href = `/user/direct_purchase?pno=\${pno}&&squantity=\${squantity}`;
		}
		
	
		$(()=>{

			/* 스크롤 내리면 버튼div 숨기기 */
			let lastScroll = 0;
			$('.user-body-container').on('scroll', function(){
			    let scrollTop = $(this).scrollTop();
			    if(scrollTop > lastScroll) {
			        //down
			        $('.js-shop-btn-div').addClass('fixed');
			    } else {
			        // up
			        $('.js-shop-btn-div').removeClass('fixed');
			    }
			    lastScroll = scrollTop;
			});
			
			/* 상품상세/후기 라디오버튼 선택 */
			$('input[name="product-info"]').on('change', function() {
		        // 선택된 라디오 버튼의 값 가져오기
		        const selectedValue = $(this).val();
		        
		        // 모든 섹션 숨기기
		        $('.js-product-details, .js-product-review').hide();
		        
		        // 선택된 값에 따라 해당 섹션 표시
		        if (selectedValue === 'details') {
		            $('.js-product-details').show();
		        } else if (selectedValue === 'reviews') {
		            $('.js-product-review').show();
		        }
		    });
			
			
		})
		
		/**
		 * input number 증감 버튼 커스텀
		 */
		function fnCalCount(type, ths){
			
		    let $input = $('.product-quantity-btn').find("input[name='pquantity']");
		    let tCount = Number($input.val());
		    let tEqCount = ${product.pquantity}; //해당 상품의 남은 수량
		    
		    if(type=='p'){
		        if(tCount < tEqCount) $input.val(Number(tCount)+1);
		        
		    } else{
		        if(tCount > 0) $input.val(Number(tCount)-1);    
		    }
		}
		
		
	</script>
</body>
</html>