<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 작성</title>
</head>
<style>
body{
 -ms-overflow-style: none;
 }
 
::-webkit-scrollbar {
  display: none;
}

 label.img_upload {
	background-color: #f0f0f0;
	cursor: pointer;
	text-align: center;
	width: 7rem;
	height: 7rem;
	line-height: 7rem;
	font-size: 1.5rem;
	border-radius: 0.625rem;
}
.pro-mainimg-div {
	width: fit-content;
	height: fit-content;
	position: relative;
}

.purchase-product-info{
	display: flex;
	margin-bottom: 12px;

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

button {
	position: relative;
	color: #666;
	font-size: 1rem;
	background-color: white;
}

.content {
 margin-bottom: 10px;
}
.content textarea {
	border: 1px solid var(--haru);
	border-radius: 10px;
	width: 100%;
	min-height: 50%;
	resize: none;
	padding: 12px;
}

</style>
<body class="box" style="overflow-y: scroll;">
	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				후기 작성
				<div style="max-width: 45px;">
					<button type="submit" form="add_prvw">완료</button>
				</div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container">
			<div style="margin-top: 0.5rem; ">
				<div class="purchase-product-info">
					<img alt="prodictimg" src="${product.pimg_main }">
					<div class="productInfo">
						<div style="font-size: 12px;">${product.pbrand }</div>
						<div style="font-size: 14px;">${product.pname }</div>
						<div style="font-size: 12px;">${product.oquantity }개 / <fmt:formatNumber value="${product.pprice}" pattern="#,###" />원</div>
					</div>
				</div>
				<hr>
				<div class="review-form">
					<form action="/user/addProductReview" method="post" id="add_prvw" enctype="multipart/form-data">
						<input type="hidden" name="orderno" value="${product.orderno }">
						<input type="hidden" name="pno" value="${product.pno }">
						<div class="content">
							<div class="title">이미지</div>
						    <div style="margin-top: 1rem">
								<div class="pro-label-div">
									<label for="main_img" class="img_upload">+</label>
									<input type="file" id="main_img" name="main_img" accept=".jpg, .jpeg, .png, .gif" style="display: none"> 							
								</div>
								<div class="pro-mainimg-div" style="display: none"></div>
						     </div>
						</div>
						<div class="content">
						    <div class="title">후기</div>
						    <div style="margin-top: 1rem;">
								<textarea placeholder="후기를 작성하세요" name="bcontents" style="font-family: 'Noto Sans KR', serif;"></textarea>	
						    </div>
						</div>
					</form>
				</div>
				<div>
				
				</div>
			</div>
		</div>
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
</body>
<script src="/js/shop_modal.js?v=0.01"></script>

</html>