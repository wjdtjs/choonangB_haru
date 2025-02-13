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
    }

    // ✅ 클라이언트가 SSE 구독
    @GetMapping("/notifications")
    public SseEmitter subscribe() {
        return notificationService.subscribe();
    }

    // ✅ SSE를 통해 알림 전송
    @PostMapping("/send")
    public ResponseEntity<String> sendNotification(@RequestBody String message) {
        boolean result = notificationService.sendNotification(message);
        return result ? ResponseEntity.ok("알림 전송 성공") : ResponseEntity.noContent().build();
    }
    
}
