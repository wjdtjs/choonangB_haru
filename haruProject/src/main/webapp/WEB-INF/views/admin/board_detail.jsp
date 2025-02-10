<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>후기 상세</title>

<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
crossorigin="anonymous" referrerpolicy="no-referrer" />
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
	padding: 0px;
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
	display: flex;
	justify-content: space-between;	
}

table#board_detail_re_table {
    color: black;
    margin: 8px 0;
}


.board_detail_re_table p {
	color: black;
	padding-top: 12px;
	font-size: 16px;
}

#board_detail_table_re tr {
	margin: 4px;
	color: black;
}

#board_detail_table_re {
	width: 500px;
}

#re_writer {
	font-size: 12px;
	color: #B9B9B9;
}

#re_del_btn {
	color : #FF0000;
	margin: auto 0;
}

/* 이미지 */
.hr-review-img-div {
	width: 100%;
	height: auto;
	padding-block: 10px;
}

.hr-review-img {
	width: 200px;
	height: auto;
	border-radius: 10px;
	margin-right: 10px;
	display: inline-block;
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
                <div class="container-fluid modal_">
			        <!-- DataTales Example -->
                    <div class="card mb-4">
                    
                        
                        <!-- 글 내용 -->
                        <div class="card-body">
                        	<!-- 내용 전체 -->
	                        <div class="board_detail_body">
	                        
	                        	<!-- Page Heading -->
	                    		<h1 class="h4 mb-4 text-gray-800 font-weight-bold" id="board_detail_title" >후기 상세</h1>
	                    		
	                        	<div class="board_detail_top">			                       
		                        	<!-- 게시글 설명 -->                   	
			                        	<div class="board_detail_table">
			                        		<table id="board_detail_table_data">
			                        		 	<colgroup>
			                        		 		<col width="25%" />
			                        		 		<col width="25%" />
			                        		 		<col width="25%" />
			                        		 		<col width="25%" />
			                        		 	</colgroup>
			                        				<tr>
								        				<th>게시글 번호</th>
								        				<td>${board.bno }</td>
								        				
								        				<th>작성자</th>
								        				<td>${board.mid }</td>
								        			</tr>
								        			<tr>								        				
								        				<c:choose>
								        					<c:when test="${board.resno ne null}">
								        						<th>예약 번호</th>
									        					<td>${board.resno }</td>
								        					</c:when>								        					
								        					<c:when test="${board.resno eq null}">
								        						<th>상품 번호</th>
									        					<td>${board.pno }</td>
								        					</c:when>
								        				</c:choose>
								        				
								        				
								        				<th>작성일</th>
								        				<td><fmt:formatDate value="${board.reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>								        				
								        			</tr>
								        			<tr>
								        				<th>예약 분류</th>
								        				<td>${board.item }</td>
								        				
								        				<th>마지막 수정일</th>
								        				<td><fmt:formatDate value="${board.update_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								        			</tr>
													<tr>
								        				<th>조회수</th>
								        				<td>${board.bview_count }</td>
								        			</tr>
			                        		</table>                        		
			                        	</div>
			                        	
		                        	<!-- 글 내용 -->
			                        	<div class="board_detail_content">
				                        	<p>글 제목 <span style="font-weight: normal; margin-left: 12px;">${board.btitle }</span></p>
				                        	
				                        	<!-- 이미지 -->
				                        	<c:if test="${fn:length(imgList) > 0 }">
				                        		<p>이미지</p>
												<div class="hr-review-img-div">
													<c:forEach var="i" items="${imgList }">
														<img class="hr-review-img" src="${i.content }">
													</c:forEach>
												</div>
											</c:if>
				                        	
				                        	<p>글 내용</p>
									        <div class="hr-board-text">
									        ${board.bcontents }
									        </div>
			                        	</div>			                        			
		                        </div>                	
	                        	
	                        	<c:if test="${board.board_type_mcd ne 300}">
	                        	
		                        	<!-- 댓글 -->
		                        	<div class="board_detail_re">
		                        		<h5 style="display: inline">댓글</h5>
		                        		<p style="display: inline">${board.re_count -1}</p>	                        			
			                        			<c:forEach var="re" items="${bdList_re}">
				                        			<c:if test="${re.bseq != null && re.bseq ne ''}">								  
											            <div class="board_detail_re_table">
											                <!-- 작성자 정보 -->		    
											                <table id="board_detail_table_re">
											              	<colgroup>
						                        		 		<col width="20%" />
						                        		 		<col width="80%" />			                        		 		
						                        		 	</colgroup>							              						                
											                    <tr>
											                        <td colspan="2"><p>${re.bcontents }</p></td>
											                    </tr>
											                    <tr id="re_writer">
											                        <td>${re.mid }</td>							               
											                        <td><fmt:formatDate value="${re.reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
											                    </tr>
											                </table>								                
											                	<i id="re_del_btn" class="fa-solid fa-xmark" alt="re_del" onclick="location.href='/boardDelete_re?bno=${re.bno}&bgroup=${re.bgroup }'" ></i>
											            </div>
											            <hr>
											        </c:if>
										    	</c:forEach>                        		
		                        		
		                        	</div>	                        	
	                        	
	                        	</c:if>
	                        	
	                        	<div class="modal_l-content-btn">	                        	 
								    <button type="button" class="to_list" id="detail_close_btn" onclick="location.href='/admin/board'">목록으로</button>
	                      	        <button type="button" class="update_btn" onclick="location.href='/boardDelete?bno=${board.bno}'">삭제하기</button>
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