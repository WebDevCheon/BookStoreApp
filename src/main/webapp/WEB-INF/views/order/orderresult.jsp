<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>주문결과</title>
<script src="${pageContext.request.contextPath}/resources/js/order/orderresult.js"></script>
</head>
<body>
	<jsp:include page="../common/common.jsp" flush = "true"/>
	
	<div class = "container">
		<div>
			<table style = "border-spacing:10px;text-align:center;vertical-align:middle;margin:10px;" border = "1" class = "table table-bordered">
			   <tr>
			   		<th>주문번호</th>
			   		<th colspan = "2">주문가격</th>
			   </tr>
			   <tr>
			   		<td class="align-middle">${Order.merchant_id}</td>
			   		<td class="align-middle" colspan = "2">${Order.price}</td>
			   </tr>
			   <tr>
			   		<th class="align-middle">상품명</th>
			   		<th class="align-middle">상품수량</th>
			   		<th class="align-middle">상품사진</th>
			   </tr>
			<c:if test = "${not empty Ordergoods}">
			  <c:forEach items = "${Ordergoods}" var = "dto">
			   <tr>
			   	 <td class="align-middle">${dto.name}</td>
			   	 <td class="align-middle">${dto.qty}</td>
			   	 <td class="align-middle"><img src = "${dto.goodsprofile}" width = "200" height = "200"></td>
			   </tr>
			  </c:forEach>
		    </c:if>
		    
		    <c:if test = "${not empty vbank_num}">
				 <c:if test = "${not empty Order}">
		    		<tr>
		    			<th>계좌번호</th>
		    			<th>은행</th>
		    			<th>기한</th>
		    		</tr>
		    		<tr>
		    			<td class="align-middle">${vbank_num}</td>
		    			<td class="align-middle">${vbank_name}</td>
		    			<td class="align-middle">${vbank_date}</td>
		    		</tr>
			     </c:if>
			</c:if>   
			
			<c:if test = "${empty vbank_num and empty Order}">
				<tr>
					<th></th>
				</tr>
				<tr>
					<td colspan="3" style = "font-weight:bold;">오류발생</td>
				</tr>		
			</c:if>
			</table>
		</div>
		<input type="hidden" name="${_csrf.parameterName}" id = "csrftoken" value="${_csrf.token}"/>
	</div>
</body>
</html>