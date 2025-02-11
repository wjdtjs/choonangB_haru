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

    <title>관리자 메인</title>

</head>

<style>

.hr-card {
	display: flex;
	flex-direction: row;
}

.hr-card-text {
	font-size: 1rem;
	margin: auto 0;
	height: 20px;
}

.hr-con-card {
    margin: 12px auto;
    width: 400px;
}

p {
	color: black;
	font-weight: bold;
}

.hr-text {
	margin: auto 0 auto 12px;	
}

.hr-main-table {
	font-size: 12px;
}

</style>

<script type="text/javascript">
	
// 예약 상세 페이지로 이동
function goToDetail(resno) {
	// alert("resno->"+resno);
	console.log("resno 값:", resno);

    if (!resno) {
        alert("resno 값이 비어 있습니다.");
        return;
    }
    location.href = '/admin/detailReservation?resno='+resno;
}

// detail페이지로 이동
$(document).on('click','#dataTable .saleTable tr',function(){
	const orderno = $(this).find('td:nth-child(1)').text();
	console.log('클릭된 행의 orderno:' + orderno);
	
	window.location.href = `<%=request.getContextPath()%>/admin/detailShop?orderno=\${orderno}`;
});
</script>

<body id="page-top"> 

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
                <div class="container-fluid" style="/* display: flex; */">

                    <!-- Page Heading -->
                   <!--  <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h4 mb-0 text-gray-800 font-weight-bold">예약 현황</h1>
                        <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                                class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
                    </div> -->

					<div style="display: flex; width: 1400px; margin: 0;">
					
	                    <!-- Content Row -->
	                    <div class="row" style="">
	
	                        <!-- Earnings (Monthly) Card Example -->
	                        <div class="hr-con-card">
	                            <div class="card border-left-primary shadow py-2" style="height: 50px;">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center hr-card">
	                                        <div class="col mr-2" style="display: flex;">
	                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1 hr-card-text">
	                                                오늘의 예약
	                                            </div>
	                                            <p class="hr-text">${today_res}&nbsp; 건</p>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-calendar-day fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	
	                        <!-- Earnings (Monthly) Card Example -->
	                        <div class="hr-con-card">
	                            <div class="card border-left-success shadow py-2" style="height: 50px;">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center hr-card">
	                                        <div class="col mr-2" style="display: flex;">
	                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1 hr-card-text">
	                                                대기중 예약
	                                            </div>
	                                            <p class="hr-text">${wait_res}&nbsp; 건</p>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-calendar-check fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	
	                         <!-- Earnings (Monthly) Card Example -->
	                        <div class="hr-con-card">
	                            <div class="card border-left-info shadow py-2" style="height: 50px;">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center hr-card">
	                                        <div class="col mr-2" style="display: flex;">
	                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1 hr-card-text" style="color: #36b9cc;">
	                                                픽업 대기
	                                            </div>
	                                            <p class="hr-text">${wait_pur}&nbsp; 건</p>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-box-archive fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	
	                        <!-- Pending Requests Card Example -->
	                        <!-- <div class="hr-con-card">
	                            <div class="card border-left-warning shadow py-2" style="height: 80px;">
	                                <div class="card-body">
	                                    <div class="row no-gutters align-items-center hr-card">
	                                        <div class="col mr-2">
	                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1 hr-card-text">
	                                                Pending Requests</div>
	                                            <div class="h5 mb-0 font-weight-bold text-gray-800">18</div>
	                                        </div>
	                                        <div class="col-auto">
	                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div> -->
	                        
	                        
	                        
	                    </div>
	
	                    
                    
                    </div>
                    
                    
                    <div style="display: flex; width: 1600px;margin: 0 auto;">
                    
	                    <div style="margin: 12px 16px;">
	                    	<div>
		                    	<p>픽업 대기</p>
	                    	</div>
	                    	<table class="table table-bordered hr-main-table" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>주문번호</th>
                                        <th>주문자</th>
                                        <th>주문 상품</th>
                                        <th>구매일</th>
                                        <th>결제 방법</th>
                                        <th>최근 상태 변경 시간</th>
                                    </tr>
                                </thead>
                                <tbody class="saleTable">
                                	<c:forEach var="sale" items="${sales}">
                                		<tr>
                                			<td>${sale.orderno }</td>
                                			<td>${sale.mname }</td>
                                			<td>${sale.pname1 }</td>
                                			<td><fmt:formatDate value="${sale.odate }" pattern="yyyy-MM-dd"/></td>
                                			<td>${sale.opayment_content }</td>
                                			<td><fmt:formatDate value="${sale.update_date}" pattern="yyyy-MM-dd"/></td>
                                		</tr>
                                	</c:forEach>
                                </tbody>
                             </table>
	                    
	                    </div>
	                    
	                    <div style="margin: 12px 40px;">
	                    	<p>대기 중 예약</p>
	                    	<table class="table table-bordered hr-main-table" id="dataTable" width="100%" cellspacing="0">
                               <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>예약 날짜</th>
                                        <th>보호자</th>
                                        <th>동물 정보</th>
                                        <th>주치의</th>
                                        <th>진료 과목</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach var="appointment" items="${aList}">
	                                	<tr onclick="goToDetail('${appointment.resno}')" style="cursor: pointer;">
	                                		<td>${appointment.resno } </td>
	                                  		<td><fmt:formatDate value="${appointment.rdate}" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;${appointment.start_time }</td>
	                                  		<td>${appointment.mname } </td>
	                                   		<td>${appointment.petname }&nbsp;&nbsp;/&nbsp;&nbsp;${appointment.species }&nbsp;&nbsp;/&nbsp;&nbsp;${appointment.gender } </td>
	                               		    <td>${appointment.aname } </td>
	                                  		<td>${appointment.item } </td>
	                                   	</tr>
									                                    
	                                </c:forEach>                                    
                                </tbody>
                            </table>
	                    
	                    </div>
	                    
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


    <!-- Page level custom scripts -->
    <script src="/js/demo/chart-area-demo.js"></script>
    <script src="/js/demo/chart-pie-demo.js"></script>

</body>
</html>