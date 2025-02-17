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

    <title>관리자 수정</title>

</head>

<!-- style -->
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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >관리자 관리</h1>
                    
                    <div class="modal_l_detail">
                    <form action="/admin/updateAdmin" method="post" name="frm" id="upd_ad" onsubmit="return validateForm()">
				        <input type="hidden" name="ano" value="${admin.ano }">
				        <table class="inputTable">
				        	<colgroup>
		                    	<col width="15%" />
		                        <col width="35%" />
		                        <col width="15%" />
		                        <col width="35%" />
		                    </colgroup>
				        	<tr>
				        		<td class="form-input-title">사번</td>				<td>${admin.ano }</td>
				        		<td class="form-input-title">입사일</td>				<td><fmt:formatDate value="${admin.hiredate }" pattern="yyyy-MM-dd"/></td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">이름<em>*</em></td>		<td><input class="form-input" type="text" name="aname" required="required" value="${admin.aname}"></td>
				        		<td class="form-input-title">등록일</td>	<td><fmt:formatDate value="${admin.reg_date }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">전화번호<em>*</em></td>	<td><input class="form-input" type="text" name="atel" required="required" value="${admin.atel}"></td>
				        		<td class="form-input-title">현재 비밀번호<em>*</em></td><td><input class="form-input" type="password" name="apasswd" required="required" placeholder="수정하려면 비밀번호를 입력하세요"></td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">Role</td>
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
				        		<td class="form-input-title">비밀번호재설정</td><td><input class="form-input" type="password" name="re_apasswd" placeholder="변경할 비밀번호를 입력하세요."></td>
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
				        		<td class="form-input-title">비밀번호확인</td><td><input class="form-input" type="password" name="re_apasswd2" placeholder="변경할 비밀번호를 재입력하세요."></td>
				        	</tr>
				        </table>
	       			 </form>
	       			 </div>
					<!-- 모달 버튼 -->
			       	<div class="modal_l-content-btn">
				       	<button type="button" class="to_list" id="detail_close_btn" onclick="location.href='/admin/doctor'">목록으로</button>
			            <button type="submit" class="admin_modal update_btn" id="update_btn" form="upd_ad">수정하기</button>
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
	
	function validateForm() {
		let result = true;
		
		let pw 	  = $('.form-input[name=apasswd]').val(); //현재비밀번호
		let re_pw = $('.form-input[name=re_apasswd]').val(); //변경할 비밀번호
		let re_pw2 = $('.form-input[name=re_apasswd2]').val(); //변경할 비밀번호 재입력
		let tel   = $('.form-input[name=atel]').val();
		
		console.log('tel ',tel)
		
		let str = "";
		console.log('dd ', isEmpty(re_pw))
		if(isEmpty(re_pw) && (re_pw != re_pw2)) {
			str+='비밀번호가 일치하지 않습니다.\n';
			result = false;
		}
		if(isEmpty(re_pw) && !checkRegex(re_pw, '^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,}$')) {
	    	str+='비밀번호는 영문, 숫자, 특수문자를 최소 1개씩 조합하여 8자 이상\n'; //비밀번호 체크
	        result = false;
	 	}
	
	  	if(!checkRegex(tel, '^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$')) {
		  	str+='잘못된 핸드폰번호 입니다.\n';
	     	result = false;
	  	}
	  	
	  	if(!result)
	   	  	alert(str);
		
		return result;
	}

</script>
</body>
</html>