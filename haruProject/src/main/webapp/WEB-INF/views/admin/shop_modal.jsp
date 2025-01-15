<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>


/* 정보 스타일 */
.hr-table-shop-modal {
	border: none;
	color: black;
	margin: 20px;
}
.hr-table-shop-modal #hr-table-shop-modal-data th {
	font-weight: bold;
	color: black;
	padding: 4px
}
.hr-table-shop-modal #hr-table-shop-modal-data td {
	color: black;
}
.hr-table-shop-modal #hr-table-shop-modal-data tr {
	margin: 4px
}

#hr-shop-table {
	margin: 16px 0;
}

.shop-status {
	border: 1px solid #0C808D;
	border-radius: 12px;
	color: #0C808D;
	padding: 0 4px;
}

#hr-table-empty {
	padding: 8px 0;
}


</style>

<!-- <div id="root">
   
    <button type="button" id="modal_open_btn">창 열기</button>
       
</div> -->

<div id="modal_l">
   
   <!-- 모달 내용 + 모달 버튼 -->
    <div class="modal_l_content">
    	
    	<!-- 모달 내용 -->
	    <div class="modal_l_detail">
		    <h4>판매 상세</h4>
	        
	        <div class="hr-table-shop-modal">
	        	<table id="hr-table-shop-modal-data">
	        			<tr>
	        				<th>주문 번호</th>
	        				<td>: 1</td>
	        			</tr>
	        			<tr>
	        				<th>주문 일시</th>
	        				<td>: 1</td>
	        			</tr>
	        			<tr>
	        				<th>결제 방법</th>
	        				<td>: 1</td>
	        			</tr>
	        			<tr>
	        				<th><div id="hr-table-empty"></div></th>
	        			</tr>
	        			
	        			<tr>
	        				<th>회원 번호</th>
	        				<td>: 123</td>
	        			</tr>
	        			<tr>
	        				<th>이름</th>
	        				<td>: 123</td>
	        			</tr>
	        			<tr>
	        				<th>연락처</th>
	        				<td>: 123</td>
	        			</tr>
	        			<tr>
	        				<th><div id="hr-table-empty"></div></th>
	        			</tr>
	        			
	        			<tr>
	        				<th>상태</th>
	        				<td>
		        				<div>
			                       	<select class="shop-status">
			                    		<option value="1">주문 완료</option>
										<option value="2">픽업 준비 완료</option>
										<option value="3">픽업 완료</option>
										<option value="4">취소</option>
			                    	</select>
			                    </div>
		                    </td>
	        			</tr>
	        			<tr>
	        				<th>마지막 상태 변경 시간</th>
	        				<td>: 2024/01/01</td>
	        			</tr>
	
	        	</table>
	        </div>
	        
	        
	        <!-- 상품 종류 -->
	        <div class="table-responsive">
        	<table class="table table-bordered" id="hr-shop-table" width="100%" cellspacing="0">
        		<thead>
        			<tr>
        				<th>상품 번호</th>
        				<th>상품 이름</th>
        				<th>상품 수량</th>
        				<th>상품 가격</th>
        			</tr>
        		</thead>
        		<tbody>
        			<tr >
        				<td>1234</td>
        				<td>1234</td>
        				<td>1234</td>
        				<td>1234</td>
					</tr>
					<tr>
        				<td>1234</td>
        				<td>1234</td>
        				<td>1234</td>
        				<td>1234</td>
					</tr>
				
        		</tbody>
        	</table>
        </div>
        
        <!--  -->
        <div class="hr-table-shop-modal">
        	<table id="hr-table-shop-modal-data">
        			<tr>
        				<th>총 결제 금액</th>
        				<td>: 1000000</td>
        			</tr>
        	</table>
        </div>
	        
	    </div>
       
		<!-- 모달 버튼 -->
        <div class="modal_l-content-btn">
	        <input type="submit" value="수정하기">
	        <button type="button" id="modal_close_btn">목록으로</button>
        </div>
       	
       
    </div>
   
    <div class="modal_l_layer"></div>
</div>


<script>

	/* 모달 열기 */
	$('#dataTable tbody tr').click(function() {
   		$("#modal_l").css("display","block");
   	})
	
   	/* 모달 닫기 */
   	$('#modal_close_btn').click(function() {
   		$("#modal_l").css("display","none");
   	})

</script>

