<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 글 관리</title>
</head>
<style>

input:focus {
	outline-color: var(--haru);
}
.js-search-div {
	width: 100%;
	position: relative;
}
.js-search-div .js-review-search {
	width: 100%;
	height: 35px;
	border-radius: 3px;
	border: 1px solid;
    border-color: rgba(0, 0, 0, .5);
    padding-right: 10px;
    padding-left: 30px;
}
.js-search-div > i {
	position: absolute;
	left: 10px;
    top: 9px;
    color: #6d6d6d;
}
.js-mcd-div {
	margin-top: 15px;
	
}
.js-mcd-div > span {
	padding-inline: 8px;
    padding-block: 3px;
    border-radius: 20px;
    color: #6F7173;
    border: 1px solid #e9e9e9;
    margin-right: 7px;
}
.js-mcd-div > span.active {
	border-color: var(--haru);
    background: var(--haru);
	color: white;
}

.js-review-div {
	margin-top: 30px;
	
}
.review-info-div {
	padding-block: 14px;
	border-bottom: 1px solid #d9d9d9;
}
.review-info-div:last-child {
	border: none;
}
.review-info-div .js-review-title {
	font-size: 16px;
}
.js-writer-div {
	color: #6F7173;
	font-size: 0.8rem;
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: space-between;
	margin-top: 0.3rem;
}
.js-review-title {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
}

.review-img {
	width: 3rem;
	height: 3rem;
	margin-right: 12px;
}

</style>
<body>
<script type="text/javascript">

		/* 제목 검색 */
		function search_word(e) {
			if (e.key === "Enter") {
    			var search1 = $(".js-review-search").val(); // 입력된 검색어
    			var isMy = "${isMy}";
    	        var mcd = "${mcd}";
    	        
    			console.log("search: ", search1);
    			console.log("isMy: ", isMy);
    			console.log("mcd: ", mcd);

    	        location.replace('/user/myCommunity?search1='+search1+'&type5='+isMy+'&mcd='+mcd);
    	    }
		}
		
		$(()=>{
			$('#pageNum${pagination.currentPage}.haru-pagenum').addClass('active');
		})
		
		
		/**	
		 * 상세페이지 이동
		 * 상품후기면 상품후기로, 진료수술 후기면 진료수술 후기로
		 */
		function goDetail(bno, mcd, event) {
			console.log(bno);
			console.log(mcd);
			
			if (mcd == 300) {
				let parentDiv = event.currentTarget; // 클릭된 div
		        let orderno = parentDiv.dataset.orderno;
		        let pno = parentDiv.dataset.pno;
		        
				alert("orderno : "+orderno+"pno : "+pno);
				location.href="/user/productReview?orderno="+orderno+"&pno="+pno;
				// location.href="/user/"
			} else {
				alert("bno : "+bno);
				location.href="/user/details-review?bno="+bno;				
			}
			
		}
		
		
	</script>
	
<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				내 글 관리
				<div style="width:45px"></div>
			</div>
		</div>
		
		<!-- body contents -->
		<div class="user-body-container">
			<div class="js-search-div">
				<i class="fa-solid fa-magnifying-glass"></i>
				<input type="text" class="js-review-search" placeholder="제목을 입력하세요" 
						onkeypress="if (event.key === 'Enter') search_word(event)"
						value="${title }">
			</div>
			
			<div class="js-mcd-div">
				<span class="shopping-filter-mcd ${ mcd == 999 ? 'active' : '' }" onclick="location.replace('/user/myCommunity?mcd=999')">전체</span>
				<c:forEach var="m" items="${mcdList }">
					<span class="shopping-filter-mcd ${ mcd == m.MCD ? 'active' : '' }" onclick="location.replace('/user/myCommunity?mcd=${m.MCD}')">${m.CONTENT}후기</span>
				</c:forEach>
			</div>
		
				<c:choose>
					<c:when test="${fn:length(rList) > 0 }"> 
						<!-- 후기가 존재할 때 -->
						<div class="js-review-div">
							<c:forEach var="rl" items="${rList }">
								<input type="hidden" name="orderno"  value="${rl.orderno}">
								<input type="hidden" name="pno" value="${rl.pno}">
								<!-- 게시글 -->
								<c:if test="${rl.btitle ne null}">
									<div class="review-info-div" 
										data-orderno="${rl.orderno}" 
     									data-pno="${rl.pno}" 
     									onclick="goDetail(${rl.bno}, ${rl.board_type_mcd}, event)">
										<!-- 상품후기면 이미지 보이게 하기 -->
										<div style="display: flex;">
											<c:if test="${rl.pimg_main ne null}">
												<img class="review-img" alt="prodictimg" src="${rl.pimg_main }">
											</c:if>
											<div class="js-review-title">
												${rl.btitle}
											</div>																				
										</div>
										<div class="js-writer-div" style="display: flex;">
											<span class="js-review-regdate" style="margin-left: auto;"><fmt:formatDate value="${rl.reg_date }" pattern="yyyy-MM-dd"/></span>
										</div>
									</div>
								</c:if>
								<!-- 댓글 -->
								<c:if test="${rl.btitle eq null}">
									<div class="review-info-div">
										<div class="js-review-title" style="display: flex; "><i class="fa-regular fa-comment-dots" style="margin: auto 0;"></i>
																	 &nbsp;${rl.bcontents }
																	 <span style="color: red; font-size: 12px; margin-left: auto;" onclick="location.href='/user/review-re-delete?bno='+${rl.bno}">삭제</span></div>
										<div class="js-writer-div" style="display: flex;">
												<!-- 원글 제목 --><span>${rl.otitle }</span>
											<span class="js-review-regdate" style="margin-left: auto;"><fmt:formatDate value="${rl.reg_date }" pattern="yyyy-MM-dd"/></span>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</c:when>
					<c:otherwise>
						<div style="margin-top: 2rem; color:#6F7173; text-align: center">작성된 후기가 없습니다.</div>
					</c:otherwise>
				</c:choose>
				
				<div class="js-pl-pagination">
					<c:if test="${pagination.startPage > pagination.blockSize }">
						<i class="haru-pagearrow fa-solid fa-chevron-left" 
							onclick="location.replace('/user/myCommunity?pageNum=${pagination.startPage-pagination.blockSize}&search1=${search1}&type5=${ismy }&mcd=${mcd}')">
						</i>
					</c:if>
					
					<c:forEach var="i" begin="${pagination.startPage }" end="${pagination.endPage }">
						<div class="haru-pagenum" id="pageNum${i}" onclick="location.replace('/user/myCommunity?pageNum=${i}&search1=${search1}&type5=${ismy }&mcd=${mcd}')">${i }</div>
					</c:forEach>
					
					<c:if test="${pagination.endPage < pagination.pageCnt }">
						<i class="haru-pagearrow fa-solid fa-chevron-right" 
							onclick="location.replace('/user/myCommunity?pageNum=${pagination.startPage+pagination.blockSize}&search1=${search1}&type5=${ismy }&mcd=${mcd}')">
						</i>
					</c:if> 
				</div>
		</div>
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
	
	
</body>
</html>