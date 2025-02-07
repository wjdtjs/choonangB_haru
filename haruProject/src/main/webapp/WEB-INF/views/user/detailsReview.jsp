<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>

<style type="text/css">
/* 수정/삭제 메뉴 모달 */
.menu-modal-bg {
	width: 100%;
    height: 100vh;
    background: rgba(0,0,0,.2);
    position: absolute;
    top: 0;
    z-index: 999;
}
.menu-modal-div {
	position: absolute;
    bottom: 0;
    background: white;
    width: 100%;
    height: 160px;
    border-top-left-radius: 20px;
    border-top-right-radius: 20px;
    display: flex;
    flex-direction: column;
    padding: 10px;
}
.menu-modal-btn-div {
	border-bottom: 1px solid #d9d9d9;
    padding: 20px;
    text-align: center;
}
.menu-modal-btn-div > button {
	height: 45px;
    width: 140px;
    background: white;
    border: 1px solid rgba(0, 0, 0, .5);
}
.menu-modal-close {
	padding: 10px;
    text-align: center;
    color: black;
}
/* 수정/삭제 메뉴 모달 끝 */

.js-board-type {
	background-color: #D0E3E7;
	color: #254D64;
	border-radius: 5px;
	font-size: 1rem;
	width: fit-content;
	padding-inline: 4px;
}
.js-board-title {
	margin-top: 5px;
	font-size: 18px;
	font-weight: 500;
}
.js-review-img-div {
	width: 100%;
	height: 120px;
	padding-block: 10px;
	overflow: scroll hidden;
	white-space: nowrap;
}
.js-review-img {
	width: 100px;
	height: 100px;
	border-radius: 10px;
	margin-right: 10px;
	display: inline-block;
	object-fit: cover;
}
.js-review-img:last-of-type {
	margin-right: 0;
}
.review-info {
	font-size: 0.8rem;
	color: #6F7173;
	background: #f2f2f2;
	border-radius: 5px;
	padding: 6px;
	margin-top: 4px;
	margin-bottom: 20px; 
}
.js-writer-div {
	width: 100%;
	font-size: 0.8rem;
	color: #6F7173;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding-block: 4px;
}
.js-review-comment-div {
	width: 100%;
	margin-top: 3rem;
	padding-top: 1rem;
	border-top: 4px solid #d9d9d9;
	padding-bottom: 55px;
}
.js-comment-container {
	margin-top: 10px;
}
.js-comment-input {
	width: 310px;
	height: 35px;
	max-height: 100px;
	padding-block: 8px;
	padding-inline: 12px;
	border-radius: 20px;
	border: none;
	background-color: #EFEFEF;
	font-family: "Noto Sans KR", serif;
	resize: none;
}
.js-comment-input:focus {
	outline: none;
}
.comment-item {
	margin-bottom: 10px;
	padding-bottom: 10px;
	border-bottom: 1px solid #f2f2f2;
}
.comment-item:last-of-type {
	border-bottom: none;
}
.comment-info {
	margin-top: 4px;
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: space-between;
	font-size: 11px;
	color: #6F7173;
}
.write-comment-div {
	width: 350px; 
	height: 59px; 
	position: fixed; 
	bottom: 72px; 
	display: flex; 
	align-items: flex-end; 
	justify-content: space-between; 
	background: white; 
	padding-bottom: 14px;
}

</style>

