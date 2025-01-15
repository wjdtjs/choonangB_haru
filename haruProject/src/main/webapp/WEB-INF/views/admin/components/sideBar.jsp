 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index">
        <div class="sidebar-brand-icon">
<!--             <i class="fas fa-laugh-wink"></i> -->
<!--             <i class="fas fa-solid fa-dog"></i> -->
        </div>
        <div class="sidebar-brand-text mx-3">HARU ADMIN</div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item">
        <a class="nav-link" href="index">
            <i class="fas fa-fw fa-solid fa-chart-simple"></i>
            <span>메인페이지</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <!-- <div class="sidebar-heading">
        ADMIN
    </div> -->

    <!-- Nav Item - ADMIN -->
    <li class="nav-item">
        <a class="nav-link collapsed"  href="#" data-toggle="collapse" data-target="#collapseUtilitiesDoctor"
            aria-expanded="true" aria-controls="collapseUtilities">
            <i class="fas fa-fw fa-solid fa-user-doctor"></i>
            <span>관리자</span>
        </a>
        <div id="collapseUtilitiesDoctor" class="collapse" aria-labelledby="headingUtilities"
            data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<a class="collapse-item" href="/api/adminList">관리자관리</a>
            	<a class="collapse-item" href="schedule">근무 관리</a>
            </div>
        </div>
    </li>
    
    <li class="nav-item">
        <a class="nav-link" href="medical">
            <i class="fas fa-fw fa-solid fa-hospital"></i>
            <span>진료 항목 관리</span>
		</a>
    </li>
    
    <li class="nav-item">
        <a class="nav-link" href="consultation">
            <i class="fas fa-fw fa-solid fa-file-medical"></i>
            <span>진료 관리</span>
		</a>
    </li>

    <!-- Nav Item - Utilities Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
            aria-expanded="true" aria-controls="collapseUtilities">
            <i class="fas fa-fw fa-solid fa-cart-shopping"></i>
            <span>상품</span>
        </a>
        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
            data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
<!--                 <h6 class="collapse-header">상품 판매</h6> -->
                <a class="collapse-item" href="stock">상품 관리</a>
                <a class="collapse-item" href="shop">판매 관리</a>
            </div>
        </div>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
<!--     <div class="sidebar-heading"> -->
<!--         CUSTOMER -->
<!--     </div> -->

    <!-- Nav Item - CUSTOMER -->
    <li class="nav-item">
        <a class="nav-link" href="members">
            <i class="fas fa-fw fa-solid fa-user"></i>
            <span>회원 관리</span>
        </a>
    </li>

    <li class="nav-item">
        <a class="nav-link" href="animals">
            <i class="fas fa-fw fa-solid fa-shield-dog"></i>
            <span>동물 관리</span>
        </a>
    </li>

    <li class="nav-item">
        <a class="nav-link" href="reservation">
            <i class="fas fa-fw fa-solid fa-calendar-days"></i>
            <span>예약 관리</span>
        </a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
<!--     <div class="sidebar-heading"> -->
<!--         BOARD -->
<!--     </div> -->

    <!-- Nav Item - BOARD -->
    <li class="nav-item">
        <a class="nav-link" href="notice">
            <i class="fas fa-fw  fa-solid fa-clipboard"></i>
            <span>공지사항 관리</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="board">
            <i class="fas fa-fw fa-solid fa-list"></i>
            <span>게시판 관리</span>
        </a>
    </li>


 </ul>