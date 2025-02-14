<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
</head>

<style>
.user-body-container input {
	width: 100%;
	height: 44px;
	padding: 0 8px;
	margin: 4px 0 12px 0;
	font-size: 16px;
	border: 1px solid var(--haru);
	border-radius: 12px;
}

.user-body-container p {
	font-size: 12px;
	color: var(--haru);
	margin: 0;
	padding: 0;
}

.info-del-btn {
	position: fixed;
	bottom: 88px;
	width: 90%;
	height: 44px;
	background-color: white;
	border: 1px solid var(--haru);
	border-radius: 12px;
	color: black;
	font-size: 16px;
}

.pw-container {
	width: 100%;
	height: 44px;
	position: relative;
	display: flex;
	border: 1px solid var(--haru);
	border-radius: 12px;
	margin: 4px 0 12px 0;
}

.pw-container button {
	position: absolute;
	width: 100px;
	top: 4px;
	bottom: 4px;
	right: 5px;
	border-radius: 12px;
	background-color: var(--haru);
	color: white;
}

#b-pw:focus {outline: none;}

</style>



<body>

<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i> 
				내 정보 수정
				<div style="width:30px"></div>
			</div>
		</div>	
		
		
		<!-- body contents -->
		<div class="user-body-container" id="mypage-background">
		<form action="/user/updateMember" id="updateMyinfoForm" method="POST">
			<input type="hidden" name="memno" value="${member.memno }">
		
			<!-- 이름 -->
			<p>이름</p>
			<input type="text" class="update-mname" name="mname" value="${member.mname }" required>
			
			<!-- 이메일 -->
			<p>이메일</p>
			<input type="email" value="${member.memail }" name="memail" readonly>
			
			<!-- 카카오 로그인은 이름, 이메일만 보이게 -->
			<c:if test="${member.mid eq null}">
				<!-- 비밀번호 -->
				<div class="hr-pw">
					<p>비밀번호&nbsp;<span style="color: red;">*</span></p>
					<div class="pw-container">
						<input id="b-pw" type="password" name="re_mpasswd" style="width: 230px; border: none; height: auto; margin: auto 0;" required>
						<button id="pw-change-btn" type="button">비밀번호 변경</button>				
					</div>
					
					<div class="pw-change" style="display: none;">
						<p>새로운 비밀번호</p>
						<input type="password" class="update-mpasswd" name="mpasswd">
						<p>비밀번호 확인</p>
						<input type="password" class="mpasswd2">
					</div>				
				</div>
				
				<!-- 전화번호 -->
				<p>전화번호</p>
				<input type="tel" value="${member.mtel}" class="update-mtel" name="mtel">	
			
			</c:if>
				
		
			<div>
				<!-- 카카오 로그인은 수정하기 버튼 말고 탈퇴하기 버튼만 보이게 -->
				<c:if test="${member.mid eq null}">
					<button class="user-btn-primary" style="bottom: 140px !important;" type="button" onclick="updateMember()">수정하기</button>				
				</c:if>
				<button class="info-del-btn" onclick="deleteMember()">탈퇴하기</button>
			</div>
		
		</form>
		</div>
		<!-- body contents end -->
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
</div>

<script type="text/javascript">
	$(() => {
		var editTrue = ${edit_true};
		console.log("editTrue ->",editTrue);
		
		if(!editTrue) {
			alert("비밀번호가 일치하지 않습니다. 정보 수정에 실패했습니다.");
		}
		
		
		$("#pw-change-btn").click(function(event) {
			console.log("비밀번호 변경 버튼 눌림");
			let npasswd = $("#b-pw").val();
			console.log("입력된 비밀번호 ->", npasswd);
	
	        let pwChangeDiv = $(this).closest(".pw-container").next(".pw-change");	       
			
	        pwChangeDiv.slideToggle(function() {
		        // 비밀번호 변경창이 보이면 required 추가, 안 보이면 required 제거
		        if ($(this).is(":visible")) {
		            pwChangeDiv.find("input").attr("required", true);
		        } else {
		            pwChangeDiv.find("input").removeAttr("required");
		        }
		    });
		});

	});
	

	// 필수값 체크
	function validateForm() {
		let result = true;
		
		let name = $('#updateMyinfoForm .update-mname').val();
		let re_passwd = $('#updateMyinfoForm #b-pw').val();
		let passwd = $('#updateMyinfoForm .update-mpasswd').val();
		let passwd2 = $('#updateMyinfoForm .mpasswd2').val();
		let tel = $('#updateMyinfoForm .update-mtel').val();
		
		let str = "";
		
		// 비밀번호 변경창이 보일 때만 검사
	    if ($(".pw-change").is(":visible")) {
	    	console.log(passwd, passwd2);
	        if(!checkRegex(passwd, '^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,}$')) {
	            str += '비밀번호는 영문, 숫자, 특수문자를 최소 1개씩 조합하여 8자 이상\n\n';
	            result = false;
	        }
	        if(passwd !== passwd2) {
	            str += '비밀번호가 일치하지 않습니다.\n';
	            result = false;
	        }
	    }
	
		if(!checkRegex(tel, '^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$')) {
	    	str+='잘못된 핸드폰번호 입니다.\n';
	        result = false;
	    }
	      
	    if(!result)
	    	alert(str);
	      
	    return result;
	}
	
	// 탈퇴하기
	function deleteMember() {
		if(confirm("정말 탈퇴하시겠습니까?")) {
			location.href = "/user/deleteMember?memno="+${member.memno};
		}		
	}
	// 수정하기
	function updateMember() {
		if(confirm("정보를 수정하시겠습니까?")) {			
			if (validateForm()) {
				document.getElementById("updateMyinfoForm").action = "/user/updateMember";
				document.getElementById("updateMyinfoForm").submit();				
			}
		}
	}
</script>

</body>
</html>