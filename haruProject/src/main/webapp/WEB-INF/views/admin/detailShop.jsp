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

    <title>판매 상세</title>

</head>

<!-- style -->
<style>

.modal_l_detail, table, .orderTable{
	color: black;
	width: 100%;
	margin-bottom: 20px;
}

.order_info tr{
	text-align: center;
	border-bottom: 1px solid #d0e4e8;
}
.order_info td{
	padding: 7px 0;
}

.infotitle {
	font-size: 1rem;
	height: 35px;
	background-color: #d0e4e8;
}

.form-input-title {
	font-weight: 500;
}

.form-input{
	width: 90%;
	height: 35px;
	border: 1.5px solid var(--haru);
	border-radius: 10px;
	padding-left: 10px;
} 

/*주문상태 드롭박스*/
.form-input-1{
	width: 150px;
	height: auto;
	border: 1.5px solid var(--haru);
	border-radius: 20px;
	padding-left: 10px;
	font-size: 14px;
}

.row {
	width:100%;
	height: 35px;
	line-height: 35px;
	margin-left: 0.1rem;

}

/* SELECT 버튼 위치 수정*/
select {
	background-position: 95% center;
}

.bottomInfo{
	display: flex;
}
</style>

<script type="text/javascript">

function psUpdate() {
	console.log("주문 상태 변경 시작");
	const ostatus_mcd = document.querySelector("select[name='ostatus_mcd']").value;
	const orderno = document.querySelector("input[name='orderno']").value;
	alert("수정될 주문 상태 ->"+ostatus_mcd+", 주문 번호 ->"+orderno);
	
	// 주문취소일시 
	if(ostatus_mcd === "400") {
		if (confirm("카카오페이 승인을 취소하시겠습니까?")) {
			console.log("카카오페이 승인 취소");
			
			const tid = document.querySelector("input[name='tid']").value;
			const ototal_price = document.querySelector("input[name='ototal_price']").value;
			alert("카카오페이 환불 가격 : "+ ototal_price + ", tid : " + tid);
			
			$.ajax({
				type: 'POST',
				url: `${contextPath}/api/kakaopay/refund`,
				contentType: "application/json",
				data: JSON.stringify({
					tid: tid,
					ototal_price: ototal_price,
					ostatus_mcd: ostatus_mcd,
					orderno: orderno
				}),
				success: function(response) {
					console.log("환불 요청 성공");
					location.href = "/admin/shop";
				},
				error: function(error) {
		            alert("카카오페이 환불 중 오류가 발생했습니다.");
		            console.error("환불 실패:", error);
		        }
			})
			
		}
	} else {
		// 주문 상태가 400이 아닐 경우, 기존의 폼을 submit() 해서 기본적인 수정 기능 실행
        console.log("주문 상태가 400이 아님. 기본적인 수정 실행");
        document.getElementById("upd_op").submit();
	}
	
}

</script>

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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >판매 상세</h1>
                    
                    <div class="modal_l_detail">
				        <table class="orderTable">
				        	<colgroup>
		                    	<col width="8%" />
		                        <col width="3%" />
		                    </colgroup>
				        	<tr>
				        		<td class="form-input-title">주문번호</td> <td>:</td> <td>${sale.orderno}</td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">주문일시</td> <td>:</td> <td><fmt:formatDate value="${sale.odate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">결제방법</td>	<td>:</td> <td>${sale.opayment_content}</td>
				        	</tr>
				        	
				        	<c:if test="${sale.opayment_mcd eq 300}">
				        		<input type="hidden" name="tid" value="${sale.tid}">
				        		<tr>
				        			<td class="form-input-title">카카오페이 <br> 승인 번호</td>	<td>:</td> <td>${sale.tid}</td>
				        		</tr>
				        	</c:if>
				        	
				        </table>
				        <table class="orderTable">
				        	<colgroup>
		                    	<col width="8%" />
		                        <col width="3%" />
		                    </colgroup>
				        	<tr>
				        		<td class="form-input-title">회원번호</td>	<td>:</td> <td>${sale.memno}</td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">이름</td>	<td>:</td> <td>${sale.mname}</td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">전화번호</td>	<td>:</td> <td>${sale.mtel}</td>
				        	</tr>
				        </table>
				        
				        <form action="/admin/updateOrder" method="post" name="frm" id="upd_op" class="orderTable" >
				        	<input type="hidden" name="orderno" value="${sale.orderno}">
				        	
				        	<div class="row">
				        		<div class="form-input-title" style="width: 80px">주문상태</div>
				        		<div><select class="form-input-1 sub-alevel-mcd-select" name="ostatus_mcd">
						        		<c:forEach var="status" items="${ostatus }">
						        			<c:choose>
						        				<c:when test="${status.mcd == sale.ostatus_mcd}">
						        					<option value="${status.mcd }" selected>${status.content }</option>
						        				</c:when>
						        				<c:otherwise>
						        					<option value="${status.mcd }">${status.content }</option>
						        				</c:otherwise>
						        			</c:choose>
						        		</c:forEach>
				        			</select>
				        		</div>
				        	</div>
				        	<div class="row">
				        		<div class="form-input-title">마지막 상태 변경 시간</div>
				        		<div style="width: 100px; text-align: center;">:</div>
				        		<div>${sale.update_date}</div>
				        	</div>
				        </form>
				        
					    <h5>주문 상품 정보</h5>
				        <table class="order_info">
				        	<colgroup>
				        		<col width="10%">
				        		<col width="60%">
				        		<col width="10%">
				        		<col width="20%">				        		 
				        	</colgroup>
				        	<tr class="infotitle">
				        		<td>상품번호</td>
				        		<td>상품명</td>
				        		<td>수량</td>
				        		<td>가격</td>
				        	</tr>
				        	<c:forEach var="prd" items="${products }">
					        	<tr>
					        		<td>${prd.pno}</td>
					        		<td>${prd.pname}</td>
					        		<td>${prd.oquantity}</td>
					        		<td>${prd.pprice }</td>
					        	</tr>
					        	
				        	</c:forEach>
				        </table>
				        <div class = "bottomInfo">
				        	<div class="form-input-title">총결제금액</div>
				        	<div style="width: 100px; text-align: center;">:</div> 
				        	<input type="hidden" name="ototal_price" value="${totalPrice}">
				        	<div><fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원</td>
				        </div>
				        
				     </div>

					<!-- 모달 버튼 -->
			       	<div class="modal_l-content-btn">
				       	<button type="button" class="to_list" id="detail_close_btn" onclick="location.href='/admin/shop'">목록으로</button>
			            <button type="button" class="admin_modal update_btn" id="update_btn" onclick="psUpdate()">수정하기</button>
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