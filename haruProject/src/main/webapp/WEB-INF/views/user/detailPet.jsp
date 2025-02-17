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
	margin-top: 4px;
}

table {
    width: 100%;
    border-top: 0.5px solid #ececec;
	border-collapse: collapse;
	font-size: 15px;
}

th, td {
	text-align: center;
	vertical-align: middle;
	
    border-bottom: 0.5px solid #ececec;
    border-left: 0.5px solid #ececec;
}

td {
	padding: 8px;
}

th:first-child, td:first-child {
    border-left: none;
}

.weight-more{
	align-items: center;
    margin: 8px;
    margin-right: 0;
}

.weight-more-btn {
	background-color: white;
    color: #6F7173;
    font-weight: bold;
    padding: 0;
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
	border: 2px solid;
	border-radius: 12px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.14);
	margin: 12px 0;
	padding: 10px;
}

.pet-res-content p {
	margin: 4px;
	
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

.past-type {
	background-color: #A6D6C6; 
	border-radius: 12px; 
	padding: 1px 4px; 
	font-size: 12px; 
	margin-left: 4px;
	color: black;
	width: 56px;
	text-align: center;
}

.page-btn {
	position: absolute;
	right: 10px;
	top: 50px;
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
}
</style>

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
				<div class="graph-title" style="margin-bottom: 0;">
					<i class="fa-solid fa-weight-scale"></i>
					<span style="font-size: 14px;">몸무게</span>
					<div id="graph-line"></div>
						<div class="weight-more" style="display: flex;" onclick="location.href='/user/petWeight?petno=${pet.petno}'">
							<button class="weight-more-btn">더보기<i class="fa-solid fa-chevron-right" style="color: #6F7173; margin-left: 4px;"></i></button>
						</div>
					</div>
				<canvas id="pet-weight-chart"></canvas>
				<%-- <div class="weight-table">
					<table>
						<colgroup>
							<col width="50%">
							<col width="50%">
						</colgroup>
						<thead style="background-color: #ececec; height: 36px;">
							<tr>
								<th>측정일</th>
								<th>몸무게</th>
							</tr>
						</thead>
						<c:forEach var="weight" items="${wList}" begin="0" end="2" step="1">
							<tr>
								<td>${weight.rreg_date}</td>
								<td>${weight.petweight}kg</td>
							</tr>							
						</c:forEach>
					</table>
					
				</div> --%>
				
				<!-- 진료 내역 -->
				<div class="graph-title">
					<i class="fa-solid fa-list-ul"></i>
					<span style="font-size: 14px;">진료 내역</span>
					<div id="graph-line"></div>
				</div>
				
				<c:forEach var="res" items="${aList}">
					<div class="pet-res" style="
												<c:choose>
													<c:when test="${res.mtitle_bcd eq 110 }">border-color: rgba(12, 128, 141, 0.46)</c:when>
													<c:when test="${res.mtitle_bcd eq 120 }">border-color: rgba(241, 141, 126, 0.71)</c:when>
													<c:when test="${res.mtitle_bcd eq 130 }">border-color: #D0E3E7</c:when>
													<c:when test="${res.mtitle_bcd eq 140 }">border-color: #A6D6C6</c:when>
												</c:choose>
												">
						<!-- 예약 내용 -->	
						<div class="pet-res-content" style="display: flex; position: relative;">
							<div style="width: 100%">
								<div class="res-number">
									<span style="color: black; font-weight: 600;">${res.resno }</span>
									<div class="past-type" style="
										<c:choose>
											<c:when test="${res.mtitle_bcd eq 110 }">background: #0c808d99; color: white</c:when>
											<c:when test="${res.mtitle_bcd eq 120 }">background: #F18D7E; color: white</c:when>
											<c:when test="${res.mtitle_bcd eq 130 }">background: #D0E3E7</c:when>
											<c:when test="${res.mtitle_bcd eq 140 }">background: #A6D6C6</c:when>
										</c:choose>
										"
										>${res.mitem }</div>
								</div>
								<div class="res-date"> 
									${res.rrdate }
									<span style="margin-left: 10px; color: black; font-size: 14px; font-weight: 500">${res.start_time }</span>
								</div>
								<div class="res-item">${res.mitem }&nbsp;-&nbsp;${res.item }</div>
							</div>
							<i class="fa-solid fa-chevron-right page-btn" style="transform: rotate(90deg);"></i> 
				
						</div>
						
						<!-- 리뷰, 차트 버튼 -->		
						<div class="res-re" style="display: none;">
							<!-- 리뷰 -->
							<c:choose>
								<c:when test="${res.resno ne null and res.resno eq res.bresno }">
									<button class="res-btn-b" onclick="location.href='/user/details-review?bno='+${res.bno}">리뷰 보러가기</button>
								</c:when>
								<c:otherwise>
								 	<button class="res-btn-b" onclick="location.href='/user/write-review?resno='+${res.resno}">리뷰 작성하기</button>							
								</c:otherwise>
							</c:choose>
							
							<!-- 차트 -->
							<c:choose>
								<c:when test="${res.resno ne null and res.resno eq res.cresno }">
									<button class="res-btn-c" data-cno="${res.cno}" onclick="location.href='/user/detailConsultation?cno=${res.cno}'">차트 확인하기</button>
								</c:when>
								<c:otherwise>
									<button class="res-btn-c" >차트 준비중</button>
								</c:otherwise>
							</c:choose>
							
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


<script type="text/javascript">
	
	// JSP에서 가져온 데이터를 JavaScript 배열로 변환
    var arr = '${labels}';  // X축 (날짜)
    var labels = arr.replace(/\[|\]/g, '').split(', ').map(item => item.trim());
    var dataValues = ${weight};  // Y축 (값)
    const ctx = document.getElementById('pet-weight-chart').getContext('2d');

	
	/* 몸무게 차트 */
	function buildChart(ctx) {
		new Chart(ctx, {
            type: 'line',  // 라인 차트
            data: {
                labels: labels,  // X축 (날짜)
                datasets: [{
                    label: '몸무게',
                    data: dataValues,  // Y축 데이터
                    borderColor: 'rgba(75, 192, 192, 1)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderWidth: 2,
                    fill: true,
                    tension: 0.1 // 곡선 효과
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    }
                },
                scales: {
                    x: {  // X축 설정
                        title: {
                            display: true,
                            text: '날짜'
                        }
                    },
                    y: {  // Y축 설정
                        title: {
                            display: true,
                            text: '값'
                        },
                        beginAtZero: true
                    }
                }
            }
        });
	}
	
	$(document).ready(() => {
		
		// 차트 생성
        const canvas = document.getElementById('pet-weight-chart');
	    if (canvas) {
	        const ctx = canvas.getContext('2d');
	        buildChart(ctx);
	    }
	    
		/* 예약 내역 버튼 토글 */
	    $(".pet-res-content").click(function() {
	        // 클릭한 버튼과 같은 부모 `.pet-res-content` 내부의 `.res-re`를 토글
	        $(this).closest(".pet-res-content").next(".res-re").slideToggle();
	       
	        var tr = $(this).children('.page-btn').css('transform');
            var values = tr.split('(')[1].split(')')[0].split(',');
            var a = values[0];
            var b = values[1];
            var c = values[2];
            var d = values[3];

            var scale = Math.sqrt(a*a + b*b);
            var sin = b/scale;
            var angle = Math.round(Math.atan2(b, a) * (180/Math.PI));
            
            var cur = angle + 180;
            
            $(this).children('.page-btn').css('transform', `rotate(\${cur}deg)`);
	    });
	});
	

</script>

</html>