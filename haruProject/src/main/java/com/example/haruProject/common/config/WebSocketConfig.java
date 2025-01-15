package com.example.haruProject.common.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.example.haruProject.common.handler.SocketHandler;




@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

	// Socket 사용 시 Server PGM으로 등록
	// Socket 서버 --> Controller와 비슷
	@Autowired
	SocketHandler socketHandler;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		
		// 누군가 url로 /chatting이라고 치면 --> socketHandler 발동 (서버역할)
//		registry.addHandler(socketHandler, "/chating");

	}

}
