<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="/css/js.css?v=0.02" rel="stylesheet">


<div id="modal_l" class="pro_reg">
   
   <!-- 모달 내용 + 모달 버튼 -->
    <div class="modal_l_content">
    	<!-- 모달 내용 -->       
        <div class="modal_l_detail">
        	<h4>상품 등록</h4>
        
	        <form class="js-pro-container" action="uploadProduct" method="post" enctype="multipart/form-data">
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
		        			<td class="sub-title">분류</td>
		        			<td>
		        				<select>
		        					<option>대분류</option>
		        				</select>
		        				<select>
		        					<option>중분류</option>
		        				</select>
		        			</td>
		        		</tr>
		        		<tr>
		        			<td class="sub-title">상품명</td>
		        			<td colspan="3"><input type="text" style="width: 91%"></td>
		        		</tr>
		        		<tr>
		        			<td class="sub-title">가격</td>
		        			<td><input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(.*)\./g, '$1');"></td>
		        			<td class="sub-title">브랜드</td>
		        			<td><input type="text"></td>
		        		</tr>
		        		<tr>
		        			<td class="sub-title">수량</td>
		        			<td><input type="number" min="0"></td>
		        			<td class="sub-title">구매처</td>
		        			<td><input type="text"></td>
		        		</tr>
		        	</table>
	        	</div>
	        	
	        	<div class="js-pro-img">
	        		<div class="title">메인 이미지</div>
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
	        	
	        </form>
	        
	        
        
		</div>
	        <!-- 모달 버튼 -->
	        <div class="modal_l-content-btn">
	        	<button type="button" id="modal_close_btn" class="pro_reg">목록으로</button>
	        	<button type="submit" class="update_btn">추가하기</button>
	        </div>
       
    </div>
   
    <div class="modal_l_layer"></div>
</div>

<script>
	
	/* 모달 열기 */
	$('#modal_open_btn.pro_reg').click(function() {
   		$("#modal_l.pro_reg").css("display","block");
   		$.ajax({
   			url: "<%=request.getContextPath()%>/api/product-list",
			data: {
				pageNum: pageNum,
				blockSize: '10',
				search1: search1,
				search2: search2
			},
			dataType: 'json',
			success: function(data){
				
			}
   		})
   	})
	
   	/* 모달 닫기 */
   	$('#modal_close_btn.pro_reg').click(function() {
   		
   		$("input").val('');
   		$('.pro-mainimg-div').css('display', 'none');
   	 	$('.pro-label-div').css('display', 'block');
   	 	$('#summernote').summernote('reset');
   		
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
   	
   	/* 이미지 삭제 */
   	document.querySelector('.pro-mainimg-div').addEventListener('click', (e) => {
		$('#main_img').val('');
        $('.pro-mainimg-div').css('display', 'none');
   	 	$('.pro-label-div').css('display', 'block');
   	});
   	
	/* 리치텍스트에디터 이미지 선택 */
	function imageUploader(file, el) {
		let formData = new FormData();
		formData.append('type', 'product');
		formData.append('file', file);
	  
		$.ajax({                                                              
			data : formData,
			type : "POST",
	        // url은 자신의 이미지 업로드 처리 컨트롤러 경로로 설정해주세요.
			url : '<%=request.getContextPath()%>/api/uploadFile',  
			contentType : false,
			processData : false,
			enctype : 'multipart/form-data',                                  
			success : function(data) {   
				$(el).summernote('insertImage', "${pageContext.request.contextPath}/upload/product/"+data.data, function($image) {
					$image.css('width', "100%");
				});

// 				console.log(data);
			}
		});
	}
	
	
	

	
	
	
	
	
   	/* 리치 텍스트 에디터 설정 */
   	$('#summernote').summernote({
      
	  // 에디터 크기 설정
	  height: 400,
	  // 에디터 한글 설정
	  lang: 'ko-KR',
	  // 에디터에 커서 이동 (input창의 autofocus라고 생각하시면 됩니다.)
	  toolbar: [
		    // 글자 크기 설정
		    ['fontsize', ['fontsize']],
		    // 글자 [굵게, 기울임, 밑줄, 취소 선, 지우기]
		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		    // 글자색 설정
		    ['color', ['color']],
		    // 표 만들기
		    ['table', ['table']],
		    // 서식 [글머리 기호, 번호매기기, 문단정렬]
		    ['para', ['ul', 'ol', 'paragraph']],
		    // 줄간격 설정
		    ['height', ['height']],
		    // 이미지 첨부
		    ['insert',['picture']]
		  ],
		  // 추가한 글꼴
		fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
		 // 추가한 폰트사이즈
		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72','96'],
        // focus는 작성 페이지 접속시 에디터에 커서를 위치하도록 하려면 설정해주세요.
		focus : true,
        // callbacks은 이미지 업로드 처리입니다.
		callbacks : {                                                    
			onImageUpload : function(files, editor, welEditable) {   
                // 다중 이미지 처리를 위해 for문을 사용했습니다.
				for (var i = 0; i < files.length; i++) {
					imageUploader(files[i], this);
				}
			}
		}
		
  });
   	
</script>

