package com.example.haruProject.common.utils;

import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {
	
	//로그인
    public static void login(HttpServletRequest request, Map<String, Object> user){
        HttpSession session = request.getSession(true);
        synchronized (session){
            session.setAttribute("no", user.get("no"));
            session.setAttribute("name", user.get("name"));
            session.setAttribute("email", user.get("email"));
            session.setAttribute("type", user.get("type"));
            session.setAttribute("role", user.get("role"));
            System.out.println("session 세션에 정보 저장 : "+user);
        }
    }

    //로그인 여부 확인 
    // return boolean
    public static boolean isLogin(HttpServletRequest request){
        HttpSession session = request.getSession(true);
        return session.getAttribute("no") != null ? true : false;
    }

	//세션에 있는 user no 정보를 반환
    public static int getNo(HttpServletRequest request){
        HttpSession session = request.getSession(true);
        return (int) session.getAttribute("no");
    }
    //세션에 있는 user name 정보를 반환
    public static String getName(HttpServletRequest request){
    	HttpSession session = request.getSession(true);
    	return (String) session.getAttribute("name");
    }
    //세션에 있는 user email 정보를 반환
    public static String getEmail(HttpServletRequest request){
    	HttpSession session = request.getSession(true);
    	return (String) session.getAttribute("email");
    }
    //세션에 있는 로그인 타입 정보를 반환
    public static String getType(HttpServletRequest request){
    	HttpSession session = request.getSession(true);
    	return (String) session.getAttribute("type");
    }
    //세션에 있는 관리자 타입 정보를 반환
    public static int getRole(HttpServletRequest request){
    	HttpSession session = request.getSession(true);
    	return (int) session.getAttribute("role");
    }
    
    
	//로그아웃
    public static void logout(HttpServletRequest request){
        HttpSession session = request.getSession(true);
        session.invalidate();
    }
}
