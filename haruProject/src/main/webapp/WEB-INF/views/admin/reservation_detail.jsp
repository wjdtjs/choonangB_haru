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


/* 모달버튼 스타일 */
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
	border-radius: 24px;
	background-color: rgba(12, 128, 141, 0.1);
	font-size: 20px;
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
	border-radius: 12px;
	color: #0C808D;
	padding: 1px 32px 1px 12px;
	margin: 0 12px;
	font-size: 16px;
	text-align: center;
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

button#res_change, #res_cancel {
    margin-right: 15px;
}


</style>



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
					        		
					        		<!-- 내용 -->
							        <div class="hr-table-appo-modal">
							        	<table id="hr-table-appo-modal-data">
							        		<colgroup>
							        			<col width="10%">
							        			<col width="25%">
							        			<col width="10%">
							        			<col width="25%">
							        		</colgroup>
							        			<tr>
							        				<th>예약 번호</th>
							        				<td>${appointment_d.resno }</td>
							        			</tr>
							        			<tr>
							        				<th>예약 일시</th>
							        				<td><fmt:formatDate value="${appointment_d.rdate}" pattern="yyyy-MM-dd"/></td>
							        				<th>진료 소요 시간</th>
							        				<td>
							        					<div>
								        						<select id="medical-time">
										                    		<option value="1">30분</option>
																	<option value="2">60분</option>
																	<option value="3">90분</option>
																	<option value="4">120분</option>
										                    	</select>
									                       	
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
							        			<tr id="res_pet">
							        				<th>번호</th>
							        				<th>이름</th>
							        				<th>종 / 성별</th>
							        				<th>몸무게</th>
							        			</tr>
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
									<div class="post-form">
										<textarea name="pdetails" class="summernoteTextArea proRegSummernote" >${appointment_d.memo}
										</textarea>
									</div>
					        		</div>
						        
	                        	
	                        	
	                        	
	                        	<!-- 모달 버튼 -->			        
						        <div class="modal_l-content-btn">
						        	<c:choose>
						        		<c:when test="${appointment_d.rstatus_mcd eq 100 }">
							        		<button type="button" id="modal_close_btn" class="to_list res_modal" onclick="location.href='/admin/reservation'">목록으로</button>
								        	<button type="button" class="update_btn2" id="res_cancel" >예약 거절</button>
								        	<button type="button" class="update_btn" id="res_confirm">예약 확정</button>
						        		</c:when>
						        		<c:when test="${appointment_d.rstatus_mcd eq 200 }">
							        		<button type="button" id="modal_close_btn" class="to_list res_modal" onclick="location.href='/admin/reservation'">목록으로</button>
								        	<button type="button" class="update_btn2" id="res_change" >예약 변경</button>
								        	<button type="button" class="update_btn" id="res_complete">진료 완료</button>
						        		</c:when>
						        		<c:when test="${appointment_d.rstatus_mcd eq 300 or appointment_d.rstatus_mcd eq 400}">
							        		<button type="button" id="modal_close_btn" class="to_list res_modal" onclick="location.href='/admin/reservation'">목록으로</button>
						        		</c:when>
						        	</c:choose>							        		        	
						        </div>
				                        	
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
    
    
    <script type="text/javascript">
	/* 메일 보내기 */
	const name = '';
	const date = '';
	const time = '';
	const mail = 'mail 내용\n';
	
	/* 확정 */
	$('#res_confirm').click(function() {
		if(confirm(mail+"의 예약 확정 메일을 전송하시겠습니까?")==true) {
			// 메일 보내기
		};
	})
	/* 취소 */
	$('#res_cancel').click(function() {
		if(confirm(mail+"의 예약 취소 메일을 전송하시겠습니까?")==true) {
			// 메일 보내기
		};
	})
	
	/* confirm에서 확인을 누르면 메일전송, 상태변경, 모달창 닫기 */
	</script>

</body>
</html>