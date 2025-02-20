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
    
    <title>근무 관리</title>

</head>
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
	background-position: 98% center;
}
em {
	color: red;
	justify-content: center;

}
</style>

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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold">일정 추가</h1>
                    <div class="modal_l_detail">
                    <form action="/admin/addSchedule" method="post" name="frm" id="add_schedule" >
				       <table class="inputTable">
			        	<colgroup>
			        		<col width="15%">
			        		<col width="35%">
			        		<col width="15%">
			        		<col width="35%">
			        	</colgroup>
				        <tr>
				        	<th>구분<em>*</em></th>		<td><select class="form-input sub-schetype-mcd-select" name="schtype_mcd">
				        											<c:forEach var="schtype" items="${schtypes}">
				        												<option value="${schtype.mcd }">${schtype.content  }</option>
				        											</c:forEach>
				        										</select></td>
				        	<th>휴무날짜<em>*</em></th>	<td><input class="form-input" type="date" name="offday1" required="required"></td>
				        
				        </tr>
	                    <tr>
				        	<th class="add-input-aname" style="opacity: 0">의사이름<em>*</em></th>
				        	<td class="add-input-aname" style="opacity: 0">
				        		<input class="form-input search-aname-input" type="text" name="aname">
				        		
				        	</td>
				        	<th></th>
				        	<td class="add-input-offday" style="opacity: 0">
				        								<input class="form-input" type="date" name="offday2" >
			        		</td>
				        </tr>
	                    <tr>
			        		<th></th>
			        		<td>
			        			<select class="form-input search-aname-result" name="ano"  style="display:none"></select>
			        		</td>			
			        	</tr>			        
				      
			        

			        </table>
	       			 </form>
	       			 </div>
	       			 <!-- 모달 버튼 -->
			       	<div class="modal_l-content-btn">
				       	<button type="button" class="to_list" id="detail_close_btn" onclick="history.back()">목록으로</button>
			            <button type="submit" class="admin_modal update_btn" id="update_btn" form="add_schedule">등록하기</button>
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
<script type="text/javascript">
 $(document).on('change','.sub-schetype-mcd-select',function(){
	 const schtype = $(this).val();
	 
	 const $offdayInput = $('.add-input-offday input[name="offday2"]');
	 const $anameInput = $('.add-input-aname input[name="aname"]');

	 if (schtype == 100) {
	     $('.add-input-offday, .add-input-aname').css('opacity', '0').prop('disabled', true);
	     $offdayInput.removeAttr('required');
	     $anameInput.removeAttr('required');
	 } else if (schtype == 200) {
	     $('.add-input-offday, .add-input-aname').css('opacity', '1').prop('disabled', false);
	     $offdayInput.attr('required', 'required');
	     $anameInput.attr('required', 'required');
	 } else if (schtype == 300) {
	     $('.add-input-offday').css('opacity', '0').prop('disabled', true);
	     $('.add-input-aname').css('opacity', '1').prop('disabled', false);
	     $offdayInput.removeAttr('required');
	     $anameInput.attr('required', 'required');
	 }
 });
 
 // 사원명 검색
 $(document).on('keydown','.search-aname-input',function(event){
	 if(event.keyCode === 13){
		 event.preventDefault(); // 기본 엔터 동작(폼 제출) 방지
		 
		 const keyword = $('.search-aname-input').val().trim();
		 console.log('keyword: '+keyword);
		 
		 const dropAname = document.querySelector(".search-aname-result");

	    
		$.ajax({
			 url: '<%=request.getContextPath()%>/api/searchAname',
			 type: 'Get',
			 data: {
				 keyword: keyword
			 },
			 dataType: 'json',
			 success: function(response) {
				 console.log('response->'+response);
				 console.log('response.length ->'+response.length);
				 console.log('response-> '+ JSON.stringify(response));
				 
				 if (response.length > 0) {
			    	 dropAname.style.display = "block";
			     }else {
			    	 dropAname.style.display = "none";
			    	 alert('사원정보가 없습니다. 다시 입력해주세요.');
			    	 return;
			     }
				 
			 	 let str = '<option value="" selected disabled>사원선택</option>';
			 	 
			 	$(response).each(function(index, item) {
			 		str += `<option value="\${item.ANO}">\${item.ANAME} (\${item.ANO})</option>`;
			 	 })

			 	 $('.search-aname-result').html(str);
			 },
			 error: function(xhr, status, error) {
		            console.error("사원 이름 데이터를 가져오는 중 오류 발생:", error);
		        }
		 }) 
	 }
 });
  $(document).on('change','.search-aname-result',function(){
	  const selectedMem = $(this).find('option:selected').text();;
	  $('.search-aname-input').val(selectedMem);
	  $('.search-aname-result').css('display','none');
	  
	  
	  
 }) 
</script>
</html>