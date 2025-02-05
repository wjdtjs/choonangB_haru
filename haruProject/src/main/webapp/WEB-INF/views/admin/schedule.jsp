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
	.calendar {
	 	width: 60%;
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
	.fc-event-time{
		display: none;
	}
	/* .fc-event-title {
		color: "#333";
	} */
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
	    selectable: true,
	    droppable: true,
	    navLinks: true,
	    editable: true,
	    nowIndicator: true,
	    locale: 'ko',
	    datesSet: function (info) {
	    	let currentDate = info.view.currentStart;
	        let formattedDate = currentDate.getFullYear() + '-' + ('0' + (currentDate.getMonth() + 1)).slice(-2); // "YYYY-MM" 형태
	                  
	        $.ajax({
	        	url: '<%=request.getContextPath()%>/admin/api/getSchedule',
	            type: 'GET',
	            data: {
	            	formattedDate :formattedDate
	            },
	            dataType: 'json',
	            success: function(response) {
	            	var events = [];
	            	console.log('response: '+ JSON.stringify(response));
	            	console.log('response: '+ response.length);
	                      	
	                // 서버에소 받은 데이터를 이벤트 객체로 변환하여 배열에 추가
	                var offdays = response.offdays;
	                for(var i = 0; i<response.schedules.length; i++){
	                	var res = response.schedules[i];
	                	var event = {};
	                      		
	                    if(res.schtype_mcd == 100){
	                    	event= {            					
	          		        	title: res.sch_content,
	          		            start: res.schdate,
	          	            	color: '#F08D7F',
	          	            	allDay: true,
	          	            }
	                    } else if(res.schtype_mcd == 200){
	                    	event = {
	                    		title: res.aname+' '+res.sch_content,
	                    		start: i,
	                    		color: "#d0e4e8",
	                    		textColor: "#333333",
	                    		allDay: true,
	          	            }
	                     }else if(res.schtype_mcd == 300){
	                      	event = {
	                          	title: res.aname+' '+res.sch_content,
	              	            start: res.schdate,
	                          	color: "#254d64",
	                          	allDay: true,
	            			}
	                     }
	                    calendar.addEvent(event);
	            	} // end for
	            },
	            error: function () {
	            	console.log('Failed to fetch data from the server.');
	          	}
	        }); //ajax end
	    } //data end
	});
	calendar.render();
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