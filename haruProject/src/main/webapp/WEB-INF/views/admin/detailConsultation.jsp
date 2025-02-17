<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>

<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>차트 상세</title>

</head>

<style>
.apmTable tr{
	height: 40px;
	color: black;
}
.petInfo_1{
	color: black;
	width: 100%;
}

.infoTitle {
	font-size: 1.15rem;
	font-weight: 500;
	margin-top: 10px;
	color: black;
}

.contents{
	height: 50px;
	text-align: center;
	line-height: 50px;
	display: inline-grid;
	grid-template-columns: 1fr 1fr 3fr 3fr 2fr;
	margin: 5px 0;
	width: 100%
}

.contents .content:first-child{
	border-top-left-radius:10px;
	border-bottom-left-radius:10px;
}
.contents .content:last-child{
	border-top-right-radius:10px;
	border-bottom-right-radius:10px;
}

.content{
	background-color: #E7F3F4;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.box{
	min-height: 50px;
	margin: 5px 0;
	border-radius: 10px;
	/* border: 1px solid #aaa; */
	background-color: #E7F3F4;
	padding: 16px;
 
}

.form-input-title {
	font-weight: 500;
}

.form-input-box{
	width: 100%;
	height: 200px;
	border: 1.5px solid var(--haru);
	border-radius: 10px;
	padding: 10px;
	margin-bottom: 20px;
	margin-top: 5px;
}
.pre-img-div {
	display: inline-block;
}
.consul-imgitem-div, .file-input-label{
	display: inline-block;
}
.consul-imgitem-div{
	position: relative;
}
.img-del {
	position: absolute;
	top: 3px;
	right: 4px;
	color: red;
	font-size: 16px;
}
.input-row{
	display: flex;
	margin-top: 20px;
	width: 50%;
	color: black;
}

.input-row .infotitle{
	width: 100px;
}

.input-row .info-row-input{
	width: 80%;
	
 	
}
.input-row .info-row-input .form-input{
	width: 90%;
	border: 1.5px solid var(--haru);
	border-radius: 10px;
	padding: 8px 12px;
	margin-right: 4px;
}

.pre-img-div .consul-imgitem-div img{
	width: 7rem;
    height: 7rem;
	position: relative;
	border-radius: 0.625rem;
	margin: 4px;
}

.file-input-label {
    background-color: #f0f0f0;
    cursor: pointer;
    text-align: center;
    width: 7rem;
    height: 7rem;
    line-height: 7rem;
    font-size: 1.5rem;
    border-radius: 0.625rem;
    margin: 4px;
}

em {
	color: red;
	justify-content: center;

}
.linked-td {
	cursor: pointer;
	text-decoration: underline;
}
.send-info{
	border: none;
}
 /* 모달 스타일 */
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.8);
        text-align: center;
    }

    .modal-content {
        max-width: 80%;
        max-height: 80%;
        margin: auto;
        margin-top: 5%;
        object-fit: contain;
        
    }

    .close {
        position: absolute;
        top: 15px;
        right: 30px;
        font-size: 30px;
        color: white;
        cursor: pointer;
    }