</head>
<body>
	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				커뮤니티
				<div style="width:45px">
					<c:if test="${ismy }">
						<i class="fa-solid fa-ellipsis-vertical" style="text-align: center" onclick="openMenu()"></i>
					</c:if>
				</div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container" style="position: relative;">
			<div style="display: flex; flex-direction: row; align-items: center; justify-content: space-between;">
				<div class="js-board-type">${board.content }후기</div>
				<div style="font-size: 12px; color: #6F7173">조회수 : ${board.bview_count }</div>			
			</div>
			<div class="js-board-title">${board.btitle }</div>
			
			<!-- 작성자/작성일 -->
			<div class="js-writer-div">
				<span class="js-review-writer">${board.memail }</span>										
				<span class="js-review-regdate"><fmt:formatDate value="${board.reg_date }" pattern="yyyy-MM-dd"/></span>
			</div>
			<div class="review-info">
				<div><span style="font-weight: 600;">담당의</span> &nbsp;&nbsp;&nbsp;${board.aname } 선생님</div>			
				<div><span style="font-weight: 600;">항목&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> ${board.bcd_content } - ${board.mcd_content }</div>			
			</div>
			
			<!-- 이미지 -->
			<c:if test="${fn:length(imgList) > 0 }">
				<div class="js-review-img-div">
					<c:forEach var="i" items="${imgList }">
						<img class="js-review-img" src="${i.content }">
					</c:forEach>
				</div>
			</c:if>

			<!-- 상세내용 -->
			<div class="js-review-content" style="margin-top: 1rem;">
				${board.bcontents }
			</div>
			
			<!-- 댓글 -->
			<div class="js-review-comment-div">
				<div style="font-weight: 500">댓글 ${cnt }</div>
				
				<div class = "js-comment-container"></div>
				<c:if test="${cnt > 10 }">
					<div class="more-comment" style="text-align: center; font-size: 0.8rem" onclick="readComment()">더보기</div>
				</c:if>
			</div>

			<div class="write-comment-div">
				<textarea class="js-comment-input" rows="1" oninput="autoResize(this)"></textarea>
				<img src="/img/Send.png" style="width: 26px; margin-bottom: 5px;" onclick="sendComment()">
			</div>
		</div>
		
		
		<!-- 수정/삭제 메뉴 모달 -->
		<form action="deleteReviews" id="delete-form" method="post" onsubmit="return deleteChk()">
			<input type="hidden" name="bno" value="${board.bno }">
		</form>
		<div class="menu-modal-bg" style="display: none">
			<div class="menu-modal-div">
				<div class="menu-modal-btn-div">
					<button style="margin-right: 10px" type="button" onclick="location.href='/user/update-review?bno=${board.bno}'">수정</button>
					<button type="submit" form="delete-form">삭제</button>
				</div>
				<div class="menu-modal-close" onclick="modal_close()">닫기</div>
			</div>
		</div>
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
	
	<script type="text/javascript">
	
		const review_container = $('.js-comment-container');
		let pageNum = 0;
		
		$(()=>{
			readComment();
			
			$('textarea').on('keydown', function(event) {
		        if (event.keyCode == 13)
		            if (!event.shiftKey){
		                event.preventDefault();
		                sendComment();
		            }
		    });
		})
		
		/* 후기 삭제 */
		function deleteChk() {
			let result = confirm('정말 삭제하시겠습니까?')
			
			return result;
		}
		
		/* 댓글 불러오기 */
		function readComment() {
			
			pageNum += 1; // 더보기 누를때마다 페이지 하나씩 증가
			
			let url = `<%=request.getContextPath()%>/user/api/review-comment?bno=${board.bno}&pageNum=\${pageNum}`;
			
			$.ajax({
				url: url,
				method: 'get',
				success: function(data) {
					console.log(data);
					
					let str = "";
					$(data.comment).each (function(){
						str+= `<div class="comment-item">
									<div style="font-size: 14px;">\${this.bcontents}</div>
									<div class="comment-info">
										<span>\${this.memail}</span>
										<span>\${this.reg_date.split('T')[0]}</span>
									</div>
								</div>`
						
					})
					
					if(data.pagination.endPage == pageNum)
						$('.more-comment').remove();
					
					review_container.append(str);
					
				}
			})
		}
		
		/* 댓글 작성 */
		function sendComment() {
			const comment = $('.js-comment-input').val();
			console.log('${sessionScope}');
			if(isEmpty(comment)) {
				let url = `<%=request.getContextPath()%>/user/api/write-comment`;
				
				$.ajax({
					url: url,
					method: 'post',
					contentType:"application/json",
					data: JSON.stringify({
						bgroup: ${board.bno},
						bseq: ${board.bseq},
						blevel: ${board.blevel},
						bcontents: comment
					}),
					success: function(data){
						console.log(data);
						
						if(data.success) {
							str = `
								<div class="comment-item">
									<div style="font-size: 14px;">\${comment}</div>
									<div class="comment-info">
										<span>${sessionScope.email}</span>
										<span>지금</span>
									</div>
								</div>
							`;
							review_container.prepend(str);
							$('.js-comment-input').val('');
							$('.js-comment-input').css('height', 'auto');
						}
						
						
					}
				})
				
			}
			
		}
		
		
		
		/* 댓글 작성 textarea height 조절 */
		function autoResize(textarea) {
	        textarea.style.height = 'auto' // 높이를 자동으로 초기화
	        textarea.style.height = textarea.scrollHeight + 'px' // 스크롤 높이에 맞게 높이 설정
	        let h = 30+textarea.scrollHeight;
	        $('.js-review-comment-div').css('padding-bottom', h + 'px');
	     }
		
		/* 수정/닫기 모달 */
		function openMenu() {
			$('.menu-modal-bg').css('display', 'block'); 
		}
		function modal_close() {
			$('.menu-modal-bg').css('display', 'none'); 
		}
		

	</script>
</body>
</html>