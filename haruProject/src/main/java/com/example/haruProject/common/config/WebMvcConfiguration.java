package com.example.haruProject.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.example.haruProject.common.handler.LoginInterceptor;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class WebMvcConfiguration implements WebMvcConfigurer {
	
	/**
	 * 유저 로그인 세션 확인 인터셉터
	 */
    private final LoginInterceptor loginInterCeptor;

    public void addInterceptors(InterceptorRegistry registry) {
        System.out.println("인터셉터 등록");
        registry.addInterceptor(loginInterCeptor)
        		.addPathPatterns("/**")
        		.excludePathPatterns("/all/**",
    								"/oauth/**",
        							"/css/**",
        							"/error",
        							"/img/**",
        							"/js/**",
        							"/vendor/**",
        							"/admin/**"
        				)
        		;
        											
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
