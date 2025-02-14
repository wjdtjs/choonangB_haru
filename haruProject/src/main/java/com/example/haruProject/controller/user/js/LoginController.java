package com.example.haruProject.controller.user.js;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.example.haruProject.common.utils.SessionUtil;
import com.example.haruProject.dto.Admin;
import com.example.haruProject.dto.AgreementTerms;
import com.example.haruProject.dto.Member;
import com.example.haruProject.dto.UserVO;
import com.example.haruProject.service.js.MailService;
import com.example.haruProject.service.js.MemberService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class LoginController {
	
	private final MemberService ms;
	private final MailService mailService;
	private final PasswordEncoder passwordEncoder;
	
	@Value("${kakao.client.id}")
    String clientId;	
	
	/**
	 * 카카오 로그인 redirect url
	 * @throws ParseException 
	 */
	@GetMapping("/oauth/api/kakao")
	public String kakaoRedirect(@RequestParam(value="code", required = false) String code, HttpSession session, HttpServletRequest request) throws ParseException {
		// SETP1 : 인가코드 받기
        // (카카오 인증 서버는 서비스 서버의 Redirect URI로 인가 코드를 전달합니다.)

		if(code != null) {
			String reqURL = "https://kauth.kakao.com/oauth/token";

			 try {
			     URL url = new URL(reqURL);
			     HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			     String redirectUri = "http://"+InetAddress.getLocalHost().getHostAddress()+":8399/oauth/api/kakao";
			     System.out.println(redirectUri);
			
			     //POST 요청을 위해 기본값이 false인 setDoOutput을 true로
			     conn.setRequestMethod("POST");
			     conn.setDoOutput(true);
			
			     //POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
			     BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			     StringBuilder sb = new StringBuilder();
			     sb.append("grant_type=authorization_code");
			     sb.append("&client_id="+clientId); 
			     sb.append("&redirect_uri="+redirectUri);
			     sb.append("&code=" + code);
			     bw.write(sb.toString());
			     bw.flush();
			
			     //결과 코드가 200이라면 성공
			     int responseCode = conn.getResponseCode();
			     System.out.println("responseCode : " + responseCode);
			
			     //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			     BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			     String line = "";
			     String result = "";
			
			     while ((line = br.readLine()) != null) {
			         result += line;
			     }
			     
			     JSONParser par = new JSONParser();
			     JSONObject jsonObj = (JSONObject) par.parse(result);
			     String id_token = (String) jsonObj.get("id_token");
			     String access_token = (String) jsonObj.get("access_token");
			     String refresh_token = (String) jsonObj.get("refresh_token");
			     //TODO: access token, refresh token db 저장
			     
			     String[] splitToken = id_token.split("\\.");
			     
			     byte[] decodedBytes = Base64.getDecoder().decode(splitToken[1]);
			     String decodedStr = new String(decodedBytes);
			
			     jsonObj = (JSONObject) par.parse(decodedStr);
			     String sub = (String) jsonObj.get("sub");
			     String name = (String) jsonObj.get("nickname");
			     String email = (String) jsonObj.get("email");
			     
			     //회원 여부 확인하고 없으면 insert
			     Member member = new Member(email, sub, name);
			//	             member.setMemail(email);
			//	             member.setMid(sub);
			//	             member.setMname(name);
			     int memno = ms.chkKakaoUser(member);
			
			     //session에 저장
			     Map<String, Object> mem_info = new HashMap<>();
			     mem_info.put("no", memno);
				 mem_info.put("name", member.getMname());
				 mem_info.put("email", member.getMemail());
				 mem_info.put("type", "GK");
					
				 SessionUtil.login(request, mem_info);
			     
			     //TODO: 인터셉터에서 토큰 검증
			
			     br.close();
			     bw.close();
			 } catch (IOException e) {
			     e.printStackTrace();
			     return "user/login";
			 }
		} else {
			return "user/login";
		}
         
        return "redirect:/user/index";                                        
         
	}	
	
	

	/**
	 * 회원가입 페이지
	 * @return
	 */
	@RequestMapping("/all/user/signup")
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
	@PostMapping("/all/user/signUpAction")
	public String userSignUp(Member mem, Model model) {
		log.info("userSignUp() start..");
		
		System.out.println("회원가입 : "+mem);
		System.out.println("이메일: "+mem.getMemail());
		String passwd = mem.getMpasswd();
		
		String encodedPassword = passwordEncoder.encode(passwd);
		System.out.println("암호화: "+encodedPassword);
		
		mem.setMpasswd(encodedPassword); //암호화된 패스워드 저장
		
		ms.signUpMember(mem);
		
		
		return "user/signupResult"; //회원가입 결과 페이지로 이동
	}
	
	/**
	 * 이메일 중복 체크 api
	 * @param member
	 * @return
	 */
	@ResponseBody
	@PostMapping("/all/api/id-duplicate-check")
	public boolean checkIdDuplicate(@RequestBody Member member) {
		log.info("checkIdDuplicate() start..");
		System.out.println("email > "+member.getMemail());
		
		String email = member.getMemail();
		boolean result = false;
		
		result = ms.chkIdDuplicate(member);
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
		
		String title = "[하루]동물병원 회원가입 인증코드";
		
		String certiCode = (int) (Math.random() * 999999) + 1 + "";
		String contents = "인증코드 : "+certiCode;
		System.out.println("인증코드 : "+ certiCode);
		
		//인증번호 전송
		mailService.sendMail(email, title, contents); //메일 보내는 함수
		
		long start_time = System.currentTimeMillis();
		
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
	@PostMapping("/all/api/code-check")
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
	
	/**
	 * 이메일 찾기
	 * @param member
	 * @param model
	 * @return
	 */
	@PostMapping("/all/user/findEmail")
	public String findEmail(Member member, Model model) {
		log.info("findEmail() start..");
		
		System.out.println("findEmail() name ->"+member.getMname());
		System.out.println("findEmail() tel ->"+member.getMtel());
		
		String email = ms.findEmail(member);
		
		System.out.println("OAuthController findEmail() email -> "+email);
		
		model.addAttribute("email", email);
		
		return "user/findIdResult";
	}
	
	/**
	 * 비밀번호 재설정
	 * @param member
	 * @param model
	 * @return
	 * @throws MessagingException 
	 */
	@PostMapping("/all/user/findPasswd")
	public String findPasswd(Member member, Model model) throws MessagingException {
		log.info("findPasswd() start..");
		
		String email = member.getMemail();
		System.out.println("findEmail() name ->"+member.getMname());
		System.out.println("findEmail() email ->"+member.getMemail());
		
		//이메일이 존재하는지 확인
		boolean result = ms.chkIdDuplicate(member);
		
		if(!result) { //존재함
			String new_pw = randomCharacters(15);
			System.out.println("재설정 비밀번호 : "+new_pw);
			
			String encodedPassword = passwordEncoder.encode(new_pw);
			System.out.println("암호화: "+encodedPassword);
			
			String title = "[하루]동물병원 비밀번호 재설정";
			String contents = "비밀번호 : "+new_pw;
			
			mailService.sendMail(email, title, contents);
			
			ms.updatePassword(encodedPassword, member); //암호화된 패스워드 저장
			
			model.addAttribute("find", true);
		} else {
			model.addAttribute("find", false);
		}
		
		return "user/findPasswdResult";
	}
	
	/**
	 * 랜덤 문자열 생성 (숫자, 영문)
	 * @param length
	 * @return
	 */
	public static String randomCharacters(int length) {
        String possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder result = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(possible.length());
            result.append(possible.charAt(index));
        }

        return result.toString();
    }
	
	
	
	
	/**
	 * 로그인 api
	 * @param request
	 * @param userVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/all/api/login")
	public ResponseEntity<LoginEntity> loginAction(HttpServletRequest request, @RequestBody UserVO userVO){
        LoginEntity loginEntity = new LoginEntity();
        Map<String, Object> mem_info = new HashMap<>();
        
        System.out.println("userVO: "+userVO);
        
        if(userVO.getType().startsWith("G")) { //사용자 로그인
        	System.out.println("loginAction() 로그인 한 사람 : 유저");
        	
        	Member member = new Member(userVO.getId(), userVO.getPasswd());
        	//이메일 존재하는지 확인
    		boolean result = ms.chkIdDuplicate(member);
    		
    		if(!result) { //존재함	
    			Member real_mem = ms.getRealPasswd(member); //암호화된 비밀번호 가져오기
    			System.out.println("loginAction() User real_mem : "+real_mem);

    			//비밀번호가 맞는지 확인
    			if(passwordEncoder.matches(member.getMpasswd(), real_mem.getMpasswd())) {
    				System.out.println("loginAction() User 로그인성공 "+ real_mem.getMemail());
    				
    				mem_info.put("no", real_mem.getMemno());
    				mem_info.put("name", real_mem.getMname());
    				mem_info.put("email", real_mem.getMemail());
    				mem_info.put("type", userVO.getType());
    				
    				SessionUtil.login(request, mem_info);
    				
    	            loginEntity.setCode(200);
    			} else {
    				loginEntity.setCode(401);
    			}
    		} else {
    			System.out.println("loginAction() User 없음");
    			loginEntity.setCode(401);
    		}
        	
        	
        } else { // 관리자 로그인 (슈퍼관리자, 일반관리자, 의사 포함)
        	System.out.println("loginAction() 로그인 한 사람 : 관리자");
        	Admin admin = new Admin(Integer.parseInt(userVO.getId()), userVO.getPasswd());
        	
        	//존재여부 확인
        	Admin ad_info = ms.chkAdminExist(admin);
        	if(ad_info != null) { //존재함
        		System.out.println("loginAction() admin info -> "+ad_info);
        		
        		//비밀번호 확인
        		if(passwordEncoder.matches(admin.getApasswd(), ad_info.getApasswd())) {
        			System.out.println("loginAction() Admin 로그인성공 "+ ad_info.getAno());
        			
        			mem_info.put("no", ad_info.getAno());
    				mem_info.put("name", ad_info.getAname());
    				mem_info.put("email", ad_info.getAemail());
    				mem_info.put("type", userVO.getType());
    				mem_info.put("role", ad_info.getAlevel_mcd());
    				
    				SessionUtil.login(request, mem_info);
        			
        			loginEntity.setCode(200);
        		} else {
        			loginEntity.setCode(401);
        		}
        		
        		
        	} else { //존재 안함
        		System.out.println("loginAction() Admin 없음");
        		
        		loginEntity.setCode(401);
        	}
        }
        
        return new ResponseEntity<>(loginEntity, HttpStatus.OK);
    }
		
	
	/**
	 * 로그인 api response
	 */
	@Getter
	@Setter
	static public class LoginEntity {
		private int code;
	}
	
	
	/**
	 * 로그아웃
	 * @return
	 */
	@RequestMapping("/admin/logout")
	public String logoutAction(HttpServletRequest request) {
		System.out.println("logoutAction() 관리자 로그아웃");
		SessionUtil.logout(request);
		return "redirect:/all/admin/login";
	}
	
	
	
	/**
	 * 
	 * @Scheduled
	 * 이메일 인증요청 후 
	 * 10분이 지나도 회원가입이 되지 않았을 경우 
	 * -> 데이터 삭제
	 * 
	 */
	// @Scheduled(fixedRate = 3600000)
	@Async
	@Scheduled(cron = "0 0 0 * * *")
	public void autoMemberCancel() {
		log.info("auto member cancel start ,,,");
		
		List<Member> mList = ms.chkMemberTime();
		
		for (Member member : mList) {			
			long current_time = System.currentTimeMillis();
			long timeDifference = current_time - member.getValid_time();
			
			long minutes = timeDifference / (1000 * 60) % 60;
			
			if(minutes < 10) {
				System.out.println("유효시간 남음 / 남은 시간 : "+minutes);
			} else {
				System.out.println("유효시간 지남, 데이터 삭제");
				ms.cancelMember(member);
			}
		}
	}
	
}
