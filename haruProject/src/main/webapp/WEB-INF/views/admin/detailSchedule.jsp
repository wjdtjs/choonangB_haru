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
    
    <title>근무 관리</title>

</head>
<style>

.inputTable{
	color: black;
	width: 100%;
}
.form-input-title {
	height: 50px;
	font-weight: 500;
	margin:4px 12px;

}

.inputTable tr {
	height: 50px;

}

td > button {
	border-radius: 10px;
	border: none;
	height: 35px;
	font-size: 14px;
}
.verifi_btn.id_dupl:disabled {
	background: #d9d9d9;
}

.form-input{
	width: 90%;
	height: 35px;
	line-height: 35px;
	border: 1.5px solid var(--haru);
	border-radius: 10px;
	padding-left: 10px;
}

.delete_btn {
	background-color: #A6D6C6;
	margin-right: 15px;
}
</style>

<body id="page-top"> 

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
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold">일정 상세</h1>
                    <div class="modal_l_detail">
                    <form action="/admin/addSchedule" method="post" name="frm" id="add_schedule" >
				       <input type="hidden" value="${schedule.schno }">
				       <table class="inputTable">
			        	<colgroup>
			        		<col width="15%">
			        		<col width="35%">
			        		<col width="15%">
			        		<col width="35%">
			        	</colgroup>
				        <tr>
				        	<th>구분<em>*</em></th>		<td><div class=" sub-schetype-mcd-select" >
				        											${schedule.sch_content }
				        										</div></td>
				        	<th>휴무날짜<em>*</em></th>	<td><input class="form-input" type="date" name="schdate" required="required" 
				        										value="<fmt:formatDate value='${schedule.schdate}' pattern='yyyy-MM-dd' />"></td>
				        
				        </tr>
				        <c:if test="${schedule.aname != null}">
					        <tr>
					        	<th class="add-input-aname">의사이름<em>*</em></th>
					        	<td class="add-input-aname">
					        		<div class="search-aname-input">
					        		${schedule.aname }
					        		</div>
					        		
					        	</td>
					        	<th></th>
					        	<td></td>
					        </tr>
				        </c:if>
	                    
				        <tr>
				        	<th>등록일</th>
				        	<td><fmt:formatDate value="${schedule.reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				        	<th>수정일</th>
				        	<td><fmt:formatDate value="${schedule.reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				        </tr>
	                    			        
				      
			        

			        </table>
	       			 </form>
	       			 </div>
	       			 <!-- 모달 버튼 -->
			       	<div class="modal_l-content-btn">
				       	<button type="button" class="to_list" id="detail_close_btn" onclick="history.back()">목록으로</button>
			            <button type="button" class="delete_btn" id="delete_btn">삭제하기</button>
			            <button type="button" class="update_btn" id="update_btn">수정하기</button>
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
<script type="text/javascript">
/* 일정삭제 */
 $(document).on('click','.delete_btn', function(){
	 if(confirm("일정을 삭제하시겠습니까?")){
		 const schno = '${schedule.schno}';
		 
		 location.href = "/admin/deleteSchedule?schno="+schno;
	 }
 })
 /* 일정수정 */
 $(document).on('click','.update_btn',function(){
	 if(confirm("일정을 수정하시겠습니까?")){
		 const schno = '${schedule.schno}';
		 var sendData = $('form').serialize();
		 sendData = sendData +('&schno='+schno);
         // alert('sendData : ' + sendData);
		 
		 location.href = "/admin/updateSchedule?"+sendData;
	 }
 })
 
 
</script>
</html>