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
			<div class="user-notice-contianer">
				<c:forEach var="nl" items="${nList }">
					<div class="user-notice-listdiv" onclick="goDetail(${nl.nno})">
						<div style="padding-right: 2rem">
							<c:if test="${nl.istop }">
								<i class="fa-solid fa-thumbtack" style="color: var(--haru);"></i>
							</c:if>
							${nl.ntitle }
						</div>
						<div>
							<fmt:formatDate value="${nl.reg_date }" pattern="yyyy-MM-dd"/>
						</div>
						<i class="fa-solid fa-chevron-right"></i>
					</div>
				</c:forEach>
			</div>
		</div>
	
		<!-- menu bar -->
		<jsp:include page="components/menubar.jsp"></jsp:include>
	</div>
	
	<script type="text/javascript">
	
		const noticeDiv = $('.user-notice-contianer');
		
		$(()=>{

			const $div = $('.user-body-container'); // 스크롤을 감지할 div
			
		    $div.on('scroll', function () {
		    	let childCount = noticeDiv.children().length;
		        
		        let scrollTop = $div.scrollTop(); // 현재 스크롤 위치
		        let scrollHeight = $div.prop('scrollHeight'); // div의 전체 높이

		        let clientHeight = $div.innerHeight(); // div의 높이 (보이는 부분)

		        // 스크롤이 가장 하단에 도달했는지 확인
		        if ((scrollTop + clientHeight >= scrollHeight)) {
		        	
		        	if(childCount < ${pagination.totalCnt}){
		        		console.log('불러오기')
	 		            $.ajax({
			    			url: "<%=request.getContextPath()%>/api/notice-list",
	 		    			data: {
	 		    				totalCnt: ${pagination.totalCnt},
			    				pageNum: ${pagination.currentPage + 1}
	 		    			},
	 		    			dataType: 'json',
	 		    			success: function(data){
	 		    				
	 		    				$(data.nList).each (function(){
	 		    					
	 		    					noticeDiv.append(`
				    						<div class="user-notice-listdiv" onclick="goDetail(\${this.nno})">
				    						<div>\${this.ntitle }</div>
				    						<div>
				    							\${this.reg_date.split('T')[0]}
				    						</div>
				    						<i class="fa-solid fa-chevron-right"></i>
				    					</div>
				    				`);
	 		    				})
	 		    				
	 		    			}
	 		    			
	 		    		})	
		        	} else {
			        	console.log('더 불러올거 없음');
			        }
		            
		        } 
		    });
	
		})
		
		
		/**	
		 * 상세페이지 이동
		 */
		function goDetail(nno) {
// 			console.log(nno);
			
			location.href="/user/details-notice?nno="+nno;
		}
		
		
	</script>
</body>
</html>