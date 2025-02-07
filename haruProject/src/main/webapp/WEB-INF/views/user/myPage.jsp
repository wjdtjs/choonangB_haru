<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>

<style>

.menu-card {
    background-color: white; /* 배경색 */
    border-radius: 12px; /* 모서리 둥글게 */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 */
    padding: 8px; /* 내부 여백 */
    margin: 12px auto; /* 가운데 정렬 */
}

.menu-list {
    list-style: none; /* 목록 스타일 제거 */
    margin: 0;
    padding: 0;
}

.menu-item {
    display: flex;
    justify-content: space-between; /* 양쪽으로 정렬 */
    align-items: center; /* 수직 가운데 정렬 */
    padding: 12px 16px; /* 항목 여백 */
    /* border-bottom: 1px solid #e5e7eb; /* 항목 구분선 */ */
    cursor: pointer;
}

.menu-item:last-child {
    border-bottom: none; /* 마지막 항목 구분선 제거 */
}

.menu-item a {
    text-decoration: none; /* 밑줄 제거 */
    color: black; /* 텍스트 색상 */
    font-size: 16px; /* 글자 크기 */

}


#mypage-background {
	background: linear-gradient(to bottom, var(--haru) 33%, white 30%);
	height: 100vh;
}


.page-btn {
	opacity: 0.8;
}





/* 동물 정보 슬라이드 */
.pet-info-container {
  width: 100%;
  overflow-x: auto; 
  overflow-y: visible;
  position: relative;
}

.pet-info-slider {
  display: flex;
  gap: 10px; /* 카드 간격 */
  padding-bottom: 10px;
}

.pet-card {
	background-color: white;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.25);
    height: 150px;
	width: 350px;
    padding: 10px;
    border-radius: 24px;
}

.pet-card-word {
	align-content: center;
    margin: 0 8px;
    width: 180px;
}

.pet-card-word p {
	margin: 4px;
}



.add-pet {
	background-color: white;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.25);
    height: 150px;
	width: 350px;
    border-radius: 24px;
	padding: 0;
	align-content: center;
}

.add-pet p {
	text-align: center;
	width: 350px;
}

</style>



<body>

<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar" style="
										    border: none;
										    color: white;
										    background-color: var(--haru);">
			<div class="topbar-title">
				<!-- 뒤로가기 버튼 없어도 될 것 같은데,,,, -->
				<i class="fa-solid fa-chevron-left" onclick="history.back()" style="color: white;"></i> 
				마이페이지
				<div style="width:30px"></div>
			</div>
		</div>	
		
		
		<!-- body contents -->
		<div class="user-body-container" id="mypage-background">
			
			<!-- 동물 정보, 동물 추가하기 -->
			<div class="pet-info-container">
				<div class="pet-info-slider" style="display: flex;">
					<c:forEach var="pet" items="${pList}">
						<div class="pet-card" id="pet-card" style="margin-top: 0; display:flex;" onclick="location.href='/user/detailPet?petno='+${pet.petno}"> <!-- 동물 번호 포함한 동물페이지 링크 추가 -->
							<div class="pet-card-img" style="align-content: center;">
								<c:choose>
									<c:when test="${not empty pet.petimg }">
										<div class="petimg-div" style="background: url(${pet.petimg}); background-size: cover;"></div>						
									</c:when>
									<c:otherwise>
										<div class="petimg-div"></div>
									</c:otherwise>
								</c:choose>
							</div>
							
							<div class="pet-card-word">
								<div style="display: flex;">
									<p style="font-size:20px;">${pet.petname }</p>
									<c:choose>
										<c:when test="${pet.petgender_mcd eq '110' || pet.petgender_mcd eq '120' }">
											<i class="fa-solid fa-venus" style="align-content: center"></i> <!-- 여 -->
										</c:when>
										<c:when test="${pet.petgender_mcd eq '210' || pet.petgender_mcd eq '220' }">
											<i class="fa-solid fa-mars" style="align-content: center"></i> <!-- 남 -->
										</c:when>
									</c:choose>								
								</div>
								<p style="font-size:12px; white-space: normal; margin-top: 0;">${pet.species }</p>
								<p style="font-size:12px;">${pet.petbirth }</p>							
							</div>
							<i class="fa-solid fa-chevron-right page-btn" style="align-content: center; margin-left: auto; margin-right: 8px;"></i> 
						</div>
					</c:forEach>
				
					<div class="add-pet" onclick="location.href='/user/addPetView'">
						<p><i class="fa-solid fa-circle-plus" style="margin-right: 8px;"></i>동물 추가하기</p>
					</div>					
					
				</div>
			</div>		
			
			<!-- 내 정보 수정 -->
			<div class="menu-card">
				<ul class="menu-list">
			        <li class="menu-item" onclick="location.href='/user/editMyinfo'">
			            내 정보 수정	            
			            <i class="fa-solid fa-chevron-right page-btn"></i> 
			        </li>
			    </ul>
			</div>
			
			
			<!-- 예약 내역, 구매 내역 -->
			<div class="menu-card">
				<ul class="menu-list">
			        <li class="menu-item" onclick="location.href='/user/reservation'">
						예약 내역
			            <i class="fa-solid fa-chevron-right page-btn"></i> 
			        </li>
			        <li class="menu-item" onclick="location.href='/user/purchaseHistory'">
						구매 내역
			            <i class="fa-solid fa-chevron-right page-btn"></i> 
			        </li>
			    </ul>
			</div>
			
			
			<!-- 내 글 관리, 공지사항, 문의 전화 -->
			<div class="menu-card">
			    <ul class="menu-list">
			        <li class="menu-item" onclick="location.href='/user/myCommunity'">
			            내 글 관리
			            <i class="fa-solid fa-chevron-right page-btn"></i> 
			        </li>
			        <li class="menu-item" onclick="location.href='/user/notice'">
			           	공지사항
			            <i class="fa-solid fa-chevron-right page-btn"></i> 
			        </li>
			        <li class="menu-item"  onclick="">
			           	문의 전화
			            <i class="fa-solid fa-chevron-right page-btn"></i> 
			        </li>
			    </ul>
			</div>

			
			
			<button class="user-btn-primary" onclick="location.href='/user/rogout'">로그아웃</button>
			
		</div>
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>

</body>
</html>