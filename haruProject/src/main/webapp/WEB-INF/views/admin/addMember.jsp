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

    <title>회원 등록</title>

</head>

<script type="text/javascript">
	let id_dupl_check = false;
	
	function valid() {
		let result = true;
		
		const passwd = frm.mpasswd.value;
		const name = frm.mname.value;
		const tel = frm.mtel.value;
		
		if(id_dupl_check) {console.log(1)} else {console.log(2)}
		
		let str="";
		if(!id_dupl_check) {
			console.log('e')
			str+= '이메일 중복체크를 해주세요.\n'; //이메일 중복 체크
	        result = false;
		}
		
	    if(!checkRegex(tel, '^01([0|1|6|7|8|9])[0-9]{3,4}[0-9]{4}$')) {
	    	str+='잘못된 핸드폰번호 입니다.\n';
	        result = false;
	    }
	    
	    if(!result)
	    	alert(str);
		
		return result;
	}

	
	function fn_dbCheckId() {
		const email = frm.memail.value;
		console.log('memail:'+email);
		
		if(!isEmpty(email) || !checkRegex(email, '^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')) {
		  	alert('올바르지 않은 이메일입니다.');
	   	} else {
		   
		   $.ajax({
				url: "<%=request.getContextPath()%>/api/dbCheckId",
				method: 'POST',
				contentType:"application/json",
				data: JSON.stringify({
					memail: email
				}),
				success: function(data){
					console.log(data)
					
					if(data>0) {
						alert('이미 존재하는 이메일입니다.');
						$('.form-input.email').val('');
					} else {
						alert('사용 가능한 이메일입니다.');
						$('.form-input.email').attr('readonly', true);
						$('.verifi_btn.id_dupl').attr("disabled", true);
						id_dupl_check = true;
						
					}
				}
			})
	   }
	}
	
	   $(()=>{
		   const $passwd = $('.form-input[name=mpasswd]');
		   $passwd.keyup(function() {
	 		   let text = $passwd.val()
	 		   console.log(text);
	 		   	$('.form-input[name=re_mpasswd]').val(text);
	 		   console.log($('.form-input[name=re_mpasswd]').val());
	 	   })         
	   })
	
</script>

<!-- style -->
<style>

.inputTable{
	color: black;
	width: 100%;
}
.form-input-title {
	height: 50px;
	font-weight: 500;
	margin:4px 12px;

}

.inputTable tr {
	height: 50px;

}
td > button {
	border-radius: 10px;
	border: none;
	height: 35px;
	font-size: 14px;
}
.verifi_btn.id_dupl:disabled {
	background: #d9d9d9;
}

.form-input{
	width: 90%;
	height: 35px;
	border: 1.5px solid var(--haru);
	border-radius: 10px;
	padding-left: 10px;
}
/* SELECT 버튼 위치 수정*/
select {
	background-position: 95% center;
}
em {
	color: red;
	justify-content: center;

}
</style>

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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >회원 등록</h1>
                    
                    <div class="modal_l_detail">
                    <form action="/admin/addMemberAction" method="post" name="frm" id="add_mb" onsubmit="return valid()">
				       <table class="inputTable">
			        	<colgroup>
	                    	<col width="15%" />
	                        <col width="35%" />
	                        <col width="15%" />
	                        <col width="35%" />
	                    </colgroup>
			        	<tr>
			        		<th>이름<em>*</em></th>		<td><input class="form-input" type="text" name="mname" required="required"></td>
			        		<th>이메일<em>*</em></th>	<td><input class="form-input email" type="text" name="memail" required="required" style="width: 70%;">
			        									<button type="button" class="btn-primary haru-tb-btn verifi_btn id_dupl" onclick="fn_dbCheckId()">중복확인</button>
			        	</tr>
			        	<tr>
			        		<th>전화번호<em>*</em></th>	<td><input class="form-input" type="text" name="mtel" required="required" placeholder="-없이 입력"></td>
			        		<th>비밀번호<em>*</em></th>	<td><input class="form-input" type="password" name="mpasswd" required="required" value="1234" readonly="readonly"></td>
			        									<td><input class="form-input" type="hidden" name="re_mpasswd" value="1234"></td>
			        	</tr>
			        	<tr>
			        		<th>개인정보동의여부</th>	
			        		<td>
			        			<select class="form-input sub-alevel-mcd-select" name="is_agree">
			        				<option value="0" selected>비동의</option>
			        				<option value="1">동의</option>
			        			</select>
							</td>
			        		
			        	</tr>
			        </table>
	       			 </form>
	       			 </div>
					<!-- 모달 버튼 -->
			       	<div class="modal_l-content-btn">
				       	<button type="button" class="to_list" id="detail_close_btn" onclick="location.href='/admin/members'">목록으로</button>
			            <button type="submit" class="admin_modal update_btn" id="update_btn" form="add_mb">등록하기</button>
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