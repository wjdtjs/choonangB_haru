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

    <title>후기 상세</title>

</head>

<style>

#board_detail_title {
	color: var(--haru) !important;
}

/* 목록으로, 삭제하기 버튼 */
.board_btn {
	position: fixed;
	bottom: 80px;
	left: 80%;
  	transform: translateX(-50%);
	z-index: 999;
}

.board_detail {
	border-radius: 0.5rem;
	height: 2.5rem;
	padding-inline: 1rem;
	color: white;
	font-size: 16px;
	border: white;
	margin: 0 10px;
}

.board_detail#detail_close_btn {
	background-color: #B9B9B9;
}

.board_detail#update_btn {
	background-color: var(--haru);
}


/* 전체 position */
.board_detail_body {
	width: 1000px;
	margin: 0 auto;
	position: relative;
}

.board_detail_top {
	width: auto;
	margin: 0 auto;
	border-radius: 24px;
}

/* 후기 상세 테이블 */
#hr-table-empty {
	padding: 16px 150px;
}

.board_detail_table {
	border: none;
	color: black;
}
.board_detail_table #board_detail_table_data th {
	font-weight: bold;
	color: black;
	padding: 4px
}
.board_detail_table #board_detail_table_data td {
	color: black;
	padding: 2px;
}
.board_detail_table #board_detail_table_data tr {
	margin: 4px
}

/* 후기 내용 */
.board_detail_content {
	margin: 20px 4px;
}

.board_detail_content p {
	color: black;
	font-size: 16px;
	font-weight: bold;
}



.hr-board-text {
	border: white;
	border-radius: 24px;
	width: auto;
	height: 220px;
	background-color: rgba(12, 128, 141, 0.1);
	color: black;
	font-size: 16px;
	
	padding: 16px 24px;
	margin: 0 auto; // 가운데 정렬
}

/* 댓글 */

.board_detail_re h5 {
	margin: 40px 0 0 40px;
	color: var(--haru);
	font-size: 20px;
	font-weight: bold;
}

.board_detail_re_table {
	margin: 20px 40px;
	box-shadow: 0px 2px 10px 0px rgba(0, 0, 0, 0.1);
	border-radius: 24px;
	padding: 20px;
}

table#board_detail_re_table {
    color: black;
    margin: 8px 0;
}


.board_detail_re_table p {
	color: black;
	font-size: 16px;
}




</style>

<script type="text/javascript">

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

                  
                    

                    <!-- DataTales Example -->
                    <div class="card mb-4">
                    
                        
                        <!-- 글 내용 -->
                        <div class="card-body">
                        	<!-- 내용 전체 -->
	                        <div class="board_detail_body">
	                        
			                    <div class="board_btn">
				                            	<button type="button" class="board_detail" id="detail_close_btn" onclick="location.href='/admin/board'">목록으로</button>
				                            	<button type="button" class="board_detail" id="update_btn" form="">삭제하기</a></button>	                           
				                </div>   
	                        	<!-- Page Heading -->
	                    		<h1 class="h4 mb-4 text-gray-800 font-weight-bold" id="board_detail_title" >후기 상세</h1>
	                    		
	                        	<div class="board_detail_top">
			                        <c:forEach var="content" items="${bdList_content }">
		                        	<!-- 게시글 설명 -->                   	
			                        	<div class="board_detail_table">
			                        		<table id="board_detail_table_data">
			                        				<tr>
								        				<th>게시글 번호</th>
								        				<td>: ${content.bno }</td>
								        				<td><div id="hr-table-empty"></div></td>
								        				<th>작성자</th>
								        				<td>: ${content.mname }</td>
								        			</tr>
								        			<tr>
								        				<c:if test="">
									        				<th>예약 번호</th>
									        				<td>: ${content.resno }</td>
								        				</c:if>
								        				
								        				<td><div id="hr-table-empty"></div></td>
								        				<th>작성일</th>
								        				<td>: ${content.reg_date }</td>
								        			</tr>
								        			<tr>
								        				<th>예약 분류</th>
								        				<td>: ${content.item }</td>
								        				<td><div id="hr-table-empty"></div></td>
								        				<th>마지막 수정일</th>
								        				<td>: ${content.update_date }</td>
								        			</tr>
													<tr>
								        				<th>조회수</th>
								        				<td>: ${content.bview_count }</td>
								        			</tr>
			                        		</table>                        		
			                        	</div>
			                        	
		                        	<!-- 글 내용 -->
			                        	<div class="board_detail_content">
				                        	<p>글 제목</p>
									        <div class="hr-board-text">
									        ${content.bcontents }
									        </div>
			                        	</div>
			                       	</c:forEach>			                        			
		                        </div>                	
	                        	
	                        	
	                        	<!-- 댓글 -->
	                        	<div class="board_detail_re">
	                        		<c:forEach var="re" items="${bdList_re}">
	                        		<h5>댓글</h5>
								        <c:if test="${re.bseq != null && re.bseq ne ''}">
								            <div class="board_detail_re_table">	                        		
								                <!-- 작성자 정보 -->		    
								                <table id="board_detail_table_re">
								                    <tr>
								                        <th>작성자</th>
								                        <td>: ${re.mname }</td>
								                    </tr>
								                    <tr>
								                        <th>작성일</th>
								                        <td>: ${re.reg_date }</td>
								                    </tr>
								                </table>
								                <p>${re.bcontents }</p>
								            </div>
								        </c:if>
								    </c:forEach>
	                        		
	                        		
	                        	</div>
	                        </div>
	                                       	
	                        	
                        </div>
                        <!-- end of .card-body -->
                        
                        
                        					
	
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