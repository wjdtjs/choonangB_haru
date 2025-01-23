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
	width: 200px;
}
.hr-table-res-modal #hr-table-res-modal-data td {
	color: black;
}
.hr-table-res-modal #hr-table-res-modal-data tr {
	margin: 4px;
	padding: 8px 0;
	display: block;
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
    var disabledDates = [];
    
    function prevCalendar() {//이전 달
    // 이전 달을 today에 값을 저장하고 달력에 today를 넣어줌
    //today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
    //getMonth()는 현재 달을 받아 오므로 이전달을 출력하려면 -1을 해줘야함
     today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
     buildCalendar(disabledDates); //달력 cell 만들어 출력 
    }

    function nextCalendar() {//다음 달
        // 다음 달을 today에 값을 저장하고 달력에 today 넣어줌
        //today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
        //getMonth()는 현재 달을 받아 오므로 다음달을 출력하려면 +1을 해줘야함
         today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
         buildCalendar(disabledDates);//달력 cell 만들어 출력
    }
	
    function buildCalendar(disabledDates) {
    	console.log("buildCalendar start ,,,");
    	console.log("buildCalendar disabledDates ->", disabledDates);
    	
        var doMonth = new Date(today.getFullYear(), today.getMonth(), 1);
        var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
        var tbCalendar = document.getElementById("calendar");
        var tbCalendarYM = document.getElementById("tbCalendarYM");		// 제목(연도, 월) 작성

        tbCalendarYM.innerHTML = `\${today.getFullYear()}년 \${today.getMonth() + 1}월`;

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
            
            const dateStr = `\${today.getFullYear()}-\${String(today.getMonth() + 1).padStart(2, "0")}-\${String(currentDay).padStart(2, "0")}`;
            console.log("dateStr ->", dateStr);
            
         	// value 배열의 날짜를 YYYY-MM-DD 형식으로 변환
            const dateValue = disabledDates.map(date => {
                const d = new Date(date);
                return `\${d.getFullYear()}-\${String(d.getMonth() + 1).padStart(2, "0")}-\${String(d.getDate()).padStart(2, "0")}`;
            });
            
            
         	// 비활성화 날짜 처리
            if (dateValue.includes(dateStr)) {
            	console.log("disabledDates dateValue start ,,,");
                cell.style.backgroundColor = "lightgray";
                cell.style.pointerEvents = "none"; // 클릭 비활성화
                cell.style.opacity = "0.6"; // 시각적 효과
            } else {
                // 날짜 클릭 이벤트 추가
                cell.addEventListener("click", function () {
                    const selectedDate = `\${today.getFullYear()}-\${today.getMonth() + 1}-\${currentDay}`;
                    alert("선택된 날짜: " + selectedDate);

                    // 선택된 날짜 표시
                    const selectedTd = document.querySelector(".selected-date");
                    if (selectedTd) {
                        selectedTd.classList.remove("selected-date");
                    }
                    cell.classList.add("selected-date");
                });
            }

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
    
    
    // 비활성화 날짜 불러오기
    async function getDisabledDates(docValue) {
    	try {
    		console.log("getDisabledDates docValue ->"+docValue);
    		console.log("getDisabledDates api url ->", `/api/disabled-dates?ano=\${docValue}`);
            const response = await fetch(`/api/disabled-dates?ano=\${docValue}`, {
                method: "GET",
                headers: {
                    "Content-Type": "application/json",
                },
            });
            if (!response.ok) {
                throw new Error("Failed to fetch disabled dates");
            }
            const data = await response.json();
            console.log("getDisabledDates data ->", data);
            // console.log("getDisabledDates data.schdate ->", data.schdate);
            return data || [];
        } catch (error) {
            console.error("Error fetching disabled dates:", error);
            return [];
        }
    }
    
    // 선생님 선택시 진료 불가능 날짜 받아오기
    $(document).ready(function () {
    	$('#res-doc').change(async function() {
    		const selectedValue = $(this).val();	// 선택된 선생님 val 가져오기
    		console.log("selectedValue ->"+selectedValue);
    		
    		if (selectedValue && selectedValue != "0") {
				const dDates = await getDisabledDates(selectedValue);
    			console.log("if selectedValue ->"+selectedValue);
    			console.log("if dDates ->"+dDates);
    			
    			for (var i = 0; i < dDates.length; i++) {
    				disabledDates.push(dDates[i].schdate);
				}
    			console.log("disabledDates ->", disabledDates);
				
				if (disabledDates) {
					console.log("disabledDates ->",disabledDates);
					console.log("buildCalendar ready,,,");
					buildCalendar(disabledDates);
					$('#res-calendar').css("display", "block");		// 달력 보이게
				}
			}
    	})
    })
    
    
    
    
    
    
     
     
	// 예약 항목 > 선택된 대분류 값에 따른 중분류 값 가져오기
     /**
      * 대분류 선택 시 중분류 값 가져오기
      */
	$(function() {
		$("#res-content").change(() => {
			console.log("눌림");
			getMcd();
		});
	});
	
	/**
	 * 중분류 값 가져오기
	 */
	function getMcd(val) {
		let selectedOptionValue = $("#res-content option:selected").val();
		console.log(selectedOptionValue);
		
		$('.add-res-mcd').remove();
		$('#res-detail option:eq(0)').prop("selected", true);
		
		$.ajax({
			url: `${contextPath}/api/res-mcd/`+selectedOptionValue,
			dataType: 'json',
			success: function(data){
				
				let str = "";
				$(data).each(function(index, item) {
					str += `<option value="\${item.MCD}" class='.add-res-mcd'>\${item.CONTENT}</option>`;
				})
				
				$('#res-detail').html(str);
				
				if(val) {
					$('#res-detail').val(val).prop('selected', true);
				}
			},
			error: function(xhr, status, error) {
	            console.error("중분류 데이터를 가져오는 중 오류 발생:", error);
	        }
			
		})
	}
	
	
	
	// 보호자 이름에 따른 동물이름 데려오기
	// 보호자 이름 검색으로 드롭박스 통해 가져오기
/* 	function getMname(search1) {
		console.log(search1);
		
		$.ajax({
			url:  ,
			data: {
				search1: search1
			},
			dataType: 'json',
			success: function(data) {
				console.log(data.mname);
				console.log(data.mtel);
				
				let str = "";
				$(data).each(function(index, item) {
					str += `<option value="\${item.mname}" class='.res-mname'>\${item.mtel}</option>`;
				})
				
				$('#res-input').html(str);
				
				if(search1) {
					$('#res-input').val(search1).prop('selected', true);
				}
			},
			error: function(xhr, status, error) {
	            console.error("보호자 이름 데이터를 가져오는 중 오류 발생:", error);
	        }
		})
	}
	
 	
 */
    
    
    
    
    
    
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
				        		
				        		<!-- 달력 -->
				        		<div id="res-calendar" style="display: none">
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
								<!-- 시간 선택 -->
				        		<div id="cal_time" style="display: none">
			        				<hr>
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
						        		
						        			<tr>
						        				<th>담당의</th>
						        				<td>
						        					<div>
								                       	<select id="res-doc" name="aname">
								                       		<option disabled selected value="0">선택</option>
								                    		<c:forEach var="d" items="${docList}">
								                    			<option value="${d.ANO}">${d.ANAME}&nbsp;선생님</option>
								                    		</c:forEach>
								                    	</select>
								                    </div>
						        				</td>
						        			</tr>	
						        			<tr>
						        				<th>예약 항목</th>
						        				<td>
						        					<div>
								                       	<select id="res-content" name="mtitle_bcd">
								                    		<option disabled selected value="0">선택</option>
								                    		<c:forEach var="bcd" items="${bcdList}">
								                    			<option value="${bcd.BCD}" class="res-content-bcd">${bcd.CONTENT}</option>
								                    		</c:forEach>
								                    	</select>
								                    </div>
						        				</td>			        						        								        				
						        			</tr>
						        			<tr>
						        				<th>세부 항목</th>
						        				<td>
						        					<div>
								                       	<select id="res-detail" name="mtitle_mcd">
								                    		<option disabled selected value="0">선택</option>
								                    	</select>
								                    </div>
						        				</td>
						        			</tr>
						        									        		
						        			<tr>
						        				<th>보호자</th>
						        				<td>
						        					<div style="display: flex">
						        						<input type="text">
								                       	<select id="res-input" name="mname">
								                       		<option disabled selected value="0">선택</option>
								                    		
								                    	</select>
								                    </div>
						        				</td>
						        			</tr>
						        			
						        			<tr>
						        				<th>동물이름</th>
						        				<!-- 보호자 이름에 해당하는 동물 불러와서 선택할 수 있게 -->
						        				<td>
						        					<select style="display: none">
						        				
						        					</select>
						        				</td>
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