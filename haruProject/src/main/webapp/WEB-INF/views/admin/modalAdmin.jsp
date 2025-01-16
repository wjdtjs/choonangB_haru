<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <script type="text/javascript">


// 테이블 행 클릭 이벤트
$(document).on('click','#dataTable .adminTable tr',function(){
		// 클릭된 행의 데이터 추출
		const ano = $(this).find('td:nth-child(1)').text();
		
		console.log('클릭된 행의 ano 값:',ano);
		
	    $('#ano').text(ano); // 사번 표시
	    $('#hidden_ano').val(ano); // 사번 표시
	   
		
		$.ajax({
			url: "<%=request.getContextPath()%>/api/getAdminDetails",
			type: 'GET',
			data: {ano: ano},
			dataType: 'json',
			success: function(data){
				console.log(data);
				
				/* input 태그에 데이터 전달 */
				$('#aname').val(data.aname);
				$('#atel').val(data.atel);
				$('#aemail').val(data.aemail);
				
				/* td 태그에 데이터 전달 */
				const hiredate = data.hiredate.split("T")[0];
				const reg_date = data.reg_date.split("T")[0];
				
				$('#hiredate').text(hiredate);
				$('#reg_date').text(reg_date);
				
				/*옵션 selected*/
				
				SelectedOption(data);
 				
				
			}
		})
		
		function SelectedOption (adminData){
	    	let alevelBCD = adminData.alevel_bcd;
	    	let astatusBCD = adminData.astatus_bcd;
		   	let selectedAlevelMCD = adminData.alevel_mcd;
		    let selectedAstatusMCD = adminData.astatus_mcd;
		    
			$.ajax({
				url: "<%=request.getContextPath()%>/api/admin-common",
				data: {},
				dataType: 'json',
				success: function(response){
					let alevelStr = "";
					let statusStr = "";
						$(response.adminCommon).each(function(){
							if (this.BCD == alevelBCD){
								let selected = (this.MCD == selectedAlevelMCD) ? 'selected' : '';
								alevelStr += `<option value="\${this.MCD}" \${selected}>\${this.CONTENT}</option>`;
							}
							else if (this.BCD == astatusBCD){
								let selected = (this.MCD == selectedAstatusMCD) ? 'selected' : '';
								statusStr += `<option value="\${this.MCD}" \${selected}>\${this.CONTENT}</option>`;
							}
							
						});
						$('.sub-alevel-mcd-select').html(alevelStr);
						$('.sub-status-mcd-select').html(statusStr);
					}
			})
	    }
		
	   	$(".detailAdmin").css("display","block");

		

});

</script> --%>

<style>
.inputTable {
	margin: 20px AUTO;
}
.inputTable th {
	width: 100px;
	height: 50px;
	font-weight: bold;
	margin:4px 12px;
	color: black;
	
}

.inputTable td {
	width: 300px;
	height: 50px;
	color: black;
}

.form-input{
	width: 200px;
	height: 35px;
	border: 1.5px solid var(--haru);
	border-radius: 10px;
	padding-left: 10px;
}
/* SELECT 버튼 위치 수정*/
select {
	background-position: 95% center;
}

</style>


<div id="modal_l" class="detailAdmin">
   
    <div class="modal_l_content">
    
    	<div class="modal_l_detail">
    		<h4>관리자수정</h4>
    		
    		<!-- 모달에 들어갈 컨텐츠 -->
    		<form action="/updateAdmin" method="post" name="frm" id="upd_ad">

		        <table class="inputTable">
		        	<colgroup>
                    	<col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
                    </colgroup>
		        	<tr>
		        		<th>사번</th>		<td id="ano"><input type="hidden" name="ano" id="hidden_ano"></td>
		        		<th>비밀번호</th>	<td><input class="form-input" type="text" name="apasswd" required="required"></td>
		        	</tr>
		        	<tr>
		        		<th>이름</th>		<td><input class="form-input" type="text" name="aname" required="required" id="aname"></td>
		        		<th>비밀번호확인</th><td><input class="form-input" type="text" name="re_apasswd" required="required"></td>
		        	</tr>
		        	<tr>
		        		<th>전화번호</th>	<td><input class="form-input" type="text" name="atel" required="required" id="atel"></td>
		        		<th>이메일</th>	<td><input class="form-input" type="text" name="aemail" id="aemail"></td>
		        	</tr>
		        	<tr>
		        		<th>Role</th>
		        		<td>
		        			<select class="form-input sub-alevel-mcd-select" name="alevelMcd"></select>
		        		</td>
		        		<th>입사일</th>	<td id="hiredate"></td>
		        		
		        		
		        	</tr>
		        	<tr>
		        		<th>상태</th>
		        		<td>
		        			<select class="form-input sub-status-mcd-select" name="astatusMcd" ></select>
		        		</td>
		        		<th>등록일</th>	<td id="reg_date"></td>
		        		
		        		
		        	</tr>
		        </table>
	        </form>
    	</div>
       
       <!-- 모달 버튼 -->
       	<div class="modal_l-content-btn">
	       	<button type="button" class="admin_modal to_list" id="modal_close_btn">목록으로</button>
            <button type="submit" class="admin_modal update_btn" id="update_btn" form="upd_ad">수정하기</button>
       	</div> 
       
    </div>
   
    <div class="modal_l_layer"></div>
</div>

<script>
	/* 모달 열기
 	$('#modal_open_btn.admin_modal').click(function() {
	   	$("#modal_l").css("display","block");
	}) */
	   	
	 /* 모달 닫기 */
	 $('#modal_close_btn.admin_modal').click(function() {
	   	$("#modal_l.detailAdmin").css("display","none");
	 })
	
</script>

