/**
 *  SSE 연결 관리
 */

let eventSource = null;
let reconnectAttempt = 0;
let reconnectTimer = null;
 $(()=>{
    console.log("DOM 로드 완료, SSE 연결 시작");
    

    let notificationContainer = document.createElement("div");
    notificationContainer.style.position = "fixed";
    notificationContainer.style.top = "20px";
    notificationContainer.style.right = "20px";
    notificationContainer.style.display = "flex";
    notificationContainer.style.flexDirection = "column-reverse";
    notificationContainer.style.gap = "10px";
    notificationContainer.style.zIndex = "9999";

    document.body.appendChild(notificationContainer);
    
    loadNotifications();
    
	if(sessionStorage.getItem("sseConnected")||sessionStorage.getItem("sseConnected")=="true"){
		console.log("🔄 SSE 이미 연결됨. 새 연결을 만들지 않음");
		return;
	} else {
		console.log("🔄 새 연결을 만들기");
	    connectSSE(); // ✅ SSE 연결 시작
	    sessionStorage.setItem("sseConnected", "true"); // SSE 연결 상태 저장
        console.log("@@@@ SSE", eventSource);
	}
	
	
	
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
	        clearTimeout(reconnectTimer); // ✅ 기존 타이머 정리
	    };
	    
	
	    eventSource.onmessage = function (event) {
	        if (event.data !== "connected") {
	            console.log("🔔 새 알림:", event.data);
	            saveNotification(event.data);
	            showNotification(event.data);
	        }
	    };
	
	    eventSource.onerror = function () {
	        console.log("❌ SSE 오류 발생. 재연결을 시도합니다...");
	
	        disconnectSSE(); // 🚨 여기서 확실히 닫기
	
	        // ✅ 점진적 재연결 (Exponential Backoff)
//	        reconnectAttempt++;
//	        let reconnectDelay = Math.min(5000 * reconnectAttempt, 30000); // 최대 30초까지 대기
//	        
//	        clearTimeout(reconnectTimer); // ✅ 기존 타이머 정리
//	        reconnectTimer = setTimeout(connectSSE, reconnectDelay);
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
	
	function showNotification(data) {
		let json_data = JSON.parse(data);
	    console.log("🔔 showNotification 호출됨:", json_data.message);
	
	    const notificationDiv = document.createElement("div");
	    notificationDiv.textContent = json_data.message;
	    notificationDiv.style.backgroundColor = json_data.color;
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
	            removeNotification(data);
	        }, 300);
	    });
	
	    notificationContainer.prepend(notificationDiv);
	    console.log("✅ 알림 추가 완료!");
	}
	
	function loadNotifications() {
	    let notifications = JSON.parse(sessionStorage.getItem("notifications")) || [];
	    notifications.forEach(data => {
	        showNotification(data);
	    });
	}
});


function disconnectSSE() {
	if (eventSource) {
        console.log("🔴 SSE 연결 종료 요청 전송...");
        eventSource.close();
        eventSource = null;
        sessionStorage.removeItem("sseConnected");

        fetch("/api/notifications/close", { method: "POST" })
            .then(() => console.log("✅ 서버에 SSE 종료 요청 완료"))
            .catch(err => console.error("❌ SSE 종료 요청 실패:", err));
    }
}


$(window).bind('beforeunload', function() {
    console.log("🔌 페이지 이동: SSE 연결 종료");
    disconnectSSE();
});