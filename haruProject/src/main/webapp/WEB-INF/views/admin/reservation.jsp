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

#cal_icon {
	color: var(--haru);
	margin: 4px;
}


</style>

<!-- datepicker -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>

<script type="text/javascript">

	var date1 = null;
	var date2 = null;

	// 날짜선택 - datepicker
	$(function() {
		// 시작 날짜
		$('#datepicker1').datepicker({
			dateFormat: 'yy-mm-dd' //달력 날짜 형태
		    ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		    ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
		    ,changeYear: true //option값 년 선택 가능
		    ,changeMonth: true //option값  월 선택 가능
		    ,buttonText: "선택" //버튼 호버 텍스트              
		    ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
		    ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
		    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
		    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
		    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
			,onSelect: function(selectedDate) {
				// Date 객체로 값을 가져옴
	            //var date1 = $.datepicker.formatDate("yymmdd", $("#datepicker1").datepicker("getDate"));
	            date1 = $("#datepicker1").val();
	            //var date2 = $.datepicker.formatDate("yymmdd", $("#datepicker2").datepicker("getDate"));
	            date2 = $("#datepicker2").val();
	           
	            console.log("date1: " + date1 + ", date2: " + date2);
	            
	         	// date1, date2 값이 다 들어오면 자동으로 검색
	            if(date1 && date2) {
	            	const searchInput = document.querySelector(".tb-search-input");
	    	        const searchSelect = document.querySelector(".haru-search-select");
	    			const selectedValue = document.querySelector(".haru-status-select");

	    			search1 = searchInput.value; // 입력된 검색어
	    		    type4 = selectedValue.value; // 상태 드롭박스
	    		    type5 = searchSelect.value;	 // 선택된 필터
	    		    date1 = $("#datepicker1").val();
	    	        date2 = $("#datepicker2").val();
	    			console.log('search_type 실행 -> type4: '+type4+',type5: '+type5+',search1: '+search1
	    			  		+',start_date: '+date1+',end_date: '+date2);
	    			alert('search_type 실행 -> type4: '+type4+',type5: '+type5+',search1: '+search1
	    			   		+',start_date: '+date1+',end_date: '+date2);
	    			location.href = '/admin/reservation?type4='+type4+'&type5='+type5+'&search1='+search1
	    			  		+'&start_date='+date1+'&end_date='+date2;
	            }
	        }
			,onClose: function( selectedDate ) {    
	             // 시작일(fromDate) datepicker가 닫힐때
	             // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
	             $("#datepicker2").datepicker( "option", "minDate", selectedDate );
	        }
		});
		// 끝 날짜
		$('#datepicker2').datepicker({
			dateFormat: 'yy-mm-dd' //달력 날짜 형태
		    ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		    ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
		    ,changeYear: true //option값 년 선택 가능
		    ,changeMonth: true //option값  월 선택 가능
		    ,buttonText: "선택" //버튼 호버 텍스트              
		    ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
		    ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
		    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
		    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
		    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
			,onSelect: function(selectedDate) {
	            // Date 객체로 값을 가져옴
	            //var date1 = $.datepicker.formatDate("yymmdd", $("#datepicker1").datepicker("getDate"));
	            date1 = $("#datepicker1").val();
	            //var date2 = $.datepicker.formatDate("yymmdd", $("#datepicker2").datepicker("getDate"));
	            date2 = $("#datepicker2").val();

	            // 선택된 날짜를 alert로 표시
	            //alert("date1: " + date1 + ", date2: " + date2);
	            console.log("date1: " + date1 + ", date2: " + date2);
	            
	         	// date1, date2 값이 다 들어오면 자동으로 검색
	            if(date1 && date2) {
	            	const searchInput = document.querySelector(".tb-search-input");
	    	        const searchSelect = document.querySelector(".haru-search-select");
	    			const selectedValue = document.querySelector(".haru-status-select");

	    			search1 = searchInput.value; // 입력된 검색어
	    		    type4 = selectedValue.value; // 상태 드롭박스
	    		    type5 = searchSelect.value;	 // 선택된 필터
	    		    date1 = $("#datepicker1").val();
	    	        date2 = $("#datepicker2").val();
	    			console.log('search_type 실행 -> type4: '+type4+',type5: '+type5+',search1: '+search1
	    			  		+',start_date: '+date1+',end_date: '+date2);
	    			alert('search_type 실행 -> type4: '+type4+',type5: '+type5+',search1: '+search1
	    			   		+',start_date: '+date1+',end_date: '+date2);
	    			location.href = '/admin/reservation?type4='+type4+'&type5='+type5+'&search1='+search1
	    			  		+'&start_date='+date1+'&end_date='+date2;
	            }
	        }
			,onClose: function( selectedDate ) {    
				// 종료일(toDate) datepicker가 닫힐때
                // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정
	             $("#datepicker1").datepicker( "option", "maxDate", selectedDate );
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
	
	
	// 검색
	
	let search1 = null;
	let type4 = null;
	let type5 = 100;
	
	// 검색창에서 엔터키 눌렀을 때 검색
	function search_word(e) {
		if (e.key === "Enter") {
			const searchInput = document.querySelector(".tb-search-input");
	        const searchSelect = document.querySelector(".haru-search-select");
			const selectedValue = document.querySelector(".haru-status-select");


			    search1 = searchInput.value; // 입력된 검색어
		        type4 = selectedValue.value; // 상태 드롭박스
		        type5 = searchSelect.value;	 // 선택된 필터
		        date1 = $("#datepicker1").val();
	            date2 = $("#datepicker2").val();
			    console.log('search_type 실행 -> type4: '+type4+',type5: '+type5+',search1: '+search1
			    		+',start_date: '+date1+',end_date: '+date2);
			    alert('search_type 실행 -> type4: '+type4+',type5: '+type5+',search1: '+search1
			    		+',start_date: '+date1+',end_date: '+date2);
			    location.href = '/admin/reservation?type4='+type4+'&type5='+type5+'&search1='+search1
			    		+'&start_date='+date1+'&end_date='+date2;
	    }
	}
	
	// 드롭다운 값 변경됐을 때 동작
	function search_type(selectElement) {
		const searchInput = document.querySelector(".tb-search-input");
        const searchSelect = document.querySelector(".haru-search-select");
		const selectedValue = selectElement.value;

		search1 = searchInput.value; // 입력된 검색어
	    type4 = selectElement.value; // 상태 드롭박스
	    type5 = searchSelect.value; // 선택된 필터
	    date1 = $("#datepicker1").val();
        date2 = $("#datepicker2").val();
		console.log('search_type 실행 -> type4: '+type4+',type5: '+type5+',search1: '+search1
				+',start_date: '+date1+',end_date: '+date2);
		alert('search_type 실행 -> type4: '+type4+',type5: '+type5+',search1: '+search1
		  		+',start_date: '+date1+',end_date: '+date2);
		location.href = '/admin/reservation?type4='+type4+'&type5='+type5+'&search1='+search1
		   		+'&start_date='+date1+'&end_date='+date2;
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
	                            	<!-- 검색 필터 -->
	                            	<select class="haru-search-select">
	                            		<option value="100" ${type5 == '100'   ? 'selected' : ''}>예약 번호</option>
	                            		<option value="200" ${type5 == '200'   ? 'selected' : ''}>보호자 이름</option>
	                            		<option value="300" ${type5 == '300'   ? 'selected' : ''}>동물 이름</option>
	                            		<option value="400" ${type5 == '400'   ? 'selected' : ''}>주치의</option>
	                            		<option value="500" ${type5 == '500'   ? 'selected' : ''}>진료 과목</option>
	                            	</select>
	                            	<!-- 검색어 입력 -->
	                            	<div class="haru-tb-input-box">
	                            		<input class="tb-search-input" name="search1" type="text"
	                            		onkeypress="console.log('onkeypress 실행됨'); if (event.key === 'Enter') search_word(event)"
		                            	value="${search1}"
		                            	autocomplete="off"> <!-- 검색한 기록 안 남게 -->
	                            	</div>
	                            	<!-- 기간 검색 -->
	                            	<p id="res_date">
	                            		<i class="fa-solid fa-calendar-days fa-lg" id="cal_icon"></i>
									    <input type="text" class="search_date" id="datepicker1" value="${start_date }" autocomplete="off">
									    <input type="text" class="search_date" id="datepicker2" value="${end_date }" autocomplete="off">
									</p>                            
	                            </div>
								
								<!-- 리스트 필터 -->
	                            <div class="haru-right">
	                            	<select class="haru-status-select" 
	                            			onchange="console.log('onchange 실행됨'); search_type(this)">
	                            		<option value="0" ${type4 == '0'   ? 'selected' : ''}>전체</option>
	                            		<option value="100" ${type4 == '100'   ? 'selected' : ''}>예약 대기</option>
	                            		<option value="200" ${type4 == '200'   ? 'selected' : ''}>예약 확정</option>
	                            		<option value="300" ${type4 == '300'   ? 'selected' : ''}>예약 취소</option>
	                            		<option value="300" ${type4 == '400'   ? 'selected' : ''}>진료 완료</option>
	                            	</select>
	                           		<button class="btn-primary haru-tb-btn res_modal" id="modal_open_btn" onclick="location.href='/admin/addReservation'">예약 추가</button>                           	                         
	                            </div>
	                            
                            
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