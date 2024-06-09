<%@ page import = "java.util.*,javax.servlet.http.HttpSession" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "spring.myapp.shoppingmall.dto.Coupon" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String Userid = (String)(session.getAttribute("Userid"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 내역</title>
<meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Title  -->
    <!-- Favicon  -->
	<link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
    <!-- Core Style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
</head>
<body>
   	<jsp:include page = "./common/search_wrapper.jsp"/>
   		<div class="main-content-wrapper d-flex clearfix">
        <div class="mobile-nav">
            <div class="amado-navbar-brand">
                <a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/img/core-img/bookstore.png" alt=""></a>
            </div>
            <div class="amado-navbar-toggler">
                <span></span><span></span><span></span>
            </div>
        </div>
        <header class="header-area clearfix">
            <div class="nav-close">
                <i class="fa fa-close" aria-hidden="true"></i>
            </div>
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
              	   <span>안녕하세요 <span style = "font-weight:bold;">${sessionScope.Userid}</span>님!</span>
              	   <br>
              	   <span>오늘도 즐거운 쇼핑하세요!</span>
              	   <br>
			    </div>
				 <div>
					<a href = "${pageContext.request.contextPath}/updatePasswordForm" class = "btn amado-btn">비밀번호 변경</a>
			     </div>
			 	 <div>
			 	 	<br>
					<button onclick = "makecoupon('${sessionScope.Userid}','${pageContext.request.contextPath}')" class = "btn amado-btn">쿠폰 받기</button>
			     </div>
			    </c:if>
            </div>
            <!-- Amado Nav -->
            <nav class="amado-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">홈페이지</a></li>
                    <li><a href="${pageContext.request.contextPath}/shopentrance">상품</a></li>
                   <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/showbasket">장바구니</a></li>
                   <li class = "active"><a href="${pageContext.request.contextPath}/showcoupon">쿠폰 내역</a></li>
                    <c:if test = "${not empty sessionScope.Userid }">
								<li><a href="${pageContext.request.contextPath}/showorder">주문 정보</a></li>
					</c:if>
					<c:if test = "${not empty sessionScope.admingrp}">
						<li><a href="${pageContext.request.contextPath}/admin/adminrefund">고객 환불</a>
					</c:if>
					<c:if test = "${not empty sessionScope.admingrp}">
						<li><a href="${pageContext.request.contextPath}/admin/registerForm">상품 등록</a>
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
		
		<div class="amado_product_area section-padding-100">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                          <div class="product-topbar d-xl-flex align-items-end justify-content-between">
                          
                          </div>                  
                    </div>
        		</div>
 <div class = "container">
   <div class="row">
    <div class="col-sm-12">
 	<h3 style = "text-align:center;">쿠폰 내역 조회 결과</h3>
	<table class = "table" style = "text-align:center;">
		<tr>
			<th>쿠폰 아이디</th>
			<th>쿠폰 종류</th>
			<th>사용자 아이디</th>
			<th>사용 여부</th>
		</tr>
	 <c:if test = "${empty list}">
	 	<tr>
	 		<td colspan = "4">쿠폰이 없습니다.</td>
	 	</tr>
	 </c:if>
	 <c:if test = "${not empty list}">
		<c:forEach items = "${list}" var = "coupon">
			<tr>
				<td>${coupon.id}</td>
			  <c:if test = "${coupon.type eq 0}">
				<td>5% 할인 쿠폰</td>
			  </c:if>
			  <c:if test = "${coupon.type eq 1}">
				<td>10% 할인 쿠폰</td>
			  </c:if>
			  <c:if test = "${coupon.type eq 2}">
				<td>15% 할인 쿠폰</td>
			  </c:if>
			  <c:if test = "${coupon.type eq 3}">
				<td>20% 할인 쿠폰</td>
			  </c:if>
			  	<td>${sessionScope.Userid}</td>
			  <c:if test = "${coupon.usecheck eq 'no'}">
			  	<td>사용 가능</td>
			  </c:if>
			  <c:if test = "${coupon.usecheck eq 'yes'}">
			  	<td>사용함</td>
			  </c:if>
			</tr>
		</c:forEach>
	</c:if>
	</table>
  				<nav aria-label="navigation">
                            <ul class="pagination justify-content-end mt-50">
    							<c:if test="${ curPageNum > 5 }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/showcoupon?page=1">◀◀</a></li>
        						</c:if>
        
        						<c:if test="${ curPageNum > 5 }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/showcoupon?page=${ blockStartNum - 1 }">◀</a></li>
        						</c:if>
        
        						<c:forEach var="i" begin="${ blockStartNum }" end="${ blockLastNum }">
            						<c:choose>
            							<c:when test="${ i > lastPageNum }">
            								
            							</c:when>
                						<c:when test="${ i == curPageNum }">
                    						<li class="page-item active" style = "color:black;"><a class = "page-link">${ i }</a></li>
                						</c:when>
                						<c:otherwise>
                    						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/showcoupon?page=${ i }">${ i }</a></li>
                						</c:otherwise>
            						</c:choose>
            						&nbsp;&nbsp;
        						</c:forEach>
 
        						<c:if test="${ lastPageNum > blockLastNum }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/showcoupon?page=${ blockLastNum + 1 }">▶</a></li>
        						</c:if>
        						<c:if test = "${lastPageNum > 5}">
        							<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/showcoupon?page=${lastPageNum}">▶▶</a></li>
        						</c:if>
    						</ul>
                     </nav>
                 </div>
 			</div>
    </div>  
    </div>
    </div>
    </div>
    <script>
		var user = "<%=Userid%>"
    </script>
    <script>
    	var contextPath = "${pageContext.request.contextPath}";
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery/jquery-2.2.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/active.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/coupon/showcoupon.js"></script>
</body>
</html>