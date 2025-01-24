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
   
   display: flex;
   flex-direction: column;
   justify-content: space-around;
   align-items: center;
}
.login-div-title {
   font-weight: 700;
    letter-spacing: 1;
    font-size: 20px;
    color: var(--haru);
}


button[type=button] {
/*    border: 1px solid var(--haru); */
   border-radius: 12px;
   height: 50px;
   padding-inline: 1rem;
}

.haru-login-btn {
   width: 80%;
   background: #F18D7E;
   color: white;
   font-size: 18px;
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
            <div>
            	<c:choose>
            		<c:when test="${find }">
			            <div class="login-div-title">이메일로 새로운 비밀번호가 <br>발급되었습니다.</div>
			            <div style="margin-top:1rem; font-size: 0.9rem;">보안을 위해 비밀번호 변경을 해주세요.</div>            
            		</c:when>
            		<c:otherwise>
            		 	<div class="login-div-title">존재하지 않는 계정입니다.</div>
            		</c:otherwise>
            	</c:choose>
            </div>
            	
            <button class="haru-login-btn" type="button" onclick="location.replace('login')">로그인 하러 가기</button>
         </div>
      
      </div>
      
   </div>

</body>
</html>