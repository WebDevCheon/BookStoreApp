<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery/jquery-2.2.4.min.js"></script>
<title>상품자 환불</title>
<style>
	@media(max-width:768px){
    	 .container-fluid {
    		zoom : 30%;
    	}
    }
	th,td {
		padding : 30px
	}
</style>
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="icon" href="img/core-img/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core-style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
</head>
<body>
     <!-- Search Wrapper Area Start -->
    <jsp:include page = "../common/search_wrapper.jsp" />
    <!-- Search Wrapper Area End -->
    <!-- ##### Main Content Wrapper Start ##### -->
   <div class="container-fluid" id = "refunddiv">
    <div class="main-content-wrapper d-flex clearfix">
        <div class="mobile-nav">
            <!-- Navbar Brand -->
            <div class="amado-navbar-brand">
                <a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/img/core-img/bookstore.png" alt=""></a>
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
                    <li><a href="${pageContext.request.contextPath}/shop">상품</a></li>
                   <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/showbasket">장바구니</a></li>
                   <li><a href="${pageContext.request.contextPath}/showcoupon">쿠폰 내역</a></li>
                    <c:if test = "${not empty sessionScope.Userid }">
								<li><a href="${pageContext.request.contextPath}/showorder">주문 정보</a></li>
					</c:if>
					<c:if test = "${not empty sessionScope.admingrp}">
						<li class = "active"><a href="${pageContext.request.contextPath}/admin/adminrefund">고객 환불</a>
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
             <c:if test = "${not empty sessionScope.Userid}">
                <a href="${pageContext.request.contextPath}/showbasket" class="cart-nav"><img src="${pageContext.request.contextPath}/resources/img/core-img/cart.png" alt="">장바구니 </a>
             </c:if>
                <a href="#" class="search-nav"><img src="${pageContext.request.contextPath}/resources/img/core-img/search.png" alt="">상품 찾기</a>
            </div>

            <div class="social-info d-flex justify-content-between">
                <a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            </div>
        </header>
       
    <div class="amado_product_area section-padding-100">
            <div>
                <div class="row">
                    <div class="col-12">
                        <div class="product-topbar d-xl-flex align-items-end justify-content-between">
                            
                          
                        </div>
                    </div>
                </div>
    
	<div>
	  <h3 style = "text-align:center">
		<span>주문번호</span> <input type = "text" id = "orderid" style = "margin:10px;"><a href = "#" onclick = "check(document.getElementById('orderid').value)" class = "btn amado-btn">조회</a><br> 
	  </h3>
		<table class = "table table-bordered" style = "text-align:center;padding:100px;border-spacing:10px;margin:10px" border = "1">
			<tr>
				<th>금액</th>
				<th>예금주</th>
				<th>은행</th>
				<th>계좌번호</th>
				<th>환불버튼</th>
			</tr>
			<tr>
				<td class="align-middle" id = "amount"></td>
				<td class="align-middle" id = "holder"></td>
				<td class="align-middle" id = "bank"></td>
				<td class="align-middle" id = "account"></td>
				<td><button class = "btn amado-btn" id = "rbtn">환불</button></td>
			</tr>
		</table>
	</div>
	
	
	  <div>
	  <h3>
	  </h3>
		<table class = "table table-bordered" style = "text-align:center;border-spacing:10px;margin:10px" border = "1">
			<tr>
				<th>주문번호</th>
				<th>금액</th>
				<th>요청시간</th>
				<th>예금주</th>
				<th>은행</th>
				<th>계좌번호</th>
				<th>처리상태</th>
				<th>환불버튼</th>
			</tr>
		<c:forEach items = "${list}" var = "dto" varStatus = "status">
			<tr>
				<td class="align-middle" id = "findmerchantid${status}">${dto.merchant_id}</td>
				<td class="align-middle" id = "findamount${status}">${dto.amount}</td>
				<td class="align-middle" id = "findrequesttime${status}">${dto.requesttime}</td>
				<td class="align-middle" id = "findholder${status}">${dto.refundholder}</td>
				<td class="align-middle" id = "findbank${status}">${dto.refundbank}</td>
				<td class="align-middle" id = "findaccount${status}">${dto.refundaccount}</td>
				<c:if test = "${dto.status eq 'finished'}">
					<td class="align-middle" id = "findstatus${status}">처리완료</td>
				</c:if>
				<c:if test = "${dto.status eq 'in progress'}">
					<td class="align-middle" id = "findstatus${status}">처리중</td>
				</c:if>
				<c:choose>
					<c:when test = "${empty dto.refundholder}">
						<td><button class = "btn amado-btn" onclick = "cancelPay2('${dto.merchant_id}',${dto.amount})">환불</button></td>
					</c:when>
					<c:when test = "${not empty dto.refundholder}">
						<td><button class = "btn amado-btn" onclick = "cancelPayVbank2('${dto.merchant_id}',${dto.amount},'${dto.refundholder}','${dto.refundbank}','${dto.refundaccount}')">환불</button></td>
					</c:when>
				</c:choose>
			</tr>
		</c:forEach>
		</table>
	  </div>
	</div>
	<div>	
		<div class="row" style = "text-align:center;">
                    <div class="col-12">
                        <nav aria-label="navigation">
                            <ul class="pagination justify-content-end mt-50">
    							<c:if test="${ curPageNum > 5 }"> <!-- 6 -->
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/admin/adminrefund?page=1">◀◀</a></li>
        						</c:if>
        
        						<c:if test="${ curPageNum > 5 }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/admin/adminrefund?page=${ blockStartNum - 1 }">◀</a></li>
        						</c:if>
        
        						<c:forEach var="i" begin="${ blockStartNum }" end="${ blockLastNum }">
            						<c:choose>
            							<c:when test="${ i > lastPageNum }">
            								
            							</c:when>
                						<c:when test="${ i == curPageNum }">
                    						<li class="page-item active" style = "color:black;"><a class = "page-link">${ i }</a></li>
                						</c:when>
                						<c:otherwise>
                    						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/admin/adminrefund?page=${ i }">${ i }</a></li>
                						</c:otherwise>
            						</c:choose>
            						&nbsp;&nbsp;
        						</c:forEach>
 
        						<c:if test="${ lastPageNum > blockLastNum }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/admin/adminrefund?page=${ blockLastNum + 1 }">▶</a></li>
        						</c:if>
        						<c:if test = "${lastPageNum > 5}">
        							<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/admin/adminrefund?page=${lastPageNum}">▶▶</a></li>
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
	var csrf = document.getElementById("csrftoken").value;
	function cancelPay2(merchantid,amount) {
	      $.ajax({
	        "url": "${pageContext.request.contextPath}/cancel",
	        "headers" : {"X-CSRF-Token":csrf},
	        "type": "POST",
	        "contentType": "application/json",
	        "data": JSON.stringify({
	          "merchant_uid": merchantid, // 주문번호
	          "cancel_request_amount": amount.toString() // 환불금액
	        }),
	        success : function(){
	        	alert('요청 성공');
	        },
	        error : function(){
	        	alert('이미 환불 요청을 하셨습니다.');
	        },
	        "dataType": "json"
	      }).done(function(result){
	    	  console.log(result);
	    	  alert(result);
	    	  var cancelstatus = result.status;
	    	  console.log("cancelstatus : " + cancelstatus);
	    	  var canceldata = {"cancel" : cancelstatus, "merchant_id" : merchantid}
	    	  
	    	  $.ajax({
				"url" : "${pageContext.request.contextPath}/cancelstatus",
				"type" : "POST",
				"headers": { "Content-Type": "application/json","X-CSRF-Token":csrf},
				"data" : JSON.stringify(canceldata),
				success : function(){
					alert('환불 처리 성공');
					alert('status 변화 성공');
					location.reload();
				},
				error : function(){
					alert('error');
				}
	    	  });
	    	  alert('환불 성공');
	      }).fail(function(error){
	    	  console.log(error);
	    	  alert('환불 실패'); 
	      });
	    }
	
	
	function cancelPayVbank2(merchantid,amount,refundholer,refundbank,refundaccount){
	      $.ajax({
	        "url": "${pageContext.request.contextPath}/cancel",
	        "type": "POST",
	        "contentType": "application/json",
	        "headers" : {"X-CSRF-Token":csrf},
	        "data": JSON.stringify({
	          "merchant_uid": merchantid, // 주문번호
	          "cancel_request_amount": amount.toString(), // 환불금액
	          "refund_holder": refundholder, // [가상계좌 환불시 필수입력] 환불 가상계좌 예금주
	          "refund_bank": refundbank, // [가상계좌 환불시 필수입력] 환불 가상계좌 은행코드(ex. KG이니시스의 경우 신한은행은 88번)
	          "refund_account": refundaccount // [가상계좌 환불시 필수입력] 환불 가상계좌 번호
	        }),
	        success : function(){
	        	alert('환불 요청 성공');
	        },
	        error : function(){
	        	alert('이미 환불 요청을 하셨습니다.');
	        },
			"dataType" : "json"
	      }).done(function(result){
	    	  console.log(result);
	    	  var cancelstatus = result.status;
	    	  console.log("cancelstatus : " + cancelstatus);
	    	  var canceldata = {"cancel" : cancelstatus, "merchant_id" : merchantid}
	    	  $.ajax({
				url : "${pageContext.request.contextPath}/cancelstatus",
				type : "POST",
				headers: { "Content-Type": "application/json","X-CSRF-Token":csrf},
				data : JSON.stringify(canceldata),
				success : function(){
					alert('환불 처리 성공');
					alert('status 변화 성공');
					location.reload();
				},
				error : function(){
					alert('error');
				 }
	    	  });
	    	  alert('환불 성공');
	      }).fail(function(error){
	    	  console.log(error);
	    	  alert('환불 실패'); 
	      });
	    }
	
	
		function check(orderid){
			if(orderid == null){
				alert('주문번호를 입력해주세요.');
				return;
			}
			else{
				$.ajax({
					"url" : "${pageContext.request.contextPath}/admin/findrefund",
					"type" : "POST",
					"contentType": "application/json",
					"headers" : {"X-CSRF-Token":csrf},
					"data" : JSON.stringify({"orderid" : orderid}),
					"dataType" : "json",
					success : function(result)
					{
						alert('조회성공');
						if(result.amount == null) {
							alert("주문 번호 존재 하지 않음");
							return;
						}
						$("#amount").html(result.amount);
						$("#holder").html(result.holder);
						$("#bank").html(result.bank);
						$("#account").html(result.account);
						if(!result.holder)
							document.getElementById("rbtn").setAttribute("onclick","cancelPay()");
						else
							document.getElementById("rbtn").setAttribute("onclick","cancelPayVbank()");
					},
					error : function(){
						alert('오류 장애');
					}
				});
			}
		}
		
		function cancelPay() {
		      $.ajax({
		        "url": "${pageContext.request.contextPath}/cancel",
		        "type": "POST",
		        "contentType": "application/json",
		        "headers" : {"X-CSRF-Token":csrf},
		        "data": JSON.stringify({
		          "merchant_uid": document.getElementById("orderid").value, // 주문번호
		          "cancel_request_amount": document.getElementById("amount").innerHTML, // 환불금액
		        }),
		        success : function(){
		        	alert('요청 성공');
		        },
		        error : function(){
		        	alert('이미 환불 요청을 하셨습니다.');
		        },
		        "dataType": "json"
		      }).done(function(result){
		    	  console.log(result);
		    	  alert(result);
		    	  var cancelstatus = result.status;
		    	  console.log("cancelstatus : " + cancelstatus);
		    	  var canceldata = {"cancel" : cancelstatus, "merchant_id" : document.getElementById('orderid').value}
		    	  
		    	  $.ajax({
					"url" : "${pageContext.request.contextPath}/cancelstatus",
					"type" : "POST",
					"headers" : { "Content-Type": "application/json","X-CSRF-Token":csrf},
					"data" : JSON.stringify(canceldata),
					success : function(){
						alert('환불 처리 성공');
						alert('status 변화 성공');
						location.reload();
					},
					error : function(){
						alert('error');
					}
		    	  });
		    	  alert('환불 성공');
		      }).fail(function(error){
		    	  console.log(error);
		    	  alert('환불 실패'); 
		      });
		    } 
		
		function cancelPayVbank(){
		      $.ajax({
		        "url": "${pageContext.request.contextPath}/cancel",
		        "type": "POST",
		        "headers" : {"X-CSRF-Token":csrf},
		        "contentType": "application/json",
		        "data": JSON.stringify({
		          "merchant_uid": document.getElementById("orderid").value, // 주문번호
		          "cancel_request_amount": document.getElementById("amount").innerHTML, // 환불금액
		          "refund_holder": document.getElementById("holder").innerHTML, // [가상계좌 환불시 필수입력] 환불 가상계좌 예금주
		          "refund_bank": document.getElementById("bank").innerHTML, // [가상계좌 환불시 필수입력] 환불 가상계좌 은행코드(ex. KG이니시스의 경우 신한은행은 88번)
		          "refund_account": document.getElementById("account").innerHTML // [가상계좌 환불시 필수입력] 환불 가상계좌 번호
		        }),
		        success : function(){
		        	alert('환불 요청 성공');
		        },
		        error : function(){
		        	alert('이미 환불 요청을 하셨습니다.');
		        },
				"dataType" : "json"
		      }).done(function(result){
		    	  console.log(result);
		    	  var cancelstatus = result.status;
		    	  console.log("cancelstatus : " + cancelstatus);
		    	  var canceldata = {"cancel" : cancelstatus, "merchant_id" : document.getElementById('orderid').value}
		    	  $.ajax({
					url : "${pageContext.request.contextPath}/cancelstatus",
					type : "POST",
					headers: { "Content-Type": "application/json","X-CSRF-Token":csrf},
					data : JSON.stringify(canceldata),
					success : function(){
						alert('환불 처리 성공');
						alert('status 변화 성공');
						location.reload();
					},
					error : function(){
						alert('error');
					}
		    	  });
		    	  alert('환불 성공');
		      }).fail(function(error){
		    	  console.log(error);
		    	  alert('환불 실패'); 
		      });
		    }
	</script>
	       <!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery/jquery-2.2.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/plugins.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/active.js"></script>
</body>
</html>