</style>
<body> 

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <jsp:include page="components/sideBar.jsp"></jsp:include>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                 <!-- Topbar -->
                <jsp:include page="components/topBar.jsp"></jsp:include>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid modal_">

                    <!-- Page Heading -->
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >차트 상세</h1>
                    
                    <div class="modal_l_detail">
                     <form action="/admin/updChart" method="post" onsubmit="return validateForm()" id="upd_chart" enctype="multipart/form-data">
				        <input type="hidden" name="cno" value="${chart.cno}">
				        <input type="hidden" name="resno" value="${chart.resno}">
				        <table class="apmTable">
				        	<colgroup>
		                    	<col width="8%" />
		                        <col width="3%" />
		                    </colgroup>
				        	<tr>
				        		<td class="form-input-title">예약번호</td> <td>:</td> <td class="linked-td resno">${apm.resno} <i class="fa-solid fa-file-lines"></i></td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">진료일시</td> <td>:</td>
				        		<td><input type="text" class="send-info" name="rdate" value="<fmt:formatDate value="${apm.rdate}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly="readonly"></td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">진료과목</td>	<td>:</td> <td>${apm.item}</td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">주치의</td>	<td>:</td> <td>${apm.aname}</td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">보호자</td>	<td>:</td> <td class="linked-td" onclick="location.href='/admin/detailMember?memno='+${apm.memno}">${apm.mname} <i class="fa-solid fa-file-lines"></i></td>
				        		<input type="hidden" name="memno" value="${apm.memno}">
				        </table>
				        <div class="petInfo_1">
						    <div class="infoTitle">동물 정보</div>
				        	<div class="contents">
				        		<div class="content"><input type="hidden" name="petno" value="${apm.petno }">${apm.petno }</div>
				        		<div class="content">${apm.petname }</div>
				        		<div class="content">${apm.species } (${apm.gender })</div>
				        		<div class="content">${apm.petbirth } 출생</div>
				        		<div class="content">${apm.petheight }cm / ${weight.petweight }kg</div>
				        	</div>
				        	<div class="infoTitle">특이사항</div>
				        	<div>
				        		<div class="box">
				        			${apm.petspecial }
				        			<c:if test="${apm.petspecial == null}">
				        				특이사항 없습니다.
				        			</c:if>
				        		
				        		</div>
				        	</div>
				        	<c:if test="${apm.memo ne null}">
				        		<div class="infoTitle">예약 메모</div>
					        	<div>
					        		<div class="box">${apm.memo }</div>
					        	</div>
				        	</c:if>
				        </div>
				        
				       
				        	<input type="hidden" name="cno" value="${chart.cno}">
				        	<div class="infoTitle">이미지</div>
				        	<div class="file-name-div" style="margin-top: 1rem" >
								<div class="pre-img-div">
									<c:forEach var="chartImg" items="${chartImgs}">
										<div class="consul-imgitem-div">
											<img src="${chartImg.content}" class="preroad-img" data-val="${chartImg.imgno }" >
											<i class="fa-solid fa-circle-xmark img-del"></i>		
										</div>
									</c:forEach>
								</div>
								<label for="img-input" class="file-input-label">+</label>
								<input type="file" id="img-input" name="file" accept=".jpg, .jpeg, .png, .gif" style="display: none" multiple>
						    </div>
					       
					       <div class="infoTitle">차트 내용<em>*</em></div>
				        	<div>
				        		<textarea class="form-input-box" name="ccontents" required="required">${chart.ccontents }</textarea>
				        	</div>
				        	<div class="infoTitle">기타/전달사항</div>
				        	<div>
				        		<textarea class="form-input-box" name="cect_con" >
				        			${chart.cect_con }
				        		</textarea>
				        	</div>
				        	
				        	<div class="input-row">
						        <div class="infoTitle">몸무게</div>
						        <div class="info-row-input">
						        <input type="hidden" name="rreg_date" value="<fmt:formatDate value='${weight.reg_date}' pattern='yyyy-MM-dd HH:mm:ss'/>">
						        	<c:if test="${weight.reg_date == apm.rdate}">
						       			<input type="text" class="form-input" name="petweight" value="${weight.petweight}">kg
						       		</c:if>
						       		<c:if test="${weight.reg_date != apm.rdate}">
						       			<input type="text" class="form-input" name="petweight">kg
						       		</c:if>
						        </div>
				        	</div>
				        	
				        </form>
				     </div>

					<!-- 모달 버튼 -->
			       	<div class="modal_l-content-btn">
				       	<button type="button" class="to_list" id="detail_close_btn" onclick="history.go(-1)">목록으로</button>
			            <button type="submit" class="admin_modal update_btn" id="update_btn" form="upd_chart">수정하기</button>
			       	</div> 
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
			<jsp:include page="components/footer.jsp"></jsp:include>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <jsp:include page="components/logOutModal.jsp"></jsp:include>
    
</body>
<!-- 이미지 모달 -->
<div id="imageModal" class="modal">
    <span class="close">&times;</span>
    <img class="modal-content" id="modalImg">
</div>

