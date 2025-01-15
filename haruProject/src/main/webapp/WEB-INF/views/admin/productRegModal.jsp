<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="/css/js.css?v=0.02" rel="stylesheet">


<div id="modal_l" class="pro_reg">
   
   <!-- 모달 내용 + 모달 버튼 -->
    <div class="modal_l_content">
    	<!-- 모달 내용 -->       
       	<h4>상품 등록</h4>
       
        <form class="js-pro-container" action="uploadProduct" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
	        <div class="modal_l_detail">
		        	<div class="js-pro-info">
		        		<div class="title">상품 정보</div>
			        	<table>
			        		<colgroup>
			        			<col width="10%"/>
			        			<col width="40%"/>
			        			<col width="10%"/>
			        			<col width="40%"/>
			        		</colgroup>
			        		<tr>
			        			<td class="sub-title">분류 <span class="haru-required">*</span></td>
			        			<td>
			        				<select class="sub-bcd-select" name="pstep_bcd">
			        					<option disabled selected value="0">대분류</option>
			        				</select>
			        				<select class="sub-mcd-select" name="pstep_mcd">
			        					<option disabled selected value="0">중분류</option>
			        				</select>
			        			</td>
			        		</tr>
			        		<tr>
			        			<td class="sub-title">상품명 <span class="haru-required">*</span></td>
			        			<td colspan="3"><input class="haru-pro-name" name="pname" type="text" style="width: 91%"></td>
			        		</tr>
			        		<tr>
			        			<td class="sub-title">가격 <span class="haru-required">*</span></td>
			        			<td><input class="haru-pro-price" name="pprice" type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(.*)\./g, '$1');"></td>
			        			<td class="sub-title">브랜드 <span class="haru-required">*</span></td>
			        			<td><input class="haru-pro-brand" name="pbrand" type="text"></td>
			        		</tr>
			        		<tr>
			        			<td class="sub-title">수량 <span class="haru-required">*</span></td>
			        			<td><input class="haru-pro-quantity" name="pquantity" type="number" min="0"></td>
			        			<td class="sub-title">구매처 <span class="haru-required">*</span></td>
			        			<td><input class="haru-pro-store" name="pbuy_store" type="text"></td>
			        		</tr>
			        	</table>
		        	</div>
		        	
		        	<div class="js-pro-img">
		        		<div class="title">메인 이미지 <span class="haru-required">*</span></div>
			        	<div style="margin-top: 1rem">
							<%-- <c:choose> 
								<c:when test="${not empty savedName }"> 
									<img alt="UpLoad Image" src="">	        		
								</c:when>
								<c:otherwise>  --%>
								<div class="pro-label-div">
									<label for="main_img" class="img_upload">+</label>
									<input type="file" id="main_img" name="main_img" accept=".jpg, .jpeg, .png, .gif" style="display: none"> 							
								</div>
								<div class="pro-mainimg-div" style="display: none">
								</div>
								<%-- </c:otherwise> 
							</c:choose>  --%>
			        	</div>
		        	</div>
		        	
		        	<div class="js-pro-detail">
		        		<div class="title">상세 설명</div>
			        	<div style="margin-top: 1rem">
							<jsp:include page="components/productDetails.jsp">
								<jsp:param name="isEditor" value="true"/>
							</jsp:include>
			        	</div>
		        	</div>
		        	
			</div>
	        <!-- 모달 버튼 -->
	        <div class="modal_l-content-btn">
	        	<button type="button" id="modal_close_btn" class="to_list pro_reg">목록으로</button>
	        	<button type="submit" class="update_btn">추가하기</button>
	        </div>
       
	   </form>
    </div>
    
    <div class="modal_l_layer"></div>
</div>

