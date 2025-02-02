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
    width: 80%;
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
	padding: 0 8px;
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
				
				// 메일 보내기
				const memail = '${appointment_d.memail}';
				const date = '${appointment_d.rdate}';
				const fixedDate = date.replace("KST", "+0900"); // KST를 +0900으로 변경
				const bdate = new Date(fixedDate);
				
				const year = bdate.getFullYear(); // 연도
			    const month = String(bdate.getMonth() + 1).padStart(2, '0'); // 월 (0부터 시작하므로 +1 필요)
			    const day = String(bdate.getDate()).padStart(2, '0'); // 일
			    const rdate = year+'년 '+month+'월 '+day+'일';
				
				const start_time = '${appointment_d.start_time}';
				const rtime = document.querySelector('input[name="rtime"]').value;
				var sendData = $('form').serialize();
				sendData = sendData + ('&status='+200);
				
				console.log("memail: "+memail+", rdate: "+rdate+", start_time: "+start_time+", rtime: "+rtime+"\n"
						+"sendData: "+sendData);
				
				url="/mail/confirmSend?memail="+memail+"&rdate="+rdate+"&start_time="+start_time+"&rtime="+rtime
						+"&"+sendData;
				
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
			    const rdate = year+'년 '+month+'월 '+day+'일';
				
				const start_time = '${appointment_d.start_time}';
				const rtime = document.querySelector('input[name="rtime"]').value;
				var sendData = $('form').serialize();
				sendData = sendData + ('&status='+300);
				
				console.log("memail: "+memail+", rdate: "+rdate+", start_time: "+start_time+", rtime: "+rtime+"\n"
						+"sendData: "+sendData);
				
				url="/mail/cancelSend?memail="+memail+"&rdate="+rdate+"&start_time="+start_time+"&rtime="+rtime
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
				// 폼 데이터 직렬화
	            var sendData = $('form').serialize();
	            sendData = sendData + ('&status=' + 300);
	            alert('sendData : ' + sendData);

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
            alert('sendData : ' + sendData);

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
	            alert('sendData : ' + sendData);

	            // 예약 변경 요청
	            location.href = "/admin/updateReservation?" + sendData; // GET 요청
			}
		})
	})
	
	

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
								        				<td><fmt:formatDate value="${appointment_d.rdate}" pattern="yyyy-MM-dd"/>&nbsp; ${appointment_d.start_time }</td>
								        				<th>진료 소요 시간(분)</th>
								        				<td>
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
								        			</tr>
								        			
								        			<tr>
								        				<th>담당의</th>
								        				<td>${appointment_d.aname }</td>
								        			</tr>
								        			<tr>
								        				<th><div id="hr-table-empty"></div></th>
								        			</tr>
								        			
								        			<tr>
								        				<th>보호자</th>
								        				<td>${appointment_d.mname }</td>
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
									        			<button type="button" id="res_to_chart" class="res_modal" onclick="location.href='/admin/consultation'">차트보기</button>							        		
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