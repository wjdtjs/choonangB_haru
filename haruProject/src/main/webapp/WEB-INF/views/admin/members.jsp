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
	// detailMember로 이동
	$(document).on('click','#dataTable .memTable tr',function(){
		const memno = $(this).find('td:nth-child(1)').text();
		console.log('클릭된 행의 memno: ', memno);
		
		window.location.href = `<%=request.getContextPath()%>/admin/detailMember?memno=\${memno}`;
	});
	
	// 비활동 회원 
	document.addEventListener("DOMContentLoaded",function(){
		const rows = document.querySelectorAll("#dataTable .memTable tr");
		
		rows.forEach((row) => {
			const statusCell = row.querySelector("td:nth-child(5)");
			if (statusCell && statusCell.textContent.trim() === "비활동") {
	            row.style.backgroundColor = "#f2f2f2"; // 원하는 배경색 설정
	        }
		})
	})
	
	
	// 필터
	$(document).on('change','.haru-show-select',function(){
		const type4 = $(this).val();
		const type5 = $('.haru-tb-type-box').val();
		const search1 = $('.tb-search-input').val();
	    location.href = '/admin/members?type4='+type4+'&type5='+type5+'&search1='+search1;
	    
	})
	
	// 검색
	$(document).on('keyup','.tb-search-input',function(){
		if (window.event.keyCode == 13){
			const type4 = $('.haru-show-select').val();
			const type5 = $('.haru-tb-type-box').val();
			const search1 = $('.tb-search-input').val();
			location.href = '/admin/members?type4='+type4+'&type5='+type5+'&search1='+search1;
		}
	})
	
	// 관리자 등록결과 alert
	 window.onload = function() {
         let message = "<c:out value='${message}' />";
         if (message) {
             alert(message);
         }
     };
	
</script>

<style>
select {
	background-position: 95% center;
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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold">회원 관리</h1>
                    
                     <!-- DataTales -->
                    <div class="card mb-4">
                        <div class="card-header py-3">
                            <div class="m-0 haru-search-box">
	                            <div class="haru-left">
	                            	<select class="haru-tb-type-box" >
	                            		<option value="1"  ${search.type5 == 1 ? 'selected' : ''}>이름</option>
	                            		<option value="2"  ${search.type5 == 2 ? 'selected' : ''}>전화번호</option>
	                            	</select>
	                            	<div class="haru-tb-input-box">
	                            		<input class="tb-search-input" type="text" value="${search.search1 }">                            	
	                            	</div>                            
	                            </div>
	                            <div class="haru-right">
	                            	<select class="haru-show-select">
	                            		<option value="0">전체</option>
	                            		<c:forEach var="status" items="${mstatus}">
	                            			<c:if test="${status.mcd == search.type4}">
		                            			<option value="${status.mcd }" selected>${status.content}</option>
	                            			</c:if>
	                            			<c:if test="${status.mcd != search.type4}">
	                            				<option value="${status.mcd }">${status.content}</option>
	                            			</c:if>
	                            		</c:forEach>
	                            	</select>
	                           		<button class="btn-primary haru-tb-btn admin_modal" id="modal_open_btn" onclick="location.href='/admin/addMember'">회원 추가</button>
	                           	</div>                           	                         
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="cursor: pointer;">
                                    <colgroup>
                                    	<col width="10%" />
                                    	<col width="20%" />
                                    	<col width="30%" />
                                    	<col width="20%" />
                                    	<col width="10%" />

                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>회원번호</th>
                                            <th>이름</th>
                                            <th>전화번호</th>
                                            <th>이메일</th>
                                            <th>상태</th>
                                        </tr>
                                    </thead>
                                    <tbody class="memTable">
                                        <c:forEach var="member" items="${members }">
	                                        <tr>
	                                            <td>${member.memno }</td>
	                                            <td>${member.mname  }</td>
	                                            <c:choose>
	                                            	<c:when test="${not empty member.mtel }">
			                                            <td class="phone-num">${member.mtel }</td>                                            	
	                                            	</c:when>
	                                            	<c:otherwise><td>-</td></c:otherwise>
	                                            </c:choose>
	                                            <td>${member.memail }</td>
	                                            <td>${member.mstatis_content }</td>
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

<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function () {
	    document.querySelectorAll(".phone-num").forEach(td => {
	        td.textContent = td.textContent.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
	    });
	});
</script>

</body>
</html>