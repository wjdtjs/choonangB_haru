<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- Swiper.js : 슬라이드 -->
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
</head>
</head>
<style>
	.haru-user-topbar {
		justify-content: center;
	}
	.topbar-title-main{
		color: var(--haru);
		font-size: 24px;
		font-weight: 800;
	}
	.user-body-top{
		padding-top: 3.8rem;
	}
	.user-body-top .notice{
		width: 100%;
		height: 36px;
		background-color: #d0e4e8;
		overflow: hidden;
	}
	.user-body-top .notice .rolling{
		position: relative;
		width: 100%;
		height: auto;
		list-style: none;
	}
	.user-body-top .notice .rolling li{
		width: 100%;
		height: 36px;
		padding : 0 16px;
		line-height: 36px;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	.user-body-top .notice .rolling li a{
		text-decoration: none;
		color: #555;
	}
	
	.user-body-container{
		padding-top: 1rem;
	}
	 .user-body-container .swiper-container{
	 	width: 100%;
	 	height: 320px;
	 	position: relative;
	 	overflow: auto;
	 	 white-space: nowrap; /* 가로 스크롤 허용 */
	}
	.user-body-container .swiper-container .swiper-wrapper{
		width: auto;
		height: 100%;
		position: absolute;
		padding: 0;
		display: flex; /* 가로 방향으로 정렬 */
    flex-wrap: nowrap; /* 줄바꿈 방지 */
	}
	
	.user-body-container .swiper-container .swiper-wrapper .mypet {
		width: 100%;
		height: 100%;
		border-radius: 20px;
		color: white;
		background-color: var(--haru);
		padding: 20px;
		float: left;
		list-style: none;
	}
	 .user-body-container .swiper-container .swiper-wrapper .add_pet{
		width: 350px;
		height: 320px;
		line-height: 290px;
		text-align: center;
		border-radius: 20px;
		color: white;
		background-color: var(--haru);
		padding: 20px;
		float: left;
		list-style: none;
	}
	
	.mypet img{
		width: 310px;
		height: 206px;
		object-fit : cover;
		margin-bottom: 8px;
	}
	
	.mypet .petinfo {
	 width: 100%;
	 display: flex;
	 justify-content: space-between;
	 align-items: center;
	 }
	.mypet .petinfo .petinfo-left .petinfo-content{
		font-size: 14px;
	}
	
	.shortcut , .reservation, .shop{
		margin-top: 1.8rem;
		color: #6F7173;
	}
	.title{
	color: #6F7173;
		font-size: 16px;
	}
	.shortcut .shortcut_list{
		list-style: none;
		display: flex;
		justify-content: space-between;
		margin-top: 8px;
		padding: 0;
		text-align: center;
	}
	
	.shortcut .shortcut_list .shortcut_item .service-icon{
		width: 60px;
		height: 60px;
		border: 1px solid #d0e4e8;
		border-radius: 100px;
		display: flex;
		justify-content: center;
		align-items: center;
		box-shadow: 0px 0px 10px 1px #d0e4e8;
		margin-bottom: 4px;
		
	}
	.shortcut .shortcut_list .shortcut_item .service-icon img{
		object-fit: cover;
	}
	.shortcut .shortcut_list .shortcut_item .service-title{
		font-size: 14px;
	}

	.resinfo .no-res{
		text-align: center;
		padding : 20px;
		font-size: 14px;
	}
	.pet-res {
	border: 2px solid #D0E3E7;
	border-radius: 12px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.14);
	margin: 12px 0;
	padding: 10px;
	}
	.past-type {
	background-color: #D0E3E7;
	padding: 1px 4px;
	border-radius: 12px;
	width: 56px;
	text-align: center;
	}
	.pet-res-content .res-date,
	.pet-res-content .res-petname,
	.pet-res-content .res-item,
	.pet-res-content .res-number {
		margin: 4px;
		color: #6F7173;	
		display: flex;
		flex-direction: row;
		align-items: center;
	}
	.res-number {
		font-size: 12px;
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: space-between;
	}
	.res-petname {
		color: black !important;
		font-weight: 600;
		font-size: 14px;
		margin-top: 8px !important;
	}
	.res-item {
		font-size: 14px;
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: space-between;
	}
	
	.shopping-product-list{
		grid-template-columns: repeat(3, 1fr);
		row-gap: 10px;
		column-gap: 10px;
		margin: 12px 0;
	}
	.prosduct-info-div{
	width: 110px;
	}
	.shopping-product-list .product-thumbnail-div{
	width: 110px;
	height: 110px;
	}
	.product-info-desc > div {
	width: 110px;
	font-size: 0.9rem;
	color: black;
	}
