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

    <title>예약 추가</title>
</head>

<style>
.modal_ p {
	color: black;
	padding: 12px 24px;
	font-size: 18px;
	font-weight: bold;
	margin: 0;
}

/* 제목 제외 컨텐츠 */
#hr-res {
	display: flex;
}

/* 달력 */
#hr-res-left {
	width:400px;
	height: 100%;
	margin: 0;
	padding: 0;
}


/* 내용 */

#hr-res-right {
	display: flex;
	flex-direction: column;
	margin-left: 40px;
}

#hr-res-right p {
	margin-left: 8px;
	font-size: 16px;
}

.hr-table-res-modal {
	border: none;
	color: black;
	margin: 20px;
}
.hr-table-res-modal #hr-table-res-modal-data th {
	font-weight: bold;
	color: black;
	padding: 4px 12px;
}
.hr-table-res-modal #hr-table-res-modal-data td {
	color: black;
}
.hr-table-res-modal #hr-table-res-modal-data tr {
	margin: 4px
}


.hr-res-table {
	margin: 16px 20px;
}

#hr-res-table-data {
	border-radius: 24px;
	background-color: rgba(12, 128, 141, 0.1);
	font-size: 20px;
	text-align: center;
	color: black;
	font-weight: bold; 
	margin: 20px autos;
}

#hr-res-table-data td {
	padding: 12px;
}
	
#hr-table-empty {
	padding: 8px;
}

#hr-res-memo {
	margin: 0 24px;
}

#hr-res-memo textarea {
	border-radius: 24px;
	background-color: rgba(12, 128, 141, 0.1);
	padding: 16px;
	border: white;
}

#hr-table-res-modal-data select {
	border: 1px solid #0C808D;
	border-radius: 12px;
	color: black;
	font-size: 14px;
	width: 136px;
	height: 28px;
	padding: 2px 0px 2px 12px;
	margin: 0 12px;
}

#res_input {
	width: 136px;
	height: 28px;
	margin: 4px 12px;
	border: 1px solid var(--haru);
	border-radius: 12px;
	padding: 0 12px;
}


/* 예약 날짜 */
table#calendar {
    width: 100%;
    height: 300px;
    border: none;
    text-align: center;
    color: black;
}

#calendar td {
    border-radius: 12px;
	border: none;
	padding: 8px;
}


#cal_time_table td{
	text-align: center;
}

#cal_time_table button {
    width: 85%;
    margin: 8px;
    border: 1px solid var(--haru);
    background-color: white;
    border-radius: 16px;
    height: 28px;
}

.selected_time {
  background-color: var(--haru) !important;
  color: white; /* 버튼 텍스트를 가독성 있게 하려면 추가 */
}

.selected-date {
	background-color: var(--haru);
	color: white;
}

#cal_time_table > tbody > tr:nth-child(3) > td {
	padding-top: 12px;
}



</style>

