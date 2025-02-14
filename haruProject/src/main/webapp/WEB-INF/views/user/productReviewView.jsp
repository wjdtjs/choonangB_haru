<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기</title>
</head>
<style>
body{
 -ms-overflow-style: none;
 }
 
::-webkit-scrollbar {
  display: none;
}

.pro-mainimg-div {
	width: fit-content;
	height: fit-content;
	position: relative;
}
.pro-mainimg-div img{
	width: 7rem;
	height: 7rem;
	border-radius: 15px;
}

.purchase-product-info{
	display: flex;
	margin-bottom: 12px;
	background: #f2f2f2;
	border-radius: 5px;
	padding: 6px;
	align-items: center;
}
.purchase-product-info > img{
	width: 5rem;
	height: 5rem;
	border-radius: 5px;
	background-color: #eee;
	margin-right: 1rem;

}

.purchase-product-info .productInfo{
	min-height: 5.5rem;
	width: 100%;
	margin-right: 5px;
	padding: 3px;

}

button {
	position: relative;
	color: #666;
	font-size: 1rem;
	background-color: white;
}

.content {
 	margin-bottom: 10px;
 	margin-top: 2rem;
}
.content .review-content {
/* 	background-color: #f0f0f0; */
/* 	border-radius: 10px; */
	width: 100%;
	height: auto;
/* 	padding: 12px; */
}
.btns button {
	width:49%;
	margin-top: 8px;
	padding: 10px;
}


/* 수정/삭제 메뉴 모달 */
.menu-modal-bg {
	width: 100%;
    height: 100vh;
    background: rgba(0,0,0,.2);
    position: absolute;
    top: 0;
    z-index: 999;
}
.menu-modal-div {
	position: absolute;
    bottom: 0;
    background: white;
    width: 100%;
    height: 160px;
    border-top-left-radius: 20px;
    border-top-right-radius: 20px;
    display: flex;
    flex-direction: column;
    padding: 10px;
}
.menu-modal-btn-div {
	border-bottom: 1px solid #d9d9d9;
    padding: 20px;
    text-align: center;
}
.menu-modal-btn-div > button {
	height: 45px;
    width: 140px;
    background: white;
    border: 1px solid rgba(0, 0, 0, .5);
}
.menu-modal-close {
	padding: 10px;
    text-align: center;
    color: black;
}
/* 수정/삭제 메뉴 모달 끝 */

</style>
<body class="box" style="overflow-y: scroll;">
	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				후기
				<div style="width:45px">
					<i class="fa-solid fa-ellipsis-vertical" style="text-align: center" onclick="openMenu()"></i>
				</div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container">
			<div>
				<div class="purchase-product-info" onclick="location.href='/user/details-product?pno=${product.pno}'">
					<img alt="prodictimg" src="${product.pimg_main }">
					<div class="productInfo">
						<div style="font-size: 12px;">${product.pbrand }</div>
						<div style="font-size: 14px; font-weight: 500;">${product.pname } </div>
						<div style="font-size: 12px;">${product.oquantity }개 / <fmt:formatNumber value="${product.pprice }" pattern="#,###" />원</div>
					</div>
				</div>
				<hr>
				<div class="review-form">
					<form action="/user/updateProductReviewView" id="add_prvw" enctype="multipart/form-data">
						<input type="hidden" name="orderno" value="${product.orderno }">
						<input type="hidden" name="pno" value="${product.pno }">
						<div class="content">
<!-- 							<div class="title">이미지</div> -->
						    <div style="margin-top: 1rem">
						    	<c:if test="${board.bimg != null}">
									<div class="pro-mainimg-div" >
										<img src="${board.bimg }">
									</div>
						    	</c:if>
						     </div>
						</div>
						<div class="content">
<!-- 						    <div class="title">후기</div> -->
						    <div style="margin-top: 1rem;">
								<div class="review-content">${board.bcontents }</div>	
						    </div>
						</div>
						
<!-- 						<div class="btns"> -->
<!-- 							<button type="submit">수정하기</button> -->
<!-- 							<button type="button" class="delete-review-btn">삭제하기</button> -->
<!-- 						</div> -->
					</form>
				</div>
				<div>
				
				</div>
			</div>
		</div>
		
		
		<div class="menu-modal-bg" style="display: none">
			<div class="menu-modal-div">
				<div class="menu-modal-btn-div">
					<button style="margin-right: 10px" type="submit" form="add_prvw">수정</button>
					<button type="button" class="delete-review-btn">삭제</button>
				</div>
				<div class="menu-modal-close" onclick="modal_close()">닫기</div>
			</div>
		</div>
		
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
</body>
 <script type="text/javascript">
 	$(document).on('click','.delete-review-btn', function () {
 		const orderno = $('input[name="orderno"]').val();
 		const pno = $('input[name="pno"]').val();
 		console.log('orderno: '+orderno+'pno: '+pno);
		if (confirm('리뷰를 삭제하겠습니까?')) {
			location.href = `/user/deleteProductReview?orderno=\${orderno}&pno=\${pno}`;
		}
	})
	
	
	/* 수정/닫기 모달 */
	function openMenu() {
		$('.menu-modal-bg').css('display', 'block'); 
	}
	function modal_close() {
		$('.menu-modal-bg').css('display', 'none'); 
	}
	
 </script>
</html>