<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 차트 상세 모달 -->
<style>

/* 진료 관리에서는 차트상세, 차트추가 모달이 두 개 필요해서 모달 열 때 클래스 이름이 겹쳐서 안 열릴 수도 있기 때문에
   modal_l_con 처럼 따로 정해둔 것!! */

/* 모달 클래스 이름 겹치는 것 땜에 추가 */
#modal_l_con {
	display: none;
 	position:absolute;
  	width:100%;
  	height:auto;
  	z-index:999;
  	top: 55px;
}
#modal_l_con .modal_l_layer {
  	position:fixed;
  	top:0;
  	left:0;
  	width:100%;
  	height:100%;
  	background:rgba(0, 0, 0, 0.5);
  	z-index:-1;
}
#modal_l_con h4 {
  	margin:0;
  	color: #0C808D;
  	font-weight: bold;
}


.modal_l_content p {
	color: black;
	padding: 12px 24px;
	font-size: 18px;
	font-weight: bold;
	margin: 0;
}

#hr-con-memo {
	margin: 0 24px;
}

#hr-con-memo textarea {
	border-radius: 24px;
	background-color: rgba(12, 128, 141, 0.1);
	padding: 16px;
	border: white;
}


#res_input {
	width: 136px;
	height: 28px;
	margin: 4px 12px;
	border: 1px solid var(--haru);
	border-radius: 12px;
	padding: 0 12px;
}


</style>


	<div id="modal_l_con">
	   
	   <!-- 모달 내용 + 모달 버튼 -->
	    <div class="modal_l_content">
	    	<!-- 모달 내용 -->       
	        <div class="modal_l_detail">
	        	<h4>차트 상세</h4>
	        	
		        		<div class="hr-table-con-modal">
				        	
				        	<!-- 내용, 테이블 -->
				        	
				        </div>
				        
				        <p>차트 내용</p>
				        <div id="hr-con-memo">
				        	<textarea rows="10" cols="70" placeholder="예약 메모를 입력해주세요."></textarea>
				        </div>
				        
				        <p>기타 / 전달사항</p>
				        <div id="hr-con-memo">
				        	<textarea rows="10" cols="70" placeholder="예약 메모를 입력해주세요."></textarea>
				        </div>        		      	
	        
		        
	        </div>
	        
	        <!-- 모달 버튼 -->
	        <div class="modal_l-content-btn">
	        	<button type="button" class="con_modal to_list" id="modal_close_btn">목록으로</button>
	        	<button type="submit" class="con_modal" id="update_btn">예약 추가</button>
	        </div>
	
	       
	    </div>
	   
	    <div class="modal_l_layer"></div>
	</div>


<script>
	
	/* 모달 열기 */
	$('#chart_modal_open_btn.con_modal').click(function() {
   		$("#modal_l_con").css("display","block");
   	})

   	/* 모달 닫기 */
   	$('#modal_close_btn.con_modal').click(function() {
   		$("#modal_l_con").css("display","none");
   	})

</script>