<script type="text/javascript">
	var delete_img = [];
	var maxFileCnt = 5; //최대 첨부파일 개수
	var attFileCnt = document.querySelectorAll(".consul-imgitem-div").length;	// 기존 첨부파일 개수		
	
	document.addEventListener("DOMContentLoaded", function(){
		if (attFileCnt == maxFileCnt){
	    	$('.file-input-label').css('display', 'none');
		}else {
			$('.file-input-label').css('display', 'inline-block');
		}
	});
	
	function validateForm() {
		let result = false;
		
		var input_str = "";
		
		for(let i=0; i<delete_img.length; i++) {
			input_str += `<input type='hidden' value='\${delete_img[i]}' name='imgno'>`;
		}
		console.log('input_str-> '+input_str)
		$('#upd_chart').append(input_str);
		
		result = confirm('이대로 수정하시겠습니까?');
		
		return result;
	}
	/**
	* 첨부파일 추가 -> 미리보기
	*/
	$('#img-input').on('change', function(e) {
		var str = "";					
		$('.img-input').html('');
	
		var fileInput = e.target;
		const files  =  Array.from(fileInput.files); // FileList를 배열로 변환
		var curFileCount = $('.consul-imgitem-div').length;
		if(curFileCount+files.length > maxFileCnt){
			alert('최대 첨부 파일수는'+ maxFileCnt+'개 입니다.');
			return false;
		}
		if(files){
			files.forEach((file)=>{
				var reader = new FileReader();
				reader.onload = function(event){
					var htmlData = '';
					htmlData += `
						<div class="consul-imgitem-div">
							<img src="\${event.target.result}" class="preroad-img"/>
							<i class="fa-solid fa-circle-xmark img-del" data-index="\${file.lastModified}"></i>
						</div>`;
						
					$('.pre-img-div').append(htmlData);
					updateFileInputLabel(); // 버튼 상태 업데이트
				};
				reader.readAsDataURL(file);
			});
		}
	});

	/**
	 * 이미지 삭제
	 */
	 $(document).on('click','.img-del', function () {
		var imgno = $(this).siblings(".preroad-img").data('val');
		console.log("imgno: ",imgno);
		
		// 현재 이미지 요소 완전히 제거
	    $(this).closest('.consul-imgitem-div').remove();
		
		if(imgno){ 	// 서버에서 가져온 이미지 삭제
			$(this).closest('.consul-imgitem-div').css('display','none');
			delete_img.push(imgno);
		}
		
		// 현재 이미지 요소 완전히 제거
	    $(this).closest('.consul-imgitem-div').remove();

	    // 파일 리스트에서 삭제
	    const dataTransfer = new DataTransfer(); // 변수를 먼저 선언
	    
	    var files = $('#img-input')[0].files;
	    Array.from(files).forEach(file => {
	        const removeTargetId = $(this).data('index');
	        if (file.lastModified !== removeTargetId) { // 삭제할 파일 제외
	            dataTransfer.items.add(file);
	        }
	    });

	    document.querySelector('#img-input').files = dataTransfer.files;
	    console.log(dataTransfer.files);
	    
		updateFileInputLabel(); // 삭제 후 버튼 상태 업데이트
	});
	
	 /**
	  * file-input-label의 display 속성 업데이트
	  */
	 function updateFileInputLabel() {
	     var currentFileCount = $('.consul-imgitem-div').length; // 현재 업로드된 이미지 개수
	     console.log("currentFileCount: "+currentFileCount);
	     
	     if (currentFileCount < maxFileCnt) {
	         $('.file-input-label').css('display', 'inline-block');
	     } else {
	         $('.file-input-label').css('display', 'none');
	     }
	 }
	 
	 // 모달열기 
	 $(document).on('click','.preroad-img',function(){
		    var modal = document.getElementById("imageModal");
		    var modalImg = document.getElementById("modalImg");

		    modal.style.display = "block";
		    modalImg.src = this.src;
	 })
	 
	 // 모달 닫기
	$(document).on("click", ".close", function () {
	    document.getElementById("imageModal").style.display = "none";
	});

	// 모달 바깥 영역 클릭 시 닫기
	$(document).on("click", "#imageModal", function (event) {
	    if (event.target === this) {
	        this.style.display = "none";
	    }
	});
	
	//예약 상세
	$(document).on('click','.resno',function(){
		 var resno = $(this).text().trim();
		    location.href = "/admin/detailReservation?resno=" + resno;
	});
	
</script>
</html>