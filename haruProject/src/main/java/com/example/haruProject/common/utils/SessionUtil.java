package com.example.haruProject.common.utils;

import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {
	
	//로그인
    public static void login(HttpServletRequest request, Map<String, Object> user){
        HttpSession session = request.getSession(true);
        synchronized (session){
            session.setAttribute("user", user);
            System.out.println("session 세션에 정보 저장 : "+user);
        }
    }

    //로그인 여부 확인 
    // return boolean
    public static boolean isLogin(HttpServletRequest request){
        HttpSession session = request.getSession(true);
        return session.getAttribute("user") != null ? true : false;
    }

	//세션에 있는 user정보를 반환
    public static Object getUser(HttpServletRequest request){
        HttpSession session = request.getSession(true);
        return session.getAttribute("user");
    }
    
	//로그아웃
    public static void logout(HttpServletRequest request){
        HttpSession session = request.getSession(true);
        session.invalidate();
    }
}
