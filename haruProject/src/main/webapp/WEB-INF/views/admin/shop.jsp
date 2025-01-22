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

    <title>판매 관리</title>

</head>

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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >상품 관리</h1>
                    

                    <!-- DataTales Example -->
                    <div class="card mb-4">
                        <div class="card-header py-3">
                            <div class="m-0 haru-search-box">
	                            <div class="haru-left">
	                            	<select class="haru-tb-type-box" >
	                            		<option value="1"  ${search.type5 == 1 ? 'selected' : ''}>주문번호</option>
	                            		<option value="2"  ${search.type5 == 2 ? 'selected' : ''}>이름</option>
	                            		<option value="3"  ${search.type5 == 3 ? 'selected' : ''}>상품명</option>
	                            	</select>
									<!-- 검색창 -->
	                            	<div class="haru-tb-input-box">
	                            		<input class="tb-search-input" type="text">                            	
	                            	</div>                            
	                            </div>
	                            
	                            <div class="haru-right">
	                            	<select>
	                            		<option value="1">전체</option>
	                            		<option value="2">주문 완료</option>
	                            		<option value="3">픽업 준비 완료</option>
	                            		<option value="4">픽업 완료</option>
	                            		<option value="5">취소</option>
	                            	</select>
	                            </div>
                            
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>주문번호</th>
                                            <th>주문자</th>
                                            <th>주문 상품</th>
                                            <th>구매일</th>
                                            <th>결제 방법</th>
                                            <th>최근 상태 변경 시간</th>
                                            <th>상태</th>
                                        </tr>
                                    </thead>
                                    <tbody class="saleTable">
                                    	<c:forEach var="sale" items="${sales}">
                                    		<tr>
                                    			<td>${sale.orderno }</td>
                                    			<td>${sale.mname }</td>
                                    			<td>${sale.pname }</td>
                                    			<td><fmt:formatDate value="${sale.odate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    			<td>${sale.opayment_content }</td>
                                    			<td><fmt:formatDate value="${sale.update_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    			<td>${sale.ostatus_content }</td>
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
    
  

</body>
</html>