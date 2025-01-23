package com.example.haruProject.controller.user.js;

import java.util.HashMap;
import java.util.Map;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.haruProject.dto.AgreementTerms;
import com.example.haruProject.dto.Member;
import com.example.haruProject.service.js.MemberService;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class OAuthController {
	
	private final MemberService ms;
	private final JavaMailSender mailSender;  //MIME 객체
	private final PasswordEncoder passwordEncoder;
	
	/**
	 * 카카오 로그인 redirect url
	 */
	@ResponseBody
	@GetMapping("api/oauth/kakao")
	public void kakao_login() {
		
	}
	

	/**
	 * 회원가입 페이지
	 * @return
	 */
	@RequestMapping("/user/signup")
	public String signUpView(AgreementTerms am, Model model) {
		log.info("signUpView() start..");
		System.out.println("동의여부> "+am);
		
		if(am.isUsage() && am.isPersonal()) { //필수동의 했으면 회원가입 페이지로 이동
			//정보수신동의 여부 전달
			int isagree = 0;
			if(am.isMarketing()) isagree = 1;
			model.addAttribute("m", isagree); 
			return "user/signup";			
		} else {							  //아니면 로그인 페이지로 이동
			return "redirect:login";
		}
	}
	
	/**
	 * 회원가입
	 * @return
	 */
	@PostMapping("/user/signUpAction")
	public String userSignUp(Member mem, Model model) {
		log.info("userSignUp() start..");
		
		System.out.println("회원가입 : "+mem);
		System.out.println("이메일: "+mem.getMemail());
		String passwd = mem.getMpasswd();
		
		String encodedPassword = passwordEncoder.encode(passwd);
		System.out.println("암호화: "+encodedPassword);
		
		mem.setMpasswd(encodedPassword); //암호화된 패스워드 저장
		
		ms.signUpMember(mem);
		
//		model.addAttribute("signup", "true"); //redirect는 model안먹네..
		
		return "redirect:login"; //TODO: 회원가입 완료 페이지 만들어서 이동하기
	}
	
	/**
	 * 이메일 중복 체크 api
	 * @param member
	 * @return
	 */
	@ResponseBody
	@PostMapping("/api/id-duplicate-check")
	public boolean checkIdDuplicate(@RequestBody Member member) {
		log.info("checkIdDuplicate() start..");
		System.out.println("email > "+member.getMemail());
		
		String email = member.getMemail();
		boolean result = false;
		
		result = ms.chkIdDuplicate(email);
		Map<String, Object> authMap = new HashMap<>(); 
		
		System.out.println("result "+ result);
		if(result) {
			try {
				authMap = authentiCode(email);			
			} catch (Exception e) {
				result = false;
			}
			
			member.setAuthcode((String) authMap.get("code"));
			member.setValid_time((Long) authMap.get("time"));
			// 인증번호, 유효시간 저장
			ms.updateAuthCode(member);
			
		}
		
		return result;
	}
	
	/**
	 * 이메일 인증코드 전송 메소드
	 * @param email
	 * @throws MessagingException 
	 */
	public Map<String, Object> authentiCode(String email) throws MessagingException {
		log.info("authentiCode() start..");
		System.out.println("email > "+email);
		
		String tomail = email; //받는사람
		String setfrom = "하루동물병원 <0808hr@gmail.com>"; //보내는사람
		String title = "[하루]동물병원 회원가입 인증코드";
		
		
		// Mime 전자우편 Internet 표준 Format
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		messageHelper.setFrom(setfrom); //보내는 사람 생략하면 정상작동 안함
		messageHelper.setTo(tomail); //받는사람 이메일
		messageHelper.setSubject(title); //메일제목은 생략 가능
		
		String certiCode = (int) (Math.random() * 999999) + 1 + "";
		messageHelper.setText("인증코드 : " + certiCode); // 메일 내용
		System.out.println("인증코드 : "+ certiCode);
		
		long start_time = System.currentTimeMillis();
		
		mailSender.send(message);
		
		Map<String, Object> authMap = new HashMap<>();
		authMap.put("code", certiCode);
		authMap.put("time", start_time);
		
		return authMap;

	}
	
	/**
	 * 인증번호 확인
	 * @param member
	 * @return
	 */
	@ResponseBody
	@PostMapping("/api/code-check")
	public boolean checkCode(@RequestBody Member member) {
		log.info("checkCode() start..");
		boolean result = false;
		
		System.out.println("인증번호== "+ member.getAuthcode());

		
		String code = member.getAuthcode();
		String email = member.getMemail();
		
		Member m = new Member();
		m = ms.getAuthCode(email);
		System.out.println("저장된 인증번호 "+m);
		
		if(code.equals(m.getAuthcode())) {
			//인증번호 같음
			System.out.println("OAuthController checkCode() 인증번호 동일");
			
			long current_time = System.currentTimeMillis();
			long timeDifference = current_time - m.getValid_time();
			
	        long minutes = timeDifference / (1000 * 60) % 60;
	        
	        if(minutes < 3) {
	        	System.out.println("유효시간 남음");
	        	result = true;
	        }

		} else {
			//인증번호 다름
			System.out.println("OAuthController checkCode() 인증번호 다름");
			result = false;
		}

		return result;
	}
	
}
