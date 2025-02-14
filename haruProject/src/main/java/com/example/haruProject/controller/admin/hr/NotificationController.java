package com.example.haruProject.controller.admin.hr;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.example.haruProject.service.hr.NotificationService;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;

@RestController
@RequestMapping("/api")
public class NotificationController {
	
	private final NotificationService notificationService;

    public NotificationController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    // ✅ 서버가 시작될 때 기존 SSE 연결 초기화
    @PostConstruct
    public void init() {
        notificationService.clearEmitters();
        System.out.println("서버 종료 - SSE 연결 정리 완료");
    }
  

    // ✅ 클라이언트가 SSE 구독
    @GetMapping("/notifications")
    public SseEmitter subscribe() {
        return notificationService.subscribe();
    }

    // ✅ SSE를 통해 알림 전송
    @PostMapping("/send")
    public ResponseEntity<String> sendNotification(@RequestBody String message, @RequestBody String color) {
        boolean result = notificationService.sendNotification(message, color);
        return result ? ResponseEntity.ok("알림 전송 성공") : ResponseEntity.noContent().build();
    }
    
    @PostMapping("/notifications/close")
    public void closeAllConnections() {
    	System.out.println("🚨 클라이언트에서 SSE 연결 종료 요청");
    	notificationService.clearEmitters();
    }
    
}
