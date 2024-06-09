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
    <title>책 상세보기 : ${good.name}</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
	<link href="${pageContext.request.contextPath}/resources/fontawesome/css/all.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontawesome/css/all.css">
    <link  rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/review-style.css" />
	<style>
	@media(max-width:768px){
    	 #review_temp {
    		zoom : 30%;
    	}
    	 #addreview {
    	 	zoom : 50%;
    	 }
    }
    
[contenteditable=true]:empty:before {
  content: attr(placeholder);
  display: block; /* For Firefox */
}
 
div[contenteditable=true] {
  border: 1px solid #ddd;
  color : gray;
  font-size: 12px;
  width: 300px;
  padding: 5px;
}
.product-breadcrumb nav{
	float: right;
	margin-bottom: 50px;
}

.breadcrumb .breadcrumb-item a i, .main-content-wrapper .single-product-area .breadcrumb .breadcrumb-item a, .main-content-wrapper .single-product-area .breadcrumb .breadcrumb-item{
	font-size: 1.1rem !important;
}
	</style>
    </head>
<body>
    <jsp:include page = "../common/search_wrapper.jsp"/>
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
		    	<div class = "jumbotron" align = "center">
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
                    <li class = "active"><a href="${pageContext.request.contextPath}/shop">상품</a></li>
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
    						<input type="hidden" name="${_csrf.parameterName}" id = "csrftoken" value="${_csrf.token}"/>
						</form>
                    </c:if>
                </ul>
            </nav>

            <div class="cart-fav-search mb-100">
                <a href="${pageContext.request.contextPath}/showbasket" class="cart-nav"><img src="${pageContext.request.contextPath}/resources/img/core-img/cart.png" alt="">장바구니</a>
                <a href="#" class="search-nav"><img src="${pageContext.request.contextPath}/resources/img/core-img/search.png" alt="">상품 검색</a>
            </div>

            <div class="social-info d-flex justify-content-between">
                <a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            </div>
        </header>

 	<!-- 바꾼 부분 -->

        <!-- Header Area End -->
        <!-- Product Details Area Start -->
        <div class="single-product-area section-padding-100 clearfix">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12 product-breadcrumb">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mt-50">
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/"><i class="nav-icon fa fa-home"></i></a></li>                                 
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/shop?bigclass=${good.bigclass}&subclass=${good.subclass}">${good.kind}</a></li>
                                <li class="breadcrumb-item"><a href="#">${good.name}</a></li>
                            </ol>
                        </nav>
                    </div>
                </div>

                <div class="row">
                	<div class="col-lg-1"></div>
                    <div class="col-lg-6">
                        <div class="single_product_thumb">
                            <div id="product_details_slider" class="carousel slide" data-ride="carousel">
                                <div class="carousel-inner">
                               <!-- 
                                <ol class="carousel-indicators">
                                    <li class="active" data-target="#product_details_slider" data-slide-to="0" style="background-image: url(${good.goodsprofile});">
                                    </li>
                                    <li data-target="#product_details_slider" data-slide-to="1" style="background-image: url(/shoppingmall/resources/img/product-img/pro-big-2.jpg);">
                                    </li>
                                    <li data-target="#product_details_slider" data-slide-to="2" style="background-image: url(/shoppingmall/resources/img/product-img/pro-big-3.jpg);">
                                    </li>
                                    <li data-target="#product_details_slider" data-slide-to="3" style="background-image: url(/shoppingmall/resources/img/product-img/pro-big-4.jpg);">
                                    </li>
                                </ol>
                            	-->
                                    <div class="carousel-item active">
                                        <a class="gallery_img" href="${good.goodsprofile}">
                                            <img class="d-block w-100" src="${good.goodsprofile}" alt="First slide" style = "width:300px;height:935px">
                                        </a>
                                    </div>
                                    <!-- 
                                    <div class="carousel-item">
                                        <a class="gallery_img" href="/shoppingmall/resources/img/product-img/pro-big-2.jpg">
                                            <img class="d-block w-100" src="/shoppingmall/resources/img/product-img/pro-big-2.jpg" alt="Second slide">
                                        </a>
                                    </div>
                                    <div class="carousel-item">
                                        <a class="gallery_img" href="/shoppingmall/resources/img/product-img/pro-big-3.jpg">
                                            <img class="d-block w-100" src="/shoppingmall/resources/img/product-img/pro-big-3.jpg" alt="Third slide">
                                        </a>
                                    </div>
                                    <div class="carousel-item">
                                        <a class="gallery_img" href="/shoppingmall/resources/img/product-img/pro-big-4.jpg">
                                            <img class="d-block w-100" src="/shoppingmall/resources/img/product-img/pro-big-4.jpg" alt="Fourth slide">
                                        </a>
                                    </div>
                                     -->
                                </div>
                            </div>
                        </div>
                    </div>

                <div class="col-lg-2"></div>
                    <div class="col-lg-3">
                        <div class="single_product_desc">
                            <div class="product-meta-data">
                                <div class = "line"></div>
                                <p class="product-price">${good.price}원</p>
                                <a style = "font-size:30px">
                                    ${good.name}
                                </a>
                              <c:if test = "${good.remain ne 0}">
                                <p class="avaibility" style="line-height: 2"><i class="fa fa-circle"></i><span style = "font-weight:bold;font-size:20px;">재고 : ${good.remain}</span></p>
                              </c:if>
                              <c:if test = "${good.remain eq 0}">
                              	<p>재고 없음 : ${good.remain}</p>
                              </c:if>
                            </div>
                            	<c:if test = "${good.kind eq 'book'}">
               	  					<div class="short_overview my-5">
                        				<h4>전체 쪽수</h4>
                        				<p>${good.page}&nbsp;쪽</p>
                  					</div>	
               					</c:if>
               					
               					<div class="ratings-review mb-15 d-flex align-items-center justify-content-between">
                                    <div class="ratings">
                                        <h4>추천</h4>
                                      <c:if test = "${good.recommend < 20}">
                                        <c:forEach begin = "1" end = "1">
                                        	<i class="fa fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                      <c:if test = "${good.recommend >= 20 and good.recommend < 40}">
                                       <c:forEach begin = "1" end = "2">
                                        	<i class="fa fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                      <c:if test = "${good.recommend >= 40 and good.recommend < 60}">
                                      	<c:forEach begin = "1" end = "3">
                                        	<i class="fa fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                      <c:if test = "${good.recommend >= 60 and good.recommend < 80}">
                                      	<c:forEach begin = "1" end = "4">
                                        	<i class="fa fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                      <c:if test = "${good.recommend >= 80 and good.recommend < 100}">
                                      	<c:forEach begin = "1" end = "5">
                                        	<i class="fa fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                      <c:if test = "${good.recommend >= 100}">
                                      	<c:forEach begin = "1" end = "6">
                                        	<i class="fa fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                    </div>
                                   </div>
							<!--               				
               				<c:if test = "${not empty good.tcontent}">
							<div class="short_overview my-5">
                            	<h4>목차</h4>
                                <p>${good.tcontent}</p>
                            </div>
                            </c:if>
							-->               				
							<c:if test = "${not empty good.writer}">
							<div class="short_overview my-5">
                            	<h4>저자</h4>
                                <p>${good.writer}</p>
                            </div>
                            </c:if>
							<c:if test = "${not empty good.wcompany}">
							<div class="short_overview my-5">
                            	<h4>출판사</h4>
                                <p>${good.wcompany}</p>
                            </div>
                            </c:if>
                            
                            <c:if test = "${good.kind eq 'shoes'}">
                            <div class="short_overview my-5">
                            	<h4>성별</h4>
                              	<p>
                              		<select name="sex" style = "padding-bottom:3px;">
                              			<option value="man">남자</option>
                              			<option value="woman">여자</option>
                              		</select>
								</p>
                            </div>
                            <br>
                            </c:if>
                                <div class="cart-btn d-flex mb-50" style = "text-align:left;">
                                <input type="hidden" name="remain" id="remain" value="${good.remain}">
                                <c:if test = "${good.remain ne 0}">
                                    <p>주문량</p>
                                    <div class="quantity" style="margin-left: 50px">
                                        <span class="qty-minus" onclick="minusfunc()"><i style = "cursor:pointer;" class="fa fa-minus-circle" aria-hidden="true"></i></span>
                                        <input type="text" class="qty-text form-control" id="qty" step="1" min="1" max="300" name="quantity" value="1" style = "display:inline;width:70px; text-align: right;">
                                        <span class="qty-plus" onclick="plusfunc(${good.remain})"><i style = "cursor:pointer;" class="fa fa-plus-circle" aria-hidden="true"></i></span>
                                    	<input type = "hidden" name = "qty" id = "hqty">
                                    	<input type = "hidden" name = "goods_id" value = "${good.id}">
                                    	<input type = "hidden" name = "price" value = "${good.price}">
                                    	<input type = "hidden" name = "name" value = "${good.name}">
                                    	<input type = "hidden" name = "check" value = "cartcheck">
                                    </div>
                                </c:if>
                                </div>
                               
                                <c:if test = "${good.remain ne 0 and not empty sessionScope.Userid}">
                                	<button type="submit" style = "width:300px;height:90px;"name="addtocart" value="5" class="customButton" onclick = "cart('${good.id}','${good.price}','${good.name}',document.getElementById('qty').value,'${sessionScope.Userid}','${good.goodsprofile}',${good.remain})">주문하기</button>
                                	<br><br>
                                																											
                                </c:if>
                          
                          		<c:if test = "${good.remain ne 0 and not empty sessionScope.Userid }">
                             		<button class = "customButton" style = "width:300px;height:90px;" onclick = "shoppingbasket('${sessionScope.Userid}',${good.remain},${good.id},${good.price},'${good.name}',document.getElementById('qty').value,'${good.goodsprofile}')">장바구니</button>
                          		</c:if>
                          		<br>
                          		<br>
                        </div>
                    </div>
                </div>
                
                <!--------------------------------------- 코드 작성 --------------------------------------------->
                <!--  
                <div class = "row">
                	<div class = "col-12 col-lg-7">
                		<div class = "container">
                			<div style = "text-align:left;display:inline;">
                				<a href = "#" class = "btn amado-btn">좋아요</a>&nbsp;&nbsp;&nbsp;&nbsp;
							 <span style = "margin-left:400px;">
								<a href = "#" class = "btn amado-btn">싫어요</a>
							 </span>
							</div>
                		</div>
                	</div>
                </div>
                -->
                  
               	  <div class="row" style = "margin-top:30px;">
               	  	<div class="col-12">
               	  	<c:if test = "${good.kind eq 'book' and not empty good.goodscontent}">
                        <h4>책소개</h4>
                    </c:if>
                    <c:if test = "${good.kind != 'book' and not empty good.goodscontent}">
                    	<h4>제품 소개</h4>
                    </c:if>
                        <p>${good.goodscontent}</p>
                        </div>
                  </div>	
               	
               	<c:if test = "${good.kind eq 'book' and not empty good.writerintroduction}">               	
               	  <div class="row" style = "margin-top:30px;">
               	  	<div class="col-12">	
                        <h4>저자소개</h4>
                        <p>${good.writerintroduction}</p>
                     </div>
                  </div>	
               	</c:if>
               	
               	<c:if test = "${good.kind eq 'book' and not empty good.review}">
               	  <div class="row" style = "margin-top:30px;">
               	   <div class="col-12">
                        <h4>출판사 서평</h4>
                        <p>${good.review}</p>
                    </div>
                  </div>	
               	</c:if>
             	
             	<c:if test = "${good.kind eq 'book' and not empty good.summary}">
               	  <div class="row" style = "margin-top:30px;">
               	    <div class="col-12">
                        <h4>줄거리</h4>
                        <p>${good.summary}</p>
					</div>                       
                  </div>	
               	</c:if>
               	
               	<c:if test = "${good.kind eq 'book' and not empty good.tcontent}">
                  <div class="row" style = "margin-top:30px;">
                  	<div class="col-12">
                        <h4>목차</h4>
                        <p>${good.tcontent}</p>
                    </div>
                  </div>
                </c:if>
                 <div class="row" style = "margin-top:30px; margin-bottom: 30px;">
                   <div class="col-12 text-center">
						<h4>추천하기</h4>
                			<p style = "margin-left:30px;">
                				<a onclick = "productrecommend(${good.id},'${good.name}')"><i style="font-size:30px; cursor: pointer;" class="far fa-thumbs-up"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;
							</p>
				 </div>
                 </div>
        			<!-- 평점/리뷰 -->
        	<div id = "review_temp">
        		<%@ include file="review_temp.jsp" %> <!-- 이 부분이 product.jsp 아래에 있는 창 -->
            </div>
              <!--------------------------------------- 코드 작성 --------------------------------------------->  
            </div>
        </div>
        <!-- Product Details Area End -->
    </div>
	
 
	<!-- 평가 리뷰 쓰기 등록 레이어 -->
    <div class="klover-dim-layer">
    <div class="klover-dimBg"></div>    
    <div id="klover-layer" class="pop-layer" >
        <div class="pop-container">
            <div class="pop-conts">
                <!--content //-->
                <p class="ctxt mb20">
 <form action=""  id="reviewForm" method="post" enctype="multipart/form-data">    
          <div id="popup_klover" style="width:450px;">
    <!-- popup_wrap -->
    <div class="popup_wrap">
        <!-- title -->
        <div class="tit02">
            <h1 class="title_h_cartlist">평점/리뷰 등록</h1>
        </div>
        <!-- // title -->
        <!-- popup_container -->
        <div class="popup_container3">
            <div class="klover_wrap">
					<span id="bookNm">
                		<h2><strong>${good.name}</strong></h2>
                	</span>
                <div class="section_klover">
                    <h3><strong>평점</strong> - 이 책에 대한 당신의 마음을 남겨주세요.</h3>            
                    <dl class="review_rating">
                        <dt>컨텐츠평가</dt>
                        <dd>
                            <div class="ratingSection2">
                                	<div class="mask star0">4점 만점에</div>
                                	<a href="#" class="mark mark0" onclick = "document.getElementById('reviewRating').value = 0">0점</a>
                                	<a href="#" class="mark mark1" onclick = "document.getElementById('reviewRating').value = 1">1점</a>
                                	<a href="#" class="mark mark2" onclick = "document.getElementById('reviewRating').value = 2">2점</a>
                                	<a href="#" class="mark mark3" onclick = "document.getElementById('reviewRating').value = 3">3점</a>
                                	<a href="#" class="mark mark4" onclick = "document.getElementById('reviewRating').value = 4">4점</a>
                                	<span class="number number4"></span>
                                	<input type="hidden" name="rating" id="reviewRating" value = "0">
                            </div>
                        </dd>
                    </dl>
                </div>
                <div class="section_klover">
                    <h3><strong>태그</strong> - 이 책을 읽으면 기분이 어떤가요?</h3>
                    <ul class="list_impress">
                        <li class="impress01"><a href="#" onclick = "document.getElementById('feelTagRating').value = 1">좋아요</a></li>
                        <li class="impress02"><a href="#" onclick = "document.getElementById('feelTagRating').value = 2">잘읽혀요</a></li>
                        <li class="impress03"><a href="#" onclick = "document.getElementById('feelTagRating').value = 3">정독해요</a></li>
                        <li class="impress04"><a href="#" onclick = "document.getElementById('feelTagRating').value = 4">기발해요</a></li>
                        <li class="impress05"><a href="#" onclick = "document.getElementById('feelTagRating').value = 5">유용해요</a></li>
                        <li class="impress06"><a href="#" onclick = "document.getElementById('feelTagRating').value = 6">기타</a></li>
                    </ul>
                    <input type="hidden" name="feelTag" id="feelTagRating" value="0">                    
                </div>
                <div class="section_klover">
                    <h3>
                    	<strong>리뷰</strong> - 이 책을 간단히 말하면?
                    </h3>
                    <div class="write_review02">							
						<textarea name="reviewContent" id="reviewContent" onkeyup="chkword(this,1000)" placeholder="내용을 입력해주세요. 주제와 무관한 댓글, 악플, 배송문의 등의 글은 임의 삭제될 수 있습니다."></textarea>
                        <span id="id_TextBytes" class="text_size notice_reply"><strong>0</strong>/1000자</span>
                    </div>
                    <div class="upload_file_img02">
                        <dl>
                            <dt>이미지첨부</dt>
                            <div id = "loadimg">
                            
                            </div>
                            <dd class="file_name"><input name="reviewImageFile" type="file" id="reviewImageFile"></dd>
                            <input type = "hidden" id = "reviewimgurl">
                        </dl>
                        <span class="help_upload_file">(파일용량은 1MB 이하이며, 파일형식은 jpg, jpeg 파일만 업로드 가능합니다.)</span>
                    </div>
                </div>
            </div>
            
            <div class="btn_clear">
                <a class="btn_pur_01" href="#"><strong>취소</strong></a>
                <a class="btn_pur_02" href="javascript:regReview();"><strong>등록</strong></a>                
            </div>
        </div>
        <!-- // popup_container -->
    </div>
    <!-- // popup_wrap -->
    <!-- btn_layer_close -->
    <a href="#" class="close_btn3" onclick="klover_dim_layer_close()"><img src="${pageContext.request.contextPath}/resources/img/review/btn_layer_close02.gif" alt="닫기"></a>
    <!-- // btn_layer_close -->
	</div>
 </form>
                </p>
                <!--// content-->
            </div>
        </div>
    </div>
