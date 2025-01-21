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

    <title>공지사항 관리</title>

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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >공지사항 관리</h1>
                    

                    <!-- DataTales Example -->
                    <div class="card mb-4">
                        <div class="card-header py-3">
                            <div class="m-0 haru-search-box">
	                            <div class="haru-left">
	                            	<select>
<!-- 	                            		<option value="all">전체</option> -->
	                            		<option value="name">제목</option>
	                            	</select>
	                            	<div class="haru-tb-input-box">
	                            		<input class="tb-search-input" type="text" onkeypress="if (event.key === 'Enter') search_word(event)"
	                            				value="${search1 }">                            	
	                            	</div>                            
	                            </div>
	                            
	                            <!-- 이거 필요없으면 걍 지우면 됩니다!! -->
	                            <div class="haru-right">
	                            	<select class="haru-show-select" name="isshow">
	                            		<option value="0" ${search2 == '0' ? 'selected': '' }>전체</option>
	                            		<c:forEach var="ps" items="${statusList }">
	                            			<option value="${ps.MCD }" ${search2 == ps.MCD ? 'selected': '' }>${ps.CONTENT }</option>
	                            		</c:forEach>
	                            	</select>
	                           		<button class="btn-primary haru-tb-btn shadow-none pro_reg" id="modal_open_btn" onclick="location.href='/admin/upload-notice'">공지사항 작성</button>                           	                         
	                            </div>
	                            <!-- 이거 필요없으면 걍 지우면 됩니다!! -->
                            
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
		                        	<colgroup>
								        <col width="10%" />
								        <col width="30%" />
								        <col width="20%" />
								        <col width="20%" />
								        <col width="10%" />
								        <col width="10%" />
								    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>제목</th>
                                            <th>작성자</th>
                                            <th>작성일</th>
                                            <th>조회수</th>
                                            <th>상태</th>
                                        </tr>
                                    </thead>
                                    <tbody class="haru-product-tbody">
                                    	<c:if test="${pagination.totalCnt > 0}">
                                    		<c:forEach var="notice" items="${nList }" varStatus="status">
                                    			<c:choose>
                                    				<c:when test="${notice.isvisible }">
                                    					<tr class="haru-table-click" onclick="goDetail(${notice.nno})" style="background: #f2f2f2; color: #919191">  
                                    				</c:when>
                                    				<c:otherwise>
                                    					<tr class="haru-table-click" onclick="goDetail(${notice.nno})">  
                                    				</c:otherwise>
                                    			</c:choose>
													<td>${notice.nno }</td>
													<td style="position: relative">
														<c:if test="${notice.istop }">
                                    					<i class="fa-solid fa-thumbtack" style="color: red; position: absolute; left: 1rem; top: 1rem"></i>
                                    					</c:if>
                                    					${notice.ntitle }
                                    				</td>
													<td>${notice.aname }</td>
													<td><fmt:formatDate value="${notice.reg_date }" pattern="yyyy-MM-dd"/></td>
													<td>${notice.nview_count }</td>
													<td>${notice.status }</td>
		                                        </tr>
                                    		</c:forEach>
                                        </c:if>
                                        <c:if test="${pagination.totalCnt == 0}">
                                        	데이터가 없습니다.
                                        </c:if>
                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>

						<div class="haru-pagination">
							<c:if test="${pagination.startPage > pagination.blockSize }">
								<i class="haru-pagearrow fa-solid fa-chevron-left" 
									onclick="location.href='/admin/notice?pageNum=${pagination.startPage-pagination.blockSize}'">
								</i>
							</c:if>
							
							<c:forEach var="i" begin="${pagination.startPage }" end="${pagination.endPage }">
								<div class="haru-pagenum" id="pageNum${i}" onclick="location.href='/admin/notice?pageNum=${i}'">${i }</div>
							</c:forEach>
							
							<c:if test="${pagination.endPage < pagination.pageCnt }">
								<i class="haru-pagearrow fa-solid fa-chevron-right" 
									onclick="location.href='/admin/notice?pageNum=${pagination.startPage+pagination.blockSize}'">
								</i>
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
    
    <script>
    	const contextPath = "<%=request.getContextPath()%>";
    	
    	$(()=>{
    		$('#pageNum${pagination.currentPage}.haru-pagenum').addClass('active');
    	})
    	
    	/**
    	 * 상세 페이지 이동
    	 */
    	function goDetail(nno) {
    		location.href="/admin/details-notice?nno="+nno;
    	}
    	
    	
    	
		let search1 = null; //제목 검색
		let search2 = null; //노출 검색
		
    	/**
    	 * 검색
    	 */
    	function search_word(e) {
    		
    		if (e.key === "Enter") {
    			search1 = $(".tb-search-input").val(); // 입력된 검색어
    			search2 = $(".haru-show-select").val(); // 선택된 필터

//     	        console.log('검색: ', search1, " 선택: ", search2);
    	        location.href = '/admin/notice?search1='+search1+'&search2='+search2;
    	    }
    	}
		
    	/**
    	 * 드롭다운 값 변경됐을 때 동작
    	 */
    	 $('.haru-show-select').change(function() {
   		    search1 = $(".tb-search-input").val(); // 입력된 검색어
 		    search2 = $(this).val(); // 선택된 필터
   		    
//  			console.log('검색: ', search1, " 선택: ", search2);
 			location.href = '/admin/notice?search1='+search1+'&search2='+search2;
 		});
    	
    </script>

</body>
</html>