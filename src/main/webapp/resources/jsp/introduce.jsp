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
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <!-- Title  -->
	<title>회사 소개</title>
    <!-- Favicon  -->
    <link rel="icon" href="img/core-img/favicon.ico">
    <!-- Core Style CSS -->
    <link rel="stylesheet" href="/shoppingmall/resources/css/core-style.css">
    <link rel="stylesheet" href="/shoppingmall/resources/style.css">
	<%@ include file="../../WEB-INF/views/common/head.jsp"%>
</head>
<body>
    <jsp:include page = "../../WEB-INF/views/common/search_wrapper.jsp"/>
    <!-- Search Wrapper Area End -->

    <!-- ##### Main Content Wrapper Start ##### -->
    <div class="main-content-wrapper d-flex clearfix">

        <!-- Mobile Nav (max width 767px)-->
        <div class="mobile-nav">
            <!-- Navbar Brand -->
            <div class="amado-navbar-brand">
                <a href="/shoppingmall/home"><img src="/shoppingmall/resources/img/core-img/bookstore.png" alt=""></a>
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
                <a href="/shoppingmall/home"><img src="/shoppingmall/resources/img/core-img/bookstore.png" alt=""></a><br>
                <br>
                <c:if test = "${empty sessionScope.Userid}">
              		<a href = "/shoppingmall/loginForm" class = "btn amado-btn">로그인</a><br><br>
		    	</c:if>
		    	<c:if test = "${empty sessionScope.Userid}">
              		<a href = "/shoppingmall/joinform" class = "btn amado-btn">회원가입</a><br><br>
		    	</c:if>
		    	<c:if test = "${empty sessionScope.Userid}">
		    		<a href = "/shoppingmall/findId" class = "btn amado-btn">아이디 찾기</a><br><br>
		    	</c:if> 
		    	<c:if test = "${empty sessionScope.Userid}">
		    		<a href = "/shoppingmall/findPassword" class = "btn amado-btn">비밀번호 찾기</a>
		    	</c:if>
		    	<c:if test = "${not empty sessionScope.Userid}">
		    	<div class = "jumbotron" align = "center" style = "width : 160px;">
              	   <span>안녕하세요 <span style = "font-weight:bold;">${sessionScope.Userid}</span>님!</span><br>
              	   <span>오늘도 즐거운 쇼핑하세요!</span>
              	   <br>
			    </div>
				 <div>
					<a href = "/shoppingmall/updatePasswordForm" class = "btn amado-btn">비밀번호 변경</a>
			     </div>
			 	 <div>
			 	 	<br>
					<button onclick = "makecoupon('${sessionScope.Userid}')" class = "btn amado-btn">쿠폰 받기</button>
			     </div>
			    </c:if>
            </div>
            <!-- Amado Nav -->
            <nav class="amado-nav">
                <ul>
                    <li><a href="/shoppingmall/home">홈페이지</a></li>
                    <li><a href="/shoppingmall/shop">상품</a></li>
                   <c:if test = "${not empty sessionScope.Userid }">
                   <li class="nav-item">
                       <a class="nav-link" href="/shoppingmall/showbasket">장바구니</a>
                   </li>
                   </c:if>
                    <c:if test = "${not empty sessionScope.Userid }">
								<li class = "active"><a href="/shoppingmall/showorder">주문 정보</a></li>
					</c:if>
					<c:if test = "${sessionScope.Userid eq 'admin'}">
						<li><a href="/shoppingmall/admin/adminrefund">고객 환불</a>
					</c:if>
					<c:if test = "${sessionScope.Userid eq 'admin'}">
						<li><a href="/shoppingmall/admin/registerForm">상품 등록</a>
					</c:if>
					<li><a href="/shoppingmall/resources/jsp/introduce.jsp">회사 소개</a></li>
					<li><a href="/shoppingmall/resources/jsp/question.jsp">자주 묻는 질문</a></li>
                    <c:if test = "${not empty sessionScope.Userid}">
                    	<li><a href="/shoppingmall/logout">로그아웃</a></li>
                    </c:if>
                </ul>
            </nav>
            <!-- Cart Menu -->
            <div class="cart-fav-search mb-100">
             <c:if test = "${not empty sessionScope.Userid}">
                <a href="/shoppingmall/showbasket" class="cart-nav"><img src="/shoppingmall/resources/img/core-img/cart.png" alt="">장바구니 </a>
             </c:if>
                <a href="#" class="search-nav"><img src="/shoppingmall/resources/img/core-img/search.png" alt="">상품 검색</a>
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
                     	<li><a href = "/shoppingmall/shop">소설</a></li>
                        <li><a href = "/shoppingmall/shop?bigclass=economy&subclass=managementgeneral">경영/경제</a></li>
                    	<li><a href = "/shoppingmall/shop?bigclass=humanity&subclass=psychology">인문</a></li>
                    	<li><a href = "/shoppingmall/shop?bigclass=religion&subclass=christianity">종교</a></li>
                    	<li><a href = "/shoppingmall/shop?bigclass=science&subclass=sciencetheory">과학</a></li>
                    	<li><a href = "/shoppingmall/shop?bigclass=politics&subclass=politics">정치/사회</a></li>
                    	<li><a href = "/shoppingmall/shop?bigclass=computer&subclass=computerengineering">컴퓨터/IT</a></li>
                    	<li><a href = "/shoppingmall/shop?bigclass=children&subclass=literature">어린이</a></li>
                        <li><a href = "/shoppingmall/shop?bigclass=textbook&subclass=EBS">교과서</a></li>
                    	<li><a href = "/shoppingmall/shop?bigclass=cook&subclass=cooknormal">요리</a></li>
                    	<li><a href = "/shoppingmall/shop?bigclass=foreign&subclass=foreignnormal">외국어</a></li>
                    	<li><a href = "/shoppingmall/shop?bigclass=cartoon&subclass=culturecartoon">만화</a></li>
                    	<li><a href = "/shoppingmall/shop?bigclass=magazine&subclass=fashion">잡지</a></li>
                    </ul>
                </div>
            </div>
          </div>
		  
          
          <div class="amado_product_area section-padding-100">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="product-topbar d-xl-flex align-items-end justify-content-between">

                        </div>
                    </div>
                </div>
            </div>
          </div>
        </div>
        <!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
    <script src="/shoppingmall/resources/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="/shoppingmall/resources/js/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="/shoppingmall/resources/js/bootstrap.min.js"></script>
    <!-- Plugins js -->
    <script src="/shoppingmall/resources/js/plugins.js"></script>
    <!-- Active js -->
    <script src="/shoppingmall/resources/js/active.js"></script>
    <script>
	function makecoupon(Id)
	{
		$.ajax({
			url : "/shoppingmall/makecoupon",
			data : {"Id" : Id},
			method : "POST",
			success : function(data){
				if(data == 0)
				{
					alert('받을 수 있는 쿠폰이 없습니다.');
				}
				else if(data == 1)
				{
					alert('쿠폰을 모두 받으셨습니다.');
				}
			},
			error : function(err){
				alert("에러 발생");
			}
		});
	}
    </script>
    <script>
    $(function(){
		$('#main_product_slide').slick({
			  pauseOnHover:true,
			  autoplay: true,
			  autoplaySpeed:3500,
			  arrows: true,
			  dots: true,
			  infinite: true,
			  speed: 300,
			  slidesToShow: 1,
			  slidesToScroll: 1,
			   responsive: [
					 	 {
					      breakpoint: 500,
					      settings: {
					    	  arrows: false					        
					      }
					    }
				]					 	 
		});
					
		$('.range-product-slider__scrollable').slick({
			  pauseOnHover:true,
			  autoplay: true,
			  autoplaySpeed:3500,
			  arrows: true,
			  dots: false,
			  infinite: true,
			  speed: 300,
			  slidesToShow: 4,
			  slidesToScroll: 4,	
			  
			  responsive: [
				 	 {
				      breakpoint: 1710,
				      settings: {
				        slidesToShow: 3,
				        slidesToScroll: 3,
				        infinite: true,
				        dots: false,
				        
				      }
				    },
			  
				  {
				      breakpoint: 1454,
				      settings: {
				        slidesToShow: 2,
				        slidesToScroll: 2,
				        infinite: true,
				        dots: false,
				        
				      }
				    },
		
				  {
				      breakpoint: 1124,
				      settings: {
				        slidesToShow: 1,
				        slidesToScroll: 1,
				        infinite: true,
				        dots: false,
				        
				      }
				    },
			 	
			   {
			      breakpoint: 1024,
			      settings: {
			        slidesToShow: 1,
			        slidesToScroll: 1,
			        infinite: true,
			        dots: false,
			        
			      }
			    },
			    
			    {
			         breakpoint: 991,
			         settings: {
			           slidesToShow: 1,
			           slidesToScroll: 1
			         }
			     },
			    
			       {
			         breakpoint: 758,
			         settings: {
			           slidesToShow: 2,
			           slidesToScroll: 2
			         }
			       },				     
			       {
			         breakpoint: 700,
			         settings: {
			           slidesToShow: 2,
			           slidesToScroll: 2
			         }
			       },
			     
			     {
			      breakpoint: 600,
			      settings: {
			        slidesToShow: 2,
			        slidesToScroll: 2
			      }
			    },
			 
			    {
			      breakpoint: 480,
			      settings: {
			        slidesToShow: 1,
			        slidesToScroll: 1
			      }
			    }
			    ,
			    
		     
			]
		
		});
		
});	
    </script>
</body>
</html>