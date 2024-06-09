<%@ page import = "java.util.*,spring.myapp.shoppingmall.dto.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>     
<%
		List<Goods> list = (List<Goods>)request.getAttribute("list");
		String kind = null;
		int CartSize=0;
		if(list!=null && list.size() >0){
			CartSize = list.size();	
			kind = (String)request.getAttribute("kind");	
			kind = list.get(0).getKind();
		}
		List<Monthbook> monthbooklist = (ArrayList<Monthbook>)request.getAttribute("monthlist");
		int monthbooklistsize = monthbooklist.size();
		List<Integer> monthbookqty = new ArrayList<Integer>();
		if(monthbooklistsize >= 6){
			for(int i=0;i<monthbooklistsize;i++)
				monthbookqty.add(monthbooklist.get(i).getGoods_id().getId());
		}
%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="../common/head.jsp"%>
	<title>추천 상품</title>
	<link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
</head>

<body>
    <!-- 검색  : Search Wrapper Area Start -->
   <%@ include file="../common/search_wrapper.jsp" %>
    <!-- // 검색  : Search Wrapper Area Start -->

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

        <!--  1차메뉴 :  로그인/회원가입/아이디 찾기/ 비밀번호 찾기  -->
        <c:import url = "../common/first_menu.jsp"></c:import>
        <!-- // 1차메뉴 끝 :  로그인/회원가입/아이디 찾기/ 비밀번호 찾기-->
		<!--  2~3 차메뉴  -->
        <div class="shop_sidebar_area">
        	<c:import url="../common/second_menu.jsp"></c:import>
        </div>
 		<!-- // 2~3 차메뉴 끝 -->

        <div class="amado_product_area section-padding-100">
            <div class="container-fluid">
 		<!-- breadcrumb 웹사이트 위치 -->
		<%@ include file="../common/breadcrumb.jsp" %>
                <div class="row">
                    <div class="col-12" id="main_product_slide">
                        <div class="text-center">                            
							<a href="${pageContext.request.contextPath}/product?goods_id=30&bookname=녹나무의 파수꾼&mode='getreviewhelp'"><img src="${pageContext.request.contextPath}/goodsimgUpload/64019819-4d6f-462b-9c93-192f2b84d9b5book2.jpg" ></a>
		                    <div class="main_sldie_text_area">
										<div class="main_sldie_caption">
											<p class="main_sldie_caption-paragraph">													
 <strong><span class="product-inspirational-price"><small>정가 : 500원</small> | 판매가 : <span class="product_price">500원</span>| <small>[10%↓ 1,150원 할인]</small></span></strong> 
											</p>
										</div>
										<div class="main_sldie_text_link-area">
											<h2 class="main_sldie_title">
												 녹나무의 파수꾼 
											</h2>
											<div class="carousel__link"> 
												<span class="button-link__link-text">하가시노게이고 지음</span> 
												<span class="sub_author">출판사 : 소미미디어</span>
											</div>
										</div>
							</div> 
                        </div>
                        
                        <div class="text-center">                            
							<a href="${pageContext.request.contextPath}/product?goods_id=34&bookname=후가는 유가&mode='getreviewhelp'"><img src="${pageContext.request.contextPath}/goodsimgUpload/8fc56f71-fc87-4250-87e0-5f7beba8ae38book6.jpg" ></a>
		                    <div class="main_sldie_text_area">
										<div class="main_sldie_caption">
											<p class="main_sldie_caption-paragraph">													
	<strong><span class="product-inspirational-price"><small>정가 : 600원</small> | 판매가 : <span class="product_price">600원</span>| <small>[10%↓ 1,350원 할인]</small></span></strong>
											</p>
										</div>
										<div class="main_sldie_text_link-area">
											<h2 class="main_sldie_title">
												 후가는 유가
											</h2>
											<div class="carousel__link"> 
												<span class="button-link__link-text">이사카 고타로 저</span> 
												<span class="sub_author">출판사 : 현대문학</span>
											</div>
										</div>
							</div> 
                        </div>
                        <!--  
                        <div class="text-center">                            
							<a href="product.html"><img src="${pageContext.request.contextPath}/goodsimgUpload/04db44fb-5b6a-4c97-9a56-e056d031a75ebook6.jpg" ></a>
		                    <div class="main_sldie_text_area">
										<div class="main_sldie_caption">
											<p class="main_sldie_caption-paragraph">													
	<strong><span class="product-inspirational-price"><small>정가 : 11,500원</small> | 판매가 : <span class="product_price">15,220원</span>| <small>[10%↓ 1,350원 할인]</small></span></strong>
											</p>
										</div>
										<div class="main_sldie_text_link-area">
											
											<h2 class="main_sldie_title">
												 작은 아씨들 
											</h2>
											
											<div class="carousel__link"> 
												<span class="button-link__link-text">루이자 메이 올콧 저 | 강미경 역</span> 
												<span class="sub_author">출판사 : 알에이치코리아(RHK) </span>
											</div>
										</div>
							</div> 
                        </div>
                        -->
                    </div>      
                </div>
                
			<div class="maring50"></div>		
				<!-- 이달의 인기 서적 -->
				 <div class="row">
				 <div class="col-12 ">		
				 	 <hr class="product-pip__line">				 
					 <h3 class="range-product-recommendations__heading">이달의 인기 서적</h3>
				 </div>			 
				<div class="col-12">
				
				<!-- ////      이달의 인기 서적 -->
				<% if(monthbooklistsize < 6) {%>
					<h3 style = "text-align:center;">이달의 인기 서적을 준비중입니다.</h3>
					<br>
					<h3 style = "text-align:center;">잠시만 기다려 주시기 바랍니다.</h3>
				<% } %>
				
					<div class="popular_books_of_theMonth" >
						<div class="range-product-slider">
							<div class="range-product-slider__inner">
								<div class="range-product-slider__scrollable" >
						<% if(monthbooklistsize >= 6) { int i = 0;%>
								<c:if test = "${not empty monthlist}">
								 <c:forEach items = "${monthlist}" var = "dto">
									<div class="range-product-slider__slide">
										<div class="product-compact">
											<div class="product-compact__spacer">
												<a href="${pageContext.request.contextPath}/product?goods_id=<%=monthbookqty.get(i) %>&bookname=${dto.name}&mode='getreviewhelp'">
													<div class="product-compact__image-container">
														<div class="product-compact__image">
															<div class="range-image-claim-height">
																<img src="${dto.goodsprofile}"	alt="더 해밍" class="img-responsive" />
															</div>
														</div>
													</div>
												</a>	
												<a href="${pageContext.request.contextPath}/product?goods_id=<%=monthbookqty.get(i) %>&bookname=${dto.name}&mode='getreviewhelp'"> 
													<span class="product-compact__name margin20">${dto.name}</span> 
													<span class="product-compact__type margin20"> ${dto.cover}, <span class="product-compact__description">${dto.width} x ${dto.height}cm</span></span> 												
													<span class="product-compact__price margin20"><span class="product-compact__price__value">￦ ${dto.price}</span></span> 											    
										 		    <span class="product-compact__ratings margin20">
												          <span class="product-compact__ratings-container">
												            <span class="product-compact__ratings-bg--color" style="width: 50%"></span>
												            <span class="product-compact__ratings-bg--stars"></span>
												          <!-- </span><span class="product-compact__ratings-value">${dto.recommend}</span><span class="product-compact__ratings-count">(5)</span>-->
                                       				
                                       <c:if test = "${dto.recommend < 20}">
                                        <c:forEach begin = "1" end = "1">
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                      <c:if test = "${dto.recommend >= 20 and dto.recommend < 40}">
                                      	<c:forEach begin = "1" end = "2">
                                        	<i class="fa fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                      <c:if test = "${dto.recommend >= 40 and dto.recommend < 60}">
                                      	<c:forEach begin = "1" end = "3">
                                        	<i class="fa fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                      <c:if test = "${dto.recommend >= 60 and dto.recommend < 80}">
                                      	<c:forEach begin = "1" end = "4">
                                        	<i class="fa fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                      <c:if test = "${dto.recommend >= 80}">
                                      	<c:forEach begin = "1" end = "5">
                                        	<i class="fa fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                    </div>
                                    <div class="cart">
                                        <a href="${pageContext.request.contextPath}/shoppingbasket?goods_id=<%=monthbookqty.get(i) %>" data-toggle="tooltip" data-placement="left" title="Add to Cart"></a>
                                					<% i++; %> 
                                					</span>
												   </span>										
												</a>										
											</div>
										</div>
									</div>
									</c:forEach>
								</c:if>
						<% } %>
				</div>
			 </div>
				<div class="maring50"></div>	
			
				<!-- 오늘의  서적 -->
				 <div class="row" id="todayBook_row">
				 <div class="col-12">		
				 	 <hr class="product-pip__line">				 
					 <h3 class="range-product-recommendations__heading">오늘의  서적</h3>
				 </div>			 
			<c:if test = "${not empty todaybook}">
				<div class="col-12 text-center">				
							<div class="row">
								<div class="col-2"></div>
								<div class="col-8">
								<img src="${todaybook.goodsprofile}" alt="이미지 에러" class="img-responsive img-thumbnail center-block" />
								</div>
							</div>
					
					
  			<div id="infoset_introduce" class="gd_infoSet">
    			<div class="tm_infoSet">
    				<h1 class="tit_txt">${todaybook.name}</h1>
    			</div>
    			<div class="tm_infoSet">
					<h3 class="tit_txt">평점</h3>
						<div class="ratings">
                            <c:if test = "${todaybook.recommend < 20}">
                                   <c:forEach begin = "1" end = "1">
                                      <i class="fa fa-star" aria-hidden="true"></i>
                                   </c:forEach>
                            </c:if>
                                   <c:if test = "${todaybook.recommend >= 20 and todaybook.recommend < 40}">
                                      	<c:forEach begin = "1" end = "2">
                                        	<i class="fa fa-star" aria-hidden="true"></i>
                                        </c:forEach>
                                   </c:if>
                                        <c:if test = "${todaybook.recommend >= 40 and todaybook.recommend < 60}">
                                      	   <c:forEach begin = "1" end = "3">
                                        	  <i class="fa fa-star" aria-hidden="true"></i>
                                           </c:forEach>
                                         </c:if>
                                      <c:if test = "${todaybook.recommend >= 60 and todaybook.recommend < 80}">
                                      	<c:forEach begin = "1" end = "4">
                                        	<i class="fa fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                      <c:if test = "${todaybook.recommend >= 80}">
                                      	<c:forEach begin = "1" end = "5">
                                        	<i class="fa fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                      </div>
                  <h3 class="tit_txt">페이지</h3>
                  	<div class="ratings">
                  		${todaybook.page}
                  	</div>
                  <h3 class="tit_txt">크기</h3>
                  	<div class="ratings">
                  		${todaybook.width} * ${todaybook.height} mm
                  	</div>
                  <h3 class="tit_txt">작가</h3>
                  	<div class="ratings">
                  		${todaybook.writer}
                  	</div>
    </div>
    <div class="infoSetCont_wrap">
            <table class="wrapTb">
                <tbody>
                    <tr>
                        <td>
                            <div class="infoWrap_txt">
                                <div class="infoWrap_txtInner">
                                    <h4 style = "text-align:center">책소개</h4>
                                    	${todaybook.summary}
                            	</div>
                            </div>
                            <div class="infoWrap_txt">
                                <div class="infoWrap_txtInner">
                                    <h4 style = "text-align:center">책내용</h4>
                                    	${todaybook.goodscontent}
                            	</div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
	</div>
  </div>							
			</div>
		</c:if>
		
		<c:if test = "${empty todaybook}">
			<div class="col-12 text-center">				
							<div class="row">
								<div class="col-2"></div>
								<div class="col-8">
									<h3 style = "text-align:center">현재 오늘의 서적을 준비중입니다.</h3>
								</div>
							</div>
			</div>
		</c:if>
		</div>					
        </div>
      </div>    
  </div>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery/jquery-2.2.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/active.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/slick.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/menu.js"></script>
 
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