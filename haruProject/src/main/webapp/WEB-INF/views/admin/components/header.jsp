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
<script src="/vendor/chart.js/Chart.bundle.min.js"></script>

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
document.addEventListener("DOMContentLoaded", function () {
    console.log("DOM 로드 완료, SSE 연결 시작");

    const notificationContainer = document.createElement("div");
    notificationContainer.style.position = "fixed";
    notificationContainer.style.top = "20px";
    notificationContainer.style.right = "20px";
    notificationContainer.style.display = "flex";
    notificationContainer.style.flexDirection = "column-reverse";
    notificationContainer.style.gap = "10px";
    notificationContainer.style.zIndex = "9999";

    document.body.appendChild(notificationContainer);

    let eventSource;
    let reconnectAttempt = 0;

    function connectSSE() {
        if (eventSource) {
            console.log("🔄 기존 SSE 연결 종료 후 새로 연결 시도...");
            eventSource.close();
        }

        console.log(`🔄 SSE 연결 시도 (${reconnectAttempt + 1}번째)`);
        eventSource = new EventSource("/api/notifications");

        eventSource.onopen = function () {
            console.log("✅ SSE 연결 성공");
            reconnectAttempt = 0; // 성공하면 초기화
        };

        eventSource.onmessage = function (event) {
            if (event.data !== "connected") {
                console.log("🔔 새 알림:", event.data);
                saveNotification(event.data);
                showNotification(event.data);
            }
        };

        eventSource.onerror = function (event) {
            console.log("❌ SSE 오류 발생. 재연결을 시도합니다...");

            eventSource.close();

            // ✅ 점진적 재연결 (Exponential Backoff)
            reconnectAttempt++;
            let reconnectDelay = Math.min(5000 * reconnectAttempt, 30000); // 최대 30초까지 대기
            setTimeout(connectSSE, reconnectDelay);
        };
    }

    function saveNotification(message) {
        let notifications = JSON.parse(sessionStorage.getItem("notifications")) || [];
        notifications.push(message);
        sessionStorage.setItem("notifications", JSON.stringify(notifications));
    }

    function removeNotification(message) {
        let notifications = JSON.parse(sessionStorage.getItem("notifications")) || [];
        notifications = notifications.filter(n => n !== message);
        sessionStorage.setItem("notifications", JSON.stringify(notifications));
    }

    function showNotification(message) {
        console.log("🔔 showNotification 호출됨:", message);

        const notificationDiv = document.createElement("div");
        notificationDiv.textContent = message;
        notificationDiv.style.backgroundColor = "#0C808D";
        notificationDiv.style.color = "#fff";
        notificationDiv.style.padding = "15px";
        notificationDiv.style.borderRadius = "8px";
        notificationDiv.style.boxShadow = "0px 4px 6px rgba(0, 0, 0, 0.1)";
        notificationDiv.style.cursor = "pointer";
        notificationDiv.style.opacity = "1";
        notificationDiv.style.transition = "opacity 0.3s ease";

        notificationDiv.addEventListener("click", function () {
            notificationDiv.style.opacity = "0";
            setTimeout(() => {
                notificationDiv.remove();
                removeNotification(message);
            }, 300);
        });

        notificationContainer.prepend(notificationDiv);
        console.log("✅ 알림 추가 완료!");
    }

    function loadNotifications() {
        let notifications = JSON.parse(sessionStorage.getItem("notifications")) || [];
        notifications.forEach(message => {
            showNotification(message);
        });
    }

    loadNotifications();
    connectSSE(); // ✅ SSE 연결 시작
});

</script>