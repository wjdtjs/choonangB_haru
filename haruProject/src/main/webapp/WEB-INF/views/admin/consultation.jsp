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

    <title>진료 관리</title>

</head>

<style>

/* 차트 상세 */
#chart_modal_open_btn {
	background-color: #A6D6C6;
	border-radius: 24px;
	border: white;
	height: 29px;
	margin: 0;
	padding: 14px 12px;
	text-align: center;
	font-size: 16px;
	line-height: 0px;
}

/* 차트 작성 */
#chart_add_modal_open_btn {
	border: 1px solid #A6D6C6;
	border-radius: 24px;
	background-color: white;
	height: 29px;
	margin: 0;
	padding: 14px 12px;
	text-align: center;
	font-size: 16px;
	line-height: 0px;
}
</style>

<script type="text/javascript">

//드롭박스 값 변경됐을 때 동작
function search_type(selectElement) {
	const searchInput = document.querySelector(".haru-status-select");
	
	if (!selectElement) {
        console.error("드롭다운 요소를 찾을 수 없습니다.");
        return;
    }
	
	type4 = selectElement.value; // 선택된 필터
    console.log('search_type 실행 -> type4: '+type4);
    alert('search_type 실행 -> type4: '+type4);
    location.href = '/admin/consultation?type4='+type4;
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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >진료 관리</h1>
                    

                    <!-- DataTales Example -->
                    <div class="card mb-4">
                        <div class="card-header py-3">
                            <div class="m-0 haru-search-box">
	                            <div class="haru-left">
									<!-- 검색창 -->
	                            	<div class="haru-tb-input-box">
	                            		<input class="tb-search-input" type="text">
	                            		<!-- 날짜 선택해서 검색할 수 있는 달력 추가해주기 -->                    	
	                            	</div>                            
	                            </div>
	                            
	                            <div class="haru-right">
	                            	<select name="type4" class="haru-search-select" onchange="console.log('onchange 실행됨'); search_type(this)" >
		                            		<option value="0" 	 ${type4 == '0'   ? 'selected' : ''}>전체</option>
		                            		<option value="100"  ${type4 == '100' ? 'selected' : ''}>차트 O</option>
		                            		<option value="200"  ${type4 == '200' ? 'selected' : ''}>차트 X</option>
		                            </select>
	                            </div>
	                       
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>진료 일시</th>
                                            <th>보호자</th>
                                            <th>동물 정보</th>
                                            <th>주치의</th>
                                            <th>진료과목</th>
                                            <th>차트</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="consultation" items="${cList }">
                                    		<tr onclick="goToDetail('${consultation.resno}')" style="cursor: pointer;">
	                                    		<td>${consultation.resno } </td>
	                                    		<td><fmt:formatDate value="${consultation.rdate}" pattern="yyyy-MM-dd"/></td>
	                                    		<td>${consultation.mname } </td>
	                                   		    <td>${consultation.petname }&nbsp;/&nbsp;${consultation.species } </td>
	                                      		<td>${consultation.aname } </td>
	                                    		<td>${consultation.item } </td>
	                                    		<td>
	                                    			<!-- 차트작성, 차트상세 controller에 따라서 onclick 경로에 빈 부분 채워서 사용하시면 됩니닷~!!~! -->
	                                    			<c:choose>
	                                    				<c:when test="${consultation.cresno eq consultation.resno }">
	                                    					<button type="button" class="chart_btn con_modal" id="chart_modal_open_btn" onclick="location.href='/admin/detailConsultation?resno=${consultation.resno}'">차트상세</button>
	                                    				</c:when>
	                                    				<c:when test="${consultation.cresno ne consultation.resno }">
	                                    					<button type="button" class="chart_btn con_modal" id="chart_add_modal_open_btn" onclick="location.href='/admin/addConsultation?resno=${consultation.resno}'">차트작성</button>
	                                    				</c:when>
	                                    			</c:choose>
	                                    		</td>
                                    		</tr>
                                    	</c:forEach>                                      
                                    </tbody>
                                </table>
                            </div>
                        </div>
						
						<div class="haru-pagination">
							    <!-- 이전 블록 이동 -->
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

	<!-- 차트 상세 모달 -->
	<jsp:include page="consultation_modal.jsp"></jsp:include>
	
	
</body>
</html>