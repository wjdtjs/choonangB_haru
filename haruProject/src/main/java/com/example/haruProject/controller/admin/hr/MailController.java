package com.example.haruProject.controller.admin.hr;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.service.hr.AppointmentService;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MailController {
	private final JavaMailSender mailSender;
	
	private final AppointmentService as;
	
	// 확정 메일 전송
	@RequestMapping("/mail/confirmSend")
	public String confirmSendMail(@RequestParam("memail") String memail, 
								  @RequestParam("rdate") String rdate, 
								  @RequestParam("start_time") String start_time, 
								  @RequestParam("rtime") int rtime,
								  @RequestParam("resno") String resno,
							      @RequestParam("memo") String memo,
								  @RequestParam("status") int status,
								  Model model
								  )
	{
	    System.out.println("MailController confirmSendMail() start ,,,");
	    System.out.println("MailController confirmSendMail() memail ->"+memail);
	    System.out.println("MailController confirmSendMail() rdate ->"+rdate);
	    System.out.println("MailController confirmSendMail() start_time ->"+start_time);
	    System.out.println("MailController confirmSendMail() rtime ->"+rtime);
	    
	    String tomail = memail;
	    String setfrom = "하루동물병원 <0808hr@gmail.com>";
	    String title = "하루 동물병원 예약 확정 안내";
	    
		/*
		 * 안녕하세요. 하루 동물병원 입니다.
		 * 신청하신 예약이 확정되었습니다.
		 * 0000년 00월 00일, 00시 00분까지 내원하여 주시기 바랍니다.
		 * 진료 소요 시간은 00분 입니다. 감사합니다.
		 */
	    
	    String content = "안녕하세요. 하루 동물병원 입니다.\n 신청하신 예약이 확정되었습니다.\n" +
	            rdate + ", " + start_time + "까지 내원하여 주시기 바랍니다.\n" +
	            "진료 소요 시간은 " + rtime + "분 입니다. 감사합니다.";
	    System.out.println("content: "+content);
	    
	    try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, false, "UTF-8");
			messageHelper.setFrom(setfrom);
			messageHelper.setTo(tomail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			mailSender.send(message);
			System.out.println("confirm mail send success");
			
            // location.href = "/admin/updateReservation?" + sendData;
            int result = as.updateReservation(resno, rtime, memo, status);
            System.out.println("MailController sendMail() updateReservation result ->"+result);
            
		} catch (Exception e) {
			System.out.println("confirm mail send error ->"+e.getMessage());
			System.out.println("confirm mail send fail");
		}
	    
	    return "redirect:/admin/reservation";
	}

	// 취소 메일 전송
	@GetMapping("/mail/cancelSend")
	public String cancelSendMail(@RequestParam("memail") String memail, 
								 @RequestParam("rdate") String rdate, 
								 @RequestParam("start_time") String start_time, 
								 @RequestParam("rtime") int rtime,
								 @RequestParam("resno") String resno,
								 @RequestParam("memo") String memo,
								 @RequestParam("status") int status,
								 Model model)
	{
		System.out.println("MailController cancelSendMail() start ,,,");
	    System.out.println("MailController cancelSendMail() memail ->"+memail);
	    System.out.println("MailController cancelSendMail() rdate ->"+rdate);
	    System.out.println("MailController cancelSendMail() start_time ->"+start_time);
	    System.out.println("MailController cancelSendMail() rtime ->"+rtime);
	    
	    String tomail = memail;
	    String setfrom = "하루동물병원 <0808hr@gmail.com>";
	    String title = "하루 동물병원 예약 취소 안내";
	    
		/*
		 * 안녕하세요. 하루 동물병원 입니다. 
		 * 신청하신 예약이 취소되었습니다.
		 * 감사합니다.
		 */
	    
	    String content = "안녕하세요. 하루 동물병원 입니다.\n 신청하신 예약이 취소되었습니다.\n 감사합니다.";
	    System.out.println("content: "+content);
	    
	    try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, false, "UTF-8");
			messageHelper.setFrom(setfrom);
			messageHelper.setTo(tomail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			mailSender.send(message);
			System.out.println("cancel mail send success");
			
			int result = as.updateReservation(resno, rtime, memo, status);
            System.out.println("MailController sendMail() updateReservation result ->"+result);
            
		} catch (Exception e) {
			System.out.println("cancel mail send error ->"+e.getMessage());
			System.out.println("cancel mail send fail");
		}
	    
	    return "redirect:/admin/reservation";
	}

}
