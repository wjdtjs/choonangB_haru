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
	height: 330px;
	background: var(--haru);
	text-align: center;
	padding-top: 120px;
	position: relative;
}

.haru-background .logo {
	width: 75px;
}
.login-div {
	position: absolute;
	top: 45%;
	left: 50%;
	width: 358px;
	height: 369px;
	background: white;
	border-radius: 12px;
	filter: drop-shadow(0px 4px 20px rgba(0, 0, 0, 0.25));
	transform: translate(-50%, -50%);
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
button[type=submit] {
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
			<img src="/img/logo.png" class="logo">
		</div>
		
		<div class="login-div">
			<div class="login-div-title">LOGIN</div>
			<form action="" id="loginForm">
				<div>
					<label>아이디</label>
					<input type="text" name="mid">				
				</div>
				<div>
					<label>비밀번호</label>
					<input type="password" name="mpasswd">
				</div>
			</form>
			<div class="find-account-div">
				<div class="find-id">아이디 찾기</div>
				<div style="width: 2px; height: 10px; background: #d9d9d9; margin-inline:10px"></div>
				<div class="find-pw">비밀번호 찾기</div>
			</div>
			
			<button class="haru-login-btn" type="submit" form="loginForm">로그인</button>
		</div>
		
		<img src="/img/kakao_login_btn.png" onclick="alert('카카오로그인');" style="margin-top:275;">
		
		<div class="go-signup-div">
			계정이 없다면? <span onclick="location.href='/user/signup'">회원가입</span>
		</div>
		
	</div>

</body>
</html>