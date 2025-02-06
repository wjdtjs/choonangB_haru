<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동물 정보 수정</title>
</head>

<style>
#pet-add-img-icon {
	position: absolute;
    bottom: 0px;
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


label.img_upload {
    background-color: #f0f0f0;
    cursor: pointer;
    text-align: center;
    width: 7rem;
    height: 7rem;
    line-height: 7rem;
    font-size: 1.5rem;
    border-radius: 50%;
}

.info-del-btn {
	position: fixed;
	bottom: 88px;
	width: 90%;
	height: 44px;
	background-color: white;
	border: 1px solid var(--haru);
	border-radius: 12px;
	color: black;
	font-size: 16px;
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
	let selectedValue = $("#species-bcd").val(); // 현재 선택된 값 가져오기
	console.log("selectedValue: ", selectedValue);
    if (selectedValue !== "0") { // 값이 0이 아닐 경우 실행
        getMcd();
    }
	
	$("#species-bcd").change(() => {
		console.log("종 대분류값 눌림");
		getMcd();
	});
});

// controller에서 받아온 pet
let pet = {petspecies_mcd: "${not empty pet ? pet.petspecies_mcd : ''}"};
      
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
				let selectedMcd = pet && pet.petspecies_mcd == String(item.mcd) ? 'selected="selected"' : '';
				str += `<option value="\${item.mcd}" class=".add-species-mcd"  \${selectedMcd}>\${item.species}</option>`;
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



/**
	* 첨부파일 추가
	*/
	
	$(()=>{
		$('#main_img').on('change', function(e) {
		    const files = e.target.files; // 변경 이벤트에서 파일 목록 가져오기
			console.log("실행");
		    
		    if (files && files[0]) {
		        const reader = new FileReader();
		        console.log("파일 실행 files ->",files);
		        // 파일 로드 완료 시 실행
		        reader.onload = function(event) {
		            // 파일의 데이터 URL을 가져와 이미지 태그 생성
		            const imgTag = `<img src="\${event.target.result}" alt="product-image" style="width: 7rem; height: 7rem; border-radius: 50%;"/>`;
					
		            
		            $('.pro-label-div').css('display', 'none');
		            $('.pro-mainimg-div').css('display', 'block');
		            $('.pro-mainimg-div').html(imgTag);
		            //$('.pro-mainimg-div').addClass('pro-thumbnail');
		        };
	
		        reader.readAsDataURL(files[0]); // 파일 읽기
		    }
		});
		
		/**
		 * 썸네일 이미지 삭제
		 */
	 	document.querySelector('.pro-mainimg-div').addEventListener('click', () => {
			console.log('썸네일 삭제');
			$('#main_img').val('');
		    $('.pro-mainimg-div').css('display', 'none');
		 	$('.pro-label-div').css('display', 'block');
		});
	})

function imgCheck() {
	console.log("이미지 체크 시작");
	let pimg = $("#main_img").val();
	let current_img = '${pet.petimg}';
	console.log("pimg: ", pimg, "current_img: ", current_img);
	
	if(!isEmpty(pimg) && isEmpty(current_img)) {
		console.log('이미지 변경 안함')
		// 기존 이미지가 삭제되고 다시 선택할 수 있는 div가 block 되면 true 반환
		let isDisplayed = $(".pro-label-div").css('display') === 'block';
		console.log("기존 이미지 제거 여부 : ",isDisplayed);		
		if(isDisplayed) {
			let img = $("#main_img").val();
			if(!isEmpty(img)) {
				console.log("새로운 이미지가 선택되지 않음, 이미지 비어있음");
				alert("새로운 이미지를 선택해주세요.");
				return false;
			}
		}
		
		return true;
		
	} else {
		console.log('이미지 변경함')
		return true;
	}
	
}


	function validationCheck() {
		let result = false;
		
		let name = $(".input-pet-name").val();
		let birth = $(".input-pet-birth").val();
		let bcd = $(".input-pet-sbcd").val();
		let mcd = $(".input-pet-smcd").val();
		let gender1 = $(".input-pet-gender1:checked").val();
		let gender2 = $(".input-pet-gender2:checked").val();
		
		console.log(`이름: \${name}, 생일: \${birth}, 대분류: \${bcd}, 중분류: \${mcd}, 성별: \${gender1}, 중성화유무: \${gender2}`);
		
		// 필수 입력 체크
		if(isEmpty(name) && isEmpty(birth) && isEmpty(bcd) && isEmpty(mcd) && 
				isEmpty(gender1) && isEmpty(gender2)) {
			console.log("validation check 성공!");
			if(confirm("동물 정보를 수정하시겠습니까?")) {
				result = true;
			} 
			
		} else {
			alert("필수값을 입력하세요.");
			result = false;
		}
		
		return result;
	}


