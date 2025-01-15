<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

/* 상세 정보 스타일 */

.hr-table-board-modal {
	border: none;
	color: black;
	margin: 20px;
}
.hr-table-board-modal #hr-table-board-modal-data th {
	font-weight: bold;
	color: black;
	padding: 4px
}
.hr-table-board-modal #hr-table-board-modal-data td {
	color: black;
}
.hr-table-board-modal #hr-table-board-modal-data tr {
	margin: 4px
}

#hr-board-table {
	margin: 16px 0;
}

#hr-table-empty {
	padding: 8px 0;
}

#hr-board-text {
	border: white;
	border-radius: 24px;
	width: 1000px;
	height: 220px;
	background-color: rgba(12, 128, 141, 0.1);
	color: black;
	font-size: 16px;
	
	padding: 16px 24px;
	margin: 0 auto; // 가운데 정렬
}

.modal_l_content p {
	color: black;
	padding: 0 24px;
	font-size: 20px;
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
	    	<h4>후기 상세</h4>
	        
	        <div class="hr-table-board-modal">
	        	<table id="hr-table-board-modal-data">
	        			<tr>
	        				<th>게시글 번호</th>
	        				<td>: 1</td>
	        			</tr>
	        			<tr>
	        				<th>예약 번호</th>
	        				<td>: 1</td>
	        			</tr>
	        			<tr>
	        				<th>예약 분류</th>
	        				<td>: 1</td>
	        			</tr>
	        			<tr>
	        				<th><div id="hr-table-empty"></div></th>
	        			</tr>
	        			
	        			<tr>
	        				<th>작성자</th>
	        				<td>: 123</td>
	        			</tr>
	        			<tr>
	        				<th>작성일</th>
	        				<td>: 123</td>
	        			</tr>
	        			<tr>
	        				<th>마지막 수정일</th>
	        				<td>: 123</td>
	        			</tr>
						<tr>
	        				<th>조회수</th>
	        				<td>: 123</td>
	        			</tr>
	        	</table>
	        </div>
	        
	        <p>글 제목</p>
	        <div id="hr-board-text">
	        글 내용
	        </div>
    	</div>
        
        <!-- 모달 버튼 -->
        <div class="modal_l-content-btn">
        	<input type="submit" value="삭제하기">
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

