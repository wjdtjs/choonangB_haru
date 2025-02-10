<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약</title>

<style type="text/css">
.seq_div {
	width: 100%;
	display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
}
.pet-choice-div {
	margin-top: 1rem;
	text-align: center;
}

/* 슬라이더 */
#pet-slider {
  	position: relative;
  	width: 100%;
  	overflow: hidden;
  	margin: 20px auto 0 auto;
  	border-radius: 4px;
  	white-space: nowrap;
  	
}
#pet-slider .slider-container {
	width: 100%;
	transition: transform 0.7s ease-in-out;
	display: flex;
}
#pet-slider .pet-slid-item-div {
  	position: relative;
 	margin-inline: 53px;
 	width: 255px;
  	list-style: none;
  	display: flex;
  	justify-content: space-around;
}

#pet-slider .pet-slid-item-div .pet-item {
  	position: relative;
  	display: block;
  	float: left;
  	margin: 0;
  	padding: 12px 18px;
	border-radius: 20px;
	border: 3px solid white;
  	text-align: center;
  	display: flex;
  	flex-direction: column;
}
#pet-slider .pet-item:has(input[type=radio]:checked) {
	border: 3px solid #A6D6C5;
	background: rgba(166, 214, 197, 0.3);
}
#pet-slider .pet-item img {
	width: 80px;
	height: 80px;
	object-fit: cover;
	border-radius: 50%;
	margin-bottom: 12px;
}
#pet-slider .pet-item input[type=radio] {
 	display: none;
}

i.control_prev, i.control_next {
  	position: absolute;
  	top: 40%;
  	z-index: 999;
  	display: block;
  	width: auto;
  	text-decoration: none;
  	font-size: 20px;
 	cursor: pointer;
 	color: var(--haru);
}

i.control_prev:hover, i.control_next:hover {
  	opacity: 1;
  	-webkit-transition: all 0.2s ease;
}
i.control_prev {
  	left: 15px;
}
i.control_next {
  	right: 15px;
}
/* 슬라이더 끝 */

.item-choice-div {
	margin-top: 1rem;
}
.item-choice-div > div {
	display: flex;
	flex-direction: column;
}
.item-choice-div label {
	font-size: 1rem;
	font-weight: 500;
}
.item-choice-div select {
	height: 50px;
	background-image: url("/img/arrow_drop_down.png");  
	background-repeat: no-repeat;  
	background-position: 92% center; 
	background-size: 30px; 
}
.item-choice-div select,
.item-choice-div textarea {
	margin-top: 6px;
	border-radius: 10px;
	border: 1px solid rgb(0,0,0,0.3);
	padding: 8px 20px;
}
.item-choice-div textarea {
	font-family: "Noto Sans KR", serif;
	width: 100%;
	height: 120px;
	resize: none;
}
.item-choice-div select:focus,
.item-choice-div textarea:focus {
	outline-color: var(--haru);
}
.item-bcd-select {
	width: 100%;
}

button[type=submit] {
	width: 350px;
	height: 50px;
	color: white;
	background: #d9d9d9;
	position: fixed;
	bottom: 82px;
	font-size: 20px;
	font-weight: 500;
}
.appointment-info-ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	padding-block: 20px;
	font-size: 16px;
}
.appointment-info-li {
	margin: 0;
	margin-block: 5px;
	padding: 0;
	display: flex;
/* 	justify-content: space-between; */
}
.appointment-info-li span:nth-child(1) {
	font-weight:500;
	width: 100px;
	color: rgb(0,0,0,0.7);
	flex-shrink: 0;
}

.doctor-choice-div,
.date-choice-div {
	border-top: 1px solid rgb(0,0,0,0.3);
}
.doctor-choice-toggle,
.date-choice-toggle {
	padding-block: 15px;
	font-size: 20px;
	vertical-align: middle;
	display: flex;
	align-items: center;
	justify-content: space-between;
}
.choiced-doctor-name {
	color: var(--haru); 
	font-size: 18px; 
	margin-left: 1rem;
	font-weight: 500;
}
.page-btn {
	font-size: 1rem;
	margin-right: 20px;
}
.res-re {
	padding-bottom: 20px;
}

.doctor-item {
 	width: 100%;
 	display: flex;
 	flex-direction: column;
 	padding: 13px 20px;
	border: 3px solid white;
 	border-radius: 20px;
 	position: relative;
}

