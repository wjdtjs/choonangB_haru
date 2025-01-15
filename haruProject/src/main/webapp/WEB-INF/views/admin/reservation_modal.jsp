<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<style>

/* 모달 클래스 이름 겹치는 것 땜에 추가 */
#modal_l_res {
	display: none;
 	position:absolute;
  	width:100%;
  	height:auto;
  	z-index:999;
  	top: 55px;
}
#modal_l_res .modal_l_layer {
  	position:fixed;
  	top:0;
  	left:0;
  	width:100%;
  	height:100%;
  	background:rgba(0, 0, 0, 0.5);
  	z-index:-1;
}
#modal_l_res h4 {
  	margin:0;
  	color: #0C808D;
  	font-weight: bold;
}

/*  */

#hr-res {
	display: flex;
}

/* 달력 */
#hr-res-left {
	width:400px;
	height: 100%;
	margin: 0;
	padding: 0;
}


/* 내용 */

#hr-res-right {
	display: flex;
	flex-direction: column;
}

.hr-table-res-modal {
	border: none;
	color: black;
	margin: 20px;
}
.hr-table-res-modal #hr-table-res-modal-data th {
	font-weight: bold;
	color: black;
	padding: 4px 12px;
}
.hr-table-res-modal #hr-table-res-modal-data td {
	color: black;
}
.hr-table-res-modal #hr-table-res-modal-data tr {
	margin: 4px
}


.hr-res-table {
	margin: 16px 20px;
}

#hr-res-table-data {
	border-radius: 24px;
	background-color: rgba(12, 128, 141, 0.1);
	font-size: 20px;
	text-align: center;
	color: black;
	font-weight: bold; 
	margin: 20px autos;
}

#hr-res-table-data td {
	padding: 12px;
}
	
#hr-table-empty {
	padding: 8px;
}


.modal_l_content p {
	color: black;
	padding: 12px 24px;
	font-size: 18px;
	font-weight: bold;
	margin: 0;
}

#hr-res-memo {
	margin: 0 24px;
}

#hr-res-memo textarea {
	border-radius: 24px;
	background-color: rgba(12, 128, 141, 0.1);
	padding: 16px;
	border: white;
}

#hr-table-res-modal-data select {
	border: 1px solid #0C808D;
	border-radius: 12px;
	color: black;
	padding: 2px 4px;
	font-size: 14px;	
}


</style>


<!-- <div id="root">
   
    <button type="button" id="modal_open_btn">창 열기</button>
       
</div> -->

	<div id="modal_l_res">
	   
	   <!-- 모달 내용 + 모달 버튼 -->
	    <div class="modal_l_content">
	    	<!-- 모달 내용 -->       
	        <div class="modal_l_detail">
	        	<h4>예약 추가</h4>
	        	<!-- 제목을 제외한 컨텐츠 -->
	        	<div id="hr-res">
	        	
		        	<div id="hr-res-left">
		        		<p>예약 날짜</p>
		        		<div id="res-calendar"></div>
		        	</div>
		        	
		        	<div id="hr-res-right">
		        		<div class="hr-table-res-modal">
				        	<table id="hr-table-res-modal-data">
				        			<tr>
				        				<th>예약 항목</th>
				        				<td>
				        					<div>
						                       	<select id="res-content">
						                    		<option value="1">일반 진료</option>
													<option value="2">접종</option>
													<option value="3">수술</option>
													<option value="4">건강검진</option>
						                    	</select>
						                    </div>
				        				</td>			        						        								        				
				        			</tr>
				        			<tr>
				        				<th><div id="hr-table-empty"></div></th>
				        			</tr>
				        			<tr>
				        				<th>세부 항목</th>
				        				<td>
				        					<div>
						                       	<select id="res-detail">
						                    		<option value="1">내과</option>
													<option value="2">치과</option>
													<option value="3">정형외과</option>
													<option value="4">이비인후과</option>
						                    	</select>
						                    </div>
				        				</td>
				        			</tr>
				        			<tr>
				        				<th><div id="hr-table-empty"></div></th>
				        			</tr>
				        			<tr>
				        				<th>담당의</th>
				        				<td>
				        					<div>
						                       	<select id="res-doc">
						                    		<option value="1">이제노 선생님</option>
													<option value="2">박원빈 선생님</option>
						                    	</select>
						                    </div>
				        				</td>
				        			</tr>				        			
				        			<tr>
				        				<th><div id="hr-table-empty"></div></th>
				        			</tr>
				        			<tr>
				        				<th><div id="hr-table-empty"></div></th>
				        			</tr>
				        			
				        			<tr>
				        				<th>보호자</th>
				        				<td>: 1</td>
				        			</tr>
				        			
				        			<tr>
				        				<th>동물이름</th>
				        				<td>: 이름</td>
				        			</tr>
				
				
				
				        	</table>
				        </div>
				        
				        <p>예약 메모</p>
				        <div id="hr-res-memo">
				        	<textarea rows="10" cols="70" placeholder="예약 메모를 입력해주세요."></textarea>
				        </div>
	        		
		        	</div>
		        
	        	</div>
	        	
	        
		        
	        </div>
	        
	        <!-- 모달 버튼 -->
	        <div class="modal_l-content-btn">
	        	<button type="button" class="res_modal" id="modal_close_btn">목록으로</button>
	        	<button type="submit" class="res_modal" id="update_btn">예약 추가</button>
	        </div>
	
	       
	    </div>
	   
	    <div class="modal_l_layer"></div>
	</div>


<script>
	
	/* 모달 열기 */
	$('#modal_open_btn.res_modal').click(function() {
   		$("#modal_l_res").css("display","block");
   	})

   	/* 모달 닫기 */
   	$('#modal_close_btn.res_modal').click(function() {
   		$("#modal_l_res").css("display","none");
   	})

</script>

