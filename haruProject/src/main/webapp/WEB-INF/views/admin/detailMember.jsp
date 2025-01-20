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

    <title>회원 정보</title>

</head>

<!-- style -->
<style>

.inputTable {
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

.myPetTitle{
	display: flex;
	margin-bottom: 5px
}

.myPetTitle > h5{
	color: black;
}
.myPetTitle > button{
	border-radius: 10px;
	border: none;
	margin-left: auto;
	width: 90px;

}

.myPetTable{
	width: 100%;
	color: black;
	text-align: center;
	border: 1px solid #ccc;
	border-collapse : collapse;
}

.myPetTable .infoTitle {
	height:20px;
	line-height:20px;
	background-color: #d0e4e8;
}
.myPetTable th {
	border: 1px solid #ccc;
}
.myPetTable td {
	border: 1px solid #ccc;
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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >회원 관리</h1>
                    
                    <div class="modal_l_detail">
                    <form action="/admin/updateMember" method="post" name="frm" id="upd_mb">
				        <table class="inputTable">
				        <input type="hidden" name="ano" value="${member.memno }">
				        	<colgroup>
		                    	<col width="15%" />
		                        <col width="35%" />
		                        <col width="15%" />
		                        <col width="35%" />
		                    </colgroup>
				        	<tr>
				        		<td class="form-input-title">회원번호</td>		<td>${member.memno }</td>
				        		<td class="form-input-title">ID</td>		<td>${member.mid }</td>
				        	<tr>
				        		<td class="form-input-title">이름</td>		<td>${member.mname }</td>
				        		<td class="form-input-title">전화번호</td>		<td>${member.mtel }</td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">등록일</td>		<td><fmt:formatDate value="${member.reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				        		<td class="form-input-title">이메일</td>		<td>${member.memail}</td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">수정일</td>		<td><fmt:formatDate value="${member.update_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				        		<td class="form-input-title">개인정보동의여부</td><td>${member.is_agree}</td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">상태</td>		<td>${member.mstatis_content }</td>
				        		<td class="form-input-title">개인정보동의일</td>	<td><fmt:formatDate value="${member.agree_date }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				        	</tr>
				        </table>
					    <table class="myPetTable">
					    	<div class="myPetTitle">
					    		<h5>동물정보</h5>
					    		<button class="btn-primary haru-tb-btn admin_modal" id="modal_open_btn" onclick="/admin/addPet">동물추가</button>
					    	</div>   
				        	<tr class="infoTitle">	
				        		<th>동물번호</th>
				        		<th>이름</th>
				        		<th>생년월일</th>
				        		<th>분류</th>
				        		<th>종</th>
				        		<th>성별</th>
				        		<th>상태</th>
					        </tr>
					        <tr class="contents">
					        	<c:forEach var="pet" items="${myPets }">
						        	<td class="content">${pet.petno }</td>
						        	<td class="content">${pet.petname }</td>
						        	<td class="content">${pet.petbirth }</td>
						       		<td class="content">${pet.species1 }</td>
						       		<td class="content">${pet.species2 }</td>
						       		<td class="content">${pet.gender }</td>
						       		<td class="content">${pet.status }</td>
					       		</c:forEach>
					       	</tr>
					      		
					        </table>
	       			 </form>
	       			 </div>
					<!-- 모달 버튼 -->
			       	<div class="modal_l-content-btn">
				       	<button type="button" class="to_list" id="detail_close_btn" onclick="location.href='/admin/member'">목록으로</button>
			            <button type="submit" class="admin_modal update_btn" id="update_btn" form="upd_mb">수정하기</button>
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