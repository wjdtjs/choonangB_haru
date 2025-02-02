<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약내역</title>

<style type="text/css">
/* daterangepicker 커스텀 */
#reportrange {
	font-size: 12px;
	width: 190px;
	cursor: pointer;
	padding: 5px 10px;
	border: 1px solid #d9d9d9;
	background: white;
	border-radius: 5px;
}
li, select, td, span {
	font-family: "Noto Sans KR", serif;
}
.daterangepicker .drp-buttons .btn {
	font-weight: 500;
}
.daterangepicker .ranges li.active {
	background: var(--haru);
}
.daterangepicker select.yearselect,
.daterangepicker select.monthselect {
	padding: 4px;
	border-radius: 5px;
	border-color: #d9d9d9;
}
/* daterangepicker 커스텀 끝*/


.js-reservation-filter {
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: space-between;
}
.js-pet-selector {
	width: 130px;
	height: 30px;
	font-size: 12px;
	cursor: pointer;
	padding: 5px 10px;
	border: 1px solid #d9d9d9;
	border-radius: 5px;
}
.js-pet-selector:focus {
	outline: none;
}

.pre-reservation {
	margin-top: 10px;
}
.js-reservation-div-top {
	color: #6F7173;
	font-size: 14px;
	display: flex;
	align-items: center;
	margin-bottom: 19px;
}
.js-reservation-div-top::after {
     content: "";
     flex-grow: 1;
     background: #B7B8B9;
     height: 1px;
     font-size: 0px;
     line-height: 0px;
     margin-left: 7px;
}


</style>

</head>
<body>
	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				예약내역
				<div style="width:45px">
					
				</div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container">
			
			<!-- 필터 -->
			<div class="js-reservation-filter">
				<div id="reportrange">
				    <i class="fa fa-calendar"></i>&nbsp;
				    <span></span> <i class="fa fa-caret-down"></i>
				</div>
				
				<select class="js-pet-selector">
					<option value="0">전체</option>
					<c:forEach var="p" items="${pet }">
						<option value="${p.petno }">${p.petname }</option>
					</c:forEach>
				</select>
			</div>
			
			<!-- 앞둔 예약 -->
			<div class="pre-reservation">
				<div class="js-reservation-div-top">
					<img src="/img/medical.png" style="margin-right: 8px;">
					앞둔 예약		
				</div>
				<c:forEach items="${reservation }" var="r">
					${r.resno }
				</c:forEach>
				
			</div>
			
			<!-- 지난 예약 -->
			<div class="past-reservation">
				<div class="js-reservation-div-top">
					<img src="/img/medical.png" style="margin-right: 8px;">
					지난 예약 	
				</div>
			
				<c:forEach begin="1" end="3">
					<div></div>
				</c:forEach>
			</div>
			
		</div>
		
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
	
	<script type="text/javascript">	
		
		$(()=>{
			var start = moment().subtract(29, 'days');
		    var end = moment();

		    function cb(start, end) {
		        $('#reportrange span').html(start.format('YYYY-MM-DD') + ' - ' + end.format('YYYY-MM-DD'));
		    }

		    $('#reportrange').daterangepicker({
		        startDate: start,
		        endDate: end,
		        locale: {
		            format: "YYYY-MM-DD",
		            applyLabel: "확인",
		            cancelLabel: "취소",
		            customRangeLabel: "직접 지정",
		            weekLabel: "W",
		            daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
		            monthNames: [
		              "1월",
		              "2월",
		              "3월",
		              "4월",
		              "5월",
		              "6월",
		              "7월",
		              "8월",
		              "9월",
		              "10월",
		              "11월",
		              "12월",
		            ],
		        },
		        ranges: {
		           '오늘': [moment(), moment()],
		           '지난 7일': [moment().subtract(6, 'days'), moment()],
		           '지난 30일': [moment().subtract(29, 'days'), moment()],
		           '이번 달': [moment().startOf('month'), moment().endOf('month')],
		           '지난 달': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
		        },
		        showDropdowns: true,
		        alwaysShowCalendars: false,
		    }, cb);

		    cb(start, end);	
		})
		
		

	</script>
</body>
</html>