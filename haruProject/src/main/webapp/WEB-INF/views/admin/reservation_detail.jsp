<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>예약 상세</title>
</head>

<style>

.res_detail_title {
    display: flex;
    flex-direction: row;
    align-items: center;
}

h1.h4.mb-4.text-gray-800.font-weight-bold {
    margin: 0 16px 0 0 !important;
    /* margin-right: 8px; */
}

button#res_status {
    width: auto;
    height: auto;
    font-size: 14px;
    border: 1px solid #0C808D;
    color: #0C808D;
    background-color: white;
    border-radius: 16px;
    margin: auto 0;
}

table#hr-table-appo-modal-data {
    width: 70%;
}

/* 버튼*/
.modal_l_content button {
	border-radius: 5px;
  	width: 92px;
  	height: 40px;
  	font-size: 16px;
  	
  	border: white;
  	color: white;
  	background-color: #0C808D;
  	font-weight: bold;
  	
  	margin: 0 10px;
}

/* 차트보기 */
#res_to_chart {
	background-color: var(--haru);
}

#res_del {
	background-color: #D0E3E7;
}

button#res_change, #res_cancel, #res_del {
    margin-right: 15px;
}

/* 예약 거절, 예약 변경 */
.update_btn2 {
	background-color: #A6D6C6;
}

/* 예약 상세 정보 스타일 */
.hr-table-appo-modal {
	border: none;
	color: black;
	margin: 20px;
}
.hr-table-appo-modal #hr-table-appo-modal-data th {
	font-weight: bold;
	color: black;
	padding: 4px 0;
}
.hr-table-appo-modal #hr-table-appo-modal-data td {
	color: black;
	padding: 0;
}
.hr-table-appo-modal #hr-table-appo-modal-data tr {
	margin: 4px
}

/* 동물 정보 */
.hr-appo-table {
	margin: 16px 20px;
}

#hr-appo-table-data {
	border-radius: 10px;
	background-color: rgba(12, 128, 141, 0.1);
	font-size: 16px;
	text-align: center;
	color: black;
	margin: 20px auto;
}

#hr-appo-table-data td {
	padding: 12px;
}
	
#hr-table-empty {
	padding: 8px;
}

#medical-time {
	border: 1px solid #0C808D;
    border-radius: 10px;
    color: #0C808D;
    margin: 0 12px;
    font-size: 16px;
    text-align: center;
    width: 70px;
}

.modal_l_content p {
	color: black;
	padding: 0 24px;
	font-size: 20px;
	font-weight: bold;
}

#hr-appo-memo {
	display: flex;
	justify-content: center;
}

#hr-appo-memo textarea {
	border-radius: 24px;
	background-color: rgba(12, 128, 141, 0.1);
	padding: 16px;
	border: white;
	width: 100%;
	margin: 0 16px;
}

.res_detail_p {
	margin: 20px;
    font-size: 16px;
    color: black;
    font-weight: 600;
}

#res_pet {
	font-size: 16px;
	font-weight: 400;
}



.res_memo {
	width: 100%;
    margin: 0 20px;
    border: 1px solid var(--haru);
    border-radius: 10px;
    height: 200px;
    padding: 12px;
}


/* 시간 */
#cal_time_table td{
	text-align: center;
}

#cal_time_table button {
    width: 80px;
    margin: 4px;
    border: 1px solid var(--haru);
    background-color: white;
    border-radius: 16px;
    height: 28px;
    color: black;
}


.disabled-btn {
	background-color: #D9D9D9 !important;
	color: white !important;
	border: none !important;
}

.selected_time {
  background-color: var(--haru) !important;
  color: white !important; /* 버튼 텍스트를 가독성 있게 하려면 추가 */
}


</style>

