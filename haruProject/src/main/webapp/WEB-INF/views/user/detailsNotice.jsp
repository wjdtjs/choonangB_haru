<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				공지사항
				<div style="width:30px"></div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container">
			<div class="user-notice-info">
				<div class="user-notice-title">${notice.ntitle }</div>
				<div class="user-notice-date">
					<fmt:formatDate value="${notice.reg_date }" pattern="yyyy-MM-dd"/>
					<span style="font-size: 14px">조회수 : ${notice.nview_count }</span>
				</div>	
			</div>
			<div style="margin-top: 1rem">
<!-- 				<textarea name="ncontents" class="summernoteTextArea readonly userNoticeSummernote"></textarea>	 -->
				${notice.ncontents}
			</div>
		</div>
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
	
	<script type="text/javascript">
	
		$(()=>{
// 			summernoteReadOnly('.userNoticeSummernote', 'notice');
//        		$('.userNoticeSummernote').summernote('disable');
//        		$('.userNoticeSummernote').summernote('code', '${notice.ncontents}' );
		})
		

	</script>
<!-- 	<script src="/js/summernote.js?v=0.05"></script> -->
</body>
</html>