<%@ page import = "java.util.*,spring.myapp.shoppingmall.dto.Goods" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>홈페이지</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</head>
<body>
    <jsp:include page = "./common/search_wrapper.jsp"/>
    <div class="main-content-wrapper d-flex clearfix">
        <div class="mobile-nav">
            <div class="amado-navbar-brand">
                <a href="${pageContext.request.contextPath}/">
                	<img src="${pageContext.request.contextPath}/resources/img/core-img/bookstore.png" alt="" width = "137" height = "77">
                </a>
            </div>
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
                <a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/img/core-img/bookstore.png" alt="" width = "300" height = "150"></a>
              	<br><br>
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
                    <li class="active"><a href="${pageContext.request.contextPath}/">홈페이지</a></li>
                    <li><a href="${pageContext.request.contextPath}/shopentrance">상품</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/showbasket">장바구니</a></li>
                    <li><a href="${pageContext.request.contextPath}/showcoupon">쿠폰 내역</a></li>
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
    						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						</form>
                	</c:if>                
                </ul>
            </nav>
            <!-- Button Group -->
            <!--  
            <div class="amado-btn-group mt-30 mb-100">
                <a href="#" class="btn amado-btn mb-15">%Discount%</a>
                <a href="#" class="btn amado-btn active">New this week</a>
            </div>
            -->
            <!-- Cart Menu -->
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
        <!-- Header Area End -->

        <!-- Product Catagories Area Start -->
        <div class="products-catagories-area clearfix">
            <div class="amado-pro-catagory clearfix">

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="${pageContext.request.contextPath}/shop?bigclass=novel&subclass=koreannovel">
                        <img src="${pageContext.request.contextPath}/resources/img/book-img/1.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>최저가 180원</p>
                            <h4>소설</h4>
                        </div>
                    </a>
                </div>

				  <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="${pageContext.request.contextPath}/shop?bigclass=economy&subclass=managementgeneral">
                        <img src="${pageContext.request.contextPath}/resources/img/book-img/2.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>최저가 180원</p>
                            <h4>경제/경영</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="${pageContext.request.contextPath}/shop?bigclass=humanity&subclass=psychology">
                        <img src="${pageContext.request.contextPath}/resources/img/book-img/3.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>최저가 180원</p>
                            <h4>인문</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="${pageContext.request.contextPath}/shop?bigclass=religion&subclass=christianity">
                        <img src="${pageContext.request.contextPath}/resources/img/book-img/4.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>최저가 180원</p>
                            <h4>종교</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="${pageContext.request.contextPath}/shop?bigclass=science&subclass=sciencetheory">
                        <img src="${pageContext.request.contextPath}/resources/img/book-img/5.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>최저가 180원</p>
                            <h4>과학</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="${pageContext.request.contextPath}/shop?bigclass=politics&subclass=politics">
                        <img src="${pageContext.request.contextPath}/resources/img/book-img/6.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>최저가 320원</p>
                            <h4>정치/사회</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="${pageContext.request.contextPath}/shop?bigclass=computer&subclass=computerengineering">
                        <img src="${pageContext.request.contextPath}/resources/img/book-img/7.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>최저가 320원</p>
                            <h4>컴퓨터/IT</h4>
                        </div>
                    </a>
                </div>
                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="${pageContext.request.contextPath}/shop?bigclass=children&subclass=childrenliterature">
                        <img src="${pageContext.request.contextPath}/resources/img/book-img/8.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>최저가 320원</p>
                            <h4>어린이</h4>
                        </div>
                    </a>
                </div>

                <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="${pageContext.request.contextPath}/shop?bigclass=textbook&subclass=EBS">
                        <img src="${pageContext.request.contextPath}/resources/img/book-img/9.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>최저가 320원</p>
                            <h4>교과서</h4>
                        </div>
                    </a>
                </div>
                
                 <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="${pageContext.request.contextPath}/shop?bigclass=cook&subclass=cooknormal">
                        <img src="${pageContext.request.contextPath}/resources/img/book-img/10.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>최저가 320원</p>
                            <h4>요리</h4>
                        </div>
                    </a>
                </div>
                
                 <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="${pageContext.request.contextPath}/shop?bigclass=foreign&subclass=foreignnormal">
                        <img src="${pageContext.request.contextPath}/resources/img/book-img/11.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>최저가 320원</p>
                            <h4>외국어</h4>
                        </div>
                    </a>
                </div>
                
                 <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="${pageContext.request.contextPath}/shop?bigclass=cartoon&subclass=culturecartoon">
                        <img src="${pageContext.request.contextPath}/resources/img/book-img/12.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>최저가 320원</p>
                            <h4>만화</h4>
                        </div>
                    </a>
                </div>
                
                 <!-- Single Catagory -->
                <div class="single-products-catagory clearfix">
                    <a href="${pageContext.request.contextPath}/shop?bigclass=magazine&subclass=fashion">
                        <img src="${pageContext.request.contextPath}/resources/img/book-img/13.jpg" alt="">
                        <!-- Hover Content -->
                        <div class="hover-content">
                            <div class="line"></div>
                            <p>최저가 320원</p>
                            <h4>잡지</h4>
                        </div>
                    </a>
                </div>
                
            </div>
        </div>
        <!-- Product Catagories Area End -->
    </div>
    <!-- ##### Main Content Wrapper End ##### -->

    <!-- ##### Newsletter Area Start ##### -->
    <section class="newsletter-area section-padding-100-0">
        <div class="container">
            <div class="row align-items-center">
                <!-- Newsletter Text -->
                <div class="col-12 col-lg-6 col-xl-7">
                    <div class="newsletter-text mb-100">
                        <h2>Subscribe for a <span>25% Discount</span></h2>
                        <p>www.forallshoppingmall.com</p>
                    </div>
                </div>
                <!-- Newsletter Form -->
                <div class="col-12 col-lg-6 col-xl-5">
                    <div class="newsletter-form mb-100">
                        <form action="#" method="post">
                            <input type="email" name="email" class="nl-email" placeholder="Your E-mail">
                            <input type="submit" value="Subscribe">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Newsletter Area End ##### -->

    <!-- ##### Footer Area Start ##### -->
    <footer class="footer_area clearfix">
        <div class="container">
            <div class="row align-items-center">
                <!-- Single Widget Area -->
                <div class="col-12 col-lg-4">
                    <div class="single_widget_area">
                        <!-- Logo -->
                        <div class="footer-logo mr-50">
                            <a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/img/core-img/bookstore.png" alt=""></a>
                        </div>
                        <!-- Copywrite Text -->
                        <p class="copywrite"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a> & Re-distributed by <a href="https://themewagon.com/" target="_blank">Themewagon</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                    </div>
                </div>
                <!-- Single Widget Area -->
                <div class="col-12 col-lg-8">
                    <div class="single_widget_area">
                        <!-- Footer Menu -->
                        <div class="footer_menu">
                            <nav class="navbar navbar-expand-lg justify-content-end">
                                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#footerNavContent" aria-controls="footerNavContent" aria-expanded="false" aria-label="Toggle navigation"><i class="fa fa-bars"></i></button>
                                <div class="collapse navbar-collapse" id="footerNavContent">
                                    <ul class="navbar-nav ml-auto">
                                        <li class="nav-item active">
                                            <a class="nav-link" href="${pageContext.request.contextPath}/">홈페이지</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${pageContext.request.contextPath}/shopentrance">상품</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${pageContext.request.contextPath}/showbasket">장바구니</a>
                                        </li>
                                        <li class="nav-item">
                                        	<a class="nav-link" href="${pageContext.request.contextPath}/showcoupon">쿠폰 내역</a>
                                        </li>
										<li class = "nav-item">
											<a class="nav-link" href="${pageContext.request.contextPath}/showorder">주문 정보</a>
										</li>
                                        <c:if test ="${not empty sessionScope.Userid}">
                    						<li class="nav-item">
                    							<a class="nav-link" style = "cursor:pointer" onclick="document.getElementById('logout-form').submit();">로그아웃</a>
                    						</li>
                							<form id="logout-form" action="<c:url value="/logout"/>" method="post">
    											<input type="hidden" name="${_csrf.parameterName}" id = "csrftoken" value="${_csrf.token}"/>
											</form>
                						</c:if>
                                    </ul>
                                </div>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <script src="${pageContext.request.contextPath}/resources/js/jquery/jquery-2.2.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/active.js"></script>
  	<script> 	//네이버 로그인 에러 발생
  	if("${sessionScope.gettokenerror}" != ""){			
  		alert("${sessionScope.gettokenerror}");
  		<%
  			session.removeAttribute("gettokenerror");
  		%>
  	} else if("${sessionScope.getprofileerror}" != ""){
  		alert("${sessionScope.getprofileerror}");
  		<%
			session.removeAttribute("getprofileerror");
		%>
  	}
  	</script>
  	<script>
  		var contextPath = "${pageContext.request.contextPath}";
  	</script>
  	<script src="${pageContext.request.contextPath}/resources/js/home.js"></script>
</body>
</html>