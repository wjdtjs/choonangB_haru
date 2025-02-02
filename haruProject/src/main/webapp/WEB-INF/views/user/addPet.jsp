<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동물 정보 등록</title>
</head>

<style>
#pet-add-img-icon {
	position: absolute;
    bottom: 8px;
    right: 112px;
    background: white;
    border-radius: 50%;
    padding: 5px;
    width: auto;
    height: auto;
}

.user-pet-add p {
	font-size: 12px;
	color: var(--haru);
	margin: 4px 0;
}

.input-pet-info {
	border: 1px solid var(--haru);
	border-radius: 12px;
	height: 44px;
	width: 100%;
	padding: 0 8px;
	font-size: 16px;
}

.pro-thumbnail {
    width: 7rem;
    height: 7rem;
    border-radius: 50%;  /* 원형 이미지 */
    object-fit: cover;   /* 이미지 비율 유지하면서 영역에 맞게 조정 */
    border: 2px solid #ccc; /* 테두리 추가 (선택 사항) */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* 살짝 그림자 효과 */
    transition: transform 0.2s ease-in-out; /* 부드러운 확대 효과 */
}


</style>

<!-- datepicker -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

<script>
$(function() {
   $('#datePicker')
      .datepicker({
    	  dateFormat: 'yy-mm-dd' //달력 날짜 형태
  		  ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
  		  ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
  		  ,changeYear: true //option값 년 선택 가능
  		  ,changeMonth: true //option값  월 선택 가능
  		  ,buttonText: "선택" //버튼 호버 텍스트              
  		  ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
  		  ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
  		  ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
  		  ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
  		  ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
      });	
})


// 종 대분류값 가져오기
$(function() {
	$("#species-bcd").change(() => {
		console.log("종 대분류값 눌림");
		getMcd();
	});
});
      
// 종 대분류에 따른 중분류값 가져오기
function getMcd(val) {
	let selectedOptionValue = $("#species-bcd option:selected").val();
	console.log(selectedOptionValue);
	
	$('.add-species-mcd').remove();
	$('#species-mcd option:eq(0)').prop("selected", true);
	
	$.ajax({
		url: `${contextPath}/api/add-mcd/`+selectedOptionValue, 
		dataType: 'json',
		success: function(data) {
			let str = "";
			$(data).each(function(index,item) {
				str += `<option value="\${item.mcd}" class='.add-species-mcd'>\${item.species}</option>`;
			})
			
			$('#species-mcd').html(str);
			
			if(val) {
				$('#species-mcd').val(val).prop('selected',true);
			}
		},
		error: function(xhr, status, error) {
            console.error("중분류 데이터를 가져오는 중 오류 발생:", error);
        }
	})
}


/* 이미지 선택 */
// 아이콘 클릭 시 파일 업로드 창 열기
/* $(document).on('click', '#pet-add-img-icon', function() {
	console.log("버튼 눌림");
    $('#petimg').click();
});

// 파일 선택 후 미리보기 업데이트
$(document).on('change', '#petimg', function(e) {
	console.log("파일 선택");
    const files = e.target.files; // 변경 이벤트에서 파일 목록 가져오기
	console.log(files);
    
    if (files && files[0]) {
    	const file = files[0];
    	const objectURL = URL.createObjectURL(file);
        console.log("임시 이미지 URL:", objectURL);
        
        console.log("pet-mainimg-div 개수:", $('.pet-mainimg-div').length);
        
     // 파일 로드 완료 시 실행
        $('.pet-mainimg-div').css('display', 'inline'); // 이미지 보이기
        $('.pet-mainimg-div').append(`<img src="${objectURL}" alt="pet-image" style="width: 7rem; height: 7rem; border-radius: 50%;"/>`);


        // file.readAsDataURL(files[0]); // 파일 읽기
    }
});
 */
/**
 * 이미지 삭제
 */
/* document.querySelector('.pet-mainimg-div').addEventListener('click', () => {
	console.log('썸네일 삭제');
	$('#petimg').val('');
    $('.pet-mainimg-div').css('display', 'none');
}); */


