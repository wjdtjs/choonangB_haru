package com.example.haruProject;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.scheduling.annotation.EnableAsync;

@EnableAsync
@SpringBootApplication(exclude = { SecurityAutoConfiguration.class })
public class HaruProjectApplication {
	
	public static void main(String[] args) {
		SpringApplication.run(HaruProjectApplication.class, args);
	}

}
