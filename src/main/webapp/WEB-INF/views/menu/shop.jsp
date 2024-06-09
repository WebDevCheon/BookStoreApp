<%@ page import = "java.util.*,spring.myapp.shoppingmall.dto.Goods" language="java" contentType="text/html; charset=UTF-8"
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
%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../common/head.jsp"%>
<title>책 목록</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
</head>
<body>
   <%@ include file="../common/search_wrapper.jsp" %>
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
       <c:import url="../common/first_menu.jsp"></c:import>

		<!--  2~3 차메뉴  -->
        <div class="shop_sidebar_area">
        	<c:import url="../common/second_menu.jsp"></c:import>
        </div>
 		<!-- // 2~3 차메뉴 끝 -->
        <div class="amado_product_area section-padding-100">
            <div class="container-fluid">
 		<!-- breadcrumb 웹사이트 위치 -->
		<%@  include file="../common/breadcrumb.jsp" %>
			 <!-- 등록된 물품이 없을 경우 -->	
            <div class="row">
             	<c:if test = "${empty list}">
             	 <div class = "container" style = "margin:60px; text-align:center;">
             		<span style = "font-weight:bold;">등록된 물품이 없습니다.</span>
             	</div>
             	</c:if>
             	
				<c:forEach items = "${list}" var = "dto">                    
                    <div class="col-12 col-sm-6 col-md-12 col-xl-6">
                        <div class="single-product-wrapper">
                            <!-- Product Image -->
                            <div class="product-img">
                                <img src="${dto.goodsprofile}" alt="" style = "height:600px;">
                                <!-- Hover Thumb -->
                            </div>

                            <!-- Product Description -->
                            <div class="product-description d-flex align-items-center justify-content-between">
                                <!-- Product Meta Data -->
                                <div class="product-meta-data">
                                    <div class="line"></div>
                                    <p class="product-price"><span style = "color:black;">￦</span>&nbsp;${dto.price}</p>
                                    <a href="${pageContext.request.contextPath}/product?goods_id=${dto.id}&bookname=${dto.name}&mode='getreviewhelp'">
                                       <h5>${dto.name}</h5>
                                        <p><span style = "color:gray;">${dto.writer}</span></p>
											<span style = "color:gray;">${dto.wcompany}</span>
											<br>
										<c:if test = "${not empty dto.cover}">
											<span style = "color:gray;">${dto.cover}</span>
											<br>
										</c:if>
											<span style = "color:gray;">${dto.width} * ${dto.height} mm</span>
                                    </a>
                                </div>
                                <!-- Ratings & Cart -->
                                <div class="ratings-cart text-right">
                                    <div class="ratings" style = "text-align:left;">
                                        <c:if test = "${dto.recommend < 20}">
                                        <c:forEach begin = "1" end = "1">
                                        <i class="fas fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                      <c:if test = "${dto.recommend >= 20 and dto.recommend < 40}">
                                      	<c:forEach begin = "1" end = "2">
                                        	<i class="fas fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                      <c:if test = "${dto.recommend >= 40 and dto.recommend < 60}">
                                      	<c:forEach begin = "1" end = "3">
                                        	<i class="fas fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                      <c:if test = "${dto.recommend >= 60 and dto.recommend < 80}">
                                      	<c:forEach begin = "1" end = "4">
                                        	<i class="fas fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                      <c:if test = "${dto.recommend >= 80}">
                                      	<c:forEach begin = "1" end = "5">
                                        	<i class="fas fa-star" aria-hidden="true"></i>
                                       </c:forEach>
                                      </c:if>
                                    </div>
                                    <div class="cart">
                                        <a href="${pageContext.request.contextPath}/shoppingbasket?goods_id=${dto.id}" data-toggle="tooltip" data-placement="left" title="Add to Cart"></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
			</c:forEach>
		</div>
			<!--  페이징 처리 -->
			<div class="row">
                    <div class="col-12">
                        <nav aria-label="navigation">
                            <ul class="pagination justify-content-end mt-50">
    							<c:if test="${ curPageNum > 5 }"> <!-- 6 -->
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/shop?page=1&kind=<%=kind%>">◀◀</a></li>
        						</c:if>
        
        						<c:if test="${ curPageNum > 5 }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/shop?page=${ blockStartNum - 1 }&kind=<%=kind%>">◀</a></li>
        						</c:if>
        
        						<c:forEach var="i" begin="${ blockStartNum }" end="${ blockLastNum }">
            						<c:choose>
            							<c:when test="${ i > lastPageNum }">
            								
            							</c:when>
                						<c:when test="${ i == curPageNum }">
                    						<li class="page-item active" style = "color:black;"><a class = "page-link">${ i }</a></li>
                						</c:when>
                						<c:otherwise>
                    						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/shop?page=${ i }&kind=<%=kind%>">${ i }</a></li>
                						</c:otherwise>
            						</c:choose>
            						&nbsp;&nbsp;
        						</c:forEach>
 
        						<c:if test="${ lastPageNum > blockLastNum }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/shop?page=${ blockLastNum + 1 }&kind=<%=kind%>">▶</a></li>
        						</c:if>
        						<c:if test = "${lastPageNum > 5}">
        							<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/shop?page=${lastPageNum}&kind=<%=kind%>">▶▶</a></li>
        						</c:if>
    						</ul>
                        </nav>
                   </div>
             </div>
        </div>
      </div>
  </div>
 <%@ include file="../common/footer.jsp" %>
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
	<script>
		var contextPath = "${pageContext.request.contextPath}";
	</script>
	<script src="${pageContext.request.contextPath}/resources/js/menu/shop.js"></script>
	</body>
</html>