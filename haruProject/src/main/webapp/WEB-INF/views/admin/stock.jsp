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

    <title>상품 관리</title>

</head>

<script type="text/javascript">

	let search1 = null;
	let search2 = null;
	
	$(()=>{
		listShow('1');
		
		$('.haru-show-select').change(function() {
		    let value = $(this).val();
			if(value == "0") {
				search2 = null;
			} else search2 = value;
			listShow('1', search1, search2);
		});
		
		//검색
		$('.tb-search-input').keyup(function() {
// 			console.log($(this).val())
			search1 = $(this).val();
			listShow('1', search1, search2);
		})
	})
	
	
	/**
	 * 리스트 보여주기 (ajax)
	*/
	function listShow(pageNum, search1, search2) {
// 		console.log(search1, search2)
		
		$.ajax({
			url: "<%=request.getContextPath()%>/api/product-list",
			data: {
				pageNum: pageNum,
				blockSize: '10',
				search1: search1,
				search2: search2
			},
			dataType: 'json',
			success: function(data){
// 				console.log(data.pagination);
// 				console.log(data.list);
				
				let pagination = data.pagination;
				
				let str = "";
				let str2 = "";
				
				$(data.list).each (function(){
					if(this.status=='비노출') {
						str+= `<tr class="haru-table-click" style="background: #f2f2f2; color: #919191" onclick="location.href='/admin/details-product?pno=\${this.pno}'">`
					} else {
						str+= `<tr class="haru-table-click" onclick="location.href='/admin/details-product?pno=\${this.pno}'">`
					}
					str += `
							
								<td>\${this.pno}</td>
								<td>\${this.pname}</td>
								<td>\${this.pbrand}</td>
								<td>\${this.pprice}</td>
								<td>\${this.pquantity}</td>
								<td>\${this.reg_date.split('T')[0]}</td>
								<td>\${this.status}</td>
							</tr>
							`
				})
				$('tbody.haru-product-tbody').html(str);
				
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
	
	/**
	 * 페이지 교체
	 * @param num 
	*/
	function pageChange(num) {
		let id = '#pageNum' + num;
		
		listShow(num, search1, search2);
		
		$('.haru-pagenum').removeClass('active');
		$(id).addClass('active');
		
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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >상품 관리</h1>
                    

                    <!-- DataTales Example -->
                    <div class="card mb-4">
                        <div class="card-header py-3">
                            <div class="m-0 haru-search-box">
	                            <div class="haru-left">
	                            	<select>
<!-- 	                            		<option value="all">전체</option> -->
	                            		<option value="name">상품명</option>
	                            	</select>
	                            	<div class="haru-tb-input-box">
	                            		<input class="tb-search-input" type="text">                            	
	                            	</div>                            
	                            </div>
	                            
	                            <!-- 이거 필요없으면 걍 지우면 됩니다!! -->
	                            <div class="haru-right">
	                            	<select class="haru-show-select" name="isshow">
	                            		<option value="0">전체</option>
	                            		<c:forEach var="ps" items="${statusList }">
	                            			<option value="${ps.MCD }">${ps.CONTENT }</option>
	                            		</c:forEach>
	                            	</select>
	                           		<button class="btn-primary haru-tb-btn shadow-none pro_reg" id="modal_open_btn" onclick="location.href='/admin/upload-product'">상품 추가</button>                           	                         
	                            </div>
	                            <!-- 이거 필요없으면 걍 지우면 됩니다!! -->
                            
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
		                        	<colgroup>
								        <col width="6%" />
								        <col width="30%" />
								        <col width="20%" />
								        <col width="12%" />
								        <col width="10%" />
								        <col width="15%" />
								        <col width="7%" />
								    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>상품명</th>
                                            <th>브랜드</th>
                                            <th>가격(원)</th>
                                            <th>수량</th>
                                            <th>등록일</th>
                                            <th>상태</th>
                                        </tr>
                                    </thead>
                                    <tbody class="haru-product-tbody">
<%--                                     	<c:if test="${pagination.totalCnt > 0}"> --%>
<%--                                     		<c:forEach var="pd" items="${plist }" varStatus="status"> --%>
<%--                                     		<fmt:setLocale value="ko_KR"/> --%>
<%-- 		                                        <tr class="haru-table-click haru-product-tr${status.index }"> --%>
<%-- 		                                            <td>${pd.pno }</td> --%>
<%-- 		                                            <td>${pd.pname }</td> --%>
<%-- 		                                            <td>${pd.pbrand }</td> --%>
<%-- 		                                            <td><fmt:formatNumber type="currency" value="${pd.pprice }" currencySymbol=""/></td> --%>
<%-- 		                                            <td>${pd.pquantity }</td> --%>
<%-- 		                                            <td><fmt:formatDate value="${pd.reg_date }" pattern="yyyy/MM/dd"/></td> --%>
<%-- 		                                            <td>${pd.status}</td> --%>
<!-- 		                                        </tr> -->
<%--                                     		</c:forEach> --%>
<%--                                         </c:if> --%>
<%--                                         <c:if test="${pagination.totalCnt == 0}"> --%>
<!--                                         	데이터가 없습니다. -->
<%--                                         </c:if> --%>
                                        
                                        
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
    
    <script>const contextPath = "<%=request.getContextPath()%>";</script>

</body>
</html>