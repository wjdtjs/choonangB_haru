<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ include file="header.jsp" %>     --%>

<style>
.menu-icon {
	color: #6f7173a6;
}
</style>

<!-- 메뉴바 -->
<div class="menubar">
	<a class="menu-icon" id="shopping" href="/user/shop">
		<!-- 1. 쇼핑 아이콘 -->
		<span><i class="fa-solid fa-cart-shopping"></i></span>
	</a>
	<a class="menu-icon" id="reservation" href="/user/appointment">
		<!-- 2. 예약 아이콘 -->
		<span><i class="fa-solid fa-calendar-check"></i></span>
	</a>
	<a class="menu-icon" id="home" href="/user/index">
		<!-- 3. 메인 아이콘 -->
		<span><i class="fa-solid fa-house"></i></span>
	</a>
	<a class="menu-icon" id="board" href="/user/community">
		<!-- 4. 게시판 아이콘 -->
		<span><i class="fa-solid fa-clipboard-list"></i></span>
	</a>
	<a class="menu-icon" id="mypage" href="/user/myPage">
		<!-- 5. 마이페이지 아이콘 -->
		<span><i class="fa-solid fa-user"></i></span>
	</a>
</div>

<script>
$(()=>{
	var path = window.location.pathname;
	console.log("현재 url : ",path)
	
	var active = null;
	
	switch(path) {
		case "/user/index":
			active = "home";
			break;
		case "/user/shop":
		case "/user/details-product":
		case "/user/shoppingCart":
			active = "shopping";
			break;
		case "/user/appointment":
		case "/user/appointmentStep1":
		case "/user/reservation":
			active = "reservation";
			break;
		case "/user/community":
		case "/user/details-review":
		case "/user/write-review":
		case "/user/update-review":
			active = "board";
			break;
		case "/user/myPage":
		case "/user/editMyinfo":
		case "/user/myCommunity":
		case "/user/detailPet":
		case "/user/editPet":
			active = "mypage";
			break;	
	}
	
	$(`#\${active} > span`).css('color', 'black');
	
})
</script>