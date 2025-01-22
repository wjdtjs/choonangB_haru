package com.example.haruProject.controller.admin.hr;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.dto.Mail;
import com.example.haruProject.service.hr.MailService;

@Controller
public class MailController {
	
	@Autowired
	private MailService mailService;
	
	SimpleDateFormat form1 = new SimpleDateFormat("yyyy년 mm월 dd일");
	
	@GetMapping("/mail/confirmSend")
	public Mail confirmSendMail(
	        @RequestParam("memail") String memail, 
	        @RequestParam("rdate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date rdate, 
	        @RequestParam("start_time") String start_time, 
	        @RequestParam("rtime") int rtime) {
	    System.out.println("MailController sendMail() start ,,,");

	    // 파라미터 검증
	    if (start_time == null || start_time.length() < 4) {
	        throw new IllegalArgumentException("start_time은 null이거나 형식이 올바르지 않습니다.");
	    }

	    Mail mail = new Mail();

	    SimpleDateFormat form1 = new SimpleDateFormat("yyyy년 MM월 dd일"); // MM을 대문자로 수정
	    String fdate = form1.format(rdate);
	    String ftime = start_time.substring(0, 2) + ":" + start_time.substring(2);
	    String message = "안녕하세요. 하루 동물병원 입니다.\n 신청하신 예약이 확정되었습니다.\n" +
	            fdate + "," + ftime + "까지 내원하여 주시기 바랍니다.\n" +
	            "진료 소요 시간은 " + rtime + "입니다. 감사합니다.";

	    mail.setAddress(memail);
	    mail.setTitle("하루 동물병원 예약 확정 안내");
	    mail.setMessage(message);

	    mailService.sendMail(mail);

	    return mail;
	}

	
	@GetMapping("/mail/cancelSend")
	public Mail cancelSendMail(String memail, Date rdate, String start_time, int rtime) {
		System.out.println("MailController sendMail() start ,,,");
		
		Mail mail = new Mail();
		
		mail.setAddress(memail);
		mail.setTitle(start_time);
		mail.setMessage(start_time);
		
		return mail;
	}

}
