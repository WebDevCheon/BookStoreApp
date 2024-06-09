<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon/books-16.png">
<style>
	.error {
		color:red
	}
</style>
</head>
<body>
	<jsp:include page="../common/common.jsp" flush="true"/>
 <div class = "container jumbotron" style = "width : 97%;">
 	<h1 style = "text-align:center;">회원가입</h1>
 	<form:form action = "${pageContext.request.contextPath}/join" id = "joinForm" method = "post" onsubmit="return chk();" class="form-horizontal" modelAttribute = "user">
 		<div class="form-group">
			<label for="inputPassword3" class="col-sm-2 control-label">아이디</label>
    <div class="col-sm-10">
      <form:input type="text" class="form-control" id = "Id" path = "id" placeholder="Id"/>
      <form:errors class="error" path="id"/>
      <c:if test = "${not empty admincheck}">
      	<span class = "error">${admincheck}</span>
      </c:if>
      <br>
      <input class = "btn amado-btn" type = "button" value ="중복확인" onclick = "check()">
    </div>
  </div>
  <div class="form-group">
    <label for="inputPassword3" class="col-sm-2 control-label">비밀번호</label>
    <div class="col-sm-10">
      <form:input type="password" class="form-control" id = "pw" path = "password" placeholder="Password"/>
      <form:errors class="error" path="password"/>
    </div>
  </div>
  <div class="form-group">
    <label for="inputPassword3" class="col-sm-2 control-label">주소</label>
    <div class="col-sm-10">
      <form:input type="text" class="form-control" id = "saddr" path = "address" placeholder="Address" readonly="true"/>
      <form:errors class="error" path="address"/>
      <br>
      <a href = "#" class = "btn amado-btn" onclick = "goPopup()">도로명 주소</a><br>
    </div>
  </div>
   <div class="form-group">
    <label for="inputPassword3" class="col-sm-2 control-label">성별</label>
    <div class="col-sm-10">
      <!--<form:input type="text" class="form-control" path = "Sex" placeholder="Sex"/>-->
      <form:select path = "sex" style = "padding:3px;height:30px;">
      	 <form:option value="남자">남자</form:option>
      	 <form:option value="여자">여자</form:option>
      </form:select>
      <form:errors class="error" path="sex"/>
    </div>
  </div>
  <div class="form-group">
    <label for="inputPassword3" class="col-sm-2 control-label">이름</label>
    <div class="col-sm-10">
      <form:input type="text" class="form-control" path = "name" placeholder="Name"/>
       <form:errors class="error" path="name"/>
    </div>
  </div>
   <div class="form-group">
    <label for="inputPassword3" class="col-sm-2 control-label">나이</label>
    <div class="col-sm-10">
      <!--<form:input type="text" class="form-control" path = "Age" placeholder="Age"/>-->
      <form:select path = "age" style = "padding:2px;">
      	<c:forEach begin = "1" end = "200" var = "x">
      	 	<form:option value="${x}">${x}</form:option>
      	</c:forEach>
      </form:select>
       <form:errors class="error" path="age"/>
    </div>
  </div>
  <div class="form-group">
    <label for="inputPassword3" class="col-sm-2 control-label">전화번호</label>
    <div class="col-sm-10">
      <form:input type="text" class="form-control" path = "phoneNumber" placeholder="Phone"/>
       <form:errors class="error" path="phoneNumber"/>
    </div>
  </div>
   <div class="form-group">
    <label for="inputPassword3" class="col-sm-2 control-label">이메일</label>
    <div class="col-sm-10">
      <form:input type="email" class="form-control" path = "email" placeholder="Email"/>
      <form:errors class="error" path="email"/>
    </div>
  </div>
   <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <button id = "submitButton" class="btn amado-btn">회원가입</button>
    </div>
  </div>
  </form:form>
 </div>
 <script>
	function goPopup() {
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	    var pop = window.open("${pageContext.request.contextPath}/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	    
		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
	    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}
	/** API 서비스 제공항목 확대 (2017.02) **/
	function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn
							, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.getElementById("saddr").value = roadFullAddr;
	}
</script>
   <script>
   		var contextPath = "${pageContext.request.contextPath}";
   		var form = document.getElementById('joinForm');
   		var submitButton = document.getElementById('submitButton');

        submitButton.addEventListener('click', function() {
            if (!submitButton.disabled) {
                submitButton.disabled = true;  // Disable the button to prevent multiple submissions
                form.submit();  // Submit the form
            }
        });
   </script>
   <script src="${pageContext.request.contextPath}/resources/js/join/joinform.js"></script>
</body>
</html>