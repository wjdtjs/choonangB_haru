<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>예약 관리</title>

</head>

<script type="text/javascript">
	
	let search1 = null;

	$(async () => {
		// 첫 페이지 로드
		await listShow('1');
		
		// 리스트 필터
		$('.haru-status-select').change(async function() {
			search1 = $(this).val();
			if(search1 == "0"){
				search1 = null;
			}
			await listShow('1', search1);
		});
		
		// 검색
		$('.tb-search-input').keyup(async function() {
// 			console.log($(this).val())
			search1 = $(this).val();
			await listShow('1', search1);
		});
	})
		
		
	// 리스트
	async function listShow(pageNum, search1) {
		console.log(search1);
		
		$.ajax({
			url: "<%=request.getContextPath()%>/api/appointment-list",
			data: {
				pageNum: pageNum,
				block: '3',  // 한 페이지에 5개씩 보이게
				search1: search1
			},
			dataType: 'json',
			success: function(data) {
				let pagination = data.pagination;
				
				let str = ""; 		// 테이블 저장
				let str2 = "";		// 페이지네이션 저장
				
				// 테이블 데이터
				$(data.list).each(function () {
					str += `
						<tr class="haru-table-click">
							<td style="">\${this.resno}</td>
							<td>\${this.rdate.split('T')[0]}</td>
							<td>\${this.mname}</td>
							<td>\${this.petname}</td>
							<td>\${this.aname}</td>
							<td>\${this.item}</td>
							<td>\${this.status}</td>
						</tr>
						`
				})
				
				// tbody에 str 넣기
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
		
		await listShow(num, search1);
		
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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold">예약 관리</h1>
                    

                    <!-- DataTales Example -->
                    <div class="card mb-4">
                        <div class="card-header py-3">
                            <div class="m-0 haru-search-box">
	                            <div class="haru-left">
	                            	<div class="haru-tb-input-box">
	                            		<input class="tb-search-input" type="text">                            	
	                            	</div>                            
	                            </div>
								
								<!-- 리스트 필터 -->
	                            <div class="haru-right">
	                            	<select class="haru-status-select">
	                            		<option value="0">전체</option>
	                            		<option value="1">예약 대기</option>
	                            		<option value="2">예약 확정</option>
	                            		<option value="3">예약 취소</option>
	                            	</select>
	                           		<button class="btn-primary haru-tb-btn res_modal" id="modal_open_btn">예약 추가</button>                           	                         
	                            </div>
	                            <!-- 이거 필요없으면 걍 지우면 됩니다!! -->
                            
                            </div>
                        </div>
                        
                        <!-- 테이블 -->
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>예약 날짜</th>
                                            <th>보호자</th>
                                            <th>동물 정보</th>
                                            <th>주치의</th>
                                            <th>진료 과목</th>
                                            <th>상태</th>
                                        </tr>
                                    </thead>
                                    <tbody>
										<!-- <tr>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
										</tr>
										<tr>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
										</tr>
										<tr>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
										</tr>
										<tr>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
										</tr>
										<tr>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
		                                	<td>1</td>
										</tr> -->
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
    
    <!-- 팝업 모달 -->
    <jsp:include page="reservation_modal1.jsp"></jsp:include>
    <jsp:include page="reservation_modal.jsp"></jsp:include>

</body>
</html>