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

    <title>관리자 수정</title>

</head>

<script type="text/javascript">

	let search1 = "";
	
	$(async ()=>{
		await listShow('1');
		
		//검색
		$('.tb-search-input').keyup(async function() {
// 			console.log($(this).val())
			search1 = $(this).val();
			await listShow('1', search1);
		})
		
	})
	
	/**
	 * 리스트 (ajax)
	*/
	async function listShow(pageNum, search1) {
		console.log(search1)
		
		$.ajax({
			url: "<%=request.getContextPath()%>/api/admin-list",
			data: {
				pageNum: pageNum,
				search1: search1
			},
			dataType: 'json',
			success: function(data) {
				
				console.log(data.list);
				
				let pagination = data.pagination;
				
				let str = "";
				let str2 = "";
				
				$(data.list).each (function(){
					str += `
							<tr class="haru-table-click">
		                        <td>\${this.ano}</td>
		                        <td>\${this.aname}</td>
		                        <td>\${this.aemail}</td>
		                        <td>\${this.level_content}</td>
		                        <td>\${this.hiredate.split('T')[0]}</td>
		                        <td>\${this.status_content}</td>
	                    	</tr>
					       `
				})
				$('.adminTable').html(str);
				
				if(pagination.startPage > pagination.blockSize) {
					str2 += `<i class="haru-pagearrow fa-solid fa-chevron-left" onclick="pageChange(\${pagination.startPage-pagination.blockSize})"></i>`;
				}
				for(let i=1; i<pagination.pageCnt+1; i++) {
					str2 += `<div class="haru-pagenum" id="pageNum\${i}" onclick="pageChange(\${i})">\${i }</div>`;
				} 
				if(pagination.endPage < pagination.pageCnt) {
					str2 += `<i class="haru-pagearrow fa-solid fa-chevron-right" onclick="pageChange(\${pagination.startPage+pagination.blockSize})"></i>`;
				}
				
				$('.haru-pagination').html(str2);
				
				$(`#pageNum\${pagination.currentPage}`).addClass('active');
				
			},
			error: function(e) {
				console.log(e);
			}
		})
	}
	
	/**
	 * 페이지 교체
	 * @param num 
	 * @return 
	*/
	async function pageChange(num) {
		let id = '#pageNum' + num;
		
		await listShow(num, search1);
		
		$('.haru-pagenum').removeClass('active');
		$(id).addClass('active');
		
	}
	
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
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >관리자 관리</h1>
                    

                    <!-- DataTales Example -->
                    <form action="/updateAdmin" method="post" name="frm" id="upd_ad">

		        <table class="inputTable">
		        <input type="hidden" name="ano" value="${admin.ano }">
		        	<colgroup>
                    	<col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
                    </colgroup>
		        	<tr>
		        		<th>사번</th>		<td>${admin.ano }</td>
		        		<th>비밀번호</th>	<td><input class="form-input" type="text" name="apasswd" required="required"></td>
		        	</tr>
		        	<tr>
		        		<th>이름</th>		<td><input class="form-input" type="text" name="aname" required="required" value="${admin.aname}"></td>
		        		<th>비밀번호확인</th><td><input class="form-input" type="text" name="re_apasswd" required="required"></td>
		        	</tr>
		        	<tr>
		        		<th>전화번호</th>	<td><input class="form-input" type="text" name="atel" required="required" value="${admin.atel}"></td>
		        		<th>이메일</th>	<td><input class="form-input" type="text" name="aemail" value="${admin.aemail}"></td>
		        	</tr>
		        	<tr>
		        		<th>Role</th>
		        		<td>
		        			<select class="form-input sub-alevel-mcd-select" name="${admin.alevel_bcd }"></select>
		        		</td>
		        		<th>입사일</th>	<td>${admin.hiredate }</td>
		        		
		        		
		        	</tr>
		        	<tr>
		        		<th>상태</th>
		        		<td>
		        			<select class="form-input sub-status-mcd-select" name="${astatus_bcd }" ></select>
		        		</td>
		        		<th>등록일</th>	<td>${admin.reg_date }</td>
		        		
		        		
		        	</tr>
		        </table>
	        </form>

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
    
    <jsp:include page="modalAddAdmin.jsp"></jsp:include>
    <jsp:include page="modalAdmin.jsp"></jsp:include>

</body>
</html>