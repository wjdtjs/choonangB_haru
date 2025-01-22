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
	height: 330px;
	background: var(--haru);
	text-align: center;
	padding-top: 32px;
	position: relative;
}

.haru-background .logo {
	width: 75px;
}
.login-div {
	position: absolute;
	top: 48%;
	left: 50%;
	width: 358px;
	height: 600px;
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
	margin-bottom: 30px;
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

</style>

</head>
<body>
	<div class="haru-user-container" style="height: 100vh; text-align: center;">
		<div class="haru-background">
			<img src="/img/logo.png" class="logo">
		</div>
		
		<div class="login-div">
			<div class="login-div-title">SIGNUP</div>
			<form action="signUp" id="signUpForm" method="post" onsubmit="return validateForm()">
				<div style="position: relative;">
					<label>아이디</label>
					<input type="text" class="signup-id" name="mid">				
					<button type="button" class="verifi_btn id_dupl">중복확인</button>
				</div>
				<div>
					<label>비밀번호</label>
					<input type="password" class="signup-pw" name="mpasswd">
				</div>
				<div>
					<label>비밀번호 확인</label>
					<input type="password" class="mpasswd2">
				</div>
				<div>
					<label>이름</label>
					<input type="text" class="signup-name" name="mname">
				</div>
				<div style="position: relative;">
					<label>전화번호</label>
					<input type="password" class="signup-tel" name="mtel">
					<button type="button" class="verifi_btn id_verifi">본인인증</button>
				</div>
				<div>
					<label>이메일</label>
					<input type="email" class="signup-email" name="memail">
				</div>
			</form>
		</div>
		
		<div>
			<button class="haru-login-btn" type="submit" form="signUpForm">가입하기</button>
			<div class="go-signup-div">
				이미 계정이 있다면? <span onclick="location.href='/user/login'">로그인</span>
			</div>	
		</div>
		
	</div>

<script type="text/javascript">

	const id_dupl_check= false; //아이디 중복 확인 여부
	const verification = false; //본인인증 확인 여부
	
	$(()=>{

	})
	
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
		
		if(!checkRegex(id, '^[a-z0-9]{5,20}$')) {
			alert('아이디는 영문, 숫자 5자 이상 20자 이하만 가능합니다.'); //아이디 체크
			result = false;
		}
		if(passwd != passwd2) {
			alert('비밀번호가 올바르지 않습니다.'); //비밀번호 같은지
			result = false;
		}
		if(!isEmpty(passwd)) {
			alert('비밀번호는 필수입니다.');
			result = false;
		}
		if(!checkRegex(passwd, '^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,}$')) {
			alert('비밀번호는 영문, 숫자, 특수문자를 최소 1개씩 조합하여 8자 이상'); //비밀번호 체크
			result = false;
		}
		if(!isEmpty(name)) {
			alert('이름은 필수입니다.');
			result = false;
		}
		if(!checkRegex(tel, '^01(?:0|1|[6-9])(?:\d{3}|\d{4})\d{4}$')) {
			alert('잘못된 핸드폰번호 입니다.');
			result = false;
		}
		if(!isEmpty(email)) {
			alert('이메일은 필수입니다.');
			result = false;
		}
		
		return result;
	}


	/**
	 * 정규식 체크
	 * @param str   체크할 문자열
	 * @param regex 정규식
	 */
	function checkRegex(str, regex) {
		let re = new RegExp(regex);
		
		let result = re.test(str);
		console.log(result);
		return result;
	}
	
</script>

</body>
</html>