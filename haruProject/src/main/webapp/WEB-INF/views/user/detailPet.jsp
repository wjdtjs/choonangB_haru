<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동물 페이지</title>


<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>

<style>
/* 동물 정보 */
.pet-card {
	background-color: #D0E3E7;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.14);
    height: 150px;
	width: 350px;
    padding: 10px;
    border-bottom-left-radius: 24px;
    border-bottom-right-radius: 24px;
}

.pet-card-word {
	align-content: center;
    margin: 0 8px;
    width: 180px;
}

.pet-card-word p {
	margin: 4px;
}

/* 동물 정보 수정 버튼 */
#editPet_btn {
	width: 100%;
	height: 44px;
	background-color: var(--haru);
	color: white;
	font-size: 16px;
	margin-top: 12px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.14);
}


/* 몸무게 */
.graph-title {
	display: flex;
	align-items: center;
	margin: 12px 0;
	color: #6F7173;
}

.graph-title i {
	font-size: 14px;
	margin-right: 8px;
	color: #6F7173;
}

#graph-line {
	flex-grow: 1;
	height: 1px;
	background-color: #6F7173;
	margin-left: 8px;
}

.weight-table table {
	color: black;
	width: 100%;
	height: auto;
}

table {
    width: 100%;
    border-top: 0.5px solid #d9d9d9;
	border-collapse: collapse;
	font-size: 15px;
}

th, td {
	text-align: center;
	vertical-align: middle;
	
    border-bottom: 0.5px solid #d9d9d9;
    border-left: 0.5px solid #d9d9d9;
}

td {
	padding: 8px;
}

th:first-child, td:first-child {
    border-left: none;
}

/* 리뷰, 차트 버튼 */
.res-re {
	margin-top: 8px;
}
.res-re button {
	width: 49%;
	height: 40px;
	font-size: 14px;
}
.res-re.show {
    display: block;
}

.res-btn-b {
	background-color: var(--haru);
	color: white;
}

.res-btn-c {
	background-color: white;
	border: 1px solid var(--haru);
	color: black;
}


/* 진료 내역 */
.pet-res {
	border: 1px solid #A6D6C6;
	border-radius: 12px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.14);
	margin: 12px 0;
	padding: 12px;
}

.pet-res-content p {
	margin: 4px;
	
}

</style>

<script type="text/javascript">
	$(document).ready(function() {
	    $(".page-btn").click(function() {
	        // 클릭한 버튼과 같은 부모 `.pet-res-content` 내부의 `.res-re`를 토글
	        $(this).closest(".pet-res-content").next(".res-re").slideToggle();
	    });
	});

</script>

<body>

	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				동물 페이지
				<div style="width:30px"></div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container" style="padding-top: 3.5rem !important;">
			<div class="user-petPage-contianer">
				<!-- 동물 정보 -->
				<div class="pet-info-container">
					<div class="pet-info-slider">
					
							<div class="pet-card" id="pet-card" style="margin-top: 0; display:flex;">
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
							</div>
					
					</div>
				</div>
				
				<button id="editPet_btn" onclick="location.href='/user/editPet?petno='+${pet.petno}">동물 정보 수정</button>
				
				<!-- 몸무게 -->
				<div class="graph-title">
					<i class="fa-solid fa-weight-scale"></i>
					<span style="font-size: 14px;">몸무게</span>
					<div id="graph-line"></div>
				</div>
				<div class="weight-table">
					<table>
						<colgroup>
							<col width="50%">
							<col width="50%">
						</colgroup>
						<thead style="background-color: #d9d9d9; height: 36px;">
							<tr>
								<th>측정일</th>
								<th>몸무게</th>
							</tr>
						</thead>
						<c:forEach var="weight" items="${wList}">
							<tr>
								<td>${weight.rreg_date}</td>
								<td>${weight.petweight}kg</td>
							</tr>							
						</c:forEach>
					</table>
				</div>
				
				<!-- 진료 내역 -->
				<div class="graph-title">
					<i class="fa-solid fa-list-ul"></i>
					<span style="font-size: 14px;">진료 내역</span>
					<div id="graph-line"></div>
				</div>
				
				<c:forEach var="res" items="${aList}">
					<div class="pet-res">
						<!-- 예약 내용 -->	
						<div class="pet-res-content" style="display: flex;">
							<div>
								<p class="res-date">${res.rrdate } <span style="background-color: #A6D6C6; border-radius: 12px; padding: 1px 4px; font-size: 14px; margin-left: 4px;">진료완료</span></p>
								<p class="res-time">${res.start_time }</p>
								<p class="res-item">
										<c:choose>
											<c:when test="${res.mcode.substring(0,1) eq 'J'}"><span style="color: var(--haru); font-weight: bold;">진료</span></c:when>
											<c:when test="${res.mcode.substring(0,1) eq 'S'}"><span style="color: #DF5641; font-weight: bold;">수술</span></c:when>
											<c:when test="${res.mcode.substring(0,1) eq 'V'}"><span style="font-weight: bold;">접종</span></c:when>
											<c:when test="${res.mcode.substring(0,1) eq 'H'}"><span style="font-weight: bold;">검진</span></c:when>													
										</c:choose>
								- &nbsp;${res.item }</p>	
							</div>
							<div style="display: contents;">
								<i class="fa-solid fa-chevron-right page-btn" style="align-content: center; margin-left: auto; margin-right: 8px; transform: rotate(90deg);"></i> 
							</div>
						</div>
						
						<!-- 리뷰, 차트 버튼 -->		
						<div class="res-re" style="display: none;">
							<!-- 리뷰 -->
							<c:choose>
								<c:when test="${res.resno ne null and res.resno eq res.bresno }">
									<button class="res-btn-b" onclick="location.href=''">리뷰 보러가기</button>
								</c:when>
								<c:otherwise>
								 	<button class="res-btn-b" onclick="location.href=''">리뷰 작성하기</button>							
								</c:otherwise>
							</c:choose>
							
							<!-- 차트 -->
							<c:if test="${res.resno ne null and res.resno eq res.cresno }">
								<button class="res-btn-c" onclick="location.href=''">차트 확인하기</button>
							</c:if>
							
						</div>
					</div>
				</c:forEach>
				
				
				
					</div>
				<div>
				
				
			</div>
		</div>
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>

</body>
</html>