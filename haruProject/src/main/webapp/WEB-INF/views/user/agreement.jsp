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
   top: 53%;
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

#agreementForm {
   margin-top: 32px;
   overflow-y: scroll;
   height: 500px;
}
#agreementForm .check-box {
    display: flex;
	flex-direction: row;
	align-items: center;
    padding: 12px;
}
#agreementForm label {
	font-size: 0.875rem;
	color: var(--haru);
}

input:focus {
   outline-color: var(--haru);
}

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
   
   margin-top: 40px;
}


[type="checkbox"] {
    appearance: none;
    width: 1.25em;
    height: 1.25em;
    border: 1px solid var(--haru);
    cursor: pointer;
    position: relative;
    margin-right: 0.5rem;
}
[type="checkbox"]:checked {
	background-color: var(--haru);
}
[type="checkbox"]:checked:before {
	content: "\f00c";	
	font-family: FontAwesome;
	color: white;
    left:1px;
    position:absolute;
    top:0;
}

.all-agree-div {
	background: rgba(208, 227, 231, 0.3);
	border-radius: 12px;
}
.agreement-content {
	overflow-y: scroll;
	width: 100%;
	height: 11.5rem;
	background: rgba(208, 227, 231, 0.3);
	padding: 0.8rem;
	font-size: 11px;
	color: black;
	text-align: start;
}
.check-box > i {
	position: absolute;
	right: 15px; 
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
			   <div class="login-div-title">약관동의</div>
				   <form action="signup" id="agreementForm" method="post" onsubmit="return validateForm()">
				       <!-- 전체동의 -->
				       <div class="check-box all-agree-div" style="margin-bottom: 25px;">
				       		<input type="checkbox" id="all-agree">
							<label for="all-agree">약관 전체 동의</label>
					   </div>
			       		<!-- 이용약관동의 -->
				       <div>
				       		<div class="check-box usage" style="position: relative;">
					       		<input type="checkbox" id="usage-agree" name="usage">
								<label for="usage-agree">이용약관 동의 (필수)</label>
								<i class="fa-solid fa-chevron-down fa-lg"></i>
								<i class="fa-solid fa-chevron-up fa-lg" style="display: none"></i>
				       		</div>
				       		<div class="agreement-content usage" style="display: none">
				       			이용약관 동의 내용<br>
				       			이용약관 동의 내용<br>
				       			이용약관 동의 내용<br>
				       			이용약관 동의 내용<br>
				       			이용약관 동의 내용<br>
				       			이용약관 동의 내용<br>
				       			이용약관 동의 내용<br>
				       			이용약관 동의 내용<br>
				       			이용약관 동의 내용<br>
				       			이용약관 동의 내용<br>
				       			이용약관 동의 내용<br>
				       			이용약관 동의 내용<br>
				       			이용약관 동의 내용<br>
				       			이용약관 동의 내용<br>
				       			이용약관 동의 내용<br>
				       		</div>
				       </div>
				       <!-- 개인정보 약관동의 -->
				       <div style="margin-top: 10px;">
				       		<div class="check-box personal" style="position: relative;">
					       		<input type="checkbox" id="personal-agree" name="personal">
								<label for="personal-agree">개인정보 수집 및 이용 동의 (필수)</label>
								<i class="fa-solid fa-chevron-down fa-lg"></i>
								<i class="fa-solid fa-chevron-up fa-lg" style="display: none"></i>
				       		</div>
				       		<div class="agreement-content personal" style="display: none">
				       			개인정보 수집 및 이용 동의 내용<br>
				       			개인정보 수집 및 이용 동의 내용<br>
				       			개인정보 수집 및 이용 동의 내용<br>
				       			개인정보 수집 및 이용 동의 내용<br>
				       			개인정보 수집 및 이용 동의 내용<br>
				       			개인정보 수집 및 이용 동의 내용<br>
				       			개인정보 수집 및 이용 동의 내용<br>
				       			개인정보 수집 및 이용 동의 내용<br>
				       			개인정보 수집 및 이용 동의 내용<br>
				       			개인정보 수집 및 이용 동의 내용<br>
				       			개인정보 수집 및 이용 동의 내용<br>
				       			개인정보 수집 및 이용 동의 내용<br>
				       			개인정보 수집 및 이용 동의 내용<br>
				       			개인정보 수집 및 이용 동의 내용<br>
				       			개인정보 수집 및 이용 동의 내용<br>
				       		</div>
				       </div>
			       
			       		<!-- 정보수신동의 -->
			       		<div style="margin-top: 10px;">
			       			<div class="check-box marketing">
					       		<input type="checkbox" id="marketing-agree" name="marketing">
								<label for="marketing-agree">정보 수신 동의 (선택)</label>
				       		</div>
			       		</div>
			       
			    </form>
			 </div>
			 
			 <button class="haru-login-btn" type="submit" form="agreementForm">동의하기</button>
		 </div>
	
	</div>

<script type="text/javascript">

   /**
    * 필수값 체크
    */
   function validateForm() {
	   let result = false;
	   
	   var checked1 = $('#usage-agree').is(':checked');
	   var checked2 = $('#personal-agree').is(':checked');
	   var mk_checked = $('#marketing-agree').is(':checked');
	   
	   if(checked1 && checked2) {
		   result = true;
	   } else {
		   alert('필수항목에 동의 해 주세요.');		   
	   }
	   
	   return result;
   }
   
   /* 전체 동의 */
   $('#all-agree').click(function(){
		var checked = $('#all-agree').is(':checked');
		if(checked)
			$('input:checkbox').prop('checked',true);
	});
   
   $('#usage-agree').click(function(){
		var checked = $('#usage-agree').is(':checked');
		if(!checked)
			$('#all-agree').prop('checked',false);
	});
	
   $('#personal-agree').click(function(){
		var checked = $('#personal-agree').is(':checked');
		if(!checked)
			$('#all-agree').prop('checked',false);
	});
   
   $('#marketing-agree').click(function(){
		var checked = $('#marketing-agree').is(':checked');
		if(!checked)
			$('#all-agree').prop('checked',false);
	});


   
   /* 약관 내용 드롭박스 열었다 닫기 */
	$('.check-box.usage .fa-chevron-down').click(() => {
		$('.check-box.usage .fa-chevron-down').css('display', 'none');
		$('.check-box.usage .fa-chevron-up').css('display', 'block');
		$('.agreement-content.usage').css('display', 'block');
	})
	$('.check-box.personal .fa-chevron-down').click(() => {
		$('.check-box.personal .fa-chevron-down').css('display', 'none');
		$('.check-box.personal .fa-chevron-up').css('display', 'block');
		$('.agreement-content.personal').css('display', 'block');
	})
		$('.check-box.usage .fa-chevron-up').click(() => {
		$('.check-box.usage .fa-chevron-down').css('display', 'block');
		$('.check-box.usage .fa-chevron-up').css('display', 'none');
		$('.agreement-content.usage').css('display', 'none');
	})
	$('.check-box.personal .fa-chevron-up').click(() => {
		$('.check-box.personal .fa-chevron-down').css('display', 'block');
		$('.check-box.personal .fa-chevron-up').css('display', 'none');
		$('.agreement-content.personal').css('display', 'none');
	})

   
</script>

</body>
</html>