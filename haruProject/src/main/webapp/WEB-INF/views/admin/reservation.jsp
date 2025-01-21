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

<style>
/* 검색 - 날짜 */
#res_date {
	display: flex;
	align-items: center;	
	margin: 0 12px;
	color: black;
	text-align: center;
}
/* 날짜 검색 아이콘 */
#res_date input {
    margin: 0 4px;
    border-radius: 0.75rem;
    border: 1px solid #6F7173;
    padding-left: 2rem;
    padding-right: 1rem;
    height: 2rem;
    width: 150px;
}


</style>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">

	// 날짜선택 - datepicker
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

	$(function() {
	    $("#datepicker1, #datepicker2").datepicker({
	        dateFormat: "yy-mm-dd", // 날짜 포맷 설정
	        onSelect: function(selectedDate) {
	            // Date 객체로 값을 가져옴
	            var date1 = $.datepicker.formatDate("yymmdd", $("#datepicker1").datepicker("getDate"));
	            var date2 = $.datepicker.formatDate("yymmdd", $("#datepicker2").datepicker("getDate"));

	            // 선택된 날짜를 alert로 표시
	            alert("date1: " + date1 + ", date2: " + date2);
	        }
	    });
	});

	


	// 예약 상세 페이지로 이동
	function goToDetail(resno) {
		alert("resno->"+resno);
		console.log("resno 값:", resno);
	
	    if (!resno) {
	        alert("resno 값이 비어 있습니다.");
	        return;
	    }
	   // location.href = `/admin/board_detail?bno=${bno}`;
	    location.href = '/admin/detailReservation?resno='+resno;
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
	                            		<option value="100">예약 번호</option>
	                            		<option value="200">보호자 이름</option>
	                            		<option value="300">동물 이름</option>
	                            		<option value="400">주치의</option>
	                            		<option value="500">진료 과목</option>
	                            	</select>
	                            	<div class="haru-tb-input-box">
	                            		<input class="tb-search-input" type="text">                            	
	                            	</div>
	                            	    <p id="res_date">조회기간
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
	                           		<button class="btn-primary haru-tb-btn res_modal" id="modal_open_btn" onclick="location.href='/admin/addReservation'">예약 추가</button>                           	                         
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
                                    	<c:forEach var="appointment" items="${aList}">
	                                    	<tr onclick="goToDetail('${appointment.resno}')" style="cursor: pointer;">
	                                    		<td>${appointment.resno } </td>
	                                    		<td><fmt:formatDate value="${appointment.rdate}" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;${appointment.start_time }</td>
	                                      		<td>${appointment.mname } </td>
	                                    		<td>${appointment.petname }&nbsp;&nbsp;/&nbsp;&nbsp;${appointment.species }&nbsp;&nbsp;/&nbsp;&nbsp;${appointment.gender } </td>
	                                   		    <td>${appointment.aname } </td>
	                                    		<td>${appointment.item } </td>
	                                    		<td>${appointment.status } </td>
	                                    	</tr>
											                                    
	                                    </c:forEach>                                    
                                    </tbody>
                                </table>
                            </div>
                        </div>

						<div class="haru-pagination">
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