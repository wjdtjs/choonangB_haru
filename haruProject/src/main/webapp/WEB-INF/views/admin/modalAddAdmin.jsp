<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$("#modal_open_btn.admin_modal").click((e) => {
	console.log('ajax')
	let alevelBCD = "";
	$.ajax({
		url: "<%=request.getContextPath()%>/api/alevel-mcd",
		data: {},
		dataType: 'json',
		success: function(data){
			console.log(data.alevelList)
			let str = "";
			$(data.alevelList).each(function(){
				str += `<option value="\${this.MCD}">\${this.CONTENT}</option>`;
			})
			
			$('.sub-mcd-select').html(str);
		}
	})
})

</script>

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


<div id="modal_l">
   
    <div class="modal_l_content">
    	<h4>관리자추가</h4>
    	<div class="modal_l_detail">
    		
    		<!-- 모달에 들어갈 컨텐츠 -->
    		<form action="/api/addAdmin" method="post" name="frm" id="add_ad" onsubmit="return validateForm()">

		        <table class="inputTable">
		        	<colgroup>
                    	<col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
                    </colgroup>
		        	<tr>
		        		<!-- <th>사번</th>		<td><input class="form-input" type="number" name="ano" required="required"></td> -->
		        		<th>이름</th>		<td><input class="form-input" type="text" name="aname" required="required"></td>
		        		<th>비밀번호</th>	<td><input class="form-input" type="password" name="apasswd" required="required"></td>
		        	</tr>
		        	<tr>
		        		<th>전화번호</th>	<td><input class="form-input" type="text" name="atel" required="required" placeholder="000-0000-0000"></td>
		        		<th>비밀번호확인</th><td><input class="form-input" type="password" name="re_apasswd" required="required"></td>
		        	</tr>
		        	<tr>
		        		<th>이메일</th>	<td><input class="form-input" type="text" name="aemail"></td>
		        		<th>Role</th>
		        		<td>
		        			<select class="form-input sub-mcd-select" name="mcd"></select>
		        		</td>
		        	</tr>
		        	<tr>
		        		<th>입사일</th>	<td><input class="form-input" type="text" name="hiredate" required="required" placeholder="YYYY/MM/DD"></td>
		        		
		        	</tr>
		        </table>
	        </form>
    	</div>
       
       <!-- 모달 버튼 -->
       	<div class="modal_l-content-btn">
	       	<button type="button" class="admin_modal to_list" id="modal_close_btn">목록으로</button>
            <button type="submit" class="admin_modal update_btn" id="update_btn" form="add_ad">등록하기</button>
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
   		$('.form-input').val('');
   		
   		$("#modal_l").css("display","none");
   	})

   	
   	function validateForm() {
		let result = true;
		
		let pw 	  = $('.form-input[name=apasswd]').val();
		let re_pw = $('.form-input[name=re_apasswd]').val();
		let tel   = $('.form-input[name=atel]').val();
		
		console.log('tel ',tel)
		
		let str = "";
		
		if(pw != re_pw) {
			str+='비밀번호가 일치하지 않습니다.\n';
			result = false;
		}
		if(!checkRegex(pw, '^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,}$')) {
	    	str+='비밀번호는 영문, 숫자, 특수문자를 최소 1개씩 조합하여 8자 이상\n'; //비밀번호 체크
	        result = false;
     	}

      	if(!checkRegex(tel, '^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$')) {
    	  	str+='잘못된 핸드폰번호 입니다.\n';
         	result = false;
      	}
      	
      	if(!result)
       	  	alert(str);
		
		return result;
	}t
</script>

