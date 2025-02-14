<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="components/header.jsp" %>   
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>관리자 로그인</title>

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">관리자 로그인</h1>
                                    </div>
                                    <form class="user">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                id="exampleInputEmail" aria-describedby="emailHelp"
                                                placeholder="ID"
                                                onkeypress="if (event.key === 'Enter') login(event)">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                id="exampleInputPassword" placeholder="Password"
                                                onkeypress="if (event.key === 'Enter') login(event)">
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" id="customCheck">
                                                <label class="custom-control-label" for="customCheck">아이디 기억하기</label>
                                            </div>
                                        </div>
                                        <button type="button" class="btn btn-primary btn-user btn-block" onclick="login()">
                                            Login
                                        </button>
                                        
                                    </form>
<!--                                     <hr> -->
<!--                                     <div class="text-center"> -->
<!--                                         <a class="small" href="">비밀번호 찾기</a> -->
<!--                                     </div> -->

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

<script type="text/javascript">
	
	function login() {
		let email = $('#exampleInputEmail').val();
		let passwd = $('#exampleInputPassword').val();
		console.log(email, passwd);
		
		//아이디 기억하기 체크
		if($("#customCheck").is(":checked")){
            setCookie("key" , email , 3);
        }else{
            deleteCookie("key");
        }
		
		$.ajax({
				url: "<%=request.getContextPath()%>/all/api/login",
				method: 'POST',
				contentType:"application/json",
				data: JSON.stringify({
					id: email,
					passwd: passwd,
					type: 'A'
				}),
				success: function(data){
					console.log(data)
					
					if(data.code != 200) alert('로그인 실패');
					else location.href="/admin/index";
				}
			})
	}
	
	$(()=>{
		let cookieId = getCookie("key");

        // 저장된 cookie 가 있다면
        if(cookieId != ''){
            $("#exampleInputEmail").val(cookieId);
            $("#customCheck").attr("checked" , true);
        }
        
	})
	
	
	// 쿠키 불러오기
    function getCookie(key) {
        key = key + "=";
        let cookieData = document.cookie;
        let firstCookie = cookieData.indexOf(key);
        let cookieValue = "";

        if(firstCookie != -1){
            firstCookie += key.length;
            let endCookie = cookieData.indexOf(';', firstCookie);
            if(endCookie == -1){
                endCookie = cookieData.length;
                cookieValue = cookieData.substring(firstCookie , endCookie);
            }
        }
        return unescape(cookieValue);
    }

    // 쿠키 설정하기
    // key = cookie 불러올때 사용할 key 값 , value = 저장할 id 값 , day = 유지할 날짜
    function setCookie(key , value , day){
        let currentTime = new Date();
        currentTime.setDate(currentTime.getDate() + day);
        let cookieValue = escape(value) + ((day == null) ? "" : "; expires=" + currentTime.toGMTString());

        document.cookie = key + "=" + cookieValue;
    }

    // 쿠키 삭제하기
    function deleteCookie(key){
        let currentTime = new Date();
        // 현재시간에서 1일을 빼서 없는 시간으로 만든다
        currentTime.setDate(currentTime.getDate() - 1);
        document.cookie = key + "=" + "; expires=" + currentTime.toGMTString();
    }
	
</script>

</body>
</html>