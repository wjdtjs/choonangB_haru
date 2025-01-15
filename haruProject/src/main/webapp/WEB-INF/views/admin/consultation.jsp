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
	
	$(async () => {
		// 첫 페이지 로드
		await listShow('1');
		
		// 리스트 필터
		
		// 검색
		
		
		
	})
	
	
	
	// 리스트
	async function listShow(pageNum) {
		$.ajax({
			url: "<%=request.getContextPath()%>/api/consultation-list",
			data: {
				pageNum: pageNum,
				block:'10'
			},
			dataType: 'json',
			success: function(data) {
				let pagination = data.pagination;
				
				let str = "";		// 테이블 저장
				let str2 = "";		// 페이지네이션 저장
				
				// 테이블 데이터
				$(data.list).each(function() {
					str += `
							<tr>
								<td style="">\${this.resno}</td>
								<td>\${this.rdate.split('T')[0]}  \${this.start_time.slice(0, -2)}:\${this.start_time.slice(-2)}</td>
								<td>\${this.mname}</td>
								<td>\${this.petname} / \${this.species}</td>
								<td>\${this.aname}</td>
								<td>\${this.item}</td>
							`
					console.log(this.cresno, this.resno);
					if (this.cresno === this.resno) {
						str += `<td><button type="button" class="chart_btn con_modal" id="chart_modal_open_btn">차트상세</button></td>`
					} else {
						str += `<td><button type="button" class="chart_btn con_modal" id="chart_add_modal_open_btn">차트작성</button></td>`
					}
							
					str += `</tr>`					
				})
				
				// tbody에 str 넣어주기
				$('#dataTable tbody').html(str);
				
				// 페이지네이션
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
		});
	}
	
	// 페이지 교체
	async function pageChange(num) {
		let id = '#pageNum' + num;
		
		await listShow(num);
		
		$('.haru-pagenum').removeClass('active');
		$('id').addClass('active');
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
									<button class="btn-primary haru-tb-btn con_modal" id="modal_open_btn">진료 내역 추가</button>
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
                                        <tr>
                                            <td>Tiger Nixon</td>
                                            <td>System Architect</td>
                                            <td>Edinburgh</td>
                                            <td>61</td>
                                            <td>2011/04/25</td>
                                            <td>$320,800</td>
                                            <td><button type="button" class="chart_btn con_modal" id="chart_modal_open_btn">차트상세</button></td>
                                        </tr>
                                        
                                        
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

	<!-- 차트 상세 모달 -->
	<jsp:include page="consultation_modal.jsp"></jsp:include>
	
	
</body>
</html>