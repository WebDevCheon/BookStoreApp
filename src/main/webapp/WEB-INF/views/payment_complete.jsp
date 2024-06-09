<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문결제 완료</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
</head>
<body>
	<jsp:include page = "./common/common.jsp" flush = "true"/>
	<h3>주문 결제가 완료되었습니다.</h3>
	<h4>고객님의 거래번호는 <span style = "font-weight:bold;">${order_id}</span>입니다.</h4>
</body>
</html>