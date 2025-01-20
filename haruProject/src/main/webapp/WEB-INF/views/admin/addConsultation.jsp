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

</head>

<!-- style -->
<style>

table, div{
	color: black;
	width: 100%;
}
.apmTable tr{
	height: 40px;
}

.infoTitle {
	font-size: 20px;
	font-weight: 500;
	margin-top: 10px
}

.contents{
	height: 50px;
	text-align: center;
	line-height: 50px;
	display: inline-grid;
	grid-template-columns: 1fr 3fr 2fr 1fr;
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
	border: 1px solid #aaa;
	background-color: #eee;
}

.box{
	height: 50px;
	margin: 5px 0;
	border-radius: 10px;
	border: 1px solid #aaa;
	background-color: #eee;
 
}


.form-input-title {
	font-weight: 500;

}



.form-input{
	width: 90%;
	height: 35px;
	border: 1.5px solid var(--haru);
	border-radius: 10px;
	padding-left: 10px;
}
/* SELECT 버튼 위치 수정*/
select {
	background-position: 95% center;
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
                    <form action="/admin/addChart" method="post" name="frm" id="upd_ad">
				        <input type="hidden" name="ano" value="${apm.resno}">
				        
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
				        		<div class="content">${apm.petname }</div>
				        		<div class="content">${apm.species } (${apm.gender })</div>
				        		<div class="content">${apm.petbirth } 출생</div>
				        		<div class="content">${apm.pno }</div>
				        	</div>
				        	<div class="infoTitle">특이사항</div>
				        	<div>
				        		<div class="box">${apm.petspecial }</div>
				        	</div>
				        </div>
				        
				        <div class="petInfo_2">
						    <div class="infoTitle">동물 정보</div>
				        	<div class="contents">
				        		<div class="content">${apm.petname }</div>
				        		<div class="content">${apm.species } (${apm.gender })</div>
				        		<div class="content">${apm.petbirth } 출생</div>
				        		<div class="content">${apm.pno }</div>
				        	</div>
				        	<div class="infoTitle_1">이미지</div>
				        	<div>
				        		<div class="image">${chart.img1 }</div>
				        	</div>
				        	<div class="infoTitle_1">차트 내용</div>
				        	<div>
				        		<div class="box">${chart.content }</div>
				        	</div>
				        	<div class="infoTitle_1">기타/전달사항</div>
				        	<div>
				        		<div class="box">${apm.memo }</div>
				        	</div>
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
</html>