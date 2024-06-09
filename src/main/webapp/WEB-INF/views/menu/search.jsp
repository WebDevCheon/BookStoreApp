<%@ page import = "java.util.*,spring.myapp.shoppingmall.dto.Goods" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String kind = null;
	if(request.getAttribute("list") != null){
	List<Goods> list = (List<Goods>)request.getAttribute("list");
	if(list.size() != 0)
		kind = list.get(0).getKind();
	else 
		kind = (String)request.getAttribute("kind");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 결과</title>
<meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>검색 결과</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
    <link rel="icon" href="img/core-img/favicon.ico">
	<link href="${pageContext.request.contextPath}/resources/fontawesome/css/all.css" rel="stylesheet">
</head>
<body>
	<jsp:include page = "../common/common.jsp" flush = "true"/>	 
		
	<h3 style = "text-align:center;">도서 검색 조회 결과</h3>
		<div class = "container" style = "margin-top : 20px;">
         <div class = "row">
	          <c:if test = "${not empty list}">
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
                                    <p class="product-price"><span style = "color:black;">￦</span> ${dto.price}</p>
                                    <a href="${pageContext.request.contextPath}/product?goods_id=${dto.id}&bookname=${dto.name}&mode='getreviewhelp'">
                                        <h5>${dto.name}</h5>
                                        <p><span style = "color:gray;">${dto.wcompany}</span></p>
										<c:if test = "${not empty dto.writer}">
											<span style = "color:gray;">${dto.writer}</span>
										</c:if>
										<br>
										<span style = "color:gray;">${dto.width} * ${dto.height} mm</span>
                                    </a>
                                </div>
                                <!-- Ratings & Cart -->
                                <div class="ratings-cart text-center">
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
		 </c:if>
		 
		 <c:if test = "${empty list}">
		 	<div class = "container" style = "margin:60px; text-align:center;">
             	<span style = "font-weight:bold;">검색 결과 정보가 없습니다.</span>
            </div>
		 </c:if>
	    </div>
				<div class = "row">
                    <div class="col-12">
                        <nav aria-label="navigation">
                            <ul class="pagination justify-content-end mt-50">
    							<c:if test="${ curPageNum > 5 }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/search?page=1&kind=<%=kind%>&search=${search}&subejct=${subject}">◀◀</a></li>
        						</c:if>
        
        						<c:if test="${ curPageNum > 5 }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/search?page=${ blockStartNum - 1 }&search=${search}&subject=${subject}">◀</a></li>
        						</c:if>
        
        						<c:forEach var="i" begin="${ blockStartNum }" end="${ blockLastNum }">
            						<c:choose>
            							<c:when test="${ i > lastPageNum }">
            								
            							</c:when>
                						<c:when test="${ i == curPageNum }">
                    						<li class="page-item active" style = "color:black;"><a class = "page-link">${ i }</a></li>
                						</c:when>
                						<c:otherwise>																								
                    						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/search?page=${ i }&search=${search}&subject=${subject}">${ i }</a></li>
                						</c:otherwise>
            						</c:choose>
            						&nbsp;&nbsp;
        						</c:forEach>
        						<c:if test="${ lastPageNum > blockLastNum }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/search?page=${ blockLastNum + 1 }&search=${search}&subject=${subject}">▶</a></li>
        						</c:if>
        						<c:if test = "${lastPageNum > 5}">
        							<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/search?page=${lastPageNum}&search=${search}&subject=${subject}">▶▶</a></li>
        						</c:if>
    						</ul>
                        </nav>
                   </div>
                  </div>
                 </div>
</body>
</html>