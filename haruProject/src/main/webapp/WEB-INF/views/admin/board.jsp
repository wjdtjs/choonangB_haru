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

    <title>게시판 관리</title>

</head>

<script type="text/javascript">

	// 후기 상세 페이지로 이동
	function goToDetail(bno) {
		//alert("kk bno->"+bno);
		//console.log("kk bno 값:", bno);

        if (!bno) {
            alert("bno 값이 비어 있습니다.");
            return;
        }
        location.href = '/admin/board_detail?bno='+bno;
    }
	
	
	// 검색
		
	let search1 = null;
	let type4 = null;
	
	// 검색창에서 엔터키 눌렀을 때 검색
	function search_word(e) {
		if (e.key === "Enter") {
	        const searchInput = document.querySelector(".tb-search-input");
	        const searchSelect = document.querySelector(".haru-search-select");

	        if (!searchInput || !searchSelect) {
	            console.error("검색창 또는 드롭다운 요소를 찾을 수 없습니다.");
	            return;
	        }

	        search1 = searchInput.value; // 입력된 검색어
	        type4 = searchSelect.value; // 선택된 필터
	        //console.log('search_word 실행 -> search1: '+search1 + ', type4: '+type4);
	        //alert('search_word 실행 -> search1: '+search1 + ', type4: '+type4);
	        location.href = '/admin/board?type4='+type4+'&search1='+search1;
	        // redirectToSearch(type1, search1);
	    }
	}
	
	// 드롭다운 값 변경됐을 때 동작
	function search_type(selectElement) {
		 const searchInput = document.querySelector(".tb-search-input");
		 const selectedValue = selectElement.value;

		    if (!searchInput || !selectElement) {
		        console.error("검색창 또는 드롭다운 요소를 찾을 수 없습니다.");
		        return;
		    }

		    type4 = selectElement.value; // 선택된 필터
		    search1 = searchInput.value; // 입력된 검색어
		    //console.log('search_type 실행 -> search1: '+search1 + ', type4: '+type4);
		    //alert('search_type 실행 -> search1: '+search1 + ', type4: '+type4);
		    location.href = '/admin/board?type4='+type4+'&search1='+search1;
		    // redirectToSearch(type1, search1);
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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >게시판 관리</h1>
                    

                    <!-- DataTales Example -->
                    <div class="card mb-4">
                        <div class="card-header py-3"> 	 
                            <div class="m-0 haru-search-box">
	                            <div class="haru-left">	                            	
										<!-- 검색창 -->
		                            	<div class="haru-tb-input-box">	                            
		                            		<input class="tb-search-input" name="search1" type="text" 
		                            		onkeypress="console.log('onkeypress 실행됨'); if (event.key === 'Enter') search_word(event)"
		                            		value="${search1}">
										</div>
	                            </div>
	                            
	                            <div class="haru-right">
	                            	<select name="type4" class="haru-search-select" onchange="console.log('onchange 실행됨'); search_type(this)" >
		                            		<option value="0" 	 ${type4 == '0'   ? 'selected' : ''}>전체</option>
		                            		<option value="100"  ${type4 == '100' ? 'selected' : ''}>진료</option>
		                            		<option value="200"  ${type4 == '200' ? 'selected' : ''}>수술</option>
		                            		<option value="300"  ${type4 == '300' ? 'selected' : ''}>상품</option>
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
                                            <th>구분</th>
                                            <th>제목</th>
                                            <th>작성자</th>
                                            <th>작성일</th>
                                            <th>조회수</th>
                                        </tr>
                                    </thead>
                                    <c:forEach var="board" items="${bList}">
                                    	<tr onclick="goToDetail(${board.bno})" style="cursor: pointer;">
                                    		<td>${board.bno } </td>
                                   		    <td>${board.content } </td>
                                      		<td>${board.btitle } </td>
                                    		<td>${board.memail } </td>
                                    		<td><fmt:formatDate value="${board.reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    		<td>${board.bview_count } </td>
                                    	</tr>
										                                    
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
						
							<div class="haru-pagination">
							    <!-- 이전 블록 이동 -->
							    <c:if test="${pagination.startPage > pagination.blockSize}">
							        <i class="haru-pagearrow fa-solid fa-chevron-left" 
							           onclick="location.href='?pageNum=${pagination.startPage - pagination.blockSize}&type4=${type4}&search1=${search1}'"></i>
							    </c:if>
							
							    <!-- 페이지 번호 출력 -->
							    <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
							        <div class="haru-pagenum ${i == pagination.currentPage ? 'active' : ''}" 
							             onclick="location.href='?pageNum=${i}&type4=${type4}&search1=${search1}'">
							            ${i}
							        </div>
							    </c:forEach>
							
							    <!-- 다음 블록 이동 -->
							    <c:if test="${pagination.endPage < pagination.pageCnt}">
							        <i class="haru-pagearrow fa-solid fa-chevron-right" 
							           onclick="location.href='?pageNum=${pagination.startPage + pagination.blockSize}&type4=${type4}&search1=${search1}'"></i>
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