.check-icon {
    width: 1.7em;
    height: 1.7em;
    border-radius: 50%;
    background-color: #fff;
    border: 1px solid gray;
    position: absolute;
    transform: translateY(-50%);
    top: 50%;
    right: 20px;
}
.check-icon::before {
    content: "";
    position: absolute;
    box-sizing: border-box;
    width: 35%;
    height: 50%;
    left: 50%;
    top: 50%;
    transform: translateX(-50%) translateY(-70%) rotateZ(40deg);
    border-right: 3px solid gray;
    border-bottom: 3px solid gray;
}
[type="radio"]:checked + .check-icon {
	border-color:  #53ad8d; 
    background-color: #53ad8d; 
}
[type="radio"]:checked + .check-icon::before {
    border-color: #fff;
}
.doctor-item:has([type="radio"]:checked) {
	border: 3px solid #A6D6C5;
	background: rgba(166, 214, 197, 0.3);
}

/* 달력 */
#res-calendar {
	padding-bottom: 40px;
}
table#calendar {
    width: 100%;
    height: 300px;
    border: none;
    text-align: center;
    color: black;
}
#calendar td {
	font-size: 14px;
    border-radius: 12px;
	border: none;
	padding: 8px;
	height: 50px;
	background-clip: content-box;
}
#tbCalendarYM {
	font-size: 1rem !important;
}

#cal_time {
	padding-bottom: 50px;
}
#cal_time_table td{
	text-align: center;
}

#cal_time_table button {
    width: 85%;
    margin: 8px;
    border: 1px solid var(--haru);
    background-color: white;
    border-radius: 16px;
    height: 28px;
}
.selected_time {
  background-color: var(--haru) !important;
  color: white; /* 버튼 텍스트를 가독성 있게 하려면 추가 */
}

.selected-date {
	background-color: var(--haru);
	color: white !important;
}

.disabled-btn {
	background-color: #D9D9D9 !important;
	color: white !important;
	border: none !important;
}

#cal_time_table > tbody > tr:nth-child(4) > td {
 	padding-top: 12px;
}

