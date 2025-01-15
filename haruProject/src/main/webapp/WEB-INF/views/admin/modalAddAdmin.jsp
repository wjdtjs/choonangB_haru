<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

#modal {
	display: none;
 	position:absolute;
  	width:100%;
  	height:100%;
  	z-index:999;
  	top: 55px;
}

#modal h2 {
  	margin:0;
  	color: #0C808D;
  	font-weight: bold;
}

.modal_content {
	position: relative; /* 자식 요소가 부모 요소를 기준으로 위치 설정할 수 있도록 함 */
  	width: 1100px;
  	height: 777px;
  	margin: auto;
  	padding:40px 40px;
  	background:#fff;
  	border-radius: 24px;
  	/*스크롤 */
  	max-height: calc(100vh - 200px);
    overflow-y: auto;
    
}

.modal_content button {
	position: absolute; /* 부모요소를 기준으로 고정 */
	border-radius: 5px;
  	width: 115px;
  	height: 52px;
  	font-size: 20px;
  	right: 40px;
  	bottom: 40px;
  	
  	border: white;
  	color: white;
  	background-color: #0C808D;
  	font-weight: bold;
  
}

.inputForm {
	width: 100%;
	height: 100%;
	display: flex;
}

.inputForm > input {
	position: absolute; /* 부모요소를 기준으로 고정 */
	border-radius: 5px;
  	width:115px;
  	height:52px;
  	font-size: 20px;
  	right: 170px;
  	bottom: 40px;
  	
  	border: white;
  	color: white;
  	background-color: #B9B9B9;
  	font-weight: bold; 
}

.inputTable {
	color: #000;
	margin: auto;
	
}

.inputTable tr {
	margin: 10px;
	justify-content: center;
}

.inputTable th {
	width: 100px;
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

#modal .modal_layer {
  	position:fixed;
  	top:0;
  	left:0;
  	width:100%;
  	height:100%;
  	background:rgba(0, 0, 0, 0.5);
  	z-index:-1;
}   
</style>


<!-- <div id="root">
   
    <button type="button" id="modal_open_btn">창 열기</button>
       
</div> -->

<div id="modal">
    <div class="modal_content">
        <h2>관리자 추가</h2>
        <form action="addAdmin" method="post" name="frm" class="inputForm">
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
	        
		     <input type="submit"  value="등록하기">
		     <button type="button" id="modal_close_btn">목록으로</button>

        
        </form>
       
    </div>
   
    <div class="modal_layer"></div>
</div>

<script>

	$('#modal_open_btn').click(function() {
   		$("#modal").css("display","block");
   	})
		
   	$('#modal_close_btn').click(function() {
   		$("#modal").css("display","none");
   	})

</script>

