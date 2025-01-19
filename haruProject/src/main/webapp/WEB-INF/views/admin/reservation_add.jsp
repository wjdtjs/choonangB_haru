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

    <title>예약 추가</title>
</head>

<style>
.modal_ p {
	color: black;
	padding: 12px 24px;
	font-size: 18px;
	font-weight: bold;
	margin: 0;
}

/* 제목 제외 컨텐츠 */
#hr-res {
	display: flex;
}

/* 달력 */
#hr-res-left {
	width:400px;
	height: 100%;
	margin: 0;
	padding: 0;
}


/* 내용 */

#hr-res-right {
	display: flex;
	flex-direction: column;
}

.hr-table-res-modal {
	border: none;
	color: black;
	margin: 20px;
}
.hr-table-res-modal #hr-table-res-modal-data th {
	font-weight: bold;
	color: black;
	padding: 4px 12px;
}
.hr-table-res-modal #hr-table-res-modal-data td {
	color: black;
}
.hr-table-res-modal #hr-table-res-modal-data tr {
	margin: 4px
}


.hr-res-table {
	margin: 16px 20px;
}

#hr-res-table-data {
	border-radius: 24px;
	background-color: rgba(12, 128, 141, 0.1);
	font-size: 20px;
	text-align: center;
	color: black;
	font-weight: bold; 
	margin: 20px autos;
}

#hr-res-table-data td {
	padding: 12px;
}
	
#hr-table-empty {
	padding: 8px;
}

#hr-res-memo {
	margin: 0 24px;
}

#hr-res-memo textarea {
	border-radius: 24px;
	background-color: rgba(12, 128, 141, 0.1);
	padding: 16px;
	border: white;
}

#hr-table-res-modal-data select {
	border: 1px solid #0C808D;
	border-radius: 12px;
	color: black;
	font-size: 14px;
	width: 136px;
	height: 28px;
	padding: 2px 0px 2px 12px;
	margin: 0 12px;
}

#res_input {
	width: 136px;
	height: 28px;
	margin: 4px 12px;
	border: 1px solid var(--haru);
	border-radius: 12px;
	padding: 0 12px;
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
                	
                	<!-- Page Heading -->
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >예약 추가</h1>
                    
					<!-- 모달 내용 -->       
			        <div class="modal_l"> 
			        	<!-- 제목을 제외한 컨텐츠 -->
			        	<div id="hr-res"> 
			        	
				        	<div id="hr-res-left">
				        		<p>예약 날짜</p>
				        		<div id="res-calendar"></div>
				        	</div>
				        	
				        	<div id="hr-res-right">
				        		<div class="hr-table-res-modal">
						        	<table id="hr-table-res-modal-data">
						        			<tr>
						        				<th>예약 항목</th>
						        				<td>
						        					<div>
								                       	<select id="res-content">
								                    		<option value="1">일반 진료</option>
															<option value="2">접종</option>
															<option value="3">수술</option>
															<option value="4">건강검진</option>
								                    	</select>
								                    </div>
						        				</td>			        						        								        				
						        			</tr>
						        			<tr>
						        				<th><div id="hr-table-empty"></div></th>
						        			</tr>
						        			<tr>
						        				<th>세부 항목</th>
						        				<td>
						        					<div>
								                       	<select id="res-detail">
								                    		<option value="1">내과</option>
															<option value="2">치과</option>
															<option value="3">정형외과</option>
															<option value="4">이비인후과</option>
								                    	</select>
								                    </div>
						        				</td>
						        			</tr>
						        			<tr>
						        				<th><div id="hr-table-empty"></div></th>
						        			</tr>
						        			<tr>
						        				<th>담당의</th>
						        				<td>
						        					<div>
								                       	<select id="res-doc">
								                    		<option value="1">이제노 선생님</option>
															<option value="2">박원빈 선생님</option>
								                    	</select>
								                    </div>
						        				</td>
						        			</tr>				        			
						        			<tr>
						        				<th><div id="hr-table-empty"></div></th>
						        			</tr>
						        			<tr>
						        				<th><div id="hr-table-empty"></div></th>
						        			</tr>
						        			
						        			<tr>
						        				<th>보호자</th>
						        				<td><input type="text" name="mname" id="res_input"></td>
						        			</tr>
						        			
						        			<tr>
						        				<th>동물이름</th>
						        				<!-- 보호자 이름에 해당하는 동물 불러와서 선택할 수 있게 -->
						        				<td><select></select></td>
						        			</tr>
						
						
						
						        	</table>
						        </div>
						        
				        <p>예약 메모</p>
				        <div id="hr-res-memo">
				        	<textarea rows="10" cols="70" placeholder="예약 메모를 입력해주세요."></textarea>
				        </div>
	        		
		        	</div>
		        
	        	</div>
	        	
	        
		        
	        </div>
			        <!-- 모달 버튼 -->
			        <div class="modal_l-content-btn">
			        	<button type="button" id="modal_close_btn" class="to_list res_modal" onclick="location.href='/admin/reservation'">목록으로</button>
			        	<button type="submit" class="update_btn" form="pro-update-form">예약추가</button>
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