<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약</title>

<style type="text/css">
.seq_div {
	width: 100%;
	display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
}
.pet-choice-div {
	margin-top: 1rem;
	text-align: center;
}

/* 슬라이더 */
#pet-slider {
  	position: relative;
  	width: 100%;
  	overflow: hidden;
  	margin: 20px auto 0 auto;
  	border-radius: 4px;
  	white-space: nowrap;
  	
}
#pet-slider .slider-container {
	width: 100%;
	transition: transform 0.7s ease-in-out;
	display: flex;
}
#pet-slider .pet-slid-item-div {
  	position: relative;
 	margin-inline: 53px;
 	width: 255px;
  	list-style: none;
  	display: flex;
  	justify-content: space-around;
}

#pet-slider .pet-slid-item-div .pet-item {
  	position: relative;
  	display: block;
  	float: left;
  	margin: 0;
  	padding: 12px 18px;
	border-radius: 20px;
	border: 3px solid white;
  	text-align: center;
  	display: flex;
  	flex-direction: column;
}
#pet-slider .pet-item:has(input[type=radio]:checked) {
	border: 3px solid #A6D6C5;
	background: rgba(166, 214, 197, 0.3);
}
#pet-slider .pet-item img {
	width: 80px;
	height: 80px;
	object-fit: cover;
	border-radius: 50%;
	margin-bottom: 12px;
}
#pet-slider .pet-item input[type=radio] {
 	display: none;
}

i.control_prev, i.control_next {
  	position: absolute;
  	top: 40%;
  	z-index: 999;
  	display: block;
  	width: auto;
  	text-decoration: none;
  	font-size: 20px;
 	cursor: pointer;
 	color: var(--haru);
}

i.control_prev:hover, i.control_next:hover {
  	opacity: 1;
  	-webkit-transition: all 0.2s ease;
}
i.control_prev {
  	left: 15px;
}
i.control_next {
  	right: 15px;
}
/* 슬라이더 끝 */

.item-choice-div {
	margin-top: 1rem;
}
.item-choice-div > div {
	display: flex;
	flex-direction: column;
}
.item-choice-div label {
	font-size: 1rem;
	font-weight: 500;
}
.item-choice-div select {
	height: 50px;
	background-image: url("/img/arrow_drop_down.png");  
	background-repeat: no-repeat;  
	background-position: 92% center; 
	background-size: 30px; 
}
.item-choice-div select,
.item-choice-div textarea {
	margin-top: 6px;
	border-radius: 10px;
	border: 1px solid rgb(0,0,0,0.3);
	padding: 8px 20px;
}
.item-choice-div textarea {
	font-family: "Noto Sans KR", serif;
	width: 100%;
	height: 120px;
	resize: none;
}
.item-choice-div select:focus,
.item-choice-div textarea:focus {
	outline-color: var(--haru);
}
.item-bcd-select {
	width: 100%;
}

button[type=submit] {
	width: 350px;
	height: 50px;
	color: white;
	background: #d9d9d9;
	position: fixed;
	bottom: 82px;
	font-size: 20px;
	font-weight: 500;
}

</style>

</head>
<body>
	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar" style="border: none; flex-direction: column;">
			<div class="topbar-title" style="height: 3.8rem;">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				예약
				<div style="width:45px">
				</div>
			</div>
			<div class="seq_div">
				<div style="width: 50%; border: 1px solid var(--haru);"></div>
				<div style="width: 49%; border: 1px solid rgb(0, 0, 0, 0.3);"></div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container" style="padding-top: 3.8rem;">
			
			<c:choose>
	 			<c:when test="${not empty pet }">
	 				<!-- 동물 선택 -->
					<form action="appointmentStep1" method="post" onsubmit="return validateForm();" id="AppointmentFormStep1">
						<input type='hidden' name='petname' value=''>
						<input type='hidden' name='ano' value=''>
						<input type='hidden' name='apt_bcd' value=''>
						<input type='hidden' name='apt_mcd' value=''>
						
						<div class="pet-choice-div">
							<div style="font-size: 20px; font-weight: 500">예약 동물</div>
							<div id="pet-slider">
								<i class="fa-solid fa-circle-chevron-right control_next"></i>
							 	<i class="fa-solid fa-circle-chevron-left control_prev"></i>
							 	<div class="slider-container">
					 				<c:forEach var="p" items="${pet }" varStatus="status" step="2">
								  		<div class="pet-slid-item-div">
									    	<label class="pet-item" for="pet${p.petno }">
									    		<img src="${p.petimg }">
									    		<span>${p.petname }</span>
									    		<input type="radio" name="petno" id="pet${p.petno }" value="${p.petno }" 
									    				data-key="${p.petname }" data-ano="${p.ano }">
									    	</label>
									    	<c:if test="${not empty pet[status.index + 1] }">
										    	<label class="pet-item" for="pet${pet[status.index + 1].petno }">
										    		<img src="${pet[status.index + 1].petimg }">
										    		<span>${pet[status.index + 1].petname }</span>
										    		<input type="radio" name="petno" id="pet${pet[status.index + 1].petno }" 
										    				value="${pet[status.index + 1].petno }"
										    				 data-key="${pet[status.index + 1].petname }"
										    				 data-ano="${pet[status.index + 1].ano }">
										    	</label>		  							    	
									    	</c:if>  		
								  		</div>  
							  		</c:forEach>
							  	</div>
							</div>
						</div>
						
						<!-- 항목 선택 -->
						<div class="item-choice-div">
							<div>
								<label>예약 항목</label>
								<select class="item-bcd-select" name="bcd">
									<option disabled="disabled" selected>선택</option>
									<c:forEach var="b" items="${bcd }">
										<option value="${b.bcd }" data-key="${b.content }">${b.content }</option>
									</c:forEach>
								</select>				
							</div>
							<div style="margin-top: 1rem;">
								<label>세부 항목</label>
								<select class="item-mcd-select" name="mcd">
								</select>				
							</div>
							<div style="margin-top: 1rem;">
								<label>예약 메모</label>
								<textarea name="memo"></textarea>			
							</div>
						</div>
						
					</form>
					<button type="submit" form="AppointmentFormStep1">다음</button>
	 			</c:when>
	 			<c:otherwise>
	 				<div style="margin-top: 200px; text-align: center; color: #6F7173;">
		 				<div>진료받을 반려동물이 없습니다.</div>
						<div>동물 등록 후 예약을 진행 해주세요.</div> 				
	 				</div>
	 			</c:otherwise>
	 		</c:choose>
			
			
		</div>
		
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
	
