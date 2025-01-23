<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<style type="text/css">

.haru-user-container {
   display: flex;
   flex-direction: column;
   justify-content: space-between;
   align-items: center;
}
.haru-background {
   width: 100%;
   height: 39%;
   background: var(--haru);
   text-align: center;
   padding-top: 32px;
   position: relative;
}

.haru-background .logo {
   width: 75px;
}
.haru-login-absolute-div {
   position: absolute;
   top: 55%;
   left: 50%;
   transform: translate(-50%, -50%);
}
.login-div {
   width: 358px;
   height: 600px;
   background: white;
   border-radius: 12px;
   filter: drop-shadow(0px 4px 20px rgba(0, 0, 0, 0.25));
   padding: 10px;
   text-align: center;
}
.login-div-title {
   font-weight: 900;
    letter-spacing: 1;
    font-size: 24px;
    color: var(--haru);
}

#signUpForm {
   margin-top: 32px;
}
#signUpForm > div {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    margin-bottom: 14px;
}
#signUpForm input {
   width: 100%;
}
#signUpForm label {
   font-size: 12px;
   color: var(--haru);
   margin-bottom: 7px;
}

input:focus {
   outline-color: var(--haru);
}

input[type=text],
input[type=password],
input[type=email],
button[type=submit] {
   border: 1px solid var(--haru);
   border-radius: 12px;
   height: 45px;
   padding-inline: 1rem;
}

.haru-login-btn {
   width: 100%;
   background: var(--haru);
   color: white;
   font-size: 20px;
   width: 334px;
}

.go-signup-div {
   font-size: 12px;
   color: #6F7173;
   margin-top: 1rem;
}
.go-signup-div > span {
   color: var(--haru);
   margin-left: 5px;
}

.verifi_btn {
   font-size: 11px;
   color: white;
   position: absolute;
   right: 6px;
   top: 32px;
   background: var(--haru);
   padding: 8px;
   font-weight: 200;
}

button[type=button]:disabled {
	background: #d9d9d9;
}
input[type=text]:readonly,
input[type=email]:readonly {
	background: #f2f2f2;
}



</style>

</head>
<body>
   <div class="haru-user-container" style="height: 100vh; text-align: center;">
      <div class="haru-background">
         <img src="/img/logo_white.png" class="logo">
      </div>
      
      <div class="haru-login-absolute-div">
         <div class="login-div">
            <div class="login-div-title">SIGNUP</div>
            <form action="signUpAction" id="signUpForm" method="post" onsubmit="return validateForm()">
               <div style="position: relative;">
                  <label>이메일</label>
                  <input type="text" class="signup-email" name="memail" required="required">            
                  <button type="button" class="verifi_btn id_dupl" onclick="chkIdDupl()">중복확인</button>
               </div>
               <div class="authcode-input-div" style="position: relative; ">
                  <label>인증번호</label>
                  <input type="text" class="signup-authcode" name="authcode" maxlength="6" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(.*)\./g, '$1');">
                  <button type="button" class="verifi_btn id_verifi_chk" onclick="verifiEmail()">인증하기</button>
               </div>
               <div>
                  <label>비밀번호</label>
                  <input type="password" class="signup-pw" name="mpasswd" required="required">
               </div>
               <div>
                  <label>비밀번호 확인</label>
                  <input type="password" class="mpasswd2" required="required">
               </div>
               <div>
                  <label>이름</label>
                  <input type="text" class="signup-name" name="mname" required="required">
               </div>
               <div>
                  <label>전화번호</label>
                  <input type="text" class="signup-tel" name="mtel" required="required">
               </div>
               <input type="hidden" value="${m }" name="is_agree">
            </form>
         </div>
         
         <div style="margin-top:40px">
            <button class="haru-login-btn" type="submit" form="signUpForm">가입하기</button>
            <div class="go-signup-div">
               이미 계정이 있다면? <span onclick="location.href='/user/login'">로그인</span>
            </div>   
         </div>
         
      </div>
      
      
      
   </div>

