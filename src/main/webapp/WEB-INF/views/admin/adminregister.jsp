<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html>
<html>
<style>
.error{
		color:red
	}
	tr
	{
		height:60px;
	}
	th
	{
		width:100px;
	}
</style>
	<title>상품 등록</title>
 	<meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta charset="UTF-8" />
	<link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
</head>
<body>
	 <!-- Search Wrapper Area Start -->
     <jsp:include page = "../common/search_wrapper.jsp"/>
    <!-- Search Wrapper Area End -->

    <!-- ##### Main Content Wrapper Start ##### -->
    <div class="main-content-wrapper d-flex clearfix">

        <!-- Mobile Nav (max width 767px)-->
        <div class="mobile-nav">
            <!-- Navbar Brand -->
            <div class="amado-navbar-brand">
                <a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/img/core-img/bookstore.png" alt=""></a>
            </div>
            <!-- Navbar Toggler -->
            <div class="amado-navbar-toggler">
                <span></span><span></span><span></span>
            </div>
        </div>

        <!-- Header Area Start -->
        <header class="header-area clearfix">
            <!-- Close Icon -->
            <div class="nav-close">
                <i class="fa fa-close" aria-hidden="true"></i>
            </div>
            <!-- Logo -->
            <div class="logo">
                <a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/img/core-img/bookstore.png" alt=""></a><br>
                <br>
                <c:if test = "${empty sessionScope.Userid}">
              		<a href = "${pageContext.request.contextPath}/loginForm" class = "btn amado-btn">로그인</a><br><br>
		    	</c:if>
		    	<c:if test = "${empty sessionScope.Userid}">
              		<a href = "${pageContext.request.contextPath}/joinform" class = "btn amado-btn">회원가입</a><br><br>
		    	</c:if>
		    	<c:if test = "${empty sessionScope.Userid}">
		    		<a href = "${pageContext.request.contextPath}/findId" class = "btn amado-btn">아이디 찾기</a><br><br>
		    	</c:if> 
		    	<c:if test = "${empty sessionScope.Userid}">
		    		<a href = "${pageContext.request.contextPath}/findPassword" class = "btn amado-btn">비밀번호 찾기</a>
		    	</c:if>
		    	<c:if test = "${not empty sessionScope.Userid}">
		    	<div class = "jumbotron" align = "center" style = "width : 160px;">
              	   <span>안녕하세요 <span style = "font-weight:bold;">${sessionScope.Userid}</span>님!</span><br>
              	   <span>오늘도 즐거운 쇼핑하세요!</span>
              	   <br>
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
                    <li><a href="${pageContext.request.contextPath}/shop">상품</a></li>
                   	<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/showbasket">장바구니</a></li>
                   	<li><a href="${pageContext.request.contextPath}/showcoupon">쿠폰 내역</a></li>
                    <c:if test = "${not empty sessionScope.Userid}">
								<li><a href="${pageContext.request.contextPath}/showorder">주문 정보</a></li>
					</c:if>
					<c:if test = "${not empty sessionScope.admingrp}">
						<li><a href="${pageContext.request.contextPath}/admin/adminrefund">고객 환불</a>
					</c:if>
					<c:if test = "${not empty sessionScope.admingrp}">
						<li class = "active"><a href="${pageContext.request.contextPath}/admin/registerForm">상품 등록</a>
					</c:if>
					<c:if test = "${not empty sessionScope.admingrp}">
						<li><a href="${pageContext.request.contextPath}/admin/monthbookselect">이달의 인기 서적 등록</a>
					</c:if>
					<c:if test = "${not empty sessionScope.admingrp}">
						<li><a href="${pageContext.request.contextPath}/admin/todaybookselect">오늘의 서적 등록</a>
					</c:if>
                    <c:if test = "${not empty sessionScope.Userid}">
                    	<li><a style = "cursor : pointer" onclick="document.getElementById('logout-form').submit();">로그아웃</a></li>
                		<form id="logout-form" action="<c:url value="/logout"/>" method="post">
    						<input type="hidden" name="${_csrf.parameterName}" id = "csrftoken" value="${_csrf.token}"/>
						</form>
                    </c:if>
                </ul>
            </nav>
            <!-- Cart Menu -->
            <div class="cart-fav-search mb-100">
             <c:if test = "${not empty sessionScope.Userid}">
                <a href="${pageContext.request.contextPath}/showbasket" class="cart-nav"><img src="${pageContext.request.contextPath}/resources/img/core-img/cart.png" alt="">장바구니 </a>
             </c:if>
                <a href="#" class="search-nav"><img src="${pageContext.request.contextPath}/resources/img/core-img/search.png" alt="">상품 찾기</a>
            </div>
            <!-- Social Button -->
            <div class="social-info d-flex justify-content-between">
                <a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            </div>
        </header>
        <!-- Header Area End -->

		   <div class="shop_sidebar_area">

            <!-- ##### Single Widget ##### -->
            <div class="widget catagory mb-50">
                <!-- Widget Title -->
                <h6 class="widget-title mb-30">상품 종류</h6>

                <!--  Catagories  -->
                <div class="catagories-menu">
                    <ul>
                     <li><a href = "${pageContext.request.contextPath}/shop">소설</a></li>
                        <li><a href = "${pageContext.request.contextPath}/shop?bigclass=economy&subclass=managementgeneral">경영/경제</a></li>
                    	<li><a href = "${pageContext.request.contextPath}/shop?bigclass=humanity&subclass=psychology">인문</a></li>
                    	<li><a href = "${pageContext.request.contextPath}/shop?bigclass=religion&subclass=christianity">종교</a></li>
                    	<li><a href = "${pageContext.request.contextPath}/shop?bigclass=science&subclass=sciencetheory">과학</a></li>
                    	<li><a href = "${pageContext.request.contextPath}/shop?bigclass=politics&subclass=politics">정치/사회</a></li>
                    	<li><a href = "${pageContext.request.contextPath}/shop?bigclass=computer&subclass=computerengineering">컴퓨터/IT</a></li>
                    	<li><a href = "${pageContext.request.contextPath}/shop?bigclass=children&subclass=literature">어린이</a></li>
                        <li><a href = "${pageContext.request.contextPath}/shop?bigclass=textbook&subclass=EBS">교과서</a></li>
                    	<li><a href = "${pageContext.request.contextPath}/shop?bigclass=cook&subclass=cooknormal">요리</a></li>
                    	<li><a href = "${pageContext.request.contextPath}/shop?bigclass=foreign&subclass=foreignnormal">외국어</a></li>
                    	<li><a href = "${pageContext.request.contextPath}/shop?bigclass=cartoon&subclass=culturecartoon">만화</a></li>
                    	<li><a href = "${pageContext.request.contextPath}/shop?bigclass=magazine&subclass=fashion">잡지</a></li>
                    </ul>
                </div>
            </div>
          </div>
          
          <div class="amado_product_area section-padding-100 container">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="product-topbar d-xl-flex align-items-end justify-content-between">
                           
                        </div>
                    </div>
                </div>
        </div>
 
 <sf:form action = "${pageContext.request.contextPath}/admin/registerGoods" method = "post" modelAttribute = "goods">
 <h1 style = "text-align:center;">관리자 등록</h1>
	<div class = "container">
	  <div class = "jumbotron">
	  	<div style = "font-weight:bold">책 이미지 업로드</div>
		<div id = "loadimg">
			
		</div>
		<br>
		<input type = "file" id = "imgfile"/> <sf:errors path = "goodsprofile" class = "error"/>
		<br>
		<br>
		<div>
			<sf:hidden path = "goodsprofile" id = "imgthumbnail"/><br> 
		  <table class = "table table-responsive" id="registertable">
		    <tr>
		    	<th>도서명</th>
				<td><sf:input type = "text" path = "name"/><sf:errors path = "name" class = "error"/></td>
			</tr>
			<tr>
				<th>가격</th>
				<td><sf:input type = "text" path = "price"/><sf:errors path = "price" class = "error"/></td>
			</tr>
			<tr>
				<th>대분류</th>
				<jsp:include page = "./bigclass.jsp"/>
			</tr>
			<tr>
				<th>소분류</th>
				<jsp:include page = "./subclass.jsp"/>
			</tr>
			<tr>
				<th>수량</th>
				<td><sf:input type = "text" path = "remain"/><sf:errors path = "remain" class = "error" /></td>
			</tr>
			<tr>
				<th>책소개</th>
				<td>
					<sf:textarea rows = "10" cols = "50" path = "goodscontent"></sf:textarea>
				</td>
			</tr>
			<sf:hidden path = "kind" value = "book"/>
			<tr>
				<th>글쓴이</th>
				<td><sf:input type = "text" path = "writer"/><sf:errors path = "writer" class = "error" /></td>				
			</tr>
			<tr>
				<th>출판사</th>
				<td><sf:input type = "text" path = "wcompany"/></td>				
			</tr>
			<tr>
				<th>목차</th>
				<td><sf:textarea rows = "10" cols = "50" path = "tcontent"></sf:textarea></td>				
			</tr>
			<tr>
				<th>저자소개</th>
				<td><sf:textarea rows = "10" cols = "50" path = "writerintroduction"></sf:textarea></td>				
			</tr>
			<tr>
				<th>서평</th>
				<td><sf:textarea rows = "10" cols = "50" path = "review"></sf:textarea></td>				
			</tr>
			<tr>
				<th>줄거리</th>
				<td><sf:textarea rows = "10" cols = "50" path = "summary"></sf:textarea></td>				
			</tr>
			<tr>
				<th>페이지수</th>
				<td><sf:input type = "text" path = "page"/><sf:errors path = "page" class = "error"/></td>				
			</tr>
			<tr>
				<th>ISBN 번호</th>
				<td><sf:input type = "text" path = "isbn"/><sf:errors path = "isbn" class = "error"/></td>				
			</tr>
			<tr>
				<th>가로 길이(단위생략)</th>
				<td style = "vertical-align:middle"><sf:input type = "text" path = "width"/><sf:errors path = "width" class = "error"/></td>				
			</tr>
			<tr>
				<th>세로 길이(단위생략)</th>
				<td style = "vertical-align:middle"><sf:input type = "text" path = "height"/><sf:errors path = "height" class = "error"/></td>				
			</tr>
			<tr>
				<th>출판일</th>
				<td><sf:input type = "date" path = "publishday"/><sf:errors path = "publishday" class = "error"/></td>				
			</tr>
			<tr>
				<th>엮은이</th>
				<td><sf:input type = "text" path = "trastlationer"/><sf:errors path = "trastlationer" class = "error"/></td>				
			</tr>
			<tr>
				<th>커버 종류</th>
				<td><sf:input type = "text" path = "cover"/><sf:errors path = "cover" class = "error"/></td>				
			</tr>
		  </table>
		  <input type = "submit" value = "등록" style = "width:30px;" class = "btn amado-btn">
		 </div>
	   </div>
	  </div>
 </sf:form>
 	</div>
 </div>
    <script src="${pageContext.request.contextPath}/resources/js/jquery/jquery-2.2.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/active.js"></script>
    <script>
		var contextPath = "${pageContext.request.contextPath}";
	</script>
	<script src="${pageContext.request.contextPath}/resources/js/admin/adminregister.js"></script>
</body>
</html>