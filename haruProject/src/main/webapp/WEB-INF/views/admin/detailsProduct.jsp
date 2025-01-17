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

    <title>상품 상세</title>
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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >상품 상세</h1>
                    
					<div class="modal_l_detail">
		       			 <form class="js-pro-container" action="updateProduct" id="pro-update-form" method="post" enctype="multipart/form-data" onsubmit="return updateValidateForm()">
				        	<div class="js-pro-info">
				        		<div class="title">상품 정보</div>
					        	<table>
					        		<colgroup>
					        			<col width="10%"/>
					        			<col width="40%"/>
					        			<col width="10%"/>
					        			<col width="40%"/>
					        		</colgroup>
					        		<tr>
					        			<td class="sub-title">분류 <span class="haru-required">*</span></td>
					        			<td>
					        				<select class="sub-bcd-select" name="pstep_bcd">
					        					<option disabled value="0">대분류</option>
					        					<c:forEach var="bcd" items="${bcdList }">
					        						<c:choose>
					        							<c:when test="${bcd.BCD eq product.pstep_bcd }">
					        								<option value="${bcd.BCD}" selected class="add-product-bcd">${bcd.CONTENT}</option>
					        							</c:when>
					        							<c:otherwise>
					        								<option value="${bcd.BCD}" class="add-product-bcd">${bcd.CONTENT}</option>
					        							</c:otherwise>
					        						</c:choose>
					        					</c:forEach>
					        				</select>
					        				<select class="sub-mcd-select" name="pstep_mcd">
					        					<option disabled selected value="0">중분류</option>
					        				</select>
					        			</td>
					        			<td class="sub-title">상품번호</td>
					        			<td>
					        				${product.pno }
					        				<input class="haru-pro-pno" name="pno" type="hidden" value="${product.pno }">
					        			</td>
					        		</tr>
					        		<tr>
					        			<td class="sub-title">상품명 <span class="haru-required">*</span></td>
					        			<td colspan="3">
					        				<input class="haru-pro-name" name="pname" type="text" style="width: 91%"
					        						value="${product.pname }"
					        				>
					        			</td>
					        		</tr>
					        		<tr>
					        			<td class="sub-title">가격 <span class="haru-required">*</span></td>
					        			<td>
					        				<input class="haru-pro-price" name="pprice" type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '');"
					        						value="${product.pprice }"
					        				>
					        			</td>
					        			<td class="sub-title">브랜드 <span class="haru-required">*</span></td>
					        			<td>
					        				<input class="haru-pro-brand" name="pbrand" type="text"
					        						value="${product.pbrand }">
					        			</td>
					        		</tr>
					        		<tr>
					        			<td class="sub-title">수량 <span class="haru-required">*</span></td>
					        			<td>
					        				<input class="haru-pro-quantity" name="pquantity" type="number" min="0"
					        						value="${product.pquantity }">
					        			</td>
					        			<td class="sub-title">구매처 <span class="haru-required">*</span></td>
					        			<td>
					        				<input class="haru-pro-store" name="pbuy_store" type="text"
					        						value="${product.pbuy_store }">
					        			</td>
					        		</tr>
					        		<tr>
					        			<td class="sub-title">상태 <span class="haru-required">*</span></td>
					        			<td>
					        				<select class="sub-status-select" name="pstatus_mcd">
					        					<c:forEach var="ps" items="${statusList }">
					        						<c:choose>
					        							<c:when test="${ps.MCD eq product.pstatus_mcd }">
					        								<option value="${ps.MCD }" selected>${ps.CONTENT }</option>
					        							</c:when>
					        							<c:otherwise>
					        								<option value="${ps.MCD }">${ps.CONTENT }</option>
					        							</c:otherwise>
					        						</c:choose>
			                            			
			                            		</c:forEach>
					        				</select>
					        			</td>
					        			<td class="sub-title">최종 수정일</td>
					        			<td class="pro-update-date">
					        				<fmt:formatDate value="${product.update_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
					        			</td>
					        		</tr>
					        	</table>
				        	</div>
				        	
				        	<div class="js-pro-img">
				        		<div class="title">썸네일 이미지 <span class="haru-required">*</span></div>
					        	<div style="margin-top: 1rem">
									<div class="pro-mainimg-div">
										<img src="${product.pimg_main}" alt="product-image" style="width: 7rem; height: 7rem"/>
									</div>
									<div class="pro-label-div" style="display: none">
										<label for="main_img" class="img_upload">+</label>
										<input type="file" id="main_img" name="main_img" accept=".jpg, .jpeg, .png, .gif" style="display: none"> 							
									</div>
					        	</div>
				        	</div>
				        	
				        	<div class="js-pro-detail">
				        		<div class="title">상세 설명</div>
					        	<div style="margin-top: 1rem">
									<div class="post-form">
										<div class="post-form">
											<textarea name="pdetails" class="summernoteTextArea proDetailSummernote">
											</textarea>
										</div>
									</div>
					        	</div>
				        	</div>
					   </form>	
					</div>
					
			        <!-- 모달 버튼 -->
			        <div class="modal_l-content-btn">
			        	<button type="button" id="modal_close_btn" class="to_list pro_reg" onclick="location.href='/admin/stock'">목록으로</button>
			        	<button type="submit" class="update_btn" form="pro-update-form">수정하기</button>
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
       		getMcd('${product.pstep_mcd}'); //분류 데이터 가져오기
