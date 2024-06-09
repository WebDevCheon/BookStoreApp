<%@ page import = "java.util.*,spring.myapp.shoppingmall.dto.Shoppingbasket" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
  List<Shoppingbasket> goods = (ArrayList<Shoppingbasket>)(request.getAttribute("list"));
  List<String> goodsname = new ArrayList<String>();
  List<Integer> goodsqty = new ArrayList<Integer>();
  for(int i=0; i < goods.size(); i++){
	  goodsname.add("'"+((Shoppingbasket)goods.get(i)).getName()+"'");
	  //goodsname.add(((Shoppingbasket)goods.get(i)).getName());
	  goodsqty.add(((Shoppingbasket)goods.get(i)).getQty());
  }
  int subtotal = 0;
  int total = 0;
  if(goods.size() > 0){
    subtotal = 0;
	total = 0;
	int sum = 0;
	for(int i = 0; i < goods.size(); i++)
		sum += goods.get(i).getPrice() * goods.get(i).getQty();
	subtotal = sum;
	total = sum;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>장바구니 : <%= session.getAttribute("Userid") %></title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
    <style type="text/css">       
        @media(max-width:768px){
        	#cart-table {
        		zoom : 70%
        	}
        }
         
        .main-content-wrapper .cart-table-area table thead tr {
        	display: table;
    		width: auto;
        }
        .main-content-wrapper .cart-table-area table thead tr th{
        	width: 200px;
        	font-size: 15px;
    		font-weight: 700;
    		border-bottom: 1px solid #ddd;
        }
        
        .main-content-wrapper .cart-table-area table tbody tr {
        	display: table;
    		width: auto;
        }
        .main-content-wrapper .cart-table-area table tbody tr td{
        	width: 200px;
        	display: table-cell;
		    vertical-align: middle;
		    text-align: center;
		    border-top: 1px solid #ddd;		   
        }
        .img-thumbnail{
        	width: 100px;
        }
        
         .main-content-wrapper .cart-table-area table tbody tr td img{
            height: auto;
   			max-width: 80%;
         }
        .main-content-wrapper .cart-table-area table tbody tr.trHover:hover {
        	background: #f8f9fa;
        }
       	
       	.jumbotron label{
       		font-size: 14px;
       		font-weight: bold;
       	}
        </style>
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
                <a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/img/core-img/bookstore.png" alt=""></a>
		    	<br>
		    	<c:if test = "${not empty sessionScope.Userid}">
		    	<div class = "jumbotron" align = "center" style = "width : 160px;margin-top:25px;">
              	   <span>안녕하세요 <span style = "font-weight:bold;">${sessionScope.Userid}</span>님!</span><br>
              	   <span>오늘도 즐거운 쇼핑하세요!</span>
              	   <br>
			    </div>
				 <div>
					<button onclick = "movetoupdatePasswordForm()" class = "btn amado-btn">비밀번호 변경</button>
			     </div>
			    </c:if>
			    <br>
			</div>
            <!-- Amado Nav -->
            <nav class="amado-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">홈페이지</a></li>
                    <li><a href="${pageContext.request.contextPath}/shopentrance">상품</a></li>
                    <li class="active"><a href="${pageContext.request.contextPath}/showbasket">장바구니</a></li>
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
					<c:if test = "${not empty sessionScope.admingrp}">
						<li><a href="${pageContext.request.contextPath}/admin/bookselect">대표 서적 등록</a>
					</c:if>
                    <c:if test ="${not empty sessionScope.Userid}">
                    	<li><a style = "cursor : pointer" onclick="document.getElementById('logout-form').submit();">로그아웃</a></li>
                		<form id="logout-form" action="<c:url value="/logout"/>" method="post">
    						<input type="hidden" name="${_csrf.parameterName}" id = "csrftoken" value="${_csrf.token}"/>
						</form>
                	</c:if>
                </ul>
            </nav>
            <!-- Cart Menu -->
            <div class="cart-fav-search mb-100">
                <a href="${pageContext.request.contextPath}/showbasket" class="cart-nav"><img src="${pageContext.request.contextPath}/resources/img/core-img/cart.png" alt="">장바구니</a>
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

        <div class="cart-table-area section-padding-100">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-8">
                        <div class="cart-title mt-50">
                            <h2>선택 품목</h2>
                        </div>
						 <div class="cart-table clearfix">
						  <div class = "container">
						   <div class = "row">
                            <table class="table table-responsive showbasket-table mb100" id = "cart-table" style = "text-align:center;">
                                <thead>
                                    <tr class="text-center">
                                    	<th>물품사진</th>
                                        <th>물품명</th>
                                        <th>가격</th>
                                        <th>개수</th>
                                        <th>삭제</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                 <c:when test = "${not empty list}">
                                  <c:forEach items = "${list}" var = "dto">
                                    <tr id = "${dto.pnum}" class="trHover">
                                        <td>
                                        <a class="gallery_img" href="${dto.thumbnail}">
                                            <img src="${dto.thumbnail}" alt="Product" class="img-responsive img-rounded">
                                           </a> 
                                        </td>
                                        <td>
                                            <span style = "font-weight:bold;">${dto.name}</span>
                                        </td>
                                        <td  id = "tdprice">
                                            <span id = "price">${dto.price}</span>
                                        </td>
                                        <td  id = "tdqty">
                                            <span id = "qty">${dto.qty}</span>
                                        </td>
                                        <td>
                                        	<a class="customButton cuB15" href="#" onclick = "DeleteShoppingCart(${dto.pnum})">삭제</a>
                                        </td>
                                    </tr>
                                   </c:forEach>
                                   <tr>
                                   	<td></td><td></td><td></td><td></td>
                                   	<td colspan="5" style="width:100%; " class="text-right">
                                  	 	<button class="customButton cuB17" onclick = "DeleteAllShoppingCart('${sessionScope.Userid}')">모든 상품 삭제하기</button>	                                   	                        
                                   	</td>
                                   </tr>
                                 </c:when>
									<c:otherwise>
									 <tr>
									 	<td></td><td></td>
                               			<td style = "font-weight:bold"><span>비었음</span></td>
                               		 	<td></td><td></td>
                               		 </tr> 
									</c:otherwise>
                               </c:choose>
                                </tbody>
                            </table>
                            </div>
                          <div class = "container">
						   <div class = "jumbotron">
						   <c:if test = "${empty sessionScope.state}">
							 <h6 style = "text-align:right;font-size:20px;"><button class = "customButton cuB16" onclick = "jeongbo('${sessionScope.Userid}')">회원 정보로 입력</button></h6>
						   </c:if> 
						    <h3 style = "text-align:center;">배송 정보</h3>
                            <div class="row mb20 mt30">
                            	<div class="col-lg-2 text-right">
                            	  <label>수령인</label>
                            	</div>
                            	<div class="col-lg-10">
                            	  <input type="text" name="name" id="sname" class="form-control"  placeholder="홍길동">
                            	</div>                            	
                            </div>
                            <div class="row mb20 mt30">
                            	<div class="col-lg-2 text-right">
                            	  <label>배송지 주소</label>
                            	</div>
                            	<div class="col-lg-10">
                            	  <input type="text" name="address" id="saddr" class="form-control" readonly>
                            	</div>                            	
                            </div>                            
                            <div class="row mb50 mt30">
                            	<div class="col-lg-12 text-right">
                            		<button class="customButton cuB16" onclick = "goPopup()">주소명 입력</button>
                            	</div>                            	
                            </div>           
                            <div class="row mb20 mt30">
                            	<div class="col-lg-2 text-right">
                            	  <label>연락처</label>
                            	</div>
                            	<div class="col-lg-10">
                            	  <input type="text" name="phone" id="sphone" class="form-control"  placeholder="01012345678">
                            	</div>                            	
                            </div>                
                              <div class="row mb20 mt30">
                            	<div class="col-lg-2 text-right">
                            	  <label>이메일</label>
                            	</div>
                            	<div class="col-lg-10">
                            	  <input type="email" name="email" id="semail" class="form-control"  placeholder = "forallshoppingmall@naver.com">
                            	</div>                            	
                            </div>                           
                              <div class="row mb20 mt30">
                            	<div class="col-lg-2 text-right">
                            	  <label>배송메모</label>
                            	</div>
                            	<div class="col-lg-10">
                            		<input type = "text" name ="memo" id = "smemo" class="form-control"  placeholder = "부재시 경비실에 맡겨주세요.">
                            	</div>                            	
                            </div>  
                             <div class="row mb20 mt30">
                            	<div class="col-lg-2 text-right">
                            	  	<label>쿠폰번호</label>
                            	</div>
                            	<div class="col-lg-10">
                            		<input type="text" name="coupon" id="scoupon" class="form-control">
                            	</div>                            	
                            </div>                              
                            <div class="row mb50 mt30">
                            	<div class="col-lg-12 text-right">
                                	<button class="customButton cuB16" onclick= "usecoupon(document.getElementById('scoupon').value)">쿠폰 사용</button>
                                	<input type = "hidden" id = "CouponId">
                            	</div>                            	
                            </div>  
                          </div>
                         </div>
                        </div>
                       </div>
                    </div>
                    <div class="col-12 col-lg-4">
                        <div class="cart-summary">
                            <h5>주문 가격</h5>
                            <ul class="summary-table">
                                <li><span>세금 적용 이전</span> <span id = "subtotal"><%= subtotal %></span></li>
                                <li><span>세금</span> <span>무료</span></li>
                                <li><span>총 주문 가격</span> <span id = "total"><%= total %></span></li>
                            </ul>
                              <input type = "hidden" id = "tmoney" value = "<%=total%>">
                            <div class="mt20">
                             <button class="customButton cuB1000" id = "paymentPhone" onclick="paymentPhone('${sessionScope.Userid}');return false">휴대폰결제</button>
                            </div>
                             <div class="mt20">
                                <button class="customButton cuB1000" id = "paymentCard" onclick="paymentCard('${sessionScope.Userid}');return false">카드결제</button>
                            </div>
                            
                            <div class="mt20">
                                <button class="customButton cuB1000" id = "paymentWithOutDeposit" onclick="paymentWithOutDeposit('${sessionScope.Userid}');return false">무통장입금</button>
							</div>
							<div class="mt20">                                
                                <button class="customButton cuB1000" id = "paymentWithDeposit" onclick="paymentWithDeposit('${sessionScope.Userid}');return false">실시간계좌이체</button>
                            </div>
                        </div>
                    </div>
                </div>
         	</div>
        </div>
    </div>
    <!-- ##### Main Content Wrapper End ##### -->



    <!-- ##### Footer Area Start ##### -->
    <footer class="footer_area clearfix">
        <div class="container">
            <div class="row align-items-center">
                <!-- Single Widget Area -->
                <div class="col-12 col-lg-4">
                    <div class="single_widget_area">
                        <!-- Logo -->
                        <div class="footer-logo mr-50">
                            <a href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/resources/img/core-img/bookstore.png" alt=""></a>
                        </div>
                        <!-- Copywrite Text -->
                        <p class="copywrite"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->& Re-distributed by <a href="https://themewagon.com/" target="_blank">Themewagon</a>
