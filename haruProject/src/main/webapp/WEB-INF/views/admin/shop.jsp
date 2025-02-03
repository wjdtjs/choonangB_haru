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
<script type="text/javascript">
	// detail페이지로 이동
	$(document).on('click','#dataTable .saleTable tr',function(){
		const orderno = $(this).find('td:nth-child(1)').text();
		console.log('클릭된 행의 orderno:' + orderno);
		
		window.location.href = `<%=request.getContextPath()%>/admin/detailShop?orderno=\${orderno}`;
	});
	
	// 필터
	$(document).on('change','.haru-show-select',function(){
		const type4 = $(this).val();
		const type5 = $('.haru-tb-type-box').val();
		const search1 = $('.tb-search-input').val();
		location.href = '/admin/shop?type4='+type4+'&type5='+type5+'&search1='+search1;
	});
	
	//검색
	$(document).on('keyup','.tb-search-input',function(){
		if (window.event.keyCode == 13) {
			const type4 = $('.haru-show-select').val();
			const type5 = $('.haru-tb-type-box').val();
			const search1 = $('.tb-search-input').val();
			location.href = '/admin/shop?type4='+type4+'&type5='+type5+'&search1='+search1;
		}
	})
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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >판매 관리</h1>
                    

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
	                            		<input class="tb-search-input" type="text" value="${search.search1 }">                            	
	                            	</div>                            
	                            </div>
	                            
	                            <div class="haru-right">
	                            	<select class="haru-show-select">
		                            		<option value="0">전체</option>
	                            		<c:forEach var="status" items="${ostatus}">
	                            			<c:choose>
	                            				<c:when test="${status.mcd == search.type4}">
	                            					<option value="${status.mcd }" selected>${status.content }</option>
	                            				</c:when>
	                            				<c:otherwise>
				                            		<option value="${status.mcd }">${status.content }</option>
	                            				</c:otherwise>
	                            			</c:choose>
	                            		</c:forEach>
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
                                    			<td>${sale.pname1 }</td>
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
                   		<div class="haru-pagination">
							<c:if test="${pagination.startPage > pagination.blockSize}">
								<i class="haru-pagearrow fa-solid fa-chevron-left" 
							           onclick="location.href='?pageNum=${pagination.startPage - pagination.blockSize}'"></i>
							</c:if>
							
							<!-- 페이지 번호 출력 -->
							<c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
							    <div class="haru-pagenum ${i == pagination.currentPage ? 'active' : ''}" 
							         onclick="location.href='?pageNum=${i}&type4=${search.type4 }&search1=${search.search1 }&type5=${search.type5 }'">
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