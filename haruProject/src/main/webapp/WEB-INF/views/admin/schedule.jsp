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
    
    <title>근무 관리</title>

</head>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	  var calendarEl = document.getElementById('calendar');

	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    initialView: 'dayGridMonth',
	    headerToolbar: {
	      left: 'title',
	      left: 'title',
	      right: 'prev,next today'
	    },
	    
	    events: [
	      {
	        title: 'All Day Event',
	        start: '2025-01-01'
	      },
	      {
	        title: 'Long Event',
	        start: '2025-01-07',
	        end: '2025-01-10'
	      },
	      {
	        groupId: '999',
	        title: 'Repeating Event',
	        start: '2025-01-09T16:00:00'
	      },
	      {
	        groupId: '999',
	        title: 'Repeating Event',
	        start: '2025-01-16T16:00:00'
	      },
	      {
	        title: 'Conference',
	        start: '2025-01-11',
	        end: '2025-01-13'
	      },
	      {
	        title: 'Meeting',
	        start: '2025-01-12T10:30:00',
	        end: '2025-01-12T12:30:00'
	      },
	      {
	        title: 'Lunch',
	        start: '2025-01-12T12:00:00'
	      },
	      {
	        title: 'Meeting',
	        start: '2025-01-12T14:30:00'
	      },
	      {
	        title: 'Birthday Party',
	        start: '2025-01-13T07:00:00'
	      },
	      {
	        title: 'Click for Google',
	        url: 'https://google.com/',
	        start: '2025-01-28'
	      }
	    ]
	  });

	  calendar.render();
	});
/* var calendar = $('#calendar').fullCalendar({
    header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
    },
    selectable: true, // 사용자가 날짜 선택
    selectHelper: true, // 날짜 선택 시 시각적
    editable: true, // 이벤트를 드래그 하여 이동
    eventLimit: true, // 한 날자에 표시할 수 있는 이벤트 수 제한
    events: function(start, end, timezone, callback) { // 서버에서 일정 데이터를 가져옴
        // AJAX를 통해 서버에서 일정 데이터를 가져옵니다.
        $.ajax({
            url: '/schedule/all',
            type: 'GET',
            dataType: 'json',
            success: function(events) {
                callback(events);
            }
        });
    },
    // 기타 이벤트 핸들러...
}); */
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