//        		$('.pro-update-date').text(LocalDateFormat('${product.update_date}')); //수정일format처리
       		
       		$('.pro-mainimg-div').addClass('pro-thumbnail');
       		//텍스트에디터 초기화
       		summernoteInit('.proDetailSummernote', 'product');
       		$('.proDetailSummernote').summernote('code', '${product.pdetails}' );
    	})
    	
    	
	 	/**
	 	 * 상품수정 요청 전 validation 체크
	 	 */
	   	function updateValidateForm() {
	   		console.log('상품수정버튼클릭')
			let result = false;
			
			let bcd 		= $(".sub-bcd-select option:selected").val(); //대분류
			let mcd 		= $(".sub-mcd-select option:selected").val(); //중분류
			let name 		= $(".haru-pro-name").val(); //상품명
			let price 		= $(".haru-pro-price").val(); //가격
			let brand 		= $(".haru-pro-brand").val(); //브랜드
			let quantity 	= $(".haru-pro-quantity").val(); //수량
			let store 		= $(".haru-pro-store").val(); //구매처
			let thumb 		= $("#main_img").val(); //썸네일
			let details 	= $('.summernoteTextArea.proDetailSummernote').summernote('code'); //상세설명
			
// 			console.log("aa ",$('haru-pro-pno').text())
// 			console.log(`대분류 : \${bcd}, 중분류 : \${mcd}, 상품명 : \${name}, 가격 : \${price}, 브랜드 : \${brand}, 수량 : \${quantity}, 구매처 : \${store}`);
// 			console.log(thumb);
// 			console.log(details);
	
			// 전체 필수 체크
			if(isEmpty(bcd) && isEmpty(mcd) && isEmpty(name) && isEmpty(price) && isEmpty(brand) 
					&& isEmpty(quantity) && isEmpty(store)) {
				
// 				console.log(1, '${product.pimg_main}')
// 				console.log(2, thumb)
				let current_img = '${product.pimg_main}'
				if(!isEmpty(thumb) && isEmpty(current_img)) {
					console.log('이미지 변경 안함')
					
				} else {
					console.log('이미지 변경함')
				}
				
				if(confirm('이대로 수정하시겠습니까?')){
					result = true;				
				}
				
			} else {
				alert('필수값을 입력하세요');
				
				result = false;
			}
			
			return result;
		}
    	
    </script>

    <script src="/js/shop_modal.js?v=0.01"></script>
	<script src="/js/summernote.js?v=0.02"></script>
</body>
</html>