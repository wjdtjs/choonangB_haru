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
    
     <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
    <script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.1/locales/ko.global.js"></script>
    
    <title>근무 관리</title>

</head>
<style>
	#calendar {
	 	height: 60%;
	}
	.fc-toolbar-chunk{
	 	font-size: 14px;
	}
	.fc-col-header-cell-cushion, .fc-daygrid-day-number {
	    text-decoration: none;
	}
	
	.fc-scrollgrid-sync-inner > .fc-col-header-cell-cushion,
	.fc-day-mon .fc-daygrid-day-number,
	.fc-day-tue .fc-daygrid-day-number,
	.fc-day-wed .fc-daygrid-day-number,
	.fc-day-thu .fc-daygrid-day-number,
	.fc-day-fri .fc-daygrid-day-number {
	    color: black;
	    font-size: 14px;
	}
	
	.fc-day-sun .fc-col-header-cell-cushion,
	.fc-day-sun a{
	    color : red;
	    font-size: 14px;
	} 
	.fc-day-sat .fc-col-header-cell-cushion,
	.fc-day-sat a {
	    color : blue;
	    font-size: 14px;
	}
	
	.fc-day-sun a >.fc-event-title,
	.fc-day-mon a >.fc-event-title,
	.fc-day-tue a >.fc-event-title,
	.fc-day-wed a >.fc-event-title,
	.fc-day-thu a >.fc-event-title,
	.fc-day-fri a >.fc-event-title,
	.fc-day-sat a >.fc-event-title
	{
		color : #254d64;
	    font-size: 14px;
	    font-weight: 500;
	}
	
	
	.fc-event-time{
		display: none;
	}
	
</style>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView: 'dayGridMonth',
	    headerToolbar: {
	    	left: 'prev,next today',
	    	center: 'title',
	    	right: 'addSchedule'
	    },
	    customButtons:{
	    	addSchedule: {
	    		text: "일정등록",
	    		click: function(){
	    			location.href= '/admin/addScheduleView'
	    		}
	    	}
	    },
	    titleFormat: function (date) {
	    	return date.date.year + '년 ' + (parseInt(date.date.month) + 1) + '월';
	    },
	    //selectable: true,
	    //droppable: true,
	    //navLinks: true,
	    editable: true,
	    nowIndicator: true,
	    locale: 'ko',
	    datesSet: function (info) {
	    	let currentDate = info.view.currentStart;
	    	let currentDateEnd = info.view.currentEnd;
	    	
	        let formattedDate = currentDate.getFullYear()%100 + '/' + ('0' + (currentDate.getMonth() + 1)).slice(-2); // "YYYY-MM" 형태
	        let formattedDateStart = currentDate.getFullYear()%100 + '/' + ('0' + (currentDate.getMonth() + 1)).slice(-2) + '/' + ('0' + currentDateEnd.getDate()).slice(-2); // "YYYY-MM" 형태
	        let formattedDateEnd = currentDateEnd.getFullYear()%100 + '/' + ('0' + (currentDateEnd.getMonth() + 1)).slice(-2) + '/' + ('0' + currentDateEnd.getDate()).slice(-2); // "YYYY-MM" 형태


	        
	        console.log("currentDate - >"+currentDate);
	        console.log("currentDateEnd - >"+currentDateEnd);
	        console.log("formattedDate - >"+formattedDate);
	        console.log("formattedDateEnd - >"+formattedDateEnd);
	        $.ajax({
	        	url: '<%=request.getContextPath()%>/api/getSchedule',
	            type: 'GET',
	            data: {
	            	formattedDate: formattedDate,
	            	formattedDateStart,formattedDateStart,
	            	formattedDateEnd : formattedDateEnd
	            },
	            dataType: 'json',
	            success: function(response) {
	            	calendar.removeAllEvents();
	            	var events = [];
	            	console.log('response: '+ JSON.stringify(response));
	            	console.log('response.schedules: '+ response.schedules.length);
	                      	
	                // 서버에서 받은 데이터를 이벤트 객체로 변환하여 배열에 추가
	                var schedules = response.schedules;
	                var reg_schedules = response.reg_schedules;
	                console.log('reg_schedules.length: '+reg_schedules.length);


	            	
	                for(var i = 0; i<schedules.length; i++){
	                	var res = schedules[i];
	                	var event = {};
	                      		
	                    if(res.schtype_mcd == 100){
	                    	event= {  
		                    		id: res.schno,
		          		        	title: res.sch_content,
		          		            start: res.schdate,
		          	            	color: '#F08D7F',
		          	            	allDay: true,
		          	            	url: '/admin/detailSchedule?schno='+res.schno,
	          	            }
	                    } else if(res.schtype_mcd == 300){
	                      	event = {
	                      			id: res.schno,
		                          	title: res.aname+' '+res.sch_content,
		              	            start: res.schdate,
		                          	color: "#254d64",
		                          	allDay: true,
		                          	url: '/admin/detailSchedule?schno='+res.schno,
	            			}
	                     }
	                    calendar.addEvent(event);
	            	} // end for
	            	for (var j = 0 ; j < reg_schedules.length ; j ++){
	            		var res1 = reg_schedules[j];
	            		console.log('response: '+ JSON.stringify(res1));
	            		if(res1.persoffdays){	            			
	            			console.log("res1.persoffdays.length : "+res1.persoffdays.length)
	            			
		            		for( var k = 0 ;  k < res1.persoffdays.length; k++){
		            			event = {
		            					id: res1.schno,
		            					title: res1.aname+' '+res1.sch_content,
			              	            start: res1.persoffdays[k],
			                          	color: "#254d64",
			                          	url: '/admin/detailSchedule?schno='+res1.schno,
			            		};
		            		calendar.addEvent(event);
		            		}
	            		}
	            	}
	            },
	            error: function () {
	            	console.log('Failed to fetch data from the server.');
	          	}
	        }); //ajax end
	    }, //data end
	    
	});
	// 수정된 날짜로 이동
    var updatedDate = '${updatedDate}';  // JSP에서 전달된 수정된 날짜
    if (updatedDate) {
        calendar.gotoDate(updatedDate);
    }
    
	calendar.render();
	// 수정된 날짜로 이동
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
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h4 mb-4 text-gray-800 font-weight-bold">근무 관리</h1>
                      <div id='calendar'></div>
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