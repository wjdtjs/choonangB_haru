<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- 예약 상세 모달 -->

<style>

.modal_l_detail_title{
	display: flex;
	align-items: center;
}


button#res_status {
	width: 52px;
	height: 20px;
	font-size: 12px;
	border: 1px solid #0C808D;
	color: #0C808D;
	background-color: white;
	border-radius: 12px;
	line-height: 12px;
	text-align: center;
	margin: 0;
}

p#title  {
  	margin:0;
  	color: #0C808D;
  	font-weight: bold;
  	font-size: 24px;
}

/* 모달버튼 스타일 */
.modal_l_content button {
	border-radius: 5px;
  	width: 92px;
  	height: 40px;
  	font-size: 16px;
  	
  	border: white;
  	color: white;
  	background-color: #0C808D;
  	font-weight: bold;
  	
  	margin: 0 10px;
}

/* 목록으로 */
button#res-modal-1-btn1 {
    background-color: #b9b9b9;
}
/* 예약 거절 */
button#res-modal-1-btn2 {
    background-color: #A6D6C6;
}

/* 예약 상세 정보 스타일 */
.hr-table-appo-modal {
	border: none;
	color: black;
	margin: 20px;
}
.hr-table-appo-modal #hr-table-appo-modal-data th {
	font-weight: bold;
	color: black;
	padding: 4px
}
.hr-table-appo-modal #hr-table-appo-modal-data td {
	color: black;
	padding: 0 8px;
}
.hr-table-appo-modal #hr-table-appo-modal-data tr {
	margin: 4px
}

/* 동물 정보 */
.hr-appo-table {
	margin: 16px 20px;
}

#hr-appo-table-data {
	border-radius: 24px;
	background-color: rgba(12, 128, 141, 0.1);
	font-size: 20px;
	text-align: center;
	color: black;
	font-weight: bold; 
	margin: 20px autos;
}

#hr-appo-table-data td {
	padding: 12px;
}
	
#hr-table-empty {
	padding: 8px;
}

#medical-time {
	border: 1px solid #0C808D;
	border-radius: 12px;
	color: #0C808D;
	padding: 1px 32px 1px 12px;
	margin: 0 12px;
	font-size: 16px;
	text-align: center;
}

.modal_l_content p {
	color: black;
	padding: 0 24px;
	font-size: 20px;
	font-weight: bold;
}

#hr-appo-memo {
	display: flex;
	justify-content: center;
}

#hr-appo-memo textarea {
	border-radius: 24px;
	background-color: rgba(12, 128, 141, 0.1);
	padding: 16px;
	border: white;
}


</style>


<div id="modal_l">
   
   <!-- 모달 내용 + 모달 버튼 -->
    <div class="modal_l_content">
    	<!-- 모달 내용 -->       
        <div class="modal_l_detail">
        	<!-- 모달 제목 + 예약 상태 -->
        	<div class="modal_l_detail_title">
	        	<p id="title">예약 상세</p>
	        	<button id="res_status">상태</button>
	        </div>
        
	        <div class="hr-table-appo-modal">
	        	<table id="hr-table-appo-modal-data">
	        			<tr>
	        				<th>예약 번호</th>
	        				<td id="resno"></td>
	        			</tr>
	        			<tr>
	        				<th>예약 일시</th>
	        				<td id="rdate"></td>
	        				<td><div id="hr-table-empty"></div></td>
	        				<th>진료 소요 시간</th>
	        				<td>
	        					<div>
			                       	<select id="medical-time">
			                    		<option value="1">30분</option>
										<option value="2">60분</option>
										<option value="3">90분</option>
										<option value="4">120분</option>
			                    	</select>
			                    </div>
			                </td>
	        			</tr>
	        			<tr>
	        				<th><div id="hr-table-empty"></div></th>
	        			</tr>
	        			<tr>
	        				<th>진료 과목</th>
	        				<td id="item"></td>
	        			</tr>
	        			
	        			<tr>
	        				<th>담당의</th>
	        				<td id="aname"></td>
	        			</tr>
	        			<tr>
	        				<th><div id="hr-table-empty"></div></th>
	        			</tr>
	        			
	        			<tr>
	        				<th>보호자</th>
	        				<td id="mname"></td>
	        			</tr>
	
	
	
	        	</table>
	        </div>
	        
	        <p>동물 정보</p>
	        <div class="hr-appo-table">
	        	<table id="hr-appo-table-data" width="100%" cellspacing="0">
	        			<tr>
	        				<td>이름</td>
	        				<td>종+ 성별</td>
	        				<td>몸무게</td>
	        				<td>동물 번호</td>
	        			</tr>
	        	</table>
	        </div>
        
	        <p>예약 메모</p>
	        <div id="hr-appo-memo">
	        	<textarea rows="10" cols="125" placeholder="예약 메모를 입력해주세요."></textarea>
	        </div>
        </div>
        
        <!-- 모달 버튼 -->
        <div class="modal_l-content-btn">
        
        	<!-- 조건 -->
        	
