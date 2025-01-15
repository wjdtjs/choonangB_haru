<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
.inputTable th {
	width: 100px;
	height: 50px;
}

.inputTable td {
	width: 300px;
	height: 50px;
}

.form-input{
	width: 200px;
	height: 35px;
	border: 1.5px solid var(--haru);
	border-radius: 10px;
}
</style>


<div id="modal_l">
   
    <div class="modal_l_content">
    
    	<div class="modal_l_detail">
    		<h4>관리자추가</h4>
    		
    		<!-- 모달에 들어갈 컨텐츠 -->
    		<form action="addAdmin" method="post" name="frm" class="inputForm" id="add_ad">
		        <table class="inputTable">
		        	<tr>
		        		<th>사번</th>		<td><input class="form-input" type="number" name="ano" required="required"></td>
		        		<th>비밀번호</th>	<td><input class="form-input" type="text" name="apasswd02" required="required"></td>
		        	</tr>
		        	<tr>
		        		<th>이름</th>		<td><input class="form-input" type="text" name="aname" required="required"></td>
		        		<th>비밀번호확인</th><td><input class="form-input" type="text" name="apasswd01" required="required"></td>
		        	</tr>
		        	<tr>
		        		<th>전화번호</th>	<td><input class="form-input" type="text" name="atel"></td>
		        		<th>입사일</th>	<td><input class="form-input" type="text" name="hiredate" required="required"></td>
		        	</tr>
		        	<tr>
		        		<th>이메일</th>	<td><input class="form-input" type="text" name="aemail"></td>
		        		<th>Role</th>
		        		<td><select class="form-input" name="alevel" >
		        				<option value="a">최고관리자</option>
		        				<option value="d">의사</option>
		        				<option value="m">매니저</option>
		        			</select>
		        		</td>
		        	</tr>
		        </table>
	        </form>
    	</div>
       
       <!-- 모달 버튼 -->
       	<div class="modal_l-content-btn">
	       	<button type="button" class="admin_modal" id="modal_close_btn">목록으로</button>
            <button type="submit" class="admin_modal" id="update_btn" form="add_ad">등록하기</button>
       	</div> 
       
    </div>
   
    <div class="modal_l_layer"></div>
</div>

<script>
	
	/* 모달 열기 */
	$('#modal_open_btn.admin_modal').click(function() {
   		$("#modal_l").css("display","block");
   	})
	
   	/* 모달 닫기 */
   	$('#modal_close_btn.admin_modal').click(function() {
   		$("#modal_l").css("display","none");
   	})

</script>

