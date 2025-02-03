<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차트</title>
</head>
<style>
body{
 -ms-overflow-style: none;
 }
 
::-webkit-scrollbar {
  display: none;
}

.user-body-container{
	box-shadow: 0 300px 0px 0px #E7F1F3 inset;
}

.consultation-detail-info{
background-color: white;
	box-shadow:0px 0px  10px #ddd;
	border-radius: 10px;
	min-height: 90%;
	margin-bottom: 10px;
	padding: 12px;
	
}

.petInfo_row{
	display: flex; 
    justify-content: space-between;
}
.petInfo_row > .info-title{
 	text-align: left; /* 왼쪽 정렬 (기본값이지만 명시적으로 추가) */
    flex: 1; /* Flexbox 비율 지정 (공간 나눔) */
}
.petInfo_row > .info-content{
	text-align: right; /* 오른쪽 정렬 */
    flex: 1; /* Flexbox 비율 지정 (공간 나눔) */
}

.content-box{
	padding: 5px 7px;
	border: 1px solid var(--haru);
	border-radius : 10px;
	width: 100%;
	min-height: 50px;
	margin-top: 5px;
	margin-bottom: 10px;
}
.chartImg {
	overflow: hidden;
	display: inline;
}

.chartImg > img {
 	width: 18rem;
 	height: 18rem;
 	object-fit: scale-down;
}

button {
	color: white;
	font-weight: 500;
	font-size: 1rem;
	width: 100%;
	height: 45px;
	background: var(--haru);
	bottom: 0;
	position: relative;
}

</style>
<body class="box" style="overflow-y: scroll;">
	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar" style="background-color: #E7F1F3;">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				차트 상세 보기
				<div style="width:30px"></div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container" >
			<div style="margin-top: 0.5rem; ">
				
				<div class="consultation-detail-info">
					<div><fmt:formatDate value="${apm.rdate}" pattern="yyyy-MM-dd E"/>요일</div>
					<hr>
					<div class="petInfo">
						<div class="petInfo_row">
							<div class="info-title">이름</div>
							<div class="info-content">${apm.petname }</div>
						</div>
						<div class="petInfo_row">
							<div class="info-title">생년월일</div>
							<div class="info-content"><fmt:formatDate value="${apm.petbirth}" pattern="yyyy-MM-dd"/></div>
						</div>
					</div>
					<div class="chartImg">
						<c:forEach var="image" items="${imageLists }">
							<img alt="chartImg" src="${image.content }" class="${image.imgno }">
						</c:forEach>
					</div>
					<div class="chartInfo">
						<div class="info-title">진료내용</div>
						<div class="content-box">${chart.ccontents }</div>					
					</div>
					<div class="chartInfo">
						<div class="info-title">기타/전달사항</div>
						<div class="content-box">${chart.cect_con }</div>
					</div>
				</div>
				
				<button onclick="history.back()">확인</button>
				<!-- menu bar -->
				<jsp:include page="components/menubar.jsp"></jsp:include>
			</div>
		</div>
	</div>
</body>
</html>