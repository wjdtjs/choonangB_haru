package com.example.haruProject.service.hr;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import com.example.haruProject.dto.Mail;

@Component
public class MailService {
	
	@Autowired
	private JavaMailSender mailSender;
	
	public void sendMail(Mail mail) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(mail.getAddress());		// 받는 사람
//		message.setFrom("");					// 보내는 사람
		message.setSubject(mail.getTitle());	// 메일 제목
		message.setText(mail.getMessage());	// 메일 내용
		
		mailSender.send(message);				
	}
}
