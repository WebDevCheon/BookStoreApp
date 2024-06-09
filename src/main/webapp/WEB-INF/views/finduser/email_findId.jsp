<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이메일 인증</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery/jquery-2.2.4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/plugins.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/active.js"></script>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core-style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
</head>
<body>
	<jsp:include page = "../common/common.jsp" flush = "true"/>
	<div class="container" align="center">
		<div class="jumbotron" style="padding-top: 50px;">
			<form id = "myform" action="${pageContext.request.contextPath}/findUserId" method="post" onsubmit="return checker();">
				<h2 style="text-align: center;">아이디 찾기 화면</h2>
				<div class="form-group">
					<label for="exampleInputEmail1">이름</label> <input type="text" id ="username" class="form-control" name="name" placeholder="이름을 입력하세요.">
				</div>
				<div class="form-group">
					<label for="exampleInputPassword1">핸드폰 번호</label> <input type="text" class="form-control" id = "userphone" name="phoneNumber" placeholder="-없이 핸드폰 번호를 입력하세요.">
				</div>
					
				<input type = "hidden" id = "check">
				<input type = "hidden" id = 'store_email'>
				<div style="text-align: center">
					<br>
					<input type="submit" class="btn amado-btn" value = "아이디 찾기">
					<input type="hidden" name="${_csrf.parameterName}" id = "csrftoken" value="${_csrf.token}"/>
				</div>
			 </form>
				<br>
				<label for="exampleInputPassword1">이메일 인증</label>
                  <div style="text-align:center;"> 
                        <div id = "dice">
                          	 <input type="email" class="form-control" id = "useremail" name="e_mail" placeholder="이메일주소를 입력하세요.">
                          	 
                        </div>                                    
                            <span id ="success"></span>
                            <br>
                        	<button class="btn amado-btn" onclick = "auth();" id = "emailbtn">이메일 인증받기</button>
                        	<div id = "errorcheck">
                        	<br>
                        	</div>
                  </div>
		</div>
	</div>
	<input type="hidden" name="${_csrf.parameterName}" id = "csrftoken" value="${_csrf.token}"/>
<script>
	var contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/resources/js/finduser/email_findId.js"></script>
</body>
</html>