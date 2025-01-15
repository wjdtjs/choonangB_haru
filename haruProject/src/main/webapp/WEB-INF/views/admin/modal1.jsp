<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

</style>


<div id="modal_l">
   
    <div class="modal_l_content">
    
    	<div class="modal_l_detail">
    		<h2>제목</h2>
    		
    		<!-- 모달에 들어갈 컨텐츠 -->
    		
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
	$('#modal_open_btn').click(function() {
   		$("#modal_l").css("display","block");
   	})
	
   	/* 모달 닫기 */
   	$('#modal_close_btn').click(function() {
   		$("#modal_l").css("display","none");
   	})

</script>