</div>

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
                                        	<a class="nav-link" href="${pageContext.request.contextPath}/showcoupon">쿠폰 내역</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${pageContext.request.contextPath}/showbasket">장바구니</a>
                                        </li>
                                        <c:if test = "${not empty sessionScope.Userid}">
											<li class = "nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/showorder">주문 정보</a></li>
										</c:if>
                                        <li class="nav-item">
                                             <c:if test ="${not empty sessionScope.Userid}">
                    							<a class = "nav-link" style = "cursor : pointer" onclick="document.getElementById('logout-form').submit();">로그아웃</a>
                								<form id="logout-form" action="<c:url value="/logout"/>" method="post">
    												<input type="hidden" name="${_csrf.parameterName}" id = "csrftoken" value="${_csrf.token}"/>
												</form>
                							</c:if>
                                        </li>
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js" integrity="sha384-FzT3vTVGXqf7wRfy8k4BiyzvbNfeYjK+frTVqZeNDFl8woCbF0CYG6g2fMEFFo/i" crossorigin="anonymous"></script>      		
    <script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/active.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/menu/product.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/review.js"></script>  
    <script>
    	var contextPath = "${pageContext.request.contextPath}";
    </script>
    <script>
  $(document).ready(function(){
	  $("#alatestseq").on('click',latestseq);
	  //$(document).on('click','#areply',latestseq);
  });
  </script>
    
   	<!-- //평점/리뷰 -->
  <script type="text/javascript">		
	function pop_klover(event,el){		
	    var $el = $(el); //레이어의 id를 $el 변수에 저장
	    $el.attr('id','addreview');
	    var isDim = $el.prev().hasClass('klover-dimBg');	//dimmed 레이어를 감지하기 위한 boolean 변수
	    isDim ? $('.klover-dim-layer').fadeIn() : $el.fadeIn();
	    var $elWidth = ~~($el.outerWidth()),
	        $elHeight = ~~($el.outerHeight()),
	        docWidth = $(document).width(),
	        docHeight = $(document).height();
	    // 화면의 중앙에 레이어를 띄운다.
	    if ($elHeight < docHeight || $elWidth < docWidth) {
	        $el.css({
	            marginTop: -$elHeight /2,
	            marginLeft: -$elWidth/2
	        })
	    } else {
	        $el.css({top: 0, left: 0});
	    }
	
	    $el.find('a.btn_pur_01').click(function(){
	    	klover_dim_layer_close();
	        return false;
	    });
	    
	    $('.pop-klover .klover-dimBg').click(function(){
	    	klover_dim_layer_close();
	        return false;
	    });
	
	    return false;
	}
	
	//평점 리뷰 등록  팝업 레이어 닫기
	function klover_dim_layer_close(){
		$('.klover-dim-layer').fadeOut();		
		//초기화
		$("#reviewRating").val(0);
		//$("#feelTagRating").val(0);
		//$("#reviewContent").val("");
		$("#reviewImageFile").val("");
		$(".mask").removeClass("star1").removeClass("star2").removeClass("star3").removeClass("star4").addClass("star0");
/* 		$(".mask").removeClass("star1");
		$(".mask").removeClass("star2");
		$(".mask").removeClass("star3");
		$(".mask").removeClass("star4");
		$(".mask").addClass("star0");	 */	
		$('.list_impress a').removeClass('on');		
	    return false;
	}
	
	$(function(){
		//네이클로버 점수 마우스 오버시
	    $('.review_rating .ratingSection2 a').bind('click mouseover',function(e){
	        e.preventDefault();
	        var idx = $(this).parent().find('a').index(this);
	        $(this).parent().find('.mask').removeClass('star0').removeClass('star1').removeClass('star2').removeClass('star3').removeClass('star4').addClass('star'+idx);
	        $(this).parent().find('span').index(this);
	        $(this).parent().find('.number').removeClass('number0').removeClass('number1').removeClass('number2').removeClass('number3').removeClass('number4').addClass('number'+idx);
	        $(this).closest('.ratingSection2').find('#reviewRating').val(idx);
	        console.log("네이클로버 : " + idx+" 개");
	    });
	    
	    //태그 선택 (이 책을 읽으면 기분이 어떤가요?)
	    $('.list_impress a').click(function(){
	    	var idx = $(this).parent().index();
	        $('.list_impress a').removeClass('on');
	        $(this).addClass('on');
	        $('#feelTagRating').val(idx+1);
	        console.log("이 책을 읽으면 기분이 어떤가요?  : " + $('#feelTagRating').val());
	    });
	});
	
	//평점 리뷰 등록
	function regReview(last) {
		var reviewRating = parseInt($("#reviewRating").val());
		var feelTagRating= parseInt($("#feelTagRating").val());		
		//var reviewContent=$("#reviewContent").val();
		if(reviewRating<=0){
			alert("평점을 선택해 주세요.");	
			return;
		}		
		
		if(feelTagRating<=0){
			alert("기분 태그를  선택해주세요.");	
			return;
		}
		
		/*
		if($.trim(reviewContent)==""){
			alert("리뷰  내용을 입력해 주세요.");
			$("#reviewContent").focus();
			return;
		}
		*/
		var attach=false;
		if($("#reviewImageFile").val() != "" ){
			var ext = $('#reviewImageFile').val().split('.').pop().toLowerCase();
		    if($.inArray(ext, ['jpg','jpeg']) == -1) {
				 alert('jpg,jpeg 파일만 업로드 할수 있습니다.');
				 $("#reviewImageFile").val("");
				 return;
		     }
		    
		    var fileSize = $("#reviewImageFile")[0].files[0].size;		    
		    var maxSize = 1 * 1024 * 1024;//1MB		 
		    
		    if(parseInt(fileSize) > maxSize){
		       alert("첨부파일 사이즈는 1MB 이내로 등록 가능합니다.");
		       $("#reviewImageFile").val("");
		       return;
		    }	
		    
		    attach=true;
		} 
		//등록 처리
		//uploadReviewFile();
		//alert("평점 :" +reviewRating  + " ,  기분 태그: "+feelTagRating + " ,  리뷰 내용 :  "+ reviewContent + " , 첨부 파일  :" + (attach==true? '있음 ':'없음') +" 로 등록 처리 되었습니다.");
		//평점 리뷰 등록  팝업 레이어 닫기
		klover_dim_layer_close();
		//alert(document.getElementById('reviewContent').value);
		//alert(document.getElementById('feelTagRating').value);
		$.ajax({
			  method : 'GET',
			  url : '${pageContext.request.contextPath}/pastreviewcheck?bookname=${good.name}',
			  success : function(data){
			  if(data == 1){
				$.ajax({
					url : "${pageContext.request.contextPath}/addreview",
					method : 'post',
					headers : {"X-CSRF-Token":csrf},
					contentType : "application/json",
					data : JSON.stringify({
						"reviewRating" : reviewRating, //평점
						"user_id" : '${sessionScope.Userid}',  //유저 아이디
						"reviewimgurl" : $("#reviewimgurl").val(),  //첨부 파일의 이미지 경로
						"bookname" : '${good.name}',  //책 이름
						"reviewContent" : document.getElementById('reviewContent').value,  //리뷰 내용
						"feelTagRating" : document.getElementById('feelTagRating').value  //태그 내용
					}),
					success : function(result){
						alert(result);
						location.reload();
					},
					error : function(){
						alert('에러 발생');	
					}
				});
			  } else {
					alert('이미 리뷰글을 작성하셨습니다.');  
					return;
				  }
			},error : function(){
					alert('에러 발생');
					return;
				 }
		});
	}
	
	function uploadReviewFile() {
		   var formData = new FormData();
	       formData.append('file',$("#reviewImageFile")[0].files[0]);
	       formData.append('reviewimgflag',1);
		   $.ajax({
			data: formData,
		  	method: 'post',
		  	headers : {"X-CSRF-Token":csrf},
		  	url: '${pageContext.request.contextPath}/upload',
		  	cache: false,
		  	contentType: false,
		  	processData: false,
		  	async : false,
		  	enctype: 'multipart/form-data',
		  	success: function(data){
		  		var obj = JSON.parse(data);
		  		$("#reviewimgurl").val(obj.url);
		  		alert("이미지 업로드 완료");
		  	},
		  	error:function(request,status,error) {
	             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	          }
		  });
    }
	window.onload = function() {
		document.getElementById("reviewImageFile").addEventListener("change",uploadReviewFile);
	}
	</script>    
  </body>
</html>