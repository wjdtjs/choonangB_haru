package com.example.haruProject.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.example.haruProject.common.handler.AdminLoginInterceptor;
import com.example.haruProject.common.handler.UserLoginInterceptor;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class WebMvcConfiguration implements WebMvcConfigurer {
	
	/**
	 * 로그인 세션 확인 인터셉터
	 */
    private final UserLoginInterceptor userLoginInterCeptor;
    private final AdminLoginInterceptor adminLoginInterCeptor;

    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(userLoginInterCeptor)
        		.addPathPatterns("/user/**")
        		;
        System.out.println("유저 로그인 인터셉터 등록");
        
        registry.addInterceptor(adminLoginInterCeptor)
				.addPathPatterns("/admin/**")
		;
        System.out.println("관리자 로그인 인터셉터 등록");
    }
    
    
    /**
     * cors
     */
    @Override
	public void addCorsMappings(CorsRegistry registry) {
		
		registry.addMapping("/**")
				.allowedOriginPatterns("http://localhost:8399")
				.allowedMethods("GET", "POST", "PUT", "DELETE")
				.allowedHeaders("*")
				.allowCredentials(true)
				.maxAge(3000)
				;
	}
}
