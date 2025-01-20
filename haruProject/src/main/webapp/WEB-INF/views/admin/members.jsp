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

    <title>회원 관리</title>

</head>
<script type="text/javascript">
	$(document).on('click','#dataTable .memTable tr',function(){
		const memno = $(this).find('td:nth-child(1)').text();
		
		console.log('클릭된 행의 memno: ', memno);
		
		window.location.href = `<%=request.getContextPath()%>/admin/detailMember?memno=\${memno}`;
	});
	
/* 	$('.haru-show-select').change(function() {
	    let value = $(this).val();
	    console.log('선택된 value: ', HJSelectAdminCommon)
		if(value == "0") {
			search2 = null;
		} else search2 = value;
		listShow(search1, search2);
	});  */
	
	$(document).on('change','.haru-show-select',function(){
		let value = $(this).val();
	    console.log('선택된 value: ', value)
		if(value == "0") {
			search2 = null;
		} else search2 = value;
		/* listShow(search1, search2); */
	})
	
	function enterkey() {
		
	}
	
	function listShow(search1,search2) {
		/* const search1 = search1;
		const search2 = search2; */
		
		window.location.href = `<%=request.getContextPath()%>/admin/member?search1=\${search1}&search2=\${search2}`;
		
	}
</script>

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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold">회원 관리</h1>
                    
                     <!-- DataTales -->
                    <div class="card mb-4">
                        <div class="card-header py-3">
                            <div class="m-0 haru-search-box">
	                            <div class="haru-left">
	                            	<select name="search1">
	                            		<!-- <option value="all">전체</option> -->
	                            		<option value="name">이름</option>
	                            		<option value="tel">전화번호</option>
	                            	</select>
	                            	<div class="haru-tb-input-box">
	                            		<input class="tb-search-input" type="text" onkeyup="enterkey()" name="keyword">                            	
	                            	</div>                            
	                            </div>
	                            <div class="haru-right">
	                            	<select class="haru-show-select" name="search2">
	                            		<c:forEach var="status" items="${mstatus}">
	                            			<option value="${status.mcd }">${status.content}</option>	                            		</c:forEach>
	                            	</select>
	                           		<button class="btn-primary haru-tb-btn admin_modal" id="modal_open_btn" onclick="location.href='/admin/addMember'">회원 추가</button>
	                           	</div>                           	                         
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <colgroup>
                                    	<col width="10%" />
                                    	<col width="20%" />
                                    	<col width="30%" />
                                    	<col width="30%" />

                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>회원번호</th>
                                            <th>이름</th>
                                            <th>전화번호</th>
                                            <th>이메일</th>
                                        </tr>
                                    </thead>
                                    <tbody class="memTable">
                                        <c:forEach var="member" items="${members }">
	                                        <tr>
	                                            <td>${member.memno }</td>
	                                            <td>${member.mname  }</td>
	                                            <td>${member.mtel }</td>
	                                            <td>${member.memail }</td>
	                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
       
						<div class="haru-pagination">
							<c:if test="${pagination.startPage > pagination.blockSize}">
								<i class="haru-pagearrow fa-solid fa-chevron-left" 
							           onclick="location.href='?pageNum=${pagination.startPage - pagination.blockSize}'"></i>
							</c:if>
							
							<!-- 페이지 번호 출력 -->
							<c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
							    <div class="haru-pagenum ${i == pagination.currentPage ? 'active' : ''}" 
							         onclick="location.href='?pageNum=${i}'">
							         ${i}
							    </div>
							</c:forEach>
							
							<!-- 다음 블록 이동 -->
							    <c:if test="${pagination.endPage < pagination.pageCnt}">
							        <i class="haru-pagearrow fa-solid fa-chevron-right" 
							           onclick="location.href='?pageNum=${pagination.startPage + pagination.blockSize}'"></i>
							    </c:if>
						</div>
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