<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*,spring.myapp.shoppingmall.dto.Goods" language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
<title>오늘의 서적 채택</title>
<style>
	@media(max-width:768px){
    	 .container {
    		zoom : 70%;
    	}
    }
</style>
<%@ include file="../common/head.jsp"%>
</head>
<body>
   <%@ include file="../common/search_wrapper.jsp" %>
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
    <div class = "container" id = "todaybookdiv">
       <div style = "margin-top: 100px;" align = "center">
	  	 <div>	
	  		<h3 style="margin-left:50px;">
				<span>서적 조회</span>
				<input type = "search" id = "searchbookname" style = "margin:10px;">
				<button style = "margin-top:20px;" onclick = "findbook(document.getElementById('searchbookname').value)" class = "btn amado-btn">조회</button>
				<br> 
	  		</h3>
		 </div>
			
			<table class = "table table-bordered" style = "text-align:center;padding:100px;border-spacing:10px;margin:10px" border = "1">
				<tr>
					<th>ID</th>
					<th>책 이름</th>
					<th>가격</th>
					<th>수량</th>
					<th>구매량</th>
					<th>책 이미지</th>
					<th>오늘의 인기 서적으로 채택</th>
				</tr>
				<tr>
					<td class="align-middle" id = "id"></td>
					<td class="align-middle" id = "name"></td>
					<td class="align-middle" id = "price"></td>
					<td class="align-middle" id = "qty"></td>
					<td class="align-middle" id = "purchase"></td>
					<td class="align-middle" id = "thumbnail"></td>
					<td><button onclick = "settodaybookselect($('#id').html())" style="margin-top:23px" class = "btn amado-btn">오늘의 도서로 채택</button></td>
				</tr>
			</table>
    	</div>  
    </div>  
   </div>
   <input type="hidden" name="${_csrf.parameterName}" id = "csrftoken" value="${_csrf.token}"/>
    <script src="${pageContext.request.contextPath}/resources/js/jquery/jquery-2.2.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/active.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/slick.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/menu.js"></script>
 	<script>
 	var csrf = document.getElementById("csrftoken").value;
 	function findbook(name){
 		$.ajax({
 			url : "${pageContext.request.contextPath}/admin/findbook",
 			headers: {"X-CSRF-Token":csrf},
 			type : "post",
 			data : {"name" : name},
 			success : function(data){
 				alert('서적 조회 성공');
 				$("#id").html(data.id);
 				$("#name").html(data.name);
 				$("#price").html(data.price);
 				$("#qty").html(data.qty);
 				$("#purchase").html(data.purchase);
 				var img = document.createElement("img");
 				img.src = data.goodsprofile;
 				img.width = "100";
 				img.height = "100";
				document.getElementById("thumbnail").append(img);
 			},
 			error : function(){
 				alert('에러 발생');
 			}
 		});
 	}
 	
 	function settodaybookselect(id){
 		$.ajax({
 			url : "${pageContext.request.contextPath}/admin/settodaybookselect",
 			type : "post",
 			headers: {"X-CSRF-Token":csrf},
 			data : {"id" : id},
 			success : function(msg){
 				alert('오늘의 서적으로 채택 성공');
 			},
 			error : function(){
 				alert('에러 발생');
 			}
 		});
 	}
 	
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