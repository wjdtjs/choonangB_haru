<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약내역</title>

<!-- date-picker -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

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
	margin-top: 20px;
}
.past-reservation {
	margin-top: 40px;
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

.empty-list {
	width: 100%;
	text-align: center;
	font-size: 14px;
	color: #6F7173;
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
					<option value="0" selected>전체</option>
					<c:forEach var="p" items="${pet }">
						<option value="${p.petno }" ${p.petno == petno ? 'selected' : '' }>${p.petname }</option>
					</c:forEach>
				</select>
			</div>
			
			<!-- 앞둔 예약 -->
			<div class="pre-reservation">
				<div class="js-reservation-div-top">
					<img src="/img/medical.png" style="margin-right: 8px;">
					앞둔 예약		
				</div>
				<c:choose>
					<c:when test="${not empty pre }">
						<c:forEach items="${pre }" var="res">
							<%@include file="components/pre_reservation_item.jsp" %>
						</c:forEach>					
					</c:when>
					<c:otherwise>
						<div class="empty-list">예약 내역이 존재하지 않습니다.</div>
					</c:otherwise>
				</c:choose>
				
			</div>
			
			<!-- 지난 예약 -->
			<div class="past-reservation">
				<div class="js-reservation-div-top">
					<img src="/img/medical.png" style="margin-right: 8px;">
					지난 예약 	
				</div>
			
				<c:choose>
					<c:when test="${not empty past }">
						<c:forEach items="${past }" var="res">
							
							<%@include file="components/past_reservation_item.jsp" %>
							
						</c:forEach>					
					</c:when>
					<c:otherwise>
						<div class="empty-list">예약 내역이 존재하지 않습니다.</div>
					</c:otherwise>
				</c:choose>
			</div>
			
		</div>
		
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
	
	<script type="text/javascript">	
		
		$(()=>{
			chooseDate();

		    
		    /* 예약 내역 버튼 토글 */
		    $(".page-btn").click(function() {
		        // 클릭한 버튼과 같은 부모 `.pet-res-content` 내부의 `.res-re`를 토글
		        $(this).closest(".pet-res-content").next(".res-re").slideToggle();
		       
		        var tr = $(this).css('transform');
		        var values = tr.split('(')[1].split(')')[0].split(',');
		        var a = values[0];
		        var b = values[1];
		        var c = values[2];
		        var d = values[3];

		        var scale = Math.sqrt(a*a + b*b);
		        var sin = b/scale;
		        var angle = Math.round(Math.atan2(b, a) * (180/Math.PI));
		        
		        var cur = angle + 180;
		        
		        $(this).css('transform', `rotate(\${cur}deg)`);
		    });
		    
		    
		})
		
		
		var pet = ${petno};
		var start_date = "${start}";
		var end_date = "${end}";
		if('${start}') {
			$('#reportrange span').html('${start} - ${end}');			
		} else {
			$('#reportrange span').html(' 전체 ');
		}
		
	    /* 동물 선택 */
	    $('.js-pet-selector').change(function() {
	    	pet = $(this).val();
	    	console.log(pet);
	    	location.href="/user/reservation?petno="+pet+"&start="+start_date+"&end="+end_date;
	    })
	    
	    
   	    /* 날짜 선택 콜백 함수 */
	    function cb(start, end) {
	    	
	    	if(start!=null && end!=null && start._isValid && end._isValid) {
		    	console.log(start.format('YYYY-MM-DD'))
		    	console.log(end.format('YYYY-MM-DD'))
		    	
		        $('#reportrange span').html(start.format('YYYY-MM-DD') + ' - ' + end.format('YYYY-MM-DD'));
		    	start_date = start.format('YYYY-MM-DD');
		    	end_date = end.format('YYYY-MM-DD');
		    	
		    	location.href="/user/reservation?petno="+pet+"&start="+start_date+"&end="+end_date;
	    	} else {
	    		$('#reportrange span').html(' 전체 ');
	    		console.log('전체선택');
	    		
	    		location.href="/user/reservation?petno="+pet;
	    	} 
	    }
	    
		
	    /* 날짜 선택기 초기화 */
		function chooseDate() {
	    	var start = '${start}';
			var end = '${end}';

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
		        	'전체': [null, null],
		           	'오늘': [moment(), moment()],
		           	'지난 7일': [moment().subtract(6, 'days'), moment()],
		           	'지난 30일': [moment().subtract(29, 'days'), moment()],
		           	'이번 달': [moment().startOf('month'), moment().endOf('month')],
		           	'지난 달': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
		        },
		        showDropdowns: true,
		        alwaysShowCalendars: false,
		    }, cb);

	    }	    
	    

	</script>
</body>
</html>