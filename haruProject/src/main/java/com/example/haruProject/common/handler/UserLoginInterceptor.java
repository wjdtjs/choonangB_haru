package com.example.haruProject.common.handler;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.haruProject.common.utils.SessionUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class UserLoginInterceptor implements HandlerInterceptor {
	
	 @Override
	    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	        
	        // 세션이 없으면 로그인 필요
	        if (!SessionUtil.isLogin(request)) {
	            // AJAX 요청인지 확인
	            String ajaxHeader = request.getHeader("X-Requested-With");

	            if ("XMLHttpRequest".equals(ajaxHeader)) {
	                // AJAX 요청이면 JSON 응답 반환
	                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Unauthorized
	                response.setContentType("application/json");
	                response.setCharacterEncoding("UTF-8");
	                response.getWriter().write("{\"error\": \"로그인이 필요합니다.\"}");
	                return false;
	            } else {
	                // 일반 요청이면 로그인 페이지로 리다이렉트
	                response.sendRedirect("/all/user/login");
	                return false;
	            }
	        } else {
	        	String type = SessionUtil.getType(request);
	        	if(!type.startsWith("G")) { //세션이 있지만 유저 타입이 아닐 때 로그인 페이지 이동
	        		response.sendRedirect("/all/user/login");
	        		return false;
	        	}
	        }
	        return true;
	    }
}
