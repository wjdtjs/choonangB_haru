<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰작성</title>

<style type="text/css">
.review-info {
	font-size: 14px;
	color: #6F7173;
}
#writeReviewForm {
	margin-block: 10px;
}
form label {
	font-size: 1rem;
	font-weight: 500;
	color: black;
}
.review-title, .review-content {
	display: flex;
	flex-direction: column;
}
input[type=text], textarea {
	padding: 5px 10px;
	border-radius: 8px;
	border: 1px solid var(--haru);
	font-family: "Noto Sans KR", serif;
	margin-top: 4px;
}
input[type=text]:focus, textarea:focus {
	outline: none;
}
.file-name-div {
	font-size: 12px;
	margin-top: 4px;
	display: flex;
}
.file-input-label {
	width: 80px;
    height: 100px;
    color: white;
    background: #d9d9d9;
    border-radius: 10px;
    text-align: center;
    line-height: 100px;
    font-size: 25px;
    flex-shrink: 0;
}
.preroad-img {
	width: 80px;
	height: 100px;
	border-radius: 10px;
	object-fit: cover;
	margin-right: 8px;
}
.pre-img-div {
	overflow-x: scroll; 
	white-space: nowrap;
	margin-left: 8px;
}
</style>

</head>
<body>
	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				리뷰 작성
				<div style="width:45px">
					<button type="submit" form="writeReviewForm" style="background: none; font-size: 1rem; padding:0">완료</button>
				</div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container">
			<div class="review-info">
				<div>예약번호 : ${resno }</div>
				<div>${bcd } - ${mcd }</div>
				
			</div>
			
			<form action="WriteReview" method="post" onsubmit="return validateForm()" id="writeReviewForm" enctype="multipart/form-data">
				<input type="hidden" value="${resno }" name="resno">
				<div class="review-title">
					<label>제목</label>
					<input type="text" name="btitle" style="height: 35px" required="required">				
				</div>
				<div class="review-image" style="margin-top: 10px;">
					<label>사진첨부</label>
					<div class="file-name-div">
						<label class="file-input-label" for="img-input">+</label>
						<input type="file" style="display: none" id="img-input" name="file" multiple="multiple">					
						<div class="pre-img-div"></div>
					</div>
				</div>
				<div class="review-content" style="margin-top: 10px;">
					<label>내용</label>
					<textarea name="bcontents" style="height: 350px" required="required"></textarea>			
				</div>
				
			</form>
			
		</div>
		
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
	
	<script type="text/javascript">	

		function validateForm() {
			let result = false;
			
			result = confirm('이대로 작성하시겠습니까?');
			return result;
		}
		
		/* 사진 선택 시 미리보기 */
		$('#img-input').on('change', function(e) {
			var str = "";
			var files=$('#img-input')[0].files;
			console.log(files)
			$('.pre-img-div').html('');
			if(files) {
	            for(var i= 0; i<files.length; i++){
	            	
					const reader = new FileReader();
	            	reader.onload = function(event) {
	                    // 파일의 데이터 URL을 가져와 이미지 태그 생성
	                    const imgTag = `<img src="\${event.target.result}" class="preroad-img"/>`;
	                    $('.pre-img-div').append(imgTag);
	                };
		            reader.readAsDataURL(files[i]); // 파일 읽기
	            }	            	
	        }
		})

	</script>
</body>
</html>