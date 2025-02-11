package com.example.haruProject.controller.admin.hr;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.example.haruProject.service.hr.NotificationService;

@RestController
@RequestMapping("/notifications")
public class NotificationController {
	
	private final NotificationService notificationService;

    public NotificationController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @GetMapping("/subscribe")
    public SseEmitter subscribe() {
        return notificationService.subscribe();
    }

    @PostMapping("/send")
    public void sendNotification(@RequestParam String message) {
        notificationService.sendNotification(message);
    }
    
}