<script type="text/javascript">
	// 달력
	var today = new Date();//오늘 날짜//내 컴퓨터 로컬을 기준으로 today에 Date 객체를 넣어줌
    var date = new Date();//today의 Date를 세어주는 역할
    function prevCalendar() {//이전 달
    // 이전 달을 today에 값을 저장하고 달력에 today를 넣어줌
    //today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
    //getMonth()는 현재 달을 받아 오므로 이전달을 출력하려면 -1을 해줘야함
     today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
     buildCalendar(); //달력 cell 만들어 출력 
    }

    function nextCalendar() {//다음 달
        // 다음 달을 today에 값을 저장하고 달력에 today 넣어줌
        //today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
        //getMonth()는 현재 달을 받아 오므로 다음달을 출력하려면 +1을 해줘야함
         today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
         buildCalendar();//달력 cell 만들어 출력
    }
	
    function buildCalendar() {
        var doMonth = new Date(today.getFullYear(), today.getMonth(), 1);
        var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
        var tbCalendar = document.getElementById("calendar");
        var tbCalendarYM = document.getElementById("tbCalendarYM");

        tbCalendarYM.innerHTML = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월";

        // 기존 열 제거
        while (tbCalendar.rows.length > 2) {
            tbCalendar.deleteRow(tbCalendar.rows.length - 1);
        }

        var row = null;
        row = tbCalendar.insertRow();
        var cnt = 0;

        // 빈 칸 채우기
        for (let i = 0; i < doMonth.getDay(); i++) {
            const cell = row.insertCell();
            cnt++;
        }

        // 날짜 채우기
        for (let i = 1; i <= lastDate.getDate(); i++) {
            const currentDay = i; // `i` 값을 고정시켜 저장
            const cell = row.insertCell();
            cell.innerHTML = i;
            cnt++;

            if (cnt % 7 == 1) {
                cell.innerHTML = "<font color=red>" + i + "</font>";
            }
            if (cnt % 7 == 0) {
                cell.innerHTML = "<font color=blue>" + i + "</font>";
                row = tbCalendar.insertRow();
            }

            if (
                today.getFullYear() == date.getFullYear() &&
                today.getMonth() == date.getMonth() &&
                i == date.getDate()
            ) {
                cell.bgColor = "#FAF58C";
            }

            // 날짜 클릭 이벤트 추가
            cell.addEventListener("click", function () {
                var selectedDate = today.getFullYear()+'-'+(today.getMonth() + 1)+'-'+currentDay;
                console.log("today.getFullYear():", today.getFullYear());
                console.log("today.getMonth():", today.getMonth());
                console.log("selectedDate:", selectedDate);
                console.log("선택된 날짜:", currentDay);
                alert("선택된 날짜: " + selectedDate);

                // 선택된 날짜 표시
                const selectedTd = document.querySelector(".selected-date");
                if (selectedTd) {
                    selectedTd.classList.remove("selected-date");
                	console.log("selectedTd:", selectedTd);
                }
                cell.classList.add("selected-date");
            });
        }
    }

    
    // 버튼 클릭시 회색    
    document.addEventListener("DOMContentLoaded", () => {
    	const cal_btn = document.querySelectorAll(".cal_time_btn");
        
        cal_btn.forEach((button) => {
        	button.addEventListener("click", () => {
        		button.classList.toggle("selected_time");
        	});
        });
	});
