<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<style type="text/css">
.haru-background {
   width: 100%;
   height: 39%;
   background: var(--haru);
   text-align: center;
   padding-top: 120px;
   position: relative;
}

.haru-background .logo {
   width: 75px;
}
.haru-login-absolute-div {
   position: absolute;
   top: 53%;
   left: 50%;
   transform: translate(-50%, -50%);
}
.login-div {
   width: 358px;
   height: 369px;
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

#loginForm {
   margin-top: 32px;
}
#loginForm > div {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    margin-bottom: 14px;
}
#loginForm input {
   width: 100%;
}
#loginForm label {
   font-size: 12px;
   color: var(--haru);
   margin-bottom: 7px;
}

input:focus {
   outline-color: var(--haru);
}

input[type=text],
input[type=password],
button[type=button] {
   border: 1px solid var(--haru);
   border-radius: 12px;
   height: 52px;
   padding-inline: 1rem;
}

.haru-login-btn {
   width: 100%;
   background: var(--haru);
   color: white;
   font-size: 20px;
}

.find-account-div {
   display: flex;
   flex-direction: row;
   font-size: 10px;
   justify-content: center;
   align-items: center;
   color: var(--haru);
   margin-bottom: 30px;
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

</style>

</head>
<body>
   <div class="haru-user-container" style="height: 100vh; text-align: center;">
      <div class="haru-background">
         <img src="/img/logo_white.png" class="logo">
      </div>
      
      <div class="haru-login-absolute-div">
         <div class="login-div">
            <div class="login-div-title">LOGIN</div>
            <div id="loginForm">
               <div>
                  <label>아이디</label>
                  <input type="text" class="memail" name="memail" required="required">            
               </div>
               <div>
                  <label>비밀번호</label>
                  <input type="password" class="mpasswd" name="mpasswd" required="required">
               </div>
            </div>
            <div class="find-account-div">
               <div class="find-id" onclick="location.href='/all/user/find-id'">아이디 찾기</div>
               <div style="width: 2px; height: 10px; background: #d9d9d9; margin-inline:10px"></div>
               <div class="find-pw" onclick="location.href='/all/user/find-passwd'">비밀번호 찾기</div>
            </div>
            
            <button class="haru-login-btn" type="button" onclick="login()">로그인</button>
         </div>
      
         <img src="/img/kakao_login_btn.png" onclick="kakaoLogin()" style="margin-top: 40px">
         <div class="go-signup-div">
            계정이 없다면? <span onclick="location.href='/all/user/agreement'">회원가입</span>
         </div>
      </div>
      
   </div>
   
	<script type="text/javascript">
	
	/* 일반 로그인 */
	function login() {
		let email = $('.memail').val();
		let passwd = $('.mpasswd').val();
// 		console.log(email, passwd);
		
		$.ajax({
				url: "<%=request.getContextPath()%>/all/api/login",
				method: 'POST',
				contentType:"application/json",
				data: JSON.stringify({
					id: email,
					passwd: passwd,
					type: 'G'
				}),
				success: function(data){
					console.log(data)
					
					if(data.code != 200) alert('로그인 실패');
					else location.href="/user/index";
				}
			})
		
	}
	
	/* 카카오 로그인 */
	function kakaoLogin() {
		location.href="https://kauth.kakao.com/oauth/authorize?client_id=efe8479005b06cbc1480277bd66620d9&redirect_uri=http://localhost:8399/oauth/api/kakao&response_type=code";
	}
	
	</script>

</body>
</html>