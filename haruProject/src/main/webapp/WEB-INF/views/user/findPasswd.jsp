<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

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
   top: 46%;
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
   font-weight: 700;
    letter-spacing: 1;
    font-size: 22px;
    color: var(--haru);
}

#findPwForm {
   margin-top: 32px;
}
#findPwForm > div {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    margin-bottom: 14px;
}
#findPwForm input {
   width: 100%;
}
#findPwForm label {
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
   height: 46px;
   padding-inline: 1rem;
}

.haru-login-btn {
   width: 100%;
   background: var(--haru);
   color: white;
   font-size: 16px;
   font-weight: 200;
   margin-top: 30px;
}

.find-account-div {
   display: flex;
   flex-direction: row;
   font-size: 10px;
   justify-content: center;
   align-items: center;
   color: var(--haru);
   margin-top: 10px;
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
            <div class="login-div-title">비밀번호 찾기</div>
            <form action="findPasswd" id="findPwForm" method="post">
               <div>
                  <label>이름</label>
                  <input type="text" name="mname" required="required">            
               </div>
               <div>
                  <label>이메일</label>
                  <input type="email" name="memail" required="required">            
               </div>
            </form>
            <button class="haru-login-btn" type="submit" form="findPwForm">비밀번호 찾기</button>
            
            <div class="find-account-div">
               <div class="find-id" onclick="location.href='login'">로그인</div>
               <div style="width: 2px; height: 10px; background: #d9d9d9; margin-inline:10px"></div>
               <div class="find-pw" onclick="location.replace('find-id')">아이디 찾기</div>
            </div>
            
         </div>
      </div>
      
   </div>

</body>
</html>