<script type="text/javascript">

   let id_dupl_check= false; //아이디 중복 확인 여부
   let verification = false; //본인인증 확인 여부
   
   $(()=>{
// 	   $('.signup-id').keyup(function() {
// 		   	$('.verifi_btn.id_dupl').attr("disabled", false);
// 			id_dupl_check = false;
// 	   })         
   })
   
   /** 
    * 이메일 중복 체크 
    */
   function chkIdDupl() {
	   const email = $('.signup-email').val();
	   
	   if(!isEmpty(email) || !checkRegex(email, '^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')) {
		  	alert('올바르지 않은 이메일입니다.');
	   } else {
		   
		   $.ajax({
				url: "<%=request.getContextPath()%>/api/id-duplicate-check",
				method: 'POST',
				contentType:"application/json",
				data: JSON.stringify({
					memail: email
				}),
				beforeSend: function () {                
					FunLoadingBarStart(); //로딩 띄우기      
				},
				success: function(data){
					console.log(data)
					FunLoadingBarEnd(); //로딩 종료
					
					if(!data) {
						alert('이미 존재하는 이메일입니다.');
						$('.signup-email').val("");
					} else {
						alert('사용 가능한 이메일입니다. \n 인증코드를 입력해주세요. (제한시간 3분)');
						$('.signup-email').attr("readonly", true);
						$('.verifi_btn.id_dupl').attr("disabled", true);
						id_dupl_check = true;
						
						$('.authcode-input-div').css('display', 'flex');
					}
				}
			})
	   }
	   
   }
     
   
   /** 
    * 인증번호 확인
    */
   function verifiEmail() {
	   const code = $('.signup-authcode').val();
	   const email = $('.signup-email').val();
	   
	   $.ajax({
			url: "<%=request.getContextPath()%>/api/code-check ",
			method: 'POST',
			contentType:"application/json",
			data: JSON.stringify({
				authcode: code,
				memail: email
			}),
			success: function(data){
				console.log(data)
				
				if(!data) {
					alert('인증번호가 올바르지 않습니다.');						
				} else {
					alert('이메일 인증이 완료되었습니다.');
					$('.signup-authcode').attr('readonly', true);
					$('.verifi_btn.id_verifi_chk').attr("disabled", true);
					
					verification = true;
				}
			}
		})
   }
   
   
   
   /**
    * 필수값 체크
    */
   function validateForm() {
      let result = true;
      
      let id = $('#signUpForm .signup-id').val();
      let passwd = $('#signUpForm .signup-pw').val();
      let passwd2 = $('#signUpForm .mpasswd2').val();
      let name = $('#signUpForm .signup-name').val();
      let tel = $('#signUpForm .signup-tel').val();
      let email = $('#signUpForm .signup-email').val();
      
      let str = "";
      if(!id_dupl_check) {
         str+= '이메일 중복체크를 해주세요.\n'; //이메일 중복 체크
         result = false;
      }
      if(!verification) {
    	  str+='이메일 인증을 해주세요.\n'; //이메일 인증
          result = false;
      }
      if(passwd != passwd2) {
    	  str+='비밀번호가 일치하지 않습니다.\n'; //비밀번호 같은지
         result = false;
      }
//       if(!isEmpty(passwd)) {
//     	  str+='비밀번호는 필수입니다.';
//          result = false;
//       }
      if(!checkRegex(passwd, '^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,}$')) {
    	 str+='비밀번호는 영문, 숫자, 특수문자를 최소 1개씩 조합하여 8자 이상\n'; //비밀번호 체크
         result = false;
      }
//       if(!isEmpty(name)) {
//     	  str+='이름은 필수입니다.\n';
//          result = false;
//       }
      if(!checkRegex(tel, '^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$')) {
    	  str+='잘못된 핸드폰번호 입니다.\n';
         result = false;
      }
      
      if(!result)
    	  alert(str);
      
      return result;
   }
   
   
</script>

</body>
</html>