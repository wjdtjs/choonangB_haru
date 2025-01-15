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

    <title>관리자 관리</title>

</head>

<script type="text/javascript">

	$(()=>{
		$('#pageNum1').addClass('active');
	})
	
	/**
	 * 페이지 교체
	 * @param num 
	 * @return 
	*/
	function pageChange(num) {
		let id = '#pageNum' + num;
		
		$('.haru-pagenum').removeClass('active');
		$(id).addClass('active');
		
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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >관리자 관리</h1>
                    

                    <!-- DataTales Example -->
                    <div class="card mb-4">
                        <div class="card-header py-3">
                            <div class="m-0 haru-search-box">
	                            <div class="haru-left">
	                            	<select name="searchAdmin">
	                            		<option value="s_all">전체</option>
	                            		<option value="s_aname">이름</option>
	                            	</select>
	                            	<div class="haru-tb-input-box">
	                            		<input class="tb-search-input" type="text" name="keyword">                            	
	                            	</div>                            
	                            </div>
	                            <div class="haru-right">
	                           		<button class="btn-primary haru-tb-btn" id="modal_open_btn">관리자 추가</button>
	                           	</div>                           	                         
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                            	<c:set var="num" value="${page.total-page.start+1 }"></c:set>
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>사번</th>
                                            <th>이름</th>
                                            <th>이메일</th>
                                            <th>ROLE</th>
                                            <th>입사일</th>
                                            <th>상태</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="admin" items="${listAdmin }">
	                                        <tr>
	                                            <td>${admin.ano }</td>
	                                            <td>${admin.aname  }</td>
	                                            <td>${admin.aemail }</td>
	                                            <td>${admin.alevel }</td>
	                                            <td>${admin.hiredate }</td>
	                                            <td>${admin.astatus }</td>
	                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                   		<%-- <div style="text-align: center;">
							<c:if test="${startPage > blockSize }">
								<a href='list.do?pageNum=${startPage - blockSize }'>[이전]</a>
							</c:if>
							<c:forEach var="i" begin="${startPage }" end="${endPage }">
								<a href='list.do?pageNum=${i }'>[${i }]</a>
							</c:forEach>
							<c:if test="${endPage < pageCnt }">
								<a href='list.do?pageNum=${startPage + blockSize }'>[다음]</a>
							</c:if>
						</div> --%>
						<div class="haru-pagination">
<%-- 							<c:if test="${startPage > blockSize }"> --%>
								<i class="haru-pagearrow fa-solid fa-chevron-left"></i>
<%-- 							</c:if> --%>
							<c:forEach var="i" begin="1" end="8">
								<div class="haru-pagenum" id="pageNum${i}" onclick="pageChange(${i})">${i }</div>
							</c:forEach>
<%-- 							<c:if test="${endPage < pageCnt }"> --%>
								<i class="haru-pagearrow fa-solid fa-chevron-right"></i>
<%-- 							</c:if> --%>
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
    
    <jsp:include page="modalAddAdmin.jsp"></jsp:include>

</body>
</html>