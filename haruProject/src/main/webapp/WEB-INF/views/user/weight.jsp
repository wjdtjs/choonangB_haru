<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>몸무게</title>
</head>
<style>
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


/* 몸무게 수정 */
.input-pet-info {
	border: 1px solid var(--haru);
	border-radius: 12px;
	height: 36px;
	width: 100%;
	padding: 0 8px;
	font-size: 16px;
	margin: 8px;
	margin-left: 0;
}

.update-weight-btn {
	background-color: var(--haru);
	color: white;
	width: 50%;
	height: 36px;
	margin: auto 0;
}




</style>
<body>

	
<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="location.href='/user/detailPet?petno='+${pet.petno}"></i>
				몸무게
				<div style="width:45px"></div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container" style="padding-top: 3.5rem !important;">
		
			<div class="graph-title">
				<i class="fa-solid fa-weight-scale"></i>
				<span style="font-size: 14px;">몸무게</span>
				<div id="graph-line"></div>
			</div>
			
			<form action="/user/updateWeight" id="updateWeightForm" method="POST">
				<input type="hidden" name="petno" value="${pet.petno}">
				<input type="hidden" name="memno" value="${pet.memno}">
				
				<div class="input-pet-weight-div" style="display: flex;">
					<!-- <i class="fa-regular fa-square-plus" style="color: var(--haru); margin: auto 0"></i> -->
					<input type="number" step="0.01" name="petweight" class="input-pet-info input-pet-weight">
					<button class="update-weight-btn" type="submit">몸무게 수정하기</button>
				</div>
			</form>
			
			<div class="weight-table">
				<table id="weight-table">
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
					<tbody>
						<c:forEach var="weight" items="${wList}">
							<tr>
								<td><fmt:formatDate pattern="yyyy.MM.dd" value="${weight.reg_date}"/> </td>
								<td>${weight.petweight}kg</td>
							</tr>							
						</c:forEach>
					</tbody>
				</table>
						
			</div>
			
			<div class="js-pl-pagination">
				<c:if test="${pagination.startPage > pagination.blockSize }">
					<i class="haru-pagearrow fa-solid fa-chevron-left" 
						onclick="location.replace('/user/petWeight?pageNum=${pagination.startPage-pagination.blockSize}&petno=${pet.petno}')">
					</i>
				</c:if>
				
				<c:forEach var="i" begin="${pagination.startPage }" end="${pagination.endPage }">
					<div class="haru-pagenum" id="pageNum${i}" onclick="location.replace('/user/petWeight?pageNum=${i}&petno=${pet.petno}')">${i }</div>
				</c:forEach>
				
				<c:if test="${pagination.endPage < pagination.pageCnt }">
					<i class="haru-pagearrow fa-solid fa-chevron-right" 
						onclick="location.replace('/user/petWeight?pageNum=${pagination.startPage+pagination.blockSize}&petno=${pet.petno}')">
					</i>
				</c:if> 
			</div>
			
		</div>
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>

<script type="text/javascript">

// 몸무게 수정(추가)
/* $(() => {
	$('.update-weight-btn').click(function() {
		var weight = $(".input-pet-weight").val();
		let today = new Date();
		var reg_date = today.toLocaleDateString('ko-KR', 
											   {year: 'numeric',
												month: '2-digit',
												day: '2-digit',
												}) // 객체 {year, month, day}를 인수로 넣은 이유는 월, 일을 두자리로 만들기 위함 
												.replace(/\./g, '')
												.replace(/\s/g, '.');
											
		console.log(`weight: \${weight}, reg_date: \${reg_date}`);
		
		$("#weight-table > tbody:first").append('<tr><td>' + reg_date + '</td><td>' + weight + 'kg</td></tr>');
		
		
		//document.getElementById("updateWeightForm").action = "/user/updateWeight";
		//document.getElementById("updateWeightForm").submit();
	});
}) */

$(()=>{
    $('#pageNum${pagination.currentPage}.haru-pagenum').addClass('active');
 })

</script>
	
	
</body>
</html>