</script>

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
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold" >예약 추가</h1>
                    
					<!-- 모달 내용 -->       
			        <div class="modal_l"> 
			        	<!-- 제목을 제외한 컨텐츠 -->
			        	<div id="hr-res"> 
			        	
				        	<div id="hr-res-left">
				        		<p>예약 날짜</p>
				        		<div id="res-calendar">
				        			<table id="calendar" border="3" align="center" style="border-color:#3333FF ">
									    <tr><!-- label은 마우스로 클릭을 편하게 해줌 -->
									        <td><label onclick="prevCalendar()"><</label></td>
									        <td align="center" id="tbCalendarYM" colspan="5">yyyy년 m월</td>
									        <td><label onclick="nextCalendar()">></label></td>
									    </tr>
									    <tr>
									        <td align="center"><font color ="red">일</td>
									        <td align="center">월</td>
									        <td align="center">화</td>
									        <td align="center">수</td>
									        <td align="center">목</td>
									        <td align="center">금</td>
									        <td align="center"><font color ="blue">토</td>
									    </tr> 
									</table>
									<script language="javascript" type="text/javascript">
									    buildCalendar();
									</script>
				        		</div>
				        				<hr>
				        		<div id="cal_time">
				        			<table id="cal_time_table" width="100%" cellspacing="0">
				        				<tr>
				        					<td><button type="button" class="cal_time_btn">09:00</button></td>
				        					<td><button type="button" class="cal_time_btn">09:30</button></td>
				        					<td><button type="button" class="cal_time_btn">10:00</button></td>
				        					<td><button type="button" class="cal_time_btn">10:30</button></td>
				        				</tr>
				        				<tr>
				        					<td><button type="button" class="cal_time_btn">11:00</button></td>
				        					<td><button type="button" class="cal_time_btn">11:30</button></td>
				        					<td><button type="button" class="cal_time_btn">12:00</button></td>
				        					<td><button type="button" class="cal_time_btn">12:30</button></td>
				        				</tr>
				        				<tr>
				        					<td><button type="button" class="cal_time_btn">02:00</button></td>
				        					<td><button type="button" class="cal_time_btn">02:30</button></td>
				        					<td><button type="button" class="cal_time_btn">03:00</button></td>
				        					<td><button type="button" class="cal_time_btn">03:30</button></td>
				        				</tr>
				        				<tr>
				        					<td><button type="button" class="cal_time_btn">04:00</button></td>
				        					<td><button type="button" class="cal_time_btn">04:30</button></td>
				        					<td><button type="button" class="cal_time_btn">05:00</button></td>
				        					<td><button type="button" class="cal_time_btn">05:30</button></td>
				        				</tr>
				        			</table>
				        			
				        		</div>
				        	</div>
				        	
				        	<div id="hr-res-right">
				        		<div class="hr-table-res-modal">
						        	<table id="hr-table-res-modal-data">
						        		<colgroup>
						        			<col width="10%">
							        		<col width="25%">
						        		</colgroup>
						        			<tr>
						        				<th>예약 항목</th>
						        				<td>
						        					<div>
								                       	<select id="res-content">
								                    		<option value="1">일반 진료</option>
															<option value="2">접종</option>
															<option value="3">수술</option>
															<option value="4">건강검진</option>
								                    	</select>
								                    </div>
						        				</td>			        						        								        				
						        			</tr>
						        			<tr>
						        				<th><div id="hr-table-empty"></div></th>
						        			</tr>
						        			<tr>
						        				<th>세부 항목</th>
						        				<td>
						        					<div>
								                       	<select id="res-detail">
								                    		<option value="1">내과</option>
															<option value="2">치과</option>
															<option value="3">정형외과</option>
															<option value="4">이비인후과</option>
								                    	</select>
								                    </div>
						        				</td>
						        			</tr>
						        			<tr>
						        				<th><div id="hr-table-empty"></div></th>
						        			</tr>
						        			<tr>
						        				<th>담당의</th>
						        				<td>
						        					<div>
								                       	<select id="res-doc">
								                    		<option value="1">이제노 선생님</option>
															<option value="2">박원빈 선생님</option>
								                    	</select>
								                    </div>
						        				</td>
						        			</tr>				        			
						        			<tr>
						        				<th><div id="hr-table-empty"></div></th>
						        			</tr>
						        			<tr>
						        				<th><div id="hr-table-empty"></div></th>
						        			</tr>
						        			
						        			<tr>
						        				<th>보호자</th>
						        				<td><input type="text" name="mname" id="res_input"></td>
						        			</tr>
						        			
						        			<tr>
						        				<th>동물이름</th>
						        				<!-- 보호자 이름에 해당하는 동물 불러와서 선택할 수 있게 -->
						        				<td><select></select></td>
						        			</tr>
						
						
						
						        	</table>
						        </div>
						        
				        <p>예약 메모</p>
				        <div id="hr-res-memo">
				        	<textarea rows="10" cols="70" placeholder="예약 메모를 입력해주세요."></textarea>
				        </div>
	        		
		        	</div>
		        
	        	</div>
	        	
	        
		        
	        </div>
			        <!-- 모달 버튼 -->
			        <div class="modal_l-content-btn">
			        	<button type="button" id="modal_close_btn" class="to_list res_modal" onclick="location.href='/admin/reservation'">목록으로</button>
			        	<button type="submit" class="update_btn" form="pro-update-form">예약추가</button>
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