<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
/* 지난 예약내역 */
.pet-res {
	border: 2px solid;
	border-radius: 12px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.14);
	margin: 12px 0;
	padding: 10px;
	cursor: pointer;
}
.pet-res-content .res-date,
.pet-res-content .res-petname,
.pet-res-content .res-item,
.pet-res-content .res-number {
	margin: 4px;
	color: #6F7173;	
	display: flex;
	flex-direction: row;
	align-items: center;
}
.res-number {
	font-size: 12px;
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: space-between;
}
.res-petname {
	color: black !important;
	font-weight: 600;
	font-size: 14px;
	margin-top: 8px !important;
}
.res-item {
	font-size: 14px;
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: space-between;
}
.res-re {
	margin-top: 8px;
}
.res-re button {
	width: 49%;
	height: 40px;
	font-size: 14px;
}
.res-re.show {
    display: block;
}
.res-btn-b {
	background-color: var(--haru);
	color: white;
}
.res-btn-c {
	background-color: white;
	border: 1px solid var(--haru);
	color: black;
}
.past-type {
	background-color: #A6D6C6; 
	border-radius: 12px; 
	padding: 1px 4px; 
	font-size: 12px; 
	margin-left: 4px;
	color: black;
	width: 56px;
	text-align: center;
}
.page-btn {
	position: absolute;
	right: 10px;
	top: 50px;
}
button {
	cursor: pointer;
}
</style>

<!-- 예약 내용 -->	
<div class="pet-res" style="
					<c:choose>
						<c:when test="${res.mtitle_bcd eq 110 }">border-color: rgba(12, 128, 141, 0.46)</c:when>
						<c:when test="${res.mtitle_bcd eq 120 }">border-color: rgba(241, 141, 126, 0.71)</c:when>
						<c:when test="${res.mtitle_bcd eq 130 }">border-color: #D0E3E7</c:when>
						<c:when test="${res.mtitle_bcd eq 140 }">border-color: #A6D6C6</c:when>
					</c:choose>
					">
	<div class="pet-res-content" style="display: flex; position: relative;">
		<div style="width: 100%">
			<div class="res-number">
				<span style="color: black; font-weight: 600;">${res.resno }</span>
				<div class="past-type" style="
					<c:choose>
						<c:when test="${res.mtitle_bcd eq 110 }">background: #0c808d99; color: white</c:when>
						<c:when test="${res.mtitle_bcd eq 120 }">background: #F18D7E; color: white</c:when>
						<c:when test="${res.mtitle_bcd eq 130 }">background: #D0E3E7</c:when>
						<c:when test="${res.mtitle_bcd eq 140 }">background: #A6D6C6</c:when>
					</c:choose>
					"
					>${res.item_bcd }</div>
			</div>
			<div class="res-date">
				<fmt:formatDate value="${res.rdate}" pattern="yyyy.MM.dd" />
				<span style="margin-left: 10px; color: black; font-size: 14px; font-weight: 500">${fn:substring(res.start_time, 0, 2) }:${fn:substring(res.start_time, 2, 4) }</span>
			</div>
			<div class="res-petname">
				<img src="${res.petimg }" style="width:40px; height: 40px; border-radius: 50%; margin-right: 10px">
				${res.petname }
			</div>
			<div class="res-item"><span>${res.item_bcd }&nbsp;-&nbsp;${res.item }</span><span>${res.aname } 선생님</span></div>
		</div>
		<i class="fa-solid fa-chevron-right page-btn" style="transform: rotate(90deg);"></i> 
	</div>
	
	<!-- 리뷰, 차트 버튼 -->		
	<div class="res-re" style="display: none;">
		<!-- 리뷰 -->
		<c:choose>
			<c:when test="${res.resno ne null and res.resno eq res.bresno }">
				<button class="res-btn-b" onclick="location.href='/user/details-review?bno=${res.bno}'">리뷰 보러가기</button>
			</c:when>
			<c:otherwise>
			 	<button class="res-btn-b" onclick="location.href='/user/write-review?resno=${res.resno}'">리뷰 작성하기</button>							
			</c:otherwise>
		</c:choose>
		
		<!-- 차트 -->
		<c:choose>
			<c:when test="${res.resno ne null and res.resno eq res.cresno }">
				<button class="res-btn-c" onclick="location.href='/user/detailConsultation?cno=${res.cno}'">차트 확인하기</button>
			</c:when>
			<c:otherwise>
				<button class="res-btn-c">차트 준비중</button>
			</c:otherwise>								
		</c:choose>
		
	</div>
</div>
