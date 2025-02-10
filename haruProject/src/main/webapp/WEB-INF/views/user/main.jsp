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
	 .user-body-container .slider{
	 	width: 350px;
	 	height: 320px;
	 	position: relative;
	 	overflow: hidden;
	}
	.user-body-container .slider .petlist{
		width: auto;
		height: 100%;
		position: absolute;
		padding: 0;
		
	}
	 .user-body-container .slider .petlist .mypet ,.add_pet{
		width: 100%;
		height: 100%;
		border-radius: 20px;
		color: white;
		background-color: var(--haru);
		padding: 20px;
		float: left;
	}
	
	
	
	.mypet  img{
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
	
	.shortcut{
		margin-top: 1rem;
		color: #6F7173;
	}
	.shortcut .title{
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
						<li>
							<a href="">${notice.ntitle}</a>
						</li>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="user-body-container">
			<div class="slider">
				<ul class="petlist">				
					<c:forEach var="pet" items="${pets}">
						<li class="mypet">
							 <img src="${pet.petimg }" >
							 <div class="petinfo">
							 	<div class="petinfo-left">
									 <div>${pet.petname }</div>
									 <div class="petinfo-content">
										 <c:choose>
											 <c:when test="${pet.petgender_mcd eq '110' || pet.petgender_mcd eq '120' }">
													<i class="fa-solid fa-venus" style="align-content: center"></i> <!-- 여 -->
											</c:when>
											<c:when test="${pet.petgender_mcd eq '210' || pet.petgender_mcd eq '220' }">
													<i class="fa-solid fa-mars" style="align-content: center"></i> <!-- 남 -->
											</c:when>
										 </c:choose>
										 ${pet.species }
									 </div>
									 <div class="petinfo-content">${pet.petbirth }</div>					 
							 	</div>
							 	<div class="petinfo-right" onclick="location.href='/user/detailPet?petno=${pet.petno}'">
							 		<i class="fa-solid fa-chevron-right"></i>
							 	</div>
							 </div>
						</li>
					</c:forEach>
					<li class="add_pet">
						<i class="fa-light fa-circle-plus" style="color: #ffffff;"></i>동물추가하기
					</li>
				</ul>
			</div>
		
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
					<li class="shortcut_item" onclick="location.href='/user/community'">
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
			
			</div>
			<div class="shop">
			
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
	
	
</script>
</html>