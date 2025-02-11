<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- Custom fonts for this template-->
<!-- <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css"> -->
<!-- <link
    href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
    rel="stylesheet"> -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.datatables.net/2.2.0/css/dataTables.dataTables.css" />

<!-- Bootstrap core JavaScript-->
<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Page level plugins -->
<script src="/vendor/chart.js/Chart.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote/dist/summernote-lite.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/js/sb-admin-2.js"></script>
<script src="/js/validation.js?v=0.05"></script>

<!-- Custom styles for this template-->
<link href="/css/sb-admin-2.css?v=0.49" rel="stylesheet">
<link href="/css/haru-admin.css?v=0.46" rel="stylesheet">
<link href="/css/js.css?v=0.02" rel="stylesheet">

<!-- 알림 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    console.log("SSE 연결 시작");

    const eventSource = new EventSource("/notifications/subscribe");

    eventSource.onmessage = function(event) {
        console.log("알림 도착: ", event.data);
    };

    eventSource.onerror = function(event) {
        console.log("SSE 연결 오류, 5초 후 재연결 시도...");
        eventSource.close();

        setTimeout(() => {
            connectSSE();  // 재연결 시도
        }, 5000);
    };

    function connectSSE() {
        const newEventSource = new EventSource("/notifications/subscribe");

        newEventSource.onmessage = function(event) {
            console.log("재연결 성공, 알림 도착: ", event.data);
        };

        newEventSource.onerror = function(event) {
            console.log("SSE 재연결 실패, 다시 시도...");
            newEventSource.close();

            setTimeout(connectSSE, 5000);
        };
    }

    function showNotification(message) {
        const notificationDiv = document.createElement("div");
        notificationDiv.textContent = message;
        notificationDiv.style.backgroundColor = "#0C808D";
        notificationDiv.style.color = "#fff";
        notificationDiv.style.padding = "20px";
        notificationDiv.style.position = "fixed";
        notificationDiv.style.top = "20px";
        notificationDiv.style.right = "20px";
        notificationDiv.style.borderRadius = "5px";
        notificationDiv.style.boxShadow = "0px 0px 5px #888";
        notificationDiv.style.zIndex = "9999";

        document.body.appendChild(notificationDiv);

        // 10초 후 자동 제거
        setTimeout(() => {
            notificationDiv.remove();
        }, 10000);
    }

    // ✅ SSE 연결 시작
    connectSSE();
</script>