<script type="text/javascript">	

	/* submit 전 검증 */
	function validateForm() {
		let result = true;
		let str = "";
		
		let $form = $('#AppointmentFormStep1');
		
		if(!$('input:radio[name=petno]').is(':checked')) {
			result = false;
			str += '진료받을 동물을 선택하세요.\n';
		}
		
		if($('.item-bcd-select').val()==null || $('.item-mcd-select').val()==null) {
			result = false;
			str += '항목 선택은 필수입니다.\n';
		} 
		
		if(!result) {
			alert(str);
		} else {
			let petname = $('input:radio[name=petno]:checked').data('key');
			let petano = $('input:radio[name=petno]:checked').data('ano');
			let bcd_content = $('.item-bcd-select').find("option:selected").data('key');
			let mcd_content = $('.item-mcd-select').find("option:selected").data('key');
			
			$('input:hidden[name=petname]').val(petname);
			$('input:hidden[name=ano]').val(petano);
			$('input:hidden[name=apt_bcd]').val(bcd_content);
			$('input:hidden[name=apt_mcd]').val(mcd_content);

		}
		
		return result;
	}
	
	/* 예약 세부 항목 가져오기 */
	$('.item-bcd-select').change(function() {
    	var bcd = $(this).val();
    	console.log(bcd);
    	
    	if($('.item-bcd-select').val()!=null) {
    		$.ajax({
    			url: "<%=request.getContextPath()%>/api/res-mcd/"+bcd,
    			method: 'GET',
    			success: function(data){
    				console.log(data)
    				
    				let str = "<option disabled selected>선택</option>";
    				$(data).each (function(){
    					str += `<option value="\${this.MCD }" data-key="\${this.CONTENT}">\${this.CONTENT }</option>`
    				});
    				
    				$('.item-mcd-select').html(str);
    			}
    		})
    	}
    	
    })

	/* 필수 선택시에만 버튼 활성화 디자인 */
    $('input[type=radio][name=petno], select').change(function () {
		if($('input:radio[name=petno]').is(':checked') 
				&& $('.item-bcd-select').val()!=null && $('.item-mcd-select').val()!=null
		) {
			$('button[type=submit]').css('background', 'var(--haru)');
		} else {
			$('button[type=submit]').css('background', '#d9d9d9');
		}
	});


    
	/* 동물 선택 슬라이더 조작 커스텀 */
	$(document).ready(function () {
		
	    let currentIndex = 0; // 현재 슬라이드 인덱스
	    const slider = $(".slider-container");
	    const slides = $(".pet-slid-item-div"); // 모든 슬라이드 요소
	    const totalSlides = slides.length; // 전체 슬라이드 개수
	
	    // 버튼 상태 업데이트
	    updateButtons();
	
	    // 다음 슬라이드
	    $(".control_next").click(function () {
	        if (currentIndex < totalSlides - 1) {
	            currentIndex++;
	            slider.css("transform", `translateX(\${-100 * currentIndex}%)`);
	            updateButtons();
	        }
	    });
	
	    // 이전 슬라이드
	    $(".control_prev").click(function () {
	        if (currentIndex > 0) {
	            currentIndex--;
	            slider.css("transform", `translateX(\${-100 * currentIndex}%)`);
	            updateButtons();
	        }
	    });
	
	    // 버튼 상태 업데이트 함수
	    function updateButtons() {
	        if (currentIndex === 0) {
	            $(".control_prev").hide(); // 첫 슬라이드면 이전 버튼 숨김
	        } else {
	            $(".control_prev").show();
	        }
	
	        if (currentIndex === totalSlides - 1) {
	            $(".control_next").hide(); // 마지막 슬라이드면 다음 버튼 숨김
	        } else {
	            $(".control_next").show();
	        }
	    }
	    
	});


</script>
</body>
</html>