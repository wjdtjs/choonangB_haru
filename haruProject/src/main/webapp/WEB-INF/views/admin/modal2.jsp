<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>

#modal_s {
	display: none;
 	position:absolute;
  	width:100%;
  	height:100%;
  	z-index:999;
  	top: 200px;
}


#modal_s p {
  	margin:0;
  	color: #0C808D;
  	font-weight: bold;
  	font-size: 24px;
}

.modal_s_content {
	position: relative; /* 자식 요소가 부모 요소를 기준으로 위치 설정할 수 있도록 함 */
  	width: 568px;
  	height: 492px;
  	margin: auto;
  	padding:40px 40px;
  	background:#fff;
  	border-radius: 24px;
}

.modal_s_content button {
	position: absolute; /* 부모요소를 기준으로 고정 */
	border-radius: 5px;
  	width:100px;
  	height:40px;
  	font-size: 16px;
  	right: 40px;
  	bottom: 40px;
  	
  	border: white;
  	color: white;
  	background-color: #0C808D;
  	font-weight: bold;
  
}

.modal_s_content input {
	position: absolute; /* 부모요소를 기준으로 고정 */
	border-radius: 5px;
  	width:100px;
  	height:40px;
  	font-size: 16px;
  	right: 160px;
  	bottom: 40px;
  	
  	border: white;
  	color: white;
  	background-color: #B9B9B9;
  	font-weight: bold;
  
}

#modal_s .modal_s_layer {
  	position:fixed;
  	top:0;
  	left:0;
  	width:100%;
  	height:100%;
  	background:rgba(0, 0, 0, 0.5);
  	z-index:-1;
}   
</style>

</head>
<body>

<!-- <div id="root">
   
    <button type="button" id="modal_open_btn">창 열기</button>
       
</div> -->

<div id="modal_s">
   
    <div class="modal_s_content">
        <p>제목</p>
        
       	<input type="submit" value="수정하기">
        <button type="button" id="modal_close_btn">목록으로</button>
       
    </div>
   
    <div class="modal_s_layer"></div>
</div>

<script>
    document.getElementById("modal_open_btn").onclick = function() {
        document.getElementById("modal_s").style.display="block";
    }
   
    document.getElementById("modal_close_btn").onclick = function() {
        document.getElementById("modal_s").style.display="none";
    }   
</script>



</body>
</html>