<script>
	
	/**
	 * 모달 열기
	 */
	$('#modal_open_btn.pro_reg').click(function() {
   		$("#modal_l.pro_reg").css("display","block");
   		
   		/* 상품 대분류 가져오기 */
   		$.ajax({
   			url: "<%=request.getContextPath()%>/api/product-bcd",
			dataType: 'json',
			success: function(data){
// 				console.log(data)
				
				let str = "";
				$(data).each(function() {
					str += `<option value="\${this.BCD}" class="add-product-bcd">\${this.CONTENT}</option>`;
				})
				
				$('.sub-bcd-select').append(str); //대분류 <option>추가
			}
   		})
   	})
	
   	/**
	 * 모달 닫기
	 */
   	$('#modal_close_btn.to_list').click(function() {
   		
   		//input 데이터 삭제
   		$("input").val('');
   		//썸네일 이미지 선택 삭제
   		$('.pro-mainimg-div').css('display', 'none');
   	 	$('.pro-label-div').css('display', 'block');
   	 	//상세 설명 데이터 삭제
   	 	$('#summernote').summernote('reset');
   	 	//분류 선택 데이터 삭제
   	 	$('.add-product-bcd').remove();
		$('.sub-bcd-select option:eq(0)').prop("selected", true);
   	 	$('.add-product-mcd').remove();
		$('.sub-mcd-select option:eq(0)').prop("selected", true);
		
		//스크롤 맨 위
		$(".modal_l_detail").scrollTop(0);
   	 	
   	 	//모달 닫기
   		$("#modal_l.pro_reg").css("display","none");
   	})

   	
   	/* 메인 이미지 선택 */
   	const mainImg = document.getElementById('main_img');
	mainImg.addEventListener('change', (e) => {
   		const files = e.currentTarget.files;
   		
   		if (files && files[0]) {
   	        const reader = new FileReader();
   	        
   	        // 파일 로드 완료 시 실행
   	        reader.onload = function(event) {
   	        	console.log(event)
   	            // 파일의 데이터 URL을 가져와 이미지 태그 생성
   	            const imgTag = `<img src="\${event.target.result}" alt="product-image" style="width: 7rem; height: 7rem"/>`;
   	            
   	            $('.pro-label-div').css('display', 'none');
   	            $('.pro-mainimg-div').css('display', 'block');
   	            $('.pro-mainimg-div').html(imgTag);
   	         	$('.pro-mainimg-div').addClass('pro-thumbnail');
   	        };
   	        
   	     	reader.readAsDataURL(files[0]);

   	    }
        
   	})
   	
   	
   	/**
   	 * 대분류 선택 시 중분류 값 가져오기
   	 */
 	$(".sub-bcd-select").change((e) => {
 		let selectedOptionValue = $(".sub-bcd-select option:selected").val();
//  		console.log(selectedOptionValue);

		$('.add-product-mcd').remove();
		$('.sub-mcd-select option:eq(0)').prop("selected", true);
		
		$.ajax({
			url: "<%=request.getContextPath()%>/api/product-mcd/"+selectedOptionValue,
			dataType: 'json',
			success: function(data){
// 				console.log(data)
				
				let str = "";
				$(data).each(function() {
					str += `<option value="\${this.MCD}" class="add-product-mcd">\${this.CONTENT}</option>`;
				})
				
				$('.sub-mcd-select').append(str);
			}
		})
 	})
 	
   	
   	/**
   	 * 썸네일 이미지 삭제
   	 */
   	document.querySelector('.pro-mainimg-div').addEventListener('click', (e) => {
		$('#main_img').val('');
        $('.pro-mainimg-div').css('display', 'none');
   	 	$('.pro-label-div').css('display', 'block');
   	});
   	
	
 	/**
 	 * 상품 등록
 	 */
   	function validateForm() {
		let result = false;
		
		let bcd = $(".sub-bcd-select option:selected").val(); //대분류
		let mcd = $(".sub-mcd-select option:selected").val(); //중분류
		let name = $(".haru-pro-name").val(); //상품명
		let price = $(".haru-pro-price").val(); //가격
		let brand = $(".haru-pro-brand").val(); //브랜드
		let quantity = $(".haru-pro-quantity").val(); //수량
		let store = $(".haru-pro-store").val(); //구매처
		let thumb = $("#main_img").val(); //썸네일
		let details = $('#summernote').summernote('code'); //상세설명
		
// 		console.log(`대분류 : \${bcd}, 중분류 : \${mcd}, 상품명 : \${name}, 가격 : \${price}, 브랜드 : \${brand}, 수량 : \${quantity}, 구매처 : \${store}`);
// 		console.log(thumb);
// 		console.log(details)

// 		console.log(isEmpty(details))

		// 전체 필수 체크
		if(isEmpty(bcd) && isEmpty(mcd) && isEmpty(name) && isEmpty(price) && isEmpty(brand) 
				&& isEmpty(quantity) && isEmpty(store) && isEmpty(thumb)) {
			
			result = true;
			
		} else {
			alert('필수값을 입력하세요');
			
			result = false;
		}
		
		return result;
	}
	
	

</script>
<script src="/js/validation.js"></script>

