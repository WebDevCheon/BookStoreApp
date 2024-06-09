<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/resources/js/jquery/jquery-2.2.4.min.js"></script>
<title>주문 내역</title>
<style>
	td {
		width:23%
	}
</style>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
<link href="${pageContext.request.contextPath}/resources/fontawesome/css/all.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
<style>
	@media(max-width: 768px){
		.container-fluid {
			zoom : 54%;
		}
	}
</style>
</head>
<body>
   <jsp:include page = "../common/common.jsp"/>
   <c:if test = "${empty orders}">
   	 <div class = "container-fluid" style = "text-align:center;">	
   		<h1 style = "text-align:center;">주문 정보 조회 결과</h1>
   		<br><br>
   		<span style = "font-weight:bold;">주문한 물품이 없습니다.</span>
     </div>
   </c:if>
	<c:if test = "${not empty orders}">
	<div class = "container-fluid" style = "text-align:center;width : 1200px;">	
		<h1 style = "text-align:center;">주문 정보 조회 결과</h1>
		<table style = "text-align:center;border-bottom : 3px solid black" border = "1" class = "table table-bordered">
		  <c:forEach items = "${orders}" var = "dto" varStatus = "mystatus">
			<input type = "hidden" id = "${mystatus.index}seqdto" value = "${mystatus.index}">
			<tr style = "border-top : 3px solid black">
				<th class="align-middle">주문번호</th>
				<th class="align-middle">주문상태</th>
				<th class="align-middle">가격</th>
				<th class="align-middle">주문날짜</th>
				<th class="align-middle">배송지</th>
			</tr>
			<tr>
				 <c:if test = "${dto.status eq 'paid'}">
					<td class="align-middle" id = "${mystatus.index}merchantid">${dto.merchant_id}</td>
			 	 </c:if>
			 	<c:if test = "${dto.status ne 'paid'}">
			 		<td class="align-middle">${dto.merchant_id}</td>
			 	</c:if>
			 	 <c:if test = "${dto.status eq 'paid'}">
					<td class="align-middle">구매완료</td>
			  	</c:if>
			  	<c:if test = "${dto.status eq 'ready'}">
					<td class="align-middle">미입금</td>
			  	</c:if>
			   	<c:if test = "${dto.status eq 'cancelled'}">
					<td class="align-middle">환불</td>
			  	</c:if>
			  	  <c:if test = "${dto.status eq 'paid'}">
					<td class="align-middle" id = "${mystatus.index}price">${dto.price}</td>
			  </c:if>
			  <c:if test = "${dto.status ne 'paid'}">
			  	    <td class="align-middle">${dto.price}</td>
			  </c:if>
			  <td class="align-middle">${dto.time}</td>
			  <td class="align-middle">${dto.address}</td>
			</tr>
			
			<tr>
				<th class="align-middle">상품명</th>
				<th class="align-middle">수량</th>
				<th class="align-middle" colspan = "3">상품사진</th>
			</tr>
			 <c:forEach items = "${ordergoods}" var = "list">
				<c:forEach items = "${list}" var ="dko">
				 <c:if test = "${dto.merchant_id eq dko.merchant_id}">
				 <tr>
					<td class="align-middle">${dko.name}</td>
					<td class="align-middle">${dko.qty}</td>
					<td class="align-middle" colspan = "3"><img src="${dko.goodsprofile}" width = "200" height = "100"></td>
				</tr>
				 </c:if>
				</c:forEach>
			</c:forEach>
			<c:if test = "${not empty dto.tekbenumber}">
					<tr>
						<td class="align-middle">택배 번호</td>
						<td class="align-middle" colspan = "4">${dto.tekbenumber}</td>
					</tr>
			</c:if>
			<c:forEach items = "${vbanks}" var = "vbank" begin = "0" end = "${fn:length(vbanks)}" varStatus = "status">
				  <c:if test = "${vbank.merchant_id eq dto.merchant_id}">
					<tr>
						<th class="align-middle">은행</th>
						<th class="align-middle">계좌번호</th>
						<th class="align-middle">입금기한</th>
						<th class="align-middle" colspan = "2">예금주</th>
					</tr>
					<tr>	
						<td class="align-middle">${vbank.vbankname}</td>
						<td class="align-middle">${vbank.vbanknum}</td>
						<td class="align-middle">${vbank.vbankdate}</td>
						<td class="align-middle" colspan = "2">${vbank.vbankholder}</td>
					</tr>
					<input type = "hidden" id ="${status.index}merchant_uid" value = "${vbank.merchant_id}">
					<input type = "hidden" id ="${status.index}vbankprice" value = "${dto.price}">
					<input type = "hidden" id ="${status.index}person" value = "${vbank.vbankperson}">
					<input type = "hidden" id ="${status.index}code" value = "${vbank.vbankcode}">
					<input type = "hidden" id ="${status.index}name" value = "${vbank.vbankname}">
					<input type = "hidden" id ="${status.index}num" value = "${vbank.vbanknum}">
					<input type = "hidden" id ="${status.index}date" value = "${vbank.vbankdate}">
					<input type = "hidden" id ="${status.index}holder" value = "${vbank.vbankholder}">
					<input type = "hidden" id ="${status.index}seq" value = "${status.index}">
					<tr>
						<td class="align-middle">환불요청</td>
						<td class="align-middle" colspan = "4">
							<c:if test = "${dto.status eq 'paid' and not empty dto.tekbenumber}">
								<button class = "btn amado-btn" onclick = "cancelPayVbank(document.getElementById('${status.index}seq').value)">무통장 입금 환불</button>
							</c:if>
							<c:if test = "${empty dto.tekbenumber}">
								비활성
							</c:if>
						</td>
					</tr>
			  </c:if>
			</c:forEach>
			<c:if test = "${dto.status ne 'ready' and dto.status ne 'cancelled' and dto.paymethod ne 'vbank' and not empty dto.tekbenumber}">
				<tr>
					<th class="align-middle">환불요청</th>
						<td class="align-middle" colspan = "4">
							<button class = "btn amado-btn" onclick = "cancelPay(document.getElementById('${mystatus.index}seqdto').value)">환불</button>
						</td>
				</tr>
			</c:if>
		</c:forEach>
	</table>
	<br>
	<br>
	<table style = "text-align:center;margin:10px;" border = "1" class = "table table-bordered"> 
			<tr>
				<th>운송장번호</th>
				<td><input type = "text" id = "invoiceNumberText"></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<th>택배상태조회</th>
				<td><select id = "tekbeCompanyList"></select></td>
				<td><button class = "btn amado-btn" id = "tekbebutton">택배 조회</button></td>
				<td></td>
			</tr>
			
			<tr id = "invoicefind">
					
			</tr>
			<tr id = "trackingtekbe">
			
			</tr>
	</table>
	
                    <div class="col-12">
                        <nav aria-label="navigation">
                            <ul class="pagination justify-content-end mt-50">
    							<c:if test="${ curPageNum > 5 }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/showorder?page=1">◀◀</a></li>
        						</c:if>
        
        						<c:if test="${ curPageNum > 5 }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/showorder?page=${ blockStartNum - 1 }">◀</a></li>
        						</c:if>
        
        						<c:forEach var="i" begin="${ blockStartNum }" end="${ blockLastNum }">
            						<c:choose>
            							<c:when test="${ i > lastPageNum }">
            								
            							</c:when>
                						<c:when test="${ i == curPageNum }">
                    						<li class="page-item active" style = "color:black;"><a class = "page-link">${ i }</a></li>
                						</c:when>
                						<c:otherwise>
                    						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/showorder?page=${ i }">${ i }</a></li>
                						</c:otherwise>
            						</c:choose>
            						&nbsp;&nbsp;
        						</c:forEach>
        						<c:if test="${ lastPageNum > blockLastNum }">
            						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/showorder?page=${ blockLastNum + 1 }">▶</a></li>
        						</c:if>
        						<c:if test = "${lastPageNum > 5}">
        							<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/showorder?page=${lastPageNum}">▶▶</a></li>
        						</c:if>
    						</ul>
                        </nav>
                   </div>
               </div>	
            </c:if>
            <input type="hidden" name="${_csrf.parameterName}" id = "csrftoken" value="${_csrf.token}"/>
			<script>
				var contextPath = "${pageContext.request.contextPath}";
			</script>
			<script src="${pageContext.request.contextPath}/resources/js/order/orderinfo.js"></script>
</body>
</html>