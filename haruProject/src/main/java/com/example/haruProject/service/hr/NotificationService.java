package com.example.haruProject.service.hr;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationService {
   private final List<SseEmitter> emitters = new CopyOnWriteArrayList<>();

    // ✅ SSE 구독 메서드
    public SseEmitter subscribe() {
        SseEmitter emitter = new SseEmitter(30 * 60 * 1000L); // 30분 유지
        emitters.add(emitter);

        // 클라이언트에게 연결 확인 메시지 전송
        try {
            emitter.send(SseEmitter.event().data("connected"));
        } catch (IOException e) {
            emitter.complete();
        }

        // ✅ 연결이 끊어질 때 자동 제거
        emitter.onCompletion(() -> removeEmitter(emitter));
        emitter.onTimeout(() -> removeEmitter(emitter));
        emitter.onError((e) -> removeEmitter(emitter));

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
            return false; // 연결된 클라이언트 없음
        }

        boolean sent = false;
        Iterator<SseEmitter> iterator = emitters.iterator();

        while (iterator.hasNext()) {
            SseEmitter emitter = iterator.next();
            try {
                emitter.send(SseEmitter.event().data(message));
                sent = true;
            } catch (IOException e) {
                emitter.complete();
                iterator.remove();
                System.out.println("SSE 예외 발생, 제거 처리: " + e.getMessage());
            }
        }

        return sent; // 하나라도 전송되면 true 반환
    }


    // ✅ 서버 재시작 시 기존 SSE 연결을 초기화하는 메서드
    public void clearEmitters() {
        emitters.forEach(SseEmitter::complete);
        emitters.clear();
        System.out.println("♻️ 서버 재시작 - 기존 SSE 연결 모두 초기화됨");
    }
}