function previewImage(event) {
    const file = event.target.files[0];
    if (file) {
        const objectURL = URL.createObjectURL(file);
        document.querySelector('.pet-mainimg-div').innerHTML = `<img src="${objectURL}" alt="pet-image" style="width: 7rem; height: 7rem; border-radius: 50%;" />`;
    }
}





// 추가하기 버튼

      
</script>

<body>

<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i> 
				동물 정보 등록
				<div style="width:30px"></div>
			</div>
		</div>	
		
		
		<!-- body contents -->
		<div class="user-body-container" id="mypage-background">
		
		<form action="/admin/addPet" method="POST" enctype="multipart/form-data">
		
			<!-- 동물 이미지 petimg -->
		    <div class="pet-add-img" style="text-align: center;margin: 0 auto;display: flex;justify-content: center;align-items: flex-end; position: relative;">
		        <div style="margin-top: 1rem; background-color: #D9D9D9; border-radius: 50%;width: 7rem; height: 7rem;">
		            <div class="pet-label-div">
		                <div id="pet-add-img-icon">
		                    <i class="fa-solid fa-camera" style="color: var(--haru); cursor: pointer;"></i>
		                </div>
		                <input type="file" id="petimg" name="petimg" accept=".jpg, .jpeg, .png, .gif" style="display: none" onchange="previewImage(event);">
		            </div>
		            <div class="pet-mainimg-div">
		            <!-- 이미지 등록 -->
		            </div>
		        </div>
		    </div>
			
			<div class="user-pet-add">
				<!-- 이름 -->
				<p>이름</p>
				<input name="petname" type="text" class="input-pet-info" required>
				<!-- 생년 월일 -->
				<p>생년월일</p>
				<input name="petbirth" class="input-pet-info" id="datePicker" autocomplete="off" required>
				<!-- 종 -->
				<p>종</p>
				<div style="display: flex;">
					<select class="input-pet-info" id="species-bcd" name="petspecies_bcd" style="margin: 0 8px 0 0; width: 120px;" required>
						<option disabled selected value="0">선택</option>
						<c:forEach var="p" items="${pList }">
							<option value="${p.bcd}">${p.species }</option>
						</c:forEach>
					</select>
					<select class="input-pet-info" id="species-mcd" name="petspecies_mcd" required>
						<option disabled selected value="0">선택</option>
					</select>
				</div>
				
				<!-- 성별 -->
				<p>성별</p>
				<label style="margin: 0 8px 0 0;">
					<input type="radio" name="gender1" value="female"><span>&nbsp;여자</span>
				</label>
				<label>
					<input type="radio" name="gender1" value="male"><span>&nbsp;남자</span>
				</label>
				<!-- 중성화 유무 -->
				<p>중성화 유무</p>
				<label>
					<input type="radio" name="gender2" value="O"><span>&nbsp;O</span>
				</label>
				<label>
					<input type="radio" name="gender2" value="X"><span>&nbsp;X</span>
				</label>
				
				<p>키 / 몸무게</p>
				<div style="display: flex;">
					<!-- 키 -->
					<input name="petheight" type="number" class="input-pet-info" style="margin: 0 4px 0 0; width: 80%" required>
					<p style="align-self: flex-end;">cm</p>
					<!-- 몸무게 -->
					<input name="petweight" type="number" class="input-pet-info" style="margin: 0 8px 0 4px; width: 80%" required>
					<p style="align-self: flex-end;">kg</p>				
				</div>
				
				<!-- 특이사항 -->
				<p>특이사항</p>
				<textarea name="petspecial" rows="10" cols="45" class="input-pet-info" style="height: auto; padding: 8px;"></textarea>
				
				<!-- 버튼이랑 안 겹치게 -->
				<div style="margin: 80px 0;"></div>
			
			</div>		
		</form>		
		
			<button class="user-btn-primary" >등록하기</button>
		
		</div>
		<!-- body contents end -->
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>


</body>
</html>