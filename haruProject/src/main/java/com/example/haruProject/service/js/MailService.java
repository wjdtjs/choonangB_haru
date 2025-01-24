package com.example.haruProject.service.js;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MailService {
	private final JavaMailSender mailSender;  //MIME 객체
	
	/**
	 * 메일 전송 메소드
	 * @param tomail
	 * @param title
	 * @param content
	 * @throws MessagingException
	 */
	@Async
	public void sendMail(String tomail, String title, String content) throws MessagingException {
		
		String setfrom = "하루동물병원 <0808hr@gmail.com>"; //보내는사람
		
		// Mime 전자우편 Internet 표준 Format
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		messageHelper.setFrom(setfrom); //보내는 사람 생략하면 정상작동 안함
		messageHelper.setTo(tomail); //받는사람 이메일
		messageHelper.setSubject(title); //메일제목은 생략 가능
		
		messageHelper.setText(content); // 메일 내용

		mailSender.send(message);
		System.out.println("메일 전송 완료: " + tomail);
	}
}
