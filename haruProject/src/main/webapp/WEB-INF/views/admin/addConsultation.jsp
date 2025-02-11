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

    <title>차트 등록</title>
	
	<!-- 폰트어썸 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
	integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
	crossorigin="anonymous" referrerpolicy="no-referrer" />
	
</head>

<style>

.modal_l_detail, table{
	color: black;
	width: 100%;
}
.apmTable tr{
	height: 40px;
}

.petInfo_1 {
	width: 100%;
}

.infoTitle {
	font-size: 1.15rem;
	font-weight: 500;
	margin-top: 10px
}

.contents{
	width: 100%;
	height: 50px;
	text-align: center;
	line-height: 50px;
	display: inline-grid;
	grid-template-columns: 1fr 1fr 3fr 3fr 2fr;
	margin: 5px 0;
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

.pre-img-div{
	width: fit-content;
	height: fit-content;

}
.pre-img-div>img{
	width: 112px;
	height: 112px;
	position: relative;
	border-radius: 8px;
	margin: 4px;
}


/* SELECT 버튼 위치 수정*/
.file-input-label {
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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >차트 작성</h1>
                    
                    <div class="modal_l_detail">
				        <input type="hidden" name="resno" value="${apm.resno}">
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
				        		<td class="form-input-title">주치의</td>	<td>:</td> <td>${apm.aname}</td>
				        	</tr>
				        	<tr>
				        		<td class="form-input-title">보호자</td>	<td>:</td> <td onclick="location.href='/admin/detailMember?memno='+${apm.memno}">${apm.mname} <i class="fa-solid fa-file-lines"></i></td>
				        	</tr>
				        </table>
				        <div class="petInfo_1">
						    <div class="infoTitle">동물 정보</div>
				        	<div class="contents">
				        		<div class="content">${apm.petno }</div>
				        		<div class="content">${apm.petname }</div>
				        		<div class="content">${apm.species } (${apm.gender })</div>
				        		<div class="content"><fmt:formatDate value="${apm.petbirth}" pattern="yyyy-MM-dd"/> 출생</div>
				        		<div class="content">${apm.petheight }cm / ${apm.petweight }kg</div>
				        	</div>
				        	<div class="infoTitle">특이사항</div>
				        	<div>
				        		<div class="box">${apm.petspecial }</div>
				        	</div>
				        </div>
				        
				        <form action="/admin/addChart" method="post" onsubmit="return vaildateForm()" id="add_chart" enctype="multipart/form-data">
				        	<input type="hidden" name="resno" value="${apm.resno}">
				        	<div class="consultation-image">
					        	<div class="infoTitle">이미지</div>
					        	<div class="file-name-div" style="margin-top: 1rem" >
									 <div class="pre-img-div"></div>
									 <label for="img-input" class="file-input-label">+</label>
									 <input type="file" id="img-input" name="file" accept=".jpg, .jpeg, .png, .gif" style="display: none" onchange="addFile(this);" multiple>
						       </div>
				        	</div>
					       
					       <div class="infoTitle">차트 내용<em>*</em></div>
				        	<div>
				        		<textarea class="form-input-box" name="ccontents" required="required"></textarea>
				        	</div>
				        	
				        	<div class="infoTitle">기타/전달사항</div>
				        	<div>
				        		<textarea class="form-input-box" name="cect_con"></textarea>
				        	</div>
				        </form>
				     </div>

					<!-- 모달 버튼 -->
			       	<div class="modal_l-content-btn">
				       	<button type="button" class="to_list" id="detail_close_btn" onclick="location.href='/admin/consultaion'">목록으로</button>
			            <button type="submit" class="admin_modal update_btn" id="update_btn" form="add_chart">등록하기</button>
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

	function validateForm() {
		let result = false;
		
		result = confirm('이대로 작성하시겠습니까?');
		return result;
	}
	
	/**
	* 첨부파일 추가
	*/
 	function addFile(obj) {
		var maxFileCnt = 5; 				//최대 첨부파일 개수
		var curFileCnt = obj.files.length; 	// 현재 첨부된 파일 개수
		
		if(curFileCnt > maxFileCnt){ 		// 최대 첨부파일수 초과시 
			alert('최대 첨부파일 수는 '+maxFileCnt+'개 입니다.');
			return false;
		}
		
		for (var i = 0; i< Math.min(curFileCnt, maxFileCnt); i++){

			var reader = new FileReader();
			const file = obj.files[i];
			
			reader.onload = function(event) {
				var htmlData = '';
				htmlData += `<img src="\${event.target.result}" style="width: 7rem; height: 7rem" />`;
				
				$('.pre-img-div').css('display', 'inline');
				$('.pre-img-div').append(htmlData);
				$('.file-input-label').css('display', 'none');
			};
			reader.readAsDataURL(file);
		}
	} 
</script>
</html>