
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

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">

		$(function() {
		    //input을 datepicker로 선언
		    $("#datepicker1, #datepicker2").datepicker({
		        dateFormat: 'yy-mm-dd' //달력 날짜 형태
		        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		        ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
		        ,changeYear: true //option값 년 선택 가능
		        ,changeMonth: true //option값  월 선택 가능                
		        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
		        ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
		        ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
		        ,buttonText: "선택" //버튼 호버 텍스트              
		        ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
		        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
		        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
		        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
		        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
		        ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		        ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
		    });                    
		    
		    //초기값을 오늘 날짜로 설정해줘야 합니다.
		    $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
		});





	
	let search1 = null;
	let search2 = null;
	let type1 = '1';

	$(() => {
		// 첫 페이지 로드
		listShow('1');
		
		// 리스트 필터
		$('.haru-status-select').change(function() {
			let value = $(this).val();
			if(value == "0"){
				search2 == null;
			} else search2 = value;
			listShow('1', search1, search2, type1);
		});
		
		// 검색
		$('.tb-search-input').keyup(async function() {
 			console.log($(this).val());
			search1 = $(this).val();
			listShow('1', search1, search2, type1);
		});
		
	  
	  $('.haru-search-select').change(function() {
			type1 = $(this).val();
			listShow('1', search1, search2, type1);
			console.log(type1);
		});
	})
		
		
	// 리스트
	function listShow(pageNum, search1, search2, type1) {
		console.log(search1, search2, type1);
		
		$.ajax({
			url: "<%=request.getContextPath()%>/api/appointment-list",
			data: {
				pageNum: pageNum,
				block: '5',  // 한 페이지에 5개씩 보이게
				search1: search1,
				search2: search2,
				type1: type1
			},
			dataType: 'json',
			success: function(data) {
 				console.log(data.pagination);
				console.log(data.list);
				
				let pagination = data.pagination;
				
				let str = ""; 		// 테이블 저장
				let str2 = "";		// 페이지네이션 저장
				
				// 테이블 데이터
				$(data.list).each(function () {
					str += `
						<tr>
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
		
		listShow(num, search1, search2, type1);
		
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
	                            	<select class="haru-search-select">
	                            		<option value="1">예약 번호</option>
	                            		<option value="2">보호자 이름</option>
	                            		<option value="3">동물 이름</option>
	                            		<option value="4">주치의</option>
	                            		<option value="5">진료 과목</option>
	                            	</select>
	                            	<div class="haru-tb-input-box">
	                            		<input class="tb-search-input" type="text">                            	
	                            	</div>
	                            	    <p>조회기간
									        <input type="text" id="datepicker1">
									        <input type="text" id="datepicker2">
									    </p>                            
	                            </div>
								
								<!-- 리스트 필터 -->
	                            <div class="haru-right">
	                            	<select class="haru-status-select">
	                            		<option value="0">전체</option>
	                            		<option value="100">예약 대기</option>
	                            		<option value="200">예약 확정</option>
	                            		<option value="300">예약 취소</option>
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