<%--        1. 예약 상태가 대기일 때 -> 예약거절/확정 바꿀 수 있도록 해줌  	
			<c:if test="${true}">
                <button class="res-modal" id="res-modal-1-btn1">목록으로</button>
                <button class="res-modal" id="res-modal-1-btn2">예약 거절</button>
                <button class="res-modal" id="res-modal-1-btn3">예약 확정</button>
            </c:if>
            2. 예약 상태가 확정일 때 -> 진료 완료 버튼이 보이게
            <c:if test="${true}">
                <input type="submit" id="res-btn-2" value="진료 완료">
        		<button type="button" class="res_modal" id="modal_close_btn">목록으로</button>
            </c:if> 
            3. 예약 상태가 취소일 때 -> 목록으로 버튼만 보이게
            <c:if test="${true}">
        		<button type="button" class="res_modal" id="modal_close_btn">목록으로</button>
            </c:if> 
            --%>

                <button class="res-modal to_list" id="res-modal-1-btn1">목록으로</button>
                <button class="res-modal" id="res-modal-1-btn2">예약 거절</button>
                <button class="res-modal" id="res-modal-1-btn3">예약 확정</button>
            
<!--         	<button type="button" class="res_modal to_list" id="modal_close_btn">목록으로</button>
         	<button type="submit" class="res_modal" id="update_btn">진료 완료</button> -->
       	
        </div>

       
    </div>
   
    <div class="modal_l_layer"></div>
</div>

<script>
	
	/* 모달 열기 */
	$(document).on('click', '#dataTable tbody tr', function() {

       	
       	// 데이터 받아오기
       	const resno = $(this).find('td:nth-child(1)').text();	// 예약번호
       	const rdate = $(this).find('td:nth-child(2)').text();	// 예약일시
       	const item = $(this).find('td:nth-child(6)').text();	// 진료과목
       	const aname = $(this).find('td:nth-child(5)').text();	// 담당의
       	const mname = $(this).find('td:nth-child(3)').text();	// 보호자
       	
    	console.log(`예약번호: \${resno}, 예약일시: \${rdate}, 진료과목: \${item}, 담당의: \${aname}, 보호자: \${mname}`);
       
       	// 모달 테이블 데이터 업데이트
       	$('#resno').text(`:  \${resno}`);
       	$('#rdate').text(`:  \${rdate}`);
       	$('#item').text(`:  \${item}`);
       	$('#aname').text(`:  \${aname} 선생님`);
       	$('#mname').text(`:  \${mname}`);
       	
    	$("#modal_l").css("display", "block");   	
	});
	

	
   	/* 모달 닫기 */
   	$('#modal_close_btn.to_list').click(function() {
   		$("#modal_l").css("display","none");
   	})
   	$('.res-modal#res-modal-1-btn1').click(function() {
   		$("#modal_l").css("display","none");
   	})

   	
   	
	   	/* 메일 보내기 */
	   	const name = '';
		const date = '';
		const time = '';
		const mail = 'mail 내용\n';
	   	
	   	/* 취소 */
		$('.res-modal#res-modal-1-btn2').click(function() {
	   		if(confirm(mail+"의 예약 확정 메일을 전송하시겠습니까?")==true) {
	   			// 메일 보내기
	   		};
	   	})
	   	/* 확정 */
	   	$('.res-modal#res-modal-1-btn3').click(function() {
	   		if(confirm(mail+"의 예약 취소 메일을 전송하시겠습니까?")==true) {
	   			// 메일 보내기
	   		};
	   	})
	   	
	   	/* confirm에서 확인을 누르면 메일전송, 상태변경, 모달창 닫기 */
   	
</script>

