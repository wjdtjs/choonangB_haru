package com.example.haruProject.service.hr;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationService {
	// 모든 사용자의 SSE 연결을 저장할 리스트
    private final List<SseEmitter> emitters = new CopyOnWriteArrayList<>();

    public SseEmitter subscribe() {
        SseEmitter emitter = new SseEmitter(60 * 60 * 1000L); // 1시간 유지
        emitters.add(emitter);

        emitter.onCompletion(() -> {
            emitters.remove(emitter);
            System.out.println("SSE 연결 종료: " + emitter);
        });

        emitter.onTimeout(() -> {
            emitter.complete();
            emitters.remove(emitter);
            System.out.println("SSE 타임아웃: " + emitter);
        });

        emitter.onError((e) -> {
            emitter.complete();
            emitters.remove(emitter);
            System.out.println("SSE 오류 발생: " + e.getMessage());
        });

        return emitter;
    }

    public boolean sendNotification(String message) {
    	if (emitters.isEmpty()) {
            return false; // 연결된 클라이언트 없음
        }

        List<SseEmitter> deadEmitters = new CopyOnWriteArrayList<>();
        boolean sent = false;

        for (SseEmitter emitter : emitters) {
            try {
                emitter.send(SseEmitter.event().data(message));
            } catch (IOException e) {
            	deadEmitters.add(emitter);
                emitter.complete();
                System.out.println("SSE 예외 발생, 제거 처리: " + e.getMessage());
            }
        }

        emitters.removeAll(deadEmitters);
        return sent; // 하나라도 전송되면 true 반환
    }
    
}
