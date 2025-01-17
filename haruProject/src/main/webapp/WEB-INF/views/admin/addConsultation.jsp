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

    <title>차트 등록</title>

</head>

<!-- style -->
<style>

.apmTable{
	color: black;
	width: 100%;
}
.apmTable tr{
	height: 40px;
}
.form-input-title {
	font-weight: 500;

}



.form-input{
	width: 90%;
	height: 35px;
	border: 1.5px solid var(--haru);
	border-radius: 10px;
	padding-left: 10px;
}
/* SELECT 버튼 위치 수정*/
select {
	background-position: 95% center;
}
em {
	color: red;
	justify-content: center;

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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >차트 작성</h1>
                    
                    <div class="modal_l_detail">
                    <form action="/admin/addChart" method="post" name="frm" id="upd_ad">
				        <input type="hidden" name="ano" value="${apm.resno}">
				        
				        <table class="apmTable">
				        	<colgroup>
		                    	<col width="8%" />
		                        <col width="3%" />
		                    </colgroup>
				        	<tr>
				        		<td class="form-input-title">예약번호</td> <td>:</td> <td>${apm.resno}</td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">진료일시</td> <td>:</td> <td><fmt:formatDate value="${apm.rdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">진료과목</td>	<td>:</td> <td>${apm.item}</td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">담당의</td>	<td>:</td> <td>${apm.aname}</td>
				        	</tr>
				        	<%-- <tr>
				        		<td class="form-input-title">전화번호<em>*</em></td>	<td><input class="form-input" type="text" name="atel" required="required" value="${admin.atel}"></td>
				        		<td class="form-input-title">이메일</td>				<td><input class="form-input" type="text" name="aemail" value="${admin.aemail}"></td>
				        	</tr>
				        	<tr>
				        		<td tclass="form-input-title">Role</td>
				        		<td>
				        			<select class="form-input sub-alevel-mcd-select" name="alevel_mcd">
						        		<c:forEach var="alevel" items="${common}">
							        		<c:choose>
				        						<c:when test="${alevel.BCD == admin.alevel_bcd && alevel.MCD == admin.alevel_mcd }">
							        				<option value="${alevel.MCD}" selected>${alevel.CONTENT}</option>
				        						</c:when>
				        						<c:when test="${alevel.BCD == admin.alevel_bcd && alevel.MCD != admin.alevel_mcd}">
						        					<option value="${alevel.MCD}">${alevel.CONTENT}</option>				        						
				        						</c:when>
				        					</c:choose>
				        				</c:forEach>
					        		</select>
				        		</td>
				        		<td class="form-input-title">입사일</td>				<td><fmt:formatDate value="${admin.hiredate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>

				        	</tr>
				        	<tr>
				        		<td class="form-input-title">상태</td>
				        		<td>
				        			<select class="form-input sub-status-mcd-select" name="astatus_mcd" >
				        				<c:forEach var="atatus" items="${common}">
				        					<c:choose>
				        						<c:when test="${atatus.BCD == admin.astatus_bcd && atatus.MCD == admin.astatus_mcd }">
							        				<option value="${atatus.MCD}" selected>${atatus.CONTENT}</option>
				        						</c:when>
				        						<c:when test="${atatus.BCD == admin.astatus_bcd}">
						        					<option value="${atatus.MCD}">${atatus.CONTENT}</option>				        						
				        						</c:when>
				        					</c:choose>
				        				</c:forEach>
				        			</select>
				        		</td>
				        		<td class="form-input-title">등록일</td>	<td><fmt:formatDate value="${admin.reg_date }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				        		
				        		
				        	</tr> --%>
				        </table>
				        <h5>동물정보</h5>
				        <table class="petInfo">
				        	<tr>
				        		<td>
				        	</tr>
				        </table>
	       			 </form>
	       			 </div>
					<!-- 모달 버튼 -->
			       	<div class="modal_l-content-btn">
				       	<button type="button" class="to_list" id="detail_close_btn" onclick="location.href='/admin/consultaion'">목록으로</button>
			            <button type="submit" class="admin_modal update_btn" id="update_btn" form="add_chart">등록하기</button>
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