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

<script type="text/javascript">// 비활동 회원 
	$(document).on('click','#dataTable .adminTable tr',function(){
		
		const ano = $(this).find('td:nth-child(1)').text();
		
		console.log('클릭된 행의 ano 값:',ano);
		
		window.location.href = `<%=request.getContextPath()%>/admin/detailAdmin?ano=\${ano}`;
	});

	let search1 = "";
	
	$(async ()=>{
		if(${result==0}) {
			alert('비밀번호가 일치하지 않아 관리자 수정이 실패했습니다.');
		}
		
		await listShow('1');
		
		//검색
		$('.tb-search-input').keyup(async function() {
// 			console.log($(this).val())
			search1 = $(this).val();
			await listShow('1', search1);
		})
		
	})
	
	/**
	 * 리스트 (ajax)
	*/
	async function listShow(pageNum, search1) {
		console.log(search1)
		
		$.ajax({
			url: "<%=request.getContextPath()%>/api/admin-list",
			data: {
				pageNum: pageNum,
				search1: search1
			},
			dataType: 'json',
			success: function(data) {
				
				console.log(data.list);
				
				let pagination = data.pagination;
				
				let str = "";
				let str2 = "";
				
				$(data.list).each (function(){
					str += `
							<tr class="haru-table-click">
		                        <td>\${this.ano}</a></td>
		                        <td>\${this.aname}</td>
		                        <td>\${this.aemail}</td>
		                        <td>\${this.level_content}</td>
		                        <td>\${this.hiredate.split('T')[0]}</td>
		                        <td>\${this.status_content}</td>
	                    	</tr>
					       `
				})
				$('.adminTable').html(str);
				
				if(pagination.startPage > pagination.blockSize) {
					str2 += `<i class="haru-pagearrow fa-solid fa-chevron-left" onclick="pageChange(\${pagination.startPage-pagination.blockSize})"></i>`;
				}
				for(let i=1; i<pagination.pageCnt+1; i++) {
					str2 += `<div class="haru-pagenum" id="pageNum\${i}" onclick="pageChange(\${i})">\${i }</div>`;
				} 
				if(pagination.endPage < pagination.pageCnt) {
					str2 += `<i class="haru-pagearrow fa-solid fa-chevron-right" onclick="pageChange(\${pagination.startPage+pagination.blockSize})"></i>`;
				}
				
				$('.haru-pagination').html(str2);
				
				$(`#pageNum\${pagination.currentPage}`).addClass('active');
				
			},
			error: function(e) {
				console.log(e);
			}
		})
	}
	
	/**
	 * 페이지 교체
	 * @param num 
	 * @return 
	*/
	async function pageChange(num) {
		let id = '#pageNum' + num;
		
		await listShow(num, search1);
		
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
	                            	<select>
	                            		<!-- <option value="all">전체</option> -->
	                            		<option value="name">이름</option>
	                            	</select>
	                            	<div class="haru-tb-input-box">
	                            		<input class="tb-search-input" type="text">                            	
	                            	</div>                            
	                            </div>
	                            <div class="haru-right">
	                            	<c:if test="${sessionScope.role eq 100 }">
		                           		<button class="btn-primary haru-tb-btn admin_modal" id="modal_open_btn">관리자 추가</button>                            	
	                            	</c:if>
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
                                    	<col width="10%" />
                                    	<col width="20%" />
                                    	<col width="10%" />
                                    </colgroup>
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
                                    <tbody class="adminTable">
                                        <%-- <c:forEach var="admin" items="${listAdmin }">
	                                        <tr>
	                                            <td>${admin.ano }</td>
	                                            <td>${admin.aname  }</td>
	                                            <td>${admin.aemail }</td>
	                                            <td>${admin.alevel }</td>
	                                            <td>${admin.hiredate }</td>
	                                            <td>${admin.astatus }</td>
	                                        </tr>
                                        </c:forEach> --%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
       
						<div class="haru-pagination">

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
   <%--  <jsp:include page="modalAdmin.jsp"></jsp:include> --%>

</body>
</html>