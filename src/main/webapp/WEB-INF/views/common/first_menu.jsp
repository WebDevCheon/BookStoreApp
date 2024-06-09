<%@ page import = "java.util.*,spring.myapp.shoppingmall.dto.Goods" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    	String url = request.getRequestURI().toString();
		String[] urlArr = url.split("/");
		String nowjsppage = urlArr[urlArr.length - 1];
		String nowpagename = nowjsppage.substring(0,nowjsppage.length()-4);
%>
	<c:set var="URL" value="${pageContext.request.requestURL}" />
	<c:set var="URL" value="${fn:replace(URL, 'shoppingmall', '')}"  />
	<link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
	<link href="${pageContext.request.contextPath}/resources/fontawesome/css/all.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
	    <div class="dim-layer">
		    <div class="dimBg"></div>
		    <div id="layer2" class="pop-layer"	>
		    </div>
		</div>
     <header class="header-area clearfix">
            <!-- Close Icon -->
            <div class="nav-close">
                <i class="fa fa-close" aria-hidden="true"></i>
            </div>
            <!-- Logo -->
            <div class="logo">
                <a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/img/core-img/bookstore.png" alt=""></a>
                <br>
                <br>
                <c:if test = "${empty sessionScope.Userid}">
              		<a href = "${pageContext.request.contextPath}/loginForm" class = "btn amado-btn">로그인</a><br>
		    	</c:if>
		    	<c:if test = "${empty sessionScope.Userid}">
              		<a href = "${pageContext.request.contextPath}/joinform" class = "btn amado-btn">회원가입</a><br>
		    	</c:if>
		    	<c:if test = "${empty sessionScope.Userid}">
		    		<a href = "${pageContext.request.contextPath}/findId" class = "btn amado-btn">아이디 찾기</a><br>
		    	</c:if> 
		    	<c:if test = "${empty sessionScope.Userid}">
		    		<a href = "${pageContext.request.contextPath}/findPassword" class = "btn amado-btn">비밀번호 찾기</a>
		    	</c:if>
		   <c:if test = "${not empty sessionScope.Userid}">
		    	<div class = "jumbotron" align = "center" style = "width : 160px;">
              	   <span>안녕하세요 <span style = "font-weight:bold;">${sessionScope.Userid}</span>님!</span><br>
              	   <span>오늘도 즐거운 쇼핑하세요!</span>
			    </div>
				 <div>
					<a href = "${pageContext.request.contextPath}/updatePasswordForm" class = "btn amado-btn">비밀번호 변경</a>
			     </div>
			    </c:if>
            </div>
            <!-- Amado Nav -->
            <nav class="amado-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">홈페이지</a></li>
					<% if(nowpagename.equals("product")){ %>
                    	<li class="${fn:contains(URL, '/shop') ? 'active':''} active" ><a href="${pageContext.request.contextPath}/shopentrance">상품</a></li>
                    <% } else { %>
                    	<li class="${fn:contains(URL, '/shop') ? 'active':''}" ><a href="${pageContext.request.contextPath}/shopentrance">상품</a></li>
                    <% } %>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/showbasket">장바구니</a></li>
                    <li class="${fn:contains(URL, '/showcoupon') ? 'active':''}"><a href="${pageContext.request.contextPath}/showcoupon">쿠폰 내역</a></li>
                    <c:if test = "${not empty sessionScope.Userid }">
						<li class="${fn:contains(URL, '/showorder') ? 'active':''}"><a href="${pageContext.request.contextPath}/showorder">주문 정보</a></li>
					</c:if>
					<c:if test = "${not empty sessionScope.admingrp}">
						<li class="${fn:contains(URL, '/adminrefund') ? 'active':''}"><a href="${pageContext.request.contextPath}/admin/adminrefund">고객 환불</a>
					</c:if>
					<c:if test = "${not empty sessionScope.admingrp}">
						<li class="${fn:contains(URL, '/registerForm') ? 'active':''}" ><a href="${pageContext.request.contextPath}/admin/registerForm">상품 등록</a>
					</c:if>
					<c:if test = "${not empty sessionScope.admingrp}">
						<% if(nowpagename.equals("monthbookselect")){ %>
							<li class = "active"><a href="${pageContext.request.contextPath}/admin/monthbookselect">이달의 인기 서적 등록</a>
						<%} else { %>
							<li><a href="${pageContext.request.contextPath}/admin/monthbookselect">이달의 인기 서적 등록</a>
						<% } %>
					</c:if>
					<c:if test = "${not empty sessionScope.admingrp}">
						<% if(nowpagename.equals("todaybookselect")){ %>
							<li class = "active"><a href="${pageContext.request.contextPath}/admin/todaybookselect">오늘의 서적 등록</a>
						<% } else { %>
							<li><a href="${pageContext.request.contextPath}/admin/todaybookselect">오늘의 서적 등록</a>
						<% } %>
					</c:if>
				   <c:if test ="${not empty sessionScope.Userid}">
                		<li class="${fn:contains(URL, '/logout') ? 'active':''}"><a onclick="document.getElementById('logout-form').submit();">로그아웃</a></li>
                		<form id="logout-form" action="<c:url value="/logout"/>" method="post">
    						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						</form>
                	</c:if>	
                </ul>
            </nav>
       
            <div class="cart-fav-search mb-100">
              <c:if test = "${not empty sessionScope.Userid }">
                <a href="${pageContext.request.contextPath}/showbasket" class="cart-nav"><img src="${pageContext.request.contextPath}/resources/img/core-img/cart.png" alt="">장바구니</a>
              </c:if>
                <a href="#" class="search-nav"><img src="${pageContext.request.contextPath}/resources/img/core-img/search.png" alt="">상품 검색</a>
            </div>
            <!-- Social Button -->
            <div class="social-info d-flex justify-content-between">
                <a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            </div>
        </header>