<script type="text/javascript">

	/* 확정 */
	$(document).ready(function () {
		$('#res_confirm').click(function() {
			if(confirm("예약 확정 메일을 전송하시겠습니까?")==true) {
				// 입력 필드 가져오기
	            const rtimeField = document.querySelector('input[name="rtime"]'); // 단일 요소 선택
	            if (!rtimeField) {
	                alert("진료 소요 시간을 입력 필드를 찾을 수 없습니다.");
	                return;
	            }
	            // 필수 속성 추가
	            rtimeField.setAttribute('required', true);

	            // 값 검증
	            if (!rtimeField.value) {
	                alert("진료 소요 시간을 입력해주세요.");
	                return; // 검증 실패 시 종료
	            } else if (parseInt(rtimeField.value) <= 0) {
	                alert("0 이하의 값은 입력할 수 없습니다.");
	                rtimeField.value = ""; // 값을 초기화
	                return; // 검증 실패 시 종료
	            }
				
				var sendData = $('form').serialize();
				sendData = sendData + ('&status='+200);
				
				url="/mail/confirmSend?"+sendData;
				//alert(url);
				
				// 메일 전송으로 이동, 메일 전송 후에 상태변경 controller 호출
				location.href = url;
			};
		});
	});
	
	/* 취소 */
	$(document).ready(function () {
		$('#res_cancel').click(function() {
			if(confirm("예약 취소 메일을 전송하시겠습니까?")==true) {		
				
				// 메일 보내기
				const memail = '${appointment_d.memail}';
				const date = '${appointment_d.rdate}';
				const fixedDate = date.replace("KST", "+0900"); // KST를 +0900으로 변경
				const bdate = new Date(fixedDate);
				
				const year = bdate.getFullYear(); // 연도
			    const month = String(bdate.getMonth() + 1).padStart(2, '0'); // 월 (0부터 시작하므로 +1 필요)
			    const day = String(bdate.getDate()).padStart(2, '0'); // 일
				
				const rtime = document.querySelector('input[name="rtime"]').value;
				var sendData = $('form').serialize();
				sendData = sendData + ('&status='+300);
				
				console.log("memail: "+memail+", rtime: "+rtime+"\n"
						+"sendData: "+sendData);
				
				url="/mail/cancelSend?memail="+memail+"&rtime="+rtime
						+"&"+sendData;
				
				// 메일 전송으로 이동, 메일 전송 후에 상태변경 controller 호출
				location.href = url;
			};		
		});
	});
	
	
	// 예약 확정 > 예약 취소
	$(function() {
		$('#res_del').click(function() {
			if(confirm("'예약 취소' 하시겠습니까?")==true) {
				// 메일 보내기
				const memail = '${appointment_d.memail}';				
			    const rtime = document.querySelector('input[name="rtime"]').value;
			    
				// 폼 데이터 직렬화
	            var sendData = $('form').serialize();
	            sendData = sendData + ('&status=' + 300 + '&memail='+memail+'&rtime='+rtime);
	            // alert('sendData : ' + sendData);

	            // 예약 변경 요청
	            location.href = "/admin/updateReservation?" + sendData; // GET 요청
			}
		})
	})
	
	// 예약 확정 > 예약 변경
	$(function() {
	    $('#res_change').click(function() {
	        if (confirm("예약 내용을 변경 하시겠습니까?") == true) {
	            // 입력 필드 가져오기
	            const rtimeField = document.querySelector('input[name="rtime"]'); // 단일 요소 선택
	            if (!rtimeField) {
	                alert("진료 소요 시간을 입력 필드를 찾을 수 없습니다.");
	                return;
	            }
	            // 필수 속성 추가
	            rtimeField.setAttribute('required', true);
	
	            // 값 검증
	            if (!rtimeField.value) {
	                alert("진료 소요 시간을 입력해주세요.");
	                return; // 검증 실패 시 종료
	            } else if (parseInt(rtimeField.value) <= 0) {
	                alert("0 이하의 값은 입력할 수 없습니다.");
	                rtimeField.value = ""; // 값을 초기화
	                return; // 검증 실패 시 종료
	            }
	
	            // 폼 데이터 직렬화
	            var sendData = $('form').serialize();
	            sendData = sendData + ('&status=' + 200);
	            //alert('sendData : ' + sendData);
	
	            // 예약 변경 요청
	            location.href = "/admin/updateReservation?" + sendData; // GET 요청
	        }
	    });
	});

	
	// 예약 확정 > 진료 완료
	$(function() {
		$('#res_complete').click(function() {
			if(confirm("'진료 완료' 하시겠습니까?")==true) {
				// 폼 데이터 직렬화
	            var sendData = $('form').serialize();
	            sendData = sendData + ('&status=' + 400);
	            //alert('sendData : ' + sendData);

	            // 예약 변경 요청
	            location.href = "/admin/updateReservation?" + sendData; // GET 요청
			}
		})
	})
	
	
	// ------------------------ 진료 소요시간
	
	$ ( async () => {
		
		const date = $('input[name=rdate]').val();
		const disabledTimes = await getDisabledTimes();		// 날짜에 따른 예약 불가능 시간 가져오기
    	
        console.log("disabledTimes : ",disabledTimes);
        // start_time, rtime/30 불러오기
        disabledTimes.forEach((item) => {
        	const stime = item.start_time;
        	const dtime = (item.rtime)/30;
        	console.log("start_time(stime) : ",stime,"rtime(dtime) : ",dtime);
            // 불가능시간과 rtime/30한 값을 넣어 예약 불가능한 시간 버튼 비활성화
            disableButtonsFromValue(stime, dtime);
        })
        
        
        // 해당 값과 일치하는 버튼 선택
        const start_time = $('input[name=start_time]').val().replace(":", "");
    	const targetButton = $(`.cal_time_btn[value="\${start_time}"]`);
    
	    // 버튼에 selected_time 클래스 적용
	    if (targetButton.length) {
	        targetButton.addClass("selected_time");
	        targetButton.prop("disabled", true); // 선택된 버튼 비활성화 (선택 사항)
	    }
        
        
        
        const numberInput = document.querySelector("#medical-time");
    	
	    // 값 변경 시 이벤트 처리
	    numberInput.addEventListener("input", (e) => {
	        const currentValue = e.target.value; // 현재 입력된 값 가져오기
	        
	        const num = currentValue/30;
	        // console.log("selectedValue : ", selectedValue, "num : ", num);
	        
	        // 기존 상태 초기화
	        resetButtonStates();

	        // 새롭게 비활성화 버튼 적용
	        buttonChangeFromRtime(start_time, num);
	    });
		
	})
	
	// 기존 버튼 상태 초기화 함수
    function resetButtonStates() {
        const buttons = document.querySelectorAll(".cal_time_btn");
        buttons.forEach((button) => {
            // button.disabled = false; // 모든 버튼 활성화
            // button.classList.remove("selected_time"); // 클래스 초기화
            
            button.disabled = false; // 버튼 활성화
   	    	button.classList.remove("selected_time"); // 관련 클래스 제거
   	    	button.style.backgroundColor = ""; // 스타일 초기화
   	    	button.style.color = ""; // 텍스트 색 초기화
   	    	button.style.pointerEvents = "";
        });
    }
	
	function formatDate(dateString) {
	    // "KST" 제거
	    let cleanDateString = dateString.replace(" KST", "");

	    // Date 객체 생성
	    let date = new Date(cleanDateString);

	    // 날짜가 유효하지 않으면 "--" 반환
	    if (isNaN(date.getTime())) {
	        console.error("Invalid date format:", dateString);
	        return "--";
	    }

	    // YYYY-MM-DD 형식 변환
	    const year = date.getFullYear();
	    const month = String(date.getMonth() + 1).padStart(2, '0'); // 1월 = 0, 따라서 +1 필요
	    const day = String(date.getDate()).padStart(2, '0');

	    return `\${year}-\${month}-\${day}`;
	}
	
    // 선택한 날짜에 따른 비활성화 시간 불러오기
    async function getDisabledTimes() {
		console.log("getDisabledTimes start ,,,");
    	try {
    		// 선생님 정보 + 날짜 정보
    		// /api/disabled-times -> rdate, ano
    		const date = $('input[name=rdate]').val();
    		const rdate = formatDate(date);
    		const ano = $('input[name=ano]').val();
    		console.log("getDisabledTimes ano : ", ano);
    		console.log("getDisabledTimes rdate ->"+rdate);
    		console.log("getDisabledTimes api url ->", `/api/disabled-times?rdate=\${rdate}&ano=\${ano}`);
    		    		
    		const response = await fetch(`/api/disabled-times?rdate=\${rdate}&ano=\${ano}`, {
    			method:"GET",
    			headers: {
    				"Content-Type": "application/json",
    			},
    		});
    		
    		if(!response.ok) {
    			throw new Error("Failed to fetch disabled times");
    		}
    		
    		const data = await response.json();
    		console.log("getDisabledTimes data ->", data);
    		return data || [];
		} catch (error) {
			console.error("Error fetching disabled times:", error);
            return [];
		}
    }
    
    // 불러온 비활성화 시간에 따른 버튼 비활성화
    function disableButtonsFromValue(startValue, count) {
    	console.log("disableButtonsFromValue start ,,,");
    	const buttons = Array.from(document.querySelectorAll(".cal_time_btn"));
    	// 기준이 될 버튼 인덱스 찾기
    	const startIndex = buttons.findIndex((button) => button.value === startValue);
    	if (startIndex === -1) {
            console.error("해당 value를 가진 버튼을 찾을 수 없습니다:", startValue);
            return;
        }
    	
    	// 기준 인덱스부터 count 만큼 버튼 비활성화
        for (let i = startIndex; i < startIndex + count && i < buttons.length; i++) {
            buttons[i].disabled = true; // 버튼 비활성화
            buttons[i].classList.add("disabled-btn"); // 시각적 효과를 위한 클래스 추가 (선택 사항)
        }
    }
    
	// 진료 소요 시간 변경에 따른 style 변화
    function buttonChangeFromRtime(startValue, count) {
    	const buttons = Array.from(document.querySelectorAll(".cal_time_btn"));
    	// 기준이 될 버튼 인덱스 찾기
    	const startIndex = buttons.findIndex((button) => button.value === startValue);
    	if (startIndex === -1) {
            console.error("해당 value를 가진 버튼을 찾을 수 없습니다:", startValue);
            return;
        }
    	
    	// 기준 인덱스부터 count 만큼 버튼 비활성화
        for (let i = startIndex; i < startIndex + count && i < buttons.length; i++) {
            buttons[i].disabled = true; // 버튼 비활성화
            buttons[i].classList.add("selected_time"); // 시각적 효과를 위한 클래스 추가 (선택 사항)
        }
    }
	
    $(document).ready(() => {
        const start_time = $('input[name=start_time]').val().replace(":", ""); // 시작 시간 값
        const rtime = parseInt($('input[name=rtime]').val()) || 0; // 진료 소요 시간 값 (기본값 0)
        const count = rtime / 30; // 30분 단위로 버튼 개수 설정

        if (start_time && count > 0) {
            buttonChangeFromRtime(start_time, count); // 버튼 선택 적용
        }
    });
	
	

