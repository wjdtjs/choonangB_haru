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

    <title>공지사항 상세</title>
</head>
<body>
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

                    <!-- Page Heading -->
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >공지사항 상세</h1>
                    
					<div class="modal_l_detail">
		        		<form class="js-pro-container" id="notice-update-form" action="updateNotice" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
				        	<div class="js-pro-info">				        	
				        		<div class="title">상태</div>
				        		<input type="hidden" value="${notice.nno }" >
				        		<select class="sub-status-select" name="nstatus_mcd" style="margin-top: 1rem">
		        					<option disabled selected value="0">상태</option>
                            		<c:forEach var="ns" items="${statusList }">
		        						<c:choose>
		        							<c:when test="${ns.MCD eq notice.nstatus_mcd }">
		        								<option value="${ns.MCD }" selected>${ns.CONTENT }</option>
		        							</c:when>
		        							<c:otherwise>
		        								<option value="${ns.MCD }">${ns.CONTENT }</option>
		        							</c:otherwise>
		        						</c:choose>
                            			
                            		</c:forEach>
		        				</select>
//TODO: 최종 수정일, 작성자 등등 추가해주기, update 안됨.. 왜 안되는지 모르겠음. 컨트롤러 잘 들어가는데
				        		<div class="title" style="margin-top: 1.7rem">제목</div>
					        	<input type="text" name="ntitle" class="js-notice-title" style="margin-top: 1rem" value="${notice.ntitle }"/>
				        	</div>
				        	
				        	
				        	<div class="js-pro-detail">
				        		<div class="title">내용</div>
					        	<div style="margin-top: 1rem">
									<div class="post-form">
										<textarea name="ncontents" class="summernoteTextArea noticeDetialSummernote">
										</textarea>
									</div>
					        	</div>
				        	</div>
			  	 		</form>
					</div>
					
			        <!-- 모달 버튼 -->
			        <div class="modal_l-content-btn">
			        	<button type="button" id="modal_close_btn" class="to_list pro_reg" onclick="location.href='/admin/stock'">목록으로</button>
			        	<button type="submit" class="update_btn" form="notice-update-form">수정하기</button>
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
    	const contextPath = "<%=request.getContextPath()%>";
    
    	$(()=>{
       		//텍스트에디터 초기화
       		summernoteInit('.noticeDetialSummernote', 'notice');
       		$('.noticeDetialSummernote').summernote('code', '${notice.ncontents}' );
    	})
    	
	    /**
	 	 * 상품등록 요청 전 validation 체크
	 	 */
	   	function validateForm() {
			let result = false;
			
			let title 		= $(".js-notice-title").val(); //제목
			let status 		= $(".sub-status-select").val(); //상태
			let details 	= $('.summernoteTextArea.noticeRegSummernote').summernote('code'); //내용
			
			console.log('title : ', title);
			console.log('status : ', status);
			console.log('details : ', details);
	
			// 전체 필수 체크
			if(isEmpty(title) && isEmpty(status) && isEmpty(details)) {
				
				console.log('성공')
// 				if(confirm('이대로 수정하시겠습니까?')){
					result = true;				
// 				}
				
			} else {
				alert('필수값을 입력하세요');
				
				result = false;
			}
			
			return result;
		}
    	
    </script>

	<script src="/js/summernote.js?v=0.02"></script>
</body>
</html>