// 동물 정보 수정
function updatePet(petno) {
	console.log("updatePet start ,,,");
	console.log("petno ->", petno);

	if (imgCheck() && validationCheck()) {
		console.log("이미지, 데이터 validation 체크 성공");
		document.getElementById("updatePetForm").action = "/user/updatePet";
		document.getElementById("updatePetForm").submit();			
	} else {
		alert("동물 정보 수정에 실패하였습니다. 다시 확인해주세요.");
	}
}


// 동물 삭제 (상태변경)
function deletePet(petno) {
	console.log("deletePet start ,,,");
	console.log("petno ->",petno);
	
	if(confirm("동물 정보를 삭제하시겠습니까?")==true) {
		url = "/user/deletePet?petno="+petno;
		console.log("url ->",url);
		location.href = url;
	}
	
}


</script>

<body>

<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i> 
				동물 정보 수정
				<div style="width:30px"></div>
			</div>
		</div>	
		
		
		<!-- body contents -->
		<div class="user-body-container" id="mypage-background">
		
		<form action="/user/updatePet" id="updatePetForm" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="memno" value="${pet.memno}">
			<input type="hidden" name="petno" value="${pet.petno}">
			
			<!-- 동물 이미지 petimg -->	
			<div class="pet-add-img" style="text-align: center;margin: 0 auto;display: flex;justify-content: center;align-items: flex-end; position: relative;">	    
				<div style="margin-top: 1rem;">
					<div class="pro-mainimg-div">
						<img src="${pet.petimg}" alt="product-image" style="width: 7rem; height: 7rem; border-radius: 50%;"/>
					</div>
					<div class="pro-label-div" style="display: none">
						<label for="main_img" class="img_upload">
							<div id="pet-add-img-icon">
		                   		<i class="fa-solid fa-camera" style="color: var(--haru); font-size: 20px; margin: 2px;"></i>
		                	</div>
						</label>
						<input type="file" id="main_img" name="main_img" accept=".jpg, .jpeg, .png, .gif" style="display: none">
					</div>
				</div>
			</div>
			
			<div class="user-pet-add">
				<!-- 이름 -->
				<p>이름 <span class="haru-required">*</span></p>
				<input name="petname" type="text" class="input-pet-info input-pet-name" value="${pet.petname}" required>
				<!-- 생년 월일 -->
				<p>생년월일 <span class="haru-required">*</span></p>
				<input name="petbirth" class="input-pet-info input-pet-birth" id="datePicker" autocomplete="off" value="${pet.petbirth}" required>
				<!-- 종 -->
				<p>종 <span class="haru-required">*</span></p>
				<div style="display: flex;">
					<select class="input-pet-info input-pet-sbcd" id="species-bcd" name="petspecies_bcd" style="margin: 0 8px 0 0; width: 120px;" required>
						<option disabled selected value="0">선택</option>
						<c:forEach var="p" items="${pList }">
							<option value="${p.bcd}" ${pet.petspecies_bcd == String.valueOf(p.bcd) ? 'selected="selected"' : ''}>${p.species}</option>
						</c:forEach>
					</select>
					<select class="input-pet-info input-pet-smcd" id="species-mcd" name="petspecies_mcd" required>
						<option disabled selected value="0">선택</option>
					</select>
				</div>
				
				<!-- 성별 -->
				<p>성별 <span class="haru-required">*</span></p>
				<label style="margin: 0 8px 0 0;">
					<input type="radio" name="gender1" class="input-pet-gender1" value="female" ${pet.petgender_mcd.toString().substring(0,1) == '1' ? 'checked="checked"': ''}><span>&nbsp;여자</span>
				</label>
				<label>
					<input type="radio" name="gender1" class="input-pet-gender1" value="male" ${pet.petgender_mcd.toString().substring(0,1) == '2' ? 'checked="checked"': ''}><span>&nbsp;남자</span>
				</label>
				<!-- 중성화 유무 -->
				<p>중성화 유무 <span class="haru-required">*</span></p>
				<label>
					<input type="radio" name="gender2" class="input-pet-gender2" value="O" ${pet.petgender_mcd.toString().substring(1,2) == '1' ? 'checked="checked"' : ''}><span>&nbsp;O</span>
				</label>
				<label>
					<input type="radio" name="gender2" class="input-pet-gender2" value="X" ${pet.petgender_mcd.toString().substring(1,2) == '2' ? 'checked="checked"' : ''}><span>&nbsp;X</span>
				</label>
				
				<!-- 특이사항 -->
				<p>특이사항</p>
				<textarea name="petspecial" rows="10" cols="45" class="input-pet-info" style="height: auto; padding: 8px;">${pet.petspecial}</textarea>
				
				<!-- 버튼이랑 안 겹치게 -->
				<div style="margin: 140px 0;"></div>
			
			</div>		
		</form>		
			<div>
				<button class="user-btn-primary" style="bottom: 140px !important;" onclick="updatePet(${pet.petno})">수정하기</button>
				<button class="info-del-btn" onclick="deletePet(${pet.petno})">정보 삭제하기</button>
			</div>
		</div>
		<!-- body contents end -->
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>


</body>
</html>