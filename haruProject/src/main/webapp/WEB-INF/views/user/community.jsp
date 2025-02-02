<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>

<style type="text/css">

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
	font-size: 18px;
}
.js-writer-div {
	color: #6F7173;
	font-size: 0.9rem;
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: space-between;
	margin-top: 0.3rem;
}
.js-my-review {
	margin-top: 10px;
	float: right;
	display: flex;
	align-items: center;
}
.js-review-title {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
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


</style>

</head>
<body>
	<div class="haru-user-container">
		<!-- header -->
		<div class="haru-user-topbar">
			<div class="topbar-title">
				<i class="fa-solid fa-chevron-left" onclick="history.back()"></i>
				커뮤니티
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
				<span class="shopping-filter-mcd ${ mcd == 999 ? 'active' : '' }" onclick="location.replace('/user/community?mcd=999')">전체</span>
				<c:forEach var="m" items="${mcdList }">
					<span class="shopping-filter-mcd ${ mcd == m.MCD ? 'active' : '' }" onclick="location.replace('/user/community?mcd=${m.MCD}')">${m.CONTENT}후기</span>
				</c:forEach>
			</div>
			
			<div class="js-my-review">
				<input type="checkbox" id="my-review" ${ismy==1?'checked':'' }>
				<label for="my-review">내 리뷰만 보기</label>
			</div>
		
			<c:choose>
					<c:when test="${fn:length(rList) > 0 }"> 
						<!-- 후기가 존재할 때 -->
						<div class="js-review-div">
							<c:forEach var="rl" items="${rList }">
								<div class="review-info-div" onclick="goDetail(${rl.bno})">
									<div class="js-review-title">${rl.btitle }</div>
									<div class="js-writer-div">
										<span class="js-review-writer">${rl.memail }</span>										
										<span class="js-review-regdate"><fmt:formatDate value="${rl.reg_date }" pattern="yyyy-MM-dd"/></span>
									</div>
								</div>
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
							onclick="location.replace('/user/community?pageNum=${pagination.startPage-pagination.blockSize}&search1=${search1}&type5=${ismy }&mcd=${mcd}')">
						</i>
					</c:if>
					
					<c:forEach var="i" begin="${pagination.startPage }" end="${pagination.endPage }">
						<div class="haru-pagenum" id="pageNum${i}" onclick="location.replace('/user/community?pageNum=${i}&search1=${search1}&type5=${ismy }&mcd=${mcd}')">${i }</div>
					</c:forEach>
					
					<c:if test="${pagination.endPage < pagination.pageCnt }">
						<i class="haru-pagearrow fa-solid fa-chevron-right" 
							onclick="location.replace('/user/community?pageNum=${pagination.startPage+pagination.blockSize}&search1=${search1}&type5=${ismy }&mcd=${mcd}')">
						</i>
					</c:if>
				</div>
		</div>
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
	
	<script type="text/javascript">
		
		$('#my-review').click(()=>{
			console.log("click")
			var checked = $('#my-review').is(':checked');
			var is_my = "0";
			if(checked)
				is_my = "1";
			
			var search1 = $(".js-review-search").val();
			
			location.replace('/user/community?search1='+search1+'&type5='+is_my+'&mcd='+${mcd});
		})
		
	
		/* 제목 검색 */
		function search_word(e) {
			if (e.key === "Enter") {
    			var search1 = $(".js-review-search").val(); // 입력된 검색어
    			var checked = $('#my-review').is(':checked');
    			var is_my = "0";
    			if(checked)
    				is_my = "1";

    	        location.replace('/user/community?search1='+search1+'&type5='+is_my+'&mcd='+${mcd});
    	    }
		}
		
		$(()=>{
			$('#pageNum${pagination.currentPage}.haru-pagenum').addClass('active');
		})
		
		
		/**	
		 * 상세페이지 이동
		 */
		function goDetail(bno) {
			console.log(bno);
			
			location.href="/user/details-review?bno="+bno;
		}
		
		
	</script>
</body>
</html>