</script>



<body>

<!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <jsp:include page="components/sideBar.jsp"></jsp:include>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <jsp:include page="components/topBar.jsp"></jsp:include>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid modal_">
                	
                	<!-- DataTales Example -->
                    <div class="card mb-4">
                    
                        
                        <!-- 글 내용 -->
                        <div class="card-body">
                        	<!-- 내용 전체 -->
	                        <div class="res_detail_body">
	                        
	                        	<!-- Page Heading -->
	                        	<div class="res_detail_title">
				                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >예약 상세</h1>
						        	<button id="res_status">${appointment_d.status }</button>	                        	
	                        	</div>
					        		
					        		<form action="updateReservation" method="POST">
						        		<!-- 내용 -->
								        <div class="hr-table-appo-modal">
								        	<table id="hr-table-appo-modal-data">
								        		<colgroup>
								        			<col width="10%">
								        			<col width="25%">
								        			<col width="15%">
								        			<col width="25%">
								        		</colgroup>
								        			<tr>
								        				<th>예약 번호</th>
								        				<td><input style="border:none" name="resno" type="text" value="${appointment_d.resno }"></td>
								        			</tr>
								        			<tr>
								        				<th>예약 일시</th>
								        				<td>
								        					<input type="hidden" name="rdate" value="${appointment_d.rdate}">
								        					<input type="hidden" name="start_time" value="${appointment_d.start_time}">
								        					<input type="hidden" name="memail" value="${appointment_d.memail}">
								        					<fmt:formatDate value="${appointment_d.rdate}" pattern="yyyy-MM-dd"/>&nbsp; ${appointment_d.start_time }
								        				</td>
								        				<th>&nbsp;&nbsp;진료 소요 시간(분)</th>
								        				<td >
								        					<div>
								        						<c:if test="${appointment_d.rstatus_mcd eq 100 or appointment_d.rstatus_mcd eq 200 }">
								        							<input name="rtime" id="medical-time" type="number" step="30" value="${appointment_d.rtime}">							        						
								        						</c:if>
								        						<c:if test="${appointment_d.rstatus_mcd eq 300 or appointment_d.rstatus_mcd eq 400 }">
								        							<input id="medical-time" type="number" step="30" value="${appointment_d.rtime}" readonly>							        						
								        						</c:if>
										                    </div>
										                </td>
								        			</tr>
								        			<tr>
								        				<th><div id="hr-table-empty"></div></th>
								        			</tr>
								        			<tr>
								        				<th>진료 과목</th>
								        				<td>${appointment_d.item }</td>
								        				<!-- 진료 소요 시간 -->
								        				<td colspan="2" rowspan="4">
								        					<table id="cal_time_table" width="100%" cellspacing="0">
										        				<tr>
										        					<td><button type="button" class="cal_time_btn" value="0900" disabled>09:00</button></td>
										        					<td><button type="button" class="cal_time_btn" value="0930" disabled>09:30</button></td>
										        					<td><button type="button" class="cal_time_btn" value="1000" disabled>10:00</button></td>
										        					<td><button type="button" class="cal_time_btn" value="1030" disabled>10:30</button></td>
										        				</tr>
										        				<tr>
										        					<td><button type="button" class="cal_time_btn" value="1100" disabled>11:00</button></td>
										        					<td><button type="button" class="cal_time_btn" value="1130" disabled>11:30</button></td>
										        					<td><button type="button" class="cal_time_btn" value="1200" disabled>12:00</button></td>
										        					<td><button type="button" class="cal_time_btn" value="1230" disabled>12:30</button></td>
										        				</tr>
										        				
										        				
										        				
										        				<tr>
										        					<td><button type="button" class="cal_time_btn" value="1400" disabled>02:00</button></td>
										        					<td><button type="button" class="cal_time_btn" value="1430" disabled>02:30</button></td>
										        					<td><button type="button" class="cal_time_btn" value="1500" disabled>03:00</button></td>
										        					<td><button type="button" class="cal_time_btn" value="1530" disabled>03:30</button></td>
										        				</tr>
										        				<tr>
										        					<td><button type="button" class="cal_time_btn" value="1600" disabled>04:00</button></td>
										        					<td><button type="button" class="cal_time_btn" value="1630" disabled>04:30</button></td>
										        					<td><button type="button" class="cal_time_btn" value="1700" disabled>05:00</button></td>
										        					<td><button type="button" class="cal_time_btn" value="1730" disabled>05:30</button></td>
										        				</tr>
										        			</table>
								        				</td>
								        			</tr>
								        			
								        			<tr>
								        				<th>담당의</th>
								        				<td>
								        					<input type="hidden" name="ano" value="${appointment_d.ano}">
								        					${appointment_d.aname }
								        				</td>
								        			</tr>
								        			
								        			<tr>
								        				<th>보호자</th>
								        				<td>${appointment_d.mname }</td>
								        			</tr>
								        			<tr>
								        				<th>  </th>
								        				<td>  </td>
								        			</tr>
								        			<tr>
								        				<th>  </th>
								        				<td>  </td>
								        			</tr>
								
								
								
								        	</table>
								        </div>
								        
								        <p class="res_detail_p">동물 정보</p>
								        <div class="hr-appo-table">
								        	<table id="hr-appo-table-data" width="100%" cellspacing="0">
								        			
								        			<tr>
								        				<td>${appointment_d.petno }</td>
								        				<td>${appointment_d.petname }</td>
								        				<td>${appointment_d.species }&nbsp;/&nbsp;${appointment_d.gender }</td>
								        				<td>${appointment_d.petweight }</td>
								        			</tr>
								        	</table>
								        </div>
							        
								        <p class="res_detail_p">예약 메모</p>
								        <div style="margin-top: 1rem">
											<div>
												<c:if test="${appointment_d.rstatus_mcd eq 100 or appointment_d.rstatus_mcd eq 200 }">
								        			<textarea name="memo" class="res_memo">${appointment_d.memo}</textarea>
								        		</c:if>
								        		<c:if test="${appointment_d.rstatus_mcd eq 300 or appointment_d.rstatus_mcd eq 400 }">
								        			<textarea class="res_memo" readonly>${appointment_d.memo}</textarea>						        						
								        		</c:if>
												
											</div>
						        		</div>					        				        
	                        	
	                        	
	                        			<div class="modal_l-content-btn">
								        	<c:choose>
								        		<c:when test="${appointment_d.rstatus_mcd eq 100 }">
									        		<button type="button" id="modal_close_btn" class="to_list res_modal" onclick="location.href='/admin/reservation'">목록으로</button>
										        	<button type="button" class="update_btn2" id="res_cancel" >예약 거절</button>
										        	<button type="button" class="update_btn" id="res_confirm">예약 확정</button>
								        		</c:when>
								        		<c:when test="${appointment_d.rstatus_mcd eq 200 }">
									        		<button type="button" id="modal_close_btn" class="to_list res_modal" onclick="location.href='/admin/reservation'">목록으로</button>
									        		<button type="button" class="update_btn" id="res_del">예약 취소</button>
										        	<button type="button" class="update_btn2" id="res_change" >예약 변경</button>
										        	<button type="button" class="update_btn" id="res_complete">진료 완료</button>
								        		</c:when>
								        		<c:when test="${appointment_d.rstatus_mcd eq 300 or appointment_d.rstatus_mcd eq 400}">
									        		<button type="button" id="modal_close_btn" class="to_list res_modal" onclick="location.href='/admin/reservation'">목록으로</button>
									        		<!-- 차트에 아직 작성되지 않은 상태면 목록으로만, 차트도 작성됐으면 차트보기 버튼 생성 -->
									        		<c:if test="${appointment_d.cresno eq appointment_d.resno }">
									        			<button type="button" id="res_to_chart" class="res_modal" onclick="location.href='/admin/detailConsultation?resno=${appointment_d.resno}'">차트보기</button>							        		
									        		</c:if>
								        		</c:when>
								        	</c:choose>							        		        	
								        </div>
				                        	
					        		</form>
	                        </div>
	                                       	
	                        	
                        </div>
                        <!-- end of .card-body -->		
	
                    </div>
					
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
			<jsp:include page="components/footer.jsp"></jsp:include>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <jsp:include page="components/logOutModal.jsp"></jsp:include>
    

</body>
</html>