.cal-time-div-top {
	color: #6F7173;
	font-size: 14px;
	display: flex;
	align-items: center;
}
.cal-time-div-top::after {
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
		<div class="haru-user-topbar" style="border: none; flex-direction: column;">
			<div class="topbar-title" style="height: 3.8rem;">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				예약
				<div style="width:45px">
				</div>
			</div>
			<div class="seq_div">
				<div style="width: 49%; border: 1px solid rgb(0, 0, 0, 0.3);"></div>
				<div style="width: 50%; border: 1px solid var(--haru);"></div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container" style="padding-top: 3.8rem;">
			
			<!-- 의사 선택 -->
			<form action="appointmentStep2" method="post" onsubmit="return validateForm();" id="AppointmentFormStep2">
				<input type='hidden' name='resno' value=''>
				<input type='hidden' name='rdate' value=''>
				<input type='hidden' name='start_time' value=''>
				
				<ul class="appointment-info-ul">
					<li class="appointment-info-li">
						<span class="info-title">보호자</span>
						<span>${apt.name }</span>
					</li>
					<li class="appointment-info-li">
						<span class="info-title">예약동물</span>
						<span>${apt.petname }</span>
						<input type="hidden" name="petno" value="${apt.petno }">
					</li>
					<li class="appointment-info-li">
						<span class="info-title">예약항목</span>
						<span>${apt.bcd_cont }</span>
						<input type="hidden" name="mtitle_bcd" value="${apt.bcd }">
					</li>
					<li class="appointment-info-li">
						<span class="info-title">세부항목</span>
						<span>${apt.mcd_cont }</span>
						<input type="hidden" name="mtitle_mcd" value="${apt.mcd }">
					</li>					
					<li class="appointment-info-li">
						<span class="info-title">예약메모</span>
						<span>${apt.memo }</span>
						<input type="hidden" name="memo" value="${apt.memo }">
					</li>
				</ul>
				
				<!-- 의사선택 -->
				<div class="doctor-choice-div">
					<div class="doctor-choice-toggle">
						<span>진료실 <span class="choiced-doctor-name"></span></span>
						<i class="fa-solid fa-chevron-right page-btn" style="transform: rotate(90deg);"></i> 
					</div>
					<div class="res-re" style="display: none">
						<c:if test="${not empty apt.doctor }">
							<c:forEach var="d" items="${apt.doctor }" varStatus="status">
							    	<label class="doctor-item" for="doctor${d.ANO }">
							    		<span style="display: flex; flex-direction: row; align-items: center;">
							    			<img src="/img/catdoctor.jpeg" style="width:50px; height:50px; object-fit:cover; border-radius: 50%">
								    		<span style="display: flex; flex-direction: column; margin-left: 15px;">
									    		<span style="font-weight:500">${d.ANAME }<span style="font-weight:400"> 선생님</span></span>
								    			<span style="font-size: 14px;">
								    					매주 
								    				<c:forEach var="off" items="${dayoff[status.index] }" varStatus="loop">
								    					<fmt:formatDate value="${off.schdate }" pattern="E"/>
									    				<c:if test="${!loop.last}">, </c:if>
								    				</c:forEach>
														휴무
								    			</span>								    		
								    		</span>
							    		</span>
							    		<input type="radio" name="ano" id="doctor${d.ANO }" value="${d.ANO }" style="display: none"
							    			data-key="${d.ANAME }"
							    			<c:if test="${d.ANO eq apt.ano }">checked</c:if>
							    		>
							    		<span class="check-icon"></span>
							    	</label>
					  		</c:forEach>
						</c:if>
					</div>
				</div>
				
				<!-- 날짜 및 시간 선택 -->
				<div class="date-choice-div">
					<div class="date-choice-toggle">
						<span>날짜/시간</span>
						<i class="fa-solid fa-chevron-right page-btn" style="transform: rotate(90deg);"></i> 
					</div>
					<div class="res-re" style="display: none">
						<div id="res-calendar" style="display: none">
		        			<table id="calendar" border="3" align="center" style="border-color:#3333FF ">
							    <tr><!-- label은 마우스로 클릭을 편하게 해줌 -->
							        <td>
							        	<label onclick="prevCalendar()" class="cal-prev-btn" style="display: none">
							        		<i class="fa-solid fa-chevron-left"></i> 
							        	</label>		
							        </td>
							        <td align="center" id="tbCalendarYM" colspan="5">yyyy년 m월</td>
							        <td><label onclick="nextCalendar()" class="cal-next-btn">
							        		<i class="fa-solid fa-chevron-right"></i> 
							        	</label>
							        </td>
							    </tr>
							    <tr>
							        <td align="center" style="color: red">일</td>
							        <td align="center">월</td>
							        <td align="center">화</td>
							        <td align="center">수</td>
							        <td align="center">목</td>
							        <td align="center">금</td>
							        <td align="center" style="color: blue">토</td>
							    </tr> 
							</table>
		        		</div>
		        		<div id="cal_time" style="display: none">
<!-- 	        				<hr> -->
		        			<table id="cal_time_table" width="100%" cellspacing="0">
		        				<tr>
		        					<td colspan="4"><span class="cal-time-div-top">오전</span></td>
		        				</tr>
		        				<tr>
		        					<td><button type="button" class="cal_time_btn" value="0900">09:00</button></td>
		        					<td><button type="button" class="cal_time_btn" value="0930">09:30</button></td>
		        					<td><button type="button" class="cal_time_btn" value="1000">10:00</button></td>
		        					<td><button type="button" class="cal_time_btn" value="1030">10:30</button></td>
		        				</tr>
		        				<tr>
		        					<td><button type="button" class="cal_time_btn" value="1100">11:00</button></td>
		        					<td><button type="button" class="cal_time_btn" value="1130">11:30</button></td>
		        					<td><button type="button" class="cal_time_btn" value="1200">12:00</button></td>
		        					<td><button type="button" class="cal_time_btn" value="1230">12:30</button></td>
		        				</tr>
		        				<tr>
		        					<td colspan="4"><span class="cal-time-div-top">오후</span></td>
		        				</tr>
		        				<tr>
		        					<td><button type="button" class="cal_time_btn" value="1400">02:00</button></td>
		        					<td><button type="button" class="cal_time_btn" value="1430">02:30</button></td>
		        					<td><button type="button" class="cal_time_btn" value="1500">03:00</button></td>
		        					<td><button type="button" class="cal_time_btn" value="1530">03:30</button></td>
		        				</tr>
		        				<tr>
		        					<td><button type="button" class="cal_time_btn" value="1600">04:00</button></td>
		        					<td><button type="button" class="cal_time_btn" value="1630">04:30</button></td>
		        					<td><button type="button" class="cal_time_btn" value="1700">05:00</button></td>
		        					<td><button type="button" class="cal_time_btn" value="1730">05:30</button></td>
		        				</tr>
		        			</table>
		        		</div>
					</div>
				</div>
				
			</form>
			
			<button type="submit" form="AppointmentFormStep2">예약</button>
		</div>
		
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>

<script src="/js/buildCalendar.js?v=0.13" ></script>	
<script type="text/javascript">	

	var today = new Date(); //오늘 날짜//내 컴퓨터 로컬을 기준으로 today에 Date 객체를 넣어줌
	var date = new Date(); 	//today의 Date를 세어주는 역할
	var disabledDates = []; //불가능 날짜 리스트
	var diff = 0;			//현재 날짜와 달력의 개월 차이
	
	let selectedDateGlobal = null; //선택한 날짜
	let selected_vet = 0;	//선택한 의사 ano
	
	/*
	 * 달력 그리기
	   /js/buildCalendar.js 
	*/
	buildCalendar(); 


	/* submit 전 검증 */
	function validateForm() {
		let result = confirm('이대로 예약하시겠습니까?');
		
		const selected_date = $('td.selected-date').text();
		const start_time = $('.cal_time_btn.selected_time').val();

		let str = '';
		if(!$('input:radio[name=ano]').is(':checked')) {
			str += '담당의를 선택하세요.\n';
			result = false;
		}
		if(!selected_date) {
			str += '날짜 선택은 필수입니다.\n';
			result = false;
		}
		if(!start_time) {
			str += '진료시간을 선택하세요.';
			result = false;
		}
		
		if(!result) {
			alert(str);
		} else {
			let rdate = today.getFullYear()+'-'+(today.getMonth() + 1)+'-'+selected_date;
			
			alert("선택한 날짜 : "+ rdate);
			alert("선택한 시간 : "+ start_time);
			
			$('input:hidden[name=rdate]').val(rdate);
			$('input:hidden[name=start_time]').val(start_time);
			
			const now = new Date();
			$('input:hidden[name=resno]').val(now.getTime());
			
// 			result = confirm(`담당의 : \${$('input:radio[name=ano]:checked').data('key')}\n
// 					예약 동물 : \${apt.petname}\n
// 					예약 날짜 : \${rdate}\n
// 					예약 시간 : \${start_time}\n\n
// 					이대로 예약하시겠습니까?
					
// 					`)
		}

		
		return result;
	}
	
	
	$(()=>{
		/* 의사 선택 시 */
		desVet();
		$('input:radio[name=ano]').change(function() {
			$('button[type=submit]').css('background', '#d9d9d9');
			desVet();
			let seldoc = $('input:radio[name=ano]:checked').val();
			selected_vet = seldoc;
			selectDoctor(); // /js/buildCalendar.js 
			
			$(".date-choice-toggle").next(".res-re").css('display', 'block');
			$(".date-choice-toggle").children('.page-btn').css('transform', `rotate(270deg)`);
	        $(".user-body-container").animate({ scrollTop: $(document).height() }, 500); //페이지 제일 하단으로 이동
	        $('#cal_time').css("display", "none"); //시간 선택 안보이게
	        
		})
		
		
		function desVet() {
			let vet = $('input:radio[name=ano]:checked').data('key');
			if(vet) {
				$('.choiced-doctor-name').text(vet+' 선생님');		
			}
		}
		
		
		/* 버튼 토글 */
	    $(".doctor-choice-toggle").click(function() {
	        $(this).closest(".doctor-choice-toggle").next(".res-re").slideToggle();
	       	arrowRotate(this);
	    });
	    $(".date-choice-toggle").click(function() {
	        $(this).closest(".date-choice-toggle").next(".res-re").slideToggle();
	       	arrowRotate(this);
	    });
		
		function arrowRotate(toggleItem) {
			var tr = $(toggleItem).children('.page-btn').css('transform');
	        var values = tr.split('(')[1].split(')')[0].split(',');
	        var a = values[0];
	        var b = values[1];
	        var c = values[2];
	        var d = values[3];

	        var scale = Math.sqrt(a*a + b*b);
	        var sin = b/scale;
	        var angle = Math.round(Math.atan2(b, a) * (180/Math.PI));
	        
	        var cur = angle + 180;
	        
	        $(toggleItem).children('.page-btn').css('transform', `rotate(\${cur}deg)`);
		}
	})
	



</script>
</body>
</html>