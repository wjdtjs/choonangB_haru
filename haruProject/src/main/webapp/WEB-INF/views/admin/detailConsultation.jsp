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

<!-- style -->
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
	/* border: 1px solid #aaa; */
	background-color: #E7F3F4;
}

.box{
	height: 50px;
	margin: 5px 0;
	border-radius: 10px;
	/* border: 1px solid #aaa; */
	background-color: #E7F3F4;
 
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
.pro-imgList-div, .pro-label-div{
	display: inline;
}
/* SELECT 버튼 위치 수정*/
label.img_upload {
    background-color: #f0f0f0;
    cursor: pointer;
    text-align: center;
    width: 7rem;
    height: 7rem;
    line-height: 7rem;
    font-size: 1.5rem;
    border-radius: 0.625rem;
}

em {
	color: red;
	justify-content: center;

}

img {
	width: 7rem;
	height: 7rem
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
				        <input type="hidden" name="cno" value="${chart.cno}">
				        <input type="hidden" name="reson" value="${chart.resno}">
				        <table class="apmTable">
				        	<colgroup>
		                    	<col width="8%" />
		                        <col width="3%" />
		                    </colgroup>
				        	<tr>
				        		<td class="form-input-title">예약번호</td> <td>:</td> <td>${apm.resno}</td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">진료일시</td> <td>:</td> <td><fmt:formatDate value="${apm.rdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">진료과목</td>	<td>:</td> <td>${apm.item}</td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">담당의</td>	<td>:</td> <td>${apm.aname}</td>
				        	</tr>
				        </table>
				        <div class="petInfo_1">
						    <div class="infoTitle">동물 정보</div>
				        	<div class="contents">
				        		<div class="content">${apm.petno }</div>
				        		<div class="content">${apm.petname }</div>
				        		<div class="content">${apm.species } (${apm.gender })</div>
				        		<div class="content">${apm.petbirth } 출생</div>
				        		<div class="content">${apm.petheight }cm / ${apm.petweight }kg</div>
				        	</div>
				        	<div class="infoTitle">특이사항</div>
				        	<div>
				        		<div class="box">${apm.petspecial }</div>
				        	</div>
				        </div>
				        
				        <form action="/admin/updChart" method="post" name="frm" id="upd_chart">
				        	<input type="hidden" name="resno" value="${apm.resno}">
				        	<div class="infoTitle">이미지</div>
				        	<div style="margin-top: 1rem" class="imgList">
								 <div class="pro-imgList-div">
					        		<c:if test="${chartImgs != null}">
										<c:forEach var="chartImg" items="${chartImgs}">
											<img alt="chartImg" src="${chartImg.content }" id="img${chartImg.imgno }" >
										</c:forEach>
					        		</c:if>
								 </div>
								 <div class="pro-label-div">
								 	<label for="main_img" class="img_upload">+</label>
									<input type="file" id="main_img" name="main_img" accept=".jpg, .jpeg, .png, .gif" style="display: none" onchange="addFile(this);" multiple> 							
								 </div>
							
					       </div>
					       
					       <div class="infoTitle">차트 내용<em>*</em></div>
				        	<div>
				        		<textarea class="form-input-box" name="ccontents" required="required">${chart.ccontents }</textarea>
				        	</div>
				        	<div class="infoTitle">기타/전달사항</div>
				        	<div>
				        		<textarea class="form-input-box" name="cect_con" >${chart.cect_con }</textarea>
				        	</div>
				        </form>
				     </div>

					<!-- 모달 버튼 -->
			       	<div class="modal_l-content-btn">
				       	<button type="button" class="to_list" id="detail_close_btn" onclick="location.href='/admin/consultaion'">목록으로</button>
			            <button type="submit" class="admin_modal update_btn" id="update_btn" form="up_chart">수정하기</button>
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
<script type="text/javascript">
	/**
	* 첨부파일 추가
	*/
	var fileNo = 1;
	var filesArr = new Array();
	var maxFileCnt = 5; //최대 첨부파일 개수
	var attFileCnt = document.querySelectorAll(".pro-imgList-div img").length;	// 기존 추가된 첨부파일 개수		
	
	document.addEventListener("DOMContentLoaded", function(){
		if (attFileCnt == maxFileCnt){
	    	$('.pro-label-div').css('display', 'none');
		}else {
			$('.pro-label-div').css('display', 'inline');
		}

		
	});
	
	function addFile(obj) {
	
	
		var remainFileCnt = maxFileCnt-attFileCnt; 											// 추가로 첨부가능한 개수
		var curFileCnt = obj.files.length; 													// 현재 첨부된 파일 개수
	
		// 최대 첨부파일수 초과시 
		if(curFileCnt > remainFileCnt){
			alert('최대 첨부파일 수는 '+maxFileCnt+'개 입니다.');
		}
	
	
		if(attFileCnt+curFileCnt >= maxFileCnt){
			$('.pro-label-div').css('display', 'none');
		}else {
			$('.pro-label-div').css('display', 'inline');
		}
	
		
		for (var i = 0; i< Math.min(curFileCnt, remainFileCnt); i++){
			
			const file = obj.files[i];

		
			// 파일 배열에 담기
			var reader = new FileReader();
			reader.onload = function (event) {
				filesArr.push(file);
				// 목록 추가
				let htmlData = '';
			
				htmlData += `<img src="\${event.target.result}" alt="product-image" name="img\${fileNo}" id="img\${fileNo}" onclick="deleteFile(\${fileNo})" style="width: 7rem; height: 7rem" />`;
					
				console.log(htmlData)
				$('.pro-imgList-div').css('display', 'inline');
				$('.pro-imgList-div').append(htmlData);
				/* $('.pro-mainimg-div').addClass('pro-thumbnail'); */
				fileNo++;
			};
			reader.readAsDataURL(file);
		}
	} 

	/**
	 * 첨부된 이미지 삭제
	 */
	function deleteFile(num){
		if(confirm("이미지를 삭제하시겠습니까?")){
			$('#img' + num).remove(); // 클릭한 이미지만 삭제
			filesArr.splice(num, 1); // 파일 배열에서 해당 파일 삭제
		}
			
		// 이미지 수가 미만이면 .pro-lavel-div 다시 보이기ㅐ
		if(document.querySelectorAll(".pro-mainimg-div-event img").length < maxFileCnt){
			$('.pro-label-div').css('display', 'inline');
		}
	}
</script>
</html>