</style>
<body>
	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title-main">
				HARU
			</div>
		</div>
		<!-- body contents -->
		<div class="user-body-top">
			<div class="notice">
				<div class="rolling">
					<c:forEach var="notice" items="${notices}">
						<li onclick="location.href='/user/details-notice?nno=${notice.nno}'">
							<a>${notice.ntitle}</a>
						</li>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="user-body-container">
			<!-- 슬라이더 -->
			<div class="swiper-container">
    			<div class="swiper-wrapper">
       				 <c:forEach var="pet" items="${pets}">
            			<div class="swiper-slide" onclick="location.href='/user/detailPet?petno=${pet.petno}'">
                			<li class="mypet">
                    			<img src="${pet.petimg }">
                   				<div class="petinfo">
                        			<div class="petinfo-left">
                            			<div>${pet.petname }</div>
                           				<div class="petinfo-content">
                              				<c:choose>
                                    			<c:when test="${pet.petgender_mcd eq '110' || pet.petgender_mcd eq '120' }">
                                       				<i class="fa-solid fa-venus"></i>
                                    			</c:when>
                                   				<c:when test="${pet.petgender_mcd eq '210' || pet.petgender_mcd eq '220' }">
                                        			<i class="fa-solid fa-mars"></i>
                                   				</c:when>
                                			</c:choose>
                                			${pet.species}
                           				</div>
                            			<div class="petinfo-content">${pet.petbirth}</div>                     
                        			</div>
                        			<div class="petinfo-right">
                           				<i class="fa-solid fa-chevron-right"></i>
                       				</div>
                    			</div>
                			</li>
            			</div>
        			</c:forEach>
        			<div class="swiper-slide">
            			<li class="add_pet" onclick="location.href='/user/addPetView'">
                			<i class="fa-solid fa-circle-plus" style="color: #ffffff;"></i> 동물추가하기
            			</li>
			        </div>
			    </div>
			</div>
			<!-- 슬라이더 끝 -->
		
			<div class="shortcut">
				<div class="title">바로가기</div>
				<ul class="shortcut_list">
					<li class="shortcut_item" onclick="location.href='/user/appointment'">
						<div class="service-icon"><div><img alt="" src="/img/icon-consulres.png"></div></div>
						<div class="service-title">진료예약</div>
					</li>
					<li class="shortcut_item" onclick="location.href='/user/reservation'">
						<div class="service-icon"><img alt="" src="/img/icon-consullist.png"></div>
						<div class="service-title">진료내역</div>
					</li>
					<li class="shortcut_item" onclick="location.href='/user/notice'">
						<div class="service-icon"><img alt="" src="/img/icon-notice.png"></div>
						<div class="service-title">공지사항</div>
					</li>
					<li class="shortcut_item">
						<div class="service-icon"><img alt="" src="/img/icon-resinfo.png"></div>
						<div class="service-title">예약안내</div>
					</li>
					<li class="shortcut_item">
						<div class="service-icon"><img alt="" src="/img/icon-consulinfo.png"></div>
						<div class="service-title">진료안내</div>
					</li>
				</ul>
			</div>
			<div class="reservation">
				<div class="title">다가오는 예약</div>
				<div class="resinfo">
					<c:if test="${not empty res }">
						<div class="pet-res">
							<div class="pet-res-content" style="display: flex; position: relative;">
								<div style="width: 100%">
									<div class="res-number">
										<span style="color: black; font-weight: 600;">${res.resno }</span>
											<div class="past-type">${res.status }</div>
									</div>
									<div class="res-date">
										<fmt:formatDate value="${res.rdate}" pattern="yyyy.MM.dd" />
										<span style="margin-left: 10px; color: black; font-size: 14px; font-weight: 500">${fn:substring(res.start_time, 0, 2) }:${fn:substring(res.start_time, 2, 4) }</span>
									</div>
									<div class="res-petname">
											${res.petname }
									</div>
									<div class="res-item"> 
									<span>
										<span style="font-weight: 600;">${res.item_bcd }</span>&nbsp;-&nbsp;${res.item }
									</span>
									<span>${res.aname } 선생님</span>
								</div>
							</div>
						</div>
					</div>
					</c:if>
					<c:if test="${empty res }">
						<div class="no-res">
							예약정보가 없습니다.
						</div>
					</c:if>
				</div>
			</div>
			<div class="shop">
				<div class="title">인기상품</div>
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
							<div class="product-info-desc" style="margin-top: 1rem;">
								<div class="js-pbrand"><c:if test="${pl.pquantity eq 0 }"><span style="color: red">[품절]</span></c:if> ${pl.pbrand }</div>
								<div class="js-pname">${pl.pname }</div>
								<div class="js-pprice" style="${pl.pquantity eq 0 ? 'text-decoration: line-through':''}"> <fmt:formatNumber value="${pl.pprice }" pattern="#,###" />원</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
		
	</div>

</body>
<script type="text/javascript">
	/* 공지사항 롤링 */
	$(document).ready(function(){
		var height = $(".notice").height(); // 공지사항의 높이
		var num = $(".rolling li").length; // 공지사항의 개수
		var max = height * num; // 총높이
		var move = 0; // 초기값
		function noticeRolling(){
			move += height;
			$(".rolling").animate({"top":-move},600,function(){
				if(move >= max){
					$(this).css("top",0);
					move = 0;
				}; // end if
			}); // end animate
		}; // end function
		
		noticeRollingOff = setInterval(noticeRolling,4000); // 1000 = 1초마다 함수 실행
		$(".rolling").append($(".rolling li").first().clone()); //
	});
	
	/* 슬라이드 */
	var swiper = new Swiper('.swiper-container', {
		 slidesPerView: 'auto',  // 자동 크기 조절
        spaceBetween: 10,
        loop: false,
        freeMode: true,  // 자유롭게 스크롤 가능하게 함
        scrollbar: {
            el: ".swiper-scrollbar",
            hide: false,
        },
        grabCursor: true,  // 마우스 커서 손모양
        touchRatio: 1,  // 터치 민감도
    });
	
	/**	
	 * 상세페이지 이동
	 */
	function goDetail(pno) {
		console.log(pno);
		
		location.href="/user/details-product?pno="+pno;
	}
</script>
</html>