<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
<title>이달의 인기 서적 채택</title>
<style>
	@media(max-width:768px){
    	 .container {
    		zoom : 70%;
    	}
    }
</style>
<%@ include file = "../common/head.jsp" %>
</head>
<body>
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
       <c:import url="../common/first_menu.jsp"></c:import>

		<!--  2~3 차메뉴  -->
        <div class="shop_sidebar_area">
        	<c:import url="../common/second_menu.jsp"></c:import>
        </div>

	<div class = "container" style = "margin-top : 80px;">
	  <div>
	  <h3 style="text-align:center;">
		<span>상품 구매 순위</span>
		<br>
	  </h3>
		<table class = "table table-bordered" style = "text-align:center;padding:100px;border-spacing:10px;margin:10px" border = "1">
			<tr>
				<th>ID</th>
				<th>책 이름</th>
				<th>가격</th>
				<th>수량</th>
				<th>구매량</th>
				<th>책 이미지</th>
				<th>이달의 인기 서적으로 채택</th>
			</tr>
		<c:forEach var = "dto" items = "${list}"> 	
			<tr>
				<td class="align-middle">${dto.id}</td>
				<td class="align-middle">${dto.name}</td>
				<td class="align-middle">${dto.price}</td>
				<td class="align-middle">${dto.remain}</td>
				<td class="align-middle">${dto.purchase}</td>
				<td class="align-middle"><img src="${dto.goodsprofile}" width = "100" height = "100"></td>
				<td style = "vertical-align:middle;"><input type = "checkbox" name = "booklist" id = "${dto.id}"></input></td>
			</tr>
		</c:forEach>
		</table>
		<br>
		<br>
		<div>		
			<button onclick = "setmonthbooklist()" class = "btn amado-btn" >이달의 인기서적으로 모두 올리기</button>
			<button onclick = "downmonthbooklist()" class = "btn amado-btn">저번 달의 인기 서적 내리기</button><br>
	  	</div>
	  </div>
	  
	  <!--  페이징 처리 -->
			<div class="row">
                    <div class="col-12">
                        <nav aria-label="navigation">
                            <ul class="pagination justify-content-end mt-50">
    							<c:if test="${ curPageNum > 10 }"> <!-- 6 -->
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/admin/monthbookselect?page=1">◀◀</a></li>
        						</c:if>
        
        						<c:if test="${ curPageNum > 10 }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/admin/monthbookselect?page=${ blockStartNum - 1 }">◀</a></li>
        						</c:if>
        
        						<c:forEach var="i" begin="${ blockStartNum }" end="${ blockLastNum }">
            						<c:choose>
            							<c:when test="${ i > lastPageNum }">
            								
            							</c:when>
                						<c:when test="${ i == curPageNum }">
                    						<li class="page-item active" style = "color:black;"><a class = "page-link">${ i }</a></li>
                						</c:when>
                						<c:otherwise>
                    						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/admin/monthbookselect?page=${ i }">${ i }</a></li>
                						</c:otherwise>
            						</c:choose>
            						&nbsp;&nbsp;
        						</c:forEach>
 
        						<c:if test="${ lastPageNum > blockLastNum }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/admin/monthbookselect?page=${ blockLastNum + 1 }">▶</a></li>
        						</c:if>
        						<c:if test = "${lastPageNum > 10}">
        							<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/admin/monthbookselect?page=${lastPageNum}">▶▶</a></li>
        						</c:if>
    						</ul>
                        </nav>
                   </div>
             </div>
	</div>
  </div>
  <input type="hidden" name="${_csrf.parameterName}" id = "csrftoken" value="${_csrf.token}"/>
	<script>
	var csrf = document.getElementById("csrftoken").value;
		function setmonthbooklist(){
			var booklist = document.getElementsByName("booklist");
			var selectedbooklist = new Array();
			var j = 0;
			for(var i=0;i<booklist.length;i++){
				if(booklist[i].checked == true){
					alert(booklist[i].id);
					selectedbooklist[j] = booklist[i].id;
					console.log(selectedbooklist[j]);
					console.log(selectedbooklist);
					j++;
				}
			}
			$.ajax({
				url : "${pageContext.request.contextPath}/admin/setmonthbooklist",
				headers: {"Content-Type": "application/json","X-CSRF-Token":csrf},
				data : JSON.stringify({"selectedbooklist" : selectedbooklist}),
				type : "post",
				success : function(msg){
					alert('성공적으로 올리셨습니다.');
				},
				error : function(){
					alert('에러 발생');
				}
			});
		}
		
		function downmonthbooklist(){
			$.ajax({
				url : "${pageContext.request.contextPath}/admin/downmonthbooklist",
				type : "post",
				headers: {"X-CSRF-Token":csrf},
				success : function(msg){
					alert('성공적으로 내리셨습니다.');
				},
				error : function(){
					alert('에러 발생');
				}
			});
		}
	</script>
	
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