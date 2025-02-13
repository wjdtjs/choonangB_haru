package com.example.haruProject.service.hr;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationService {
   private final List<SseEmitter> emitters = new CopyOnWriteArrayList<>();
   private static final int MAX_CONNECTIONS = 100; // 최대 100개까지 허용

    // ✅ SSE 구독 메서드
    public SseEmitter subscribe() {
    	System.out.println("$$$ SSE subscribe() start..");
        SseEmitter emitter = new SseEmitter(30 * 60 * 1000L); // 30분 유지
        
        synchronized (emitters) {
            if (emitters.size() >= MAX_CONNECTIONS) {
                System.out.println("⚠️ 최대 SSE 연결 개수 초과! 오래된 연결 정리 중...");
                emitters.remove(0).complete(); // 가장 오래된 연결 제거
            }
            emitters.add(emitter);
        }
        
        // 클라이언트에게 연결 확인 메시지 전송
        try {
            emitter.send(SseEmitter.event().data("connected"));
        } catch (IOException e) {
            emitter.complete();
        }

        // ✅ 연결이 끊어질 때 자동 제거
        emitter.onCompletion(() -> {removeEmitter(emitter); System.out.println("$$$ SSE 연결 종료");});
        emitter.onTimeout(() -> {emitter.complete(); removeEmitter(emitter); System.out.println("$$$ SSE 타임아웃");});
        emitter.onError((e) -> {emitter.complete(); removeEmitter(emitter); System.out.println("$$$ SSE 에러 : "+e);});

        return emitter;
    }

    // ✅ SSE 연결 해제
    public void removeEmitter(SseEmitter emitter) {
        emitters.remove(emitter);
        System.out.println("🚫 SSE 연결 제거됨");
    }

    // ✅ SSE를 통해 알림 전송
    public boolean sendNotification(String message) {
    	 if (emitters.isEmpty()) {
    	        return false;
    	    }

    	    List<SseEmitter> deadEmitters = new ArrayList<>();

    	    for (SseEmitter emitter : emitters) {
    	        try {
    	            emitter.send(SseEmitter.event().data(message));
    	        } catch (IOException e) {
    	            emitter.complete();
    	            deadEmitters.add(emitter); // 제거할 Emitter 수집
    	            System.out.println("🚨 SSE 예외 발생, 제거 처리: " + e.getMessage());
    	        }
    	    }

    	    emitters.removeAll(deadEmitters); // 안전하게 한 번에 제거
    	    return !deadEmitters.isEmpty();
    }


    // ✅ 기존 SSE 연결을 초기화하는 메서드
    public void clearEmitters() {
    	for (SseEmitter emitter : emitters) {
    		try {
                emitter.complete();
            } catch (Exception e) {
            	System.out.println("==== SSE 종료 에러!!!!!!!!! "+e);
            }
        }
        emitters.clear();
        System.out.println("♻️ 기존 SSE 연결 모두 초기화됨");
    }
    
}