</p>
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
        <input type="hidden" name="csrftoken" id = "csrftoken" value="${_csrf.token}"/>
        <form id="form" name="form" method="post">
			<input type="hidden" id="confmKey" name="confmKey" value=""/>
			<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
			<input type="hidden" id="resultType" name="resultType" value=""/>
		</form>
    </footer>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/active.js"></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <script type="text/javascript" src="http://www.turnjs.com/lib/turn.min.js"></script>
	<script>
	function goPopup() {
	    var pop = window.open("${pageContext.request.contextPath}/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	}
	function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn
							, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo){
		document.getElementById("saddr").value = roadFullAddr;
	}
	</script>
	<script>
		var csrf = document.getElementById("csrftoken").value;
		function DeleteShoppingCart(pnum){
			$.ajax({
		        type:"POST",
		        url:"${pageContext.request.contextPath}/deleteshoppingcart",
		        headers : {"X-CSRF-Token":csrf},
		        data : {pnum : pnum},
		        success: function(data){
		            alert("삭제하였습니다 ");
		            $("#subtotal").html($("#subtotal").html() - ($("#"+pnum).find('td#tdprice').find('span#price').html()) * ($("#"+pnum).find('td#tdqty').find('span#qty').html()));
		        	$("#total").html($("#total").html() - ($("#"+pnum).find('td#tdprice').find('span#price').html()) * ($("#"+pnum).find('td#tdqty').find('span#qty').html()));
		            $("#"+pnum).remove();
		            location.href = "${pageContext.request.contextPath}/showbasket";
		        },
		        error: function(xhr, status, error) {
		            alert(error);
		        }  
		    });
		}
		function DeleteAllShoppingCart(Id){
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/deleteallshoppingcart",
				headers : {"X-CSRF-Token":csrf},
				data : {"Id" : Id},
				success : function(){
					alert("모든 상품 삭제");
					location.href = "${pageContext.request.contextPath}/showbasket";
				},
				error : function(){
					alert("오류 발생");
				}
			});
		}
	</script>
	<script>
		var generateRandom = function (min, max){
		  var ranNum = Math.floor(Math.random()*(max-min+1)) + min;
		  return ranNum;
		}
		var couponcheck = 0;
		var user_merchant = null;
		booknamelist = <%=goodsname%>
		bookqtylist = <%=goodsqty%>
		console.log(booknamelist);
		console.log(bookqtylist);
	</script>
	<script>
	function noEvent() {
		if (event.keyCode == 116) {
			event.keyCode= 2;
			return false;
		} else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82)) {
		  return false;
		}
	}
	</script>
 <script>
 	function movetoupdatePasswordForm(){
 		location.href = "${pageContext.request.contextPath}/updatePasswordForm";
 	}
 </script>
  	<script>
		 if("${sessionScope.Userid}".length == 0)
			 location.href = "/shoppingmall/loginForm";
  	</script>
  	<script>
  		var contextPath = "${pageContext.request.contextPath}";
  	</script>
  	<script src="${pageContext.request.contextPath}/resources/js/order/shoppingbasket.js"></script>
  	</body>
</html>