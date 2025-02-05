<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰수정</title>

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
	display: flex;
	overflow-x: scroll; 
	white-space: nowrap;
	margin-left: 8px;
}
.review-imgitem-div {
	position: relative;
}
.img-delte {
	position: absolute;
	top: 3px;
	right: 4px;
	color: red;
	font-size: 16px;
}
</style>

</head>
<body>
	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				리뷰 수정
				<div style="width:45px">
					<button type="submit" form="writeReviewForm" style="background: none; font-size: 1rem; padding:0">완료</button>
				</div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container">
			<div class="review-info">
				<div>예약번호 : ${board.resno }</div>
				<div>${bcd } - ${mcd }</div>
				
			</div>
			
			<form action="UpdateReview" method="post" onsubmit="return validateForm()" id="writeReviewForm" enctype="multipart/form-data">
				<input type="hidden" value="${board.bno }" name="bno">
				<div class="review-title">
					<label>제목</label>
					<input type="text" name="btitle" style="height: 35px" value="${board.btitle }">				
				</div>
				<div class="review-image" style="margin-top: 10px;">
					<label>사진</label>
					<div class="file-name-div">
						<label class="file-input-label" for="img-input">+</label>
						<input type="file" style="display: none" id="img-input" name="file" multiple="multiple">					
						<div class="pre-img-div">
							<c:forEach var="i" items="${imgList }">
								<div class="review-imgitem-div">
									<img src="${i.content }" class="preroad-img" data-val="${i.imgno }">
									<i class="fa-solid fa-circle-xmark img-delte"></i>							
								</div>
							</c:forEach>
							<div class="new-upload-img" style="display: flex"></div>
						</div>
					</div>
				</div>
				<div class="review-content" style="margin-top: 10px;">
					<label>내용</label>
					<textarea name="bcontents" style="height: 350px">${board.bcontents }</textarea>			
				</div>
				
			</form>
			
		</div>
		
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
	
	<script type="text/javascript">	
		var delete_img = [];
		
		function validateForm() {
			let result = false;
			
			var input_str = "";
			
			for(let i=0; i<delete_img.length; i++) {
				input_str += `<input type='hidden' value='\${delete_img[i]}' name='imgno'>`;
			}
			
			$('#writeReviewForm').append(input_str);
			
			result = confirm('이대로 수정하시겠습니까?');
			
			return result;
		}
		
		/* 사진 선택 시 미리보기 */
		$('#img-input').on('change', function(e) {
			var str = "";
// 			var files=$('#img-input')[0].files;
// 			console.log(files)
			$('.new-upload-img').html('');
			
			var fileInput = e.target;
			const files = Array.from(fileInput.files); // FileList를 배열로 변환
			
			if(files) {
// 	            for(var i= 0; i<files.length; i++){
	            	files.forEach((file)=>{
	            		
					const reader = new FileReader();
	            	reader.onload = function(event) {
	                    // 파일의 데이터 URL을 가져와 이미지 태그 생성
	                    const imgTag = `
	                    	<div class="review-imgitem-div">
	                    		<img src="\${event.target.result}" class="preroad-img"/>
								<i class="fa-solid fa-circle-xmark img-delte" data-index="\${file.lastModified}"></i>							
							</div>
						`;
	                    $('.new-upload-img').append(imgTag);
	                };
		            reader.readAsDataURL(file); // 파일 읽기
	            		
	            	})
// 	            }	            	
	        }
		})
		
		
		
		/* 이미지 삭제 */
		$(document).on('click', '.img-delte', function() {
			
	        var imgno = $(this).siblings(".preroad-img").data('val');
	        console.log("imgno : ",imgno);
	        
	        if(imgno) {
		        $(this).closest('.review-imgitem-div').css('display', 'none');
		        delete_img.push(imgno);	        	
	        } else {
	        	console.log('없음')
	        	$(this).closest('.review-imgitem-div').css('display', 'none');
	        	console.log('index: ',$(this).data('index'))
	        	
	        	const removeTargetId = $(this).data('index');
	        	const dataTranster = new DataTransfer();
	        	var files=$('#img-input')[0].files;
	        	Array.from(files)
	        	    .filter(file => {
	        	        console.log("파일 비교:", file.lastModified, removeTargetId); // 비교 확인용
	        	        return file.lastModified != removeTargetId; // 삭제 대상 제외
	        	    })
	        	    .forEach(file => {
	        	    	console.log(file.lastModified)
	        	        dataTranster.items.add(file);
	        	    });
	        	
	        	
// 	        	$('#img-input').files = dataTranster.files; //jquery로 하면 왜 안되지....
	        	document.querySelector('#img-input').files = dataTranster.files;
	        	console.log(dataTranster.files)
	        }
	        
		 });

	</script>
</body>
</html>