<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비밀번호 찾기 화면</title>
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
	<div class="container" align = "center">
		<div class="jumbotron" style="padding-top: 50px;">
			<form id = "myform" action="${pageContext.request.contextPath}/findUserPw" method="post" onsubmit="return checker();">
				<h2 style="text-align: center;">비밀번호 찾기 화면</h2>
				<div class="form-group">
					<label for="exampleInputEmail1">아이디</label> <input type="text" id ="userid" class="form-control" name="cId" placeholder="아이디를 입력하세요.">
				</div>
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
					<input type="submit" class="btn amado-btn" value = "비밀번호 찾기">
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
	/*
	 idchk = 0;
	 
	 function regive()
	 {
		clearInterval(refreshIntervalId);
	 	m = "4";
	 	s = "0";
	 	k = "59";
	 	refreshIntervalId = setInterval(mytimerfunc,1000);
	 	
	 	$.ajax({
	 		url:'/shoppingmall/authpw',
	 		type:'post',
	 		data:{e_mail:$("#store_email").val(),cId:$("#userid").val(),name:$("#username").val(),phoneNumber:$("#userphone").val()},
	 		success:function(data)
	 		{
	 			$("#check").val(data);
	 			window.open("/shoppingmall/resources/html/emailhtml.html", "", "width=450, height=300");
	 		}
	 	})
	 }
	 
	 function auth()
	 {
		 $("#store_email").val(document.getElementById("useremail").value);
		 if(document.getElementById("userid").value.length == 0 || document.getElementById("username").value.length == 0 || document.getElementById("userphone").value.length == 0)
		 {
			 alert("아이디 또는 이름 또는 핸드폰 번호를 먼저 작성해주세요.");
			 return;
		 }
		 else{
		 $.ajax({
			url:'/shoppingmall/authpw',
			type:'post',
			data:{cId:$("#userid").val(),e_mail:$("#useremail").val(),phoneNumber:$("#userphone").val(),name:$("#username").val()},
			success:function(data)
			{
				if(data != 0) //data!=null		data!=false였음
				{
					window.open("/shoppingmall/resources/html/emailhtml.html", "", "width=450, height=300");
					//alert("해당 이메일로 인증번호가 발송되었습니다.인증번호를 넣어주십시오.");
					$("#check").val(data);
					$("#useremail").remove();
					$("#emailbtn").html("인증받기");
					document.getElementById("emailbtn").setAttribute("onclick","checking();");
					var input = document.createElement('input');
					input.setAttribute('type','text');
					input.setAttribute('name','auth');
					input.setAttribute('id','authcheck');
					var element = document.getElementById("dice");
					element.appendChild(input);
					element.appendChild( document.createTextNode( '\u00A0' ) );
					var btn = document.createElement('button');
					btn.setAttribute('class','btn btn-primary');
					btn.setAttribute('id','mybtn');
					btn.setAttribute('onclick','regive()');
					btn.innerHTML = '재발송';
					element.appendChild(btn);

					element.appendChild(document.createElement("br"));
					m = "4";
			        s = "0";
			        k = "59";
			     	var timebar = document.createElement("h3");
			     	timebar.setAttribute("id","clock");
			     	element.appendChild(timebar);
			     	
			     	refreshIntervalId = setInterval(mytimerfunc,1000);
				}
				else
				{
					alert("정보가 유효하지 않습니다.다시 입력하여 주십시오.");
				}
			},
			error:function(data)
			{
				alert("에러가 발생했습니다.");
			}
		});
		 }
	 }
	
	 function mytimerfunc()
	 {
	 
	     	    if(m == "0" && k == "00")
		        {
		            	alert("시간이 만료되었습니다.다시 인증을 받으세요.")
		                document.getElementById("check").value = "";
		                clearInterval(refreshIntervalId);
		        }
	            document.getElementById('clock').innerHTML = "<div id = 'timerdiv'><span id='m'>" + m + "</span>"+ ':'+"<span id = 'k'>" + k + "</span></div>";
	            s--;     
	            k = 59 + s;
	            
	            if(k < "10")
	            {
	                k = "0"+k;
	            }

	            if(k == "0-1")
	            {
	                m--;
	                s = 0;
	                k = 59;
	            }
	 }
	
	 function checking() //인증 확인
	 {
		 if(document.getElementById("checker") != null)
				$("#checker").remove();
		 if(document.getElementById("checkingnumber") != null)
			 $("#checkingnumber").remove();
		 
		 if($("#authcheck").val() == $("#check").val())
		 {
			 idchk = 1;
			 clearInterval(refreshIntervalId);
			 document.getElementById('timerdiv').innerHTML = " ";
			 $("#success").html("인증이 되었습니다.");
		 	 $("#emailbtn").remove();
		 }
		 else
		 {
			var span = document.createElement("span");
			span.innerHTML = "인증번호가 틀렸습니다.다시 확인하여 주십시오.";
			span.setAttribute("style","color:red");
			span.setAttribute("id","checkingnumber");
			//document.getElementById("dice").appendChild(span);
		 	document.getElementById("errorcheck").appendChild(span);
		 }
	 }
	 
	 function checker()
	 {
		if(document.getElementById("checkingnumber") != null)
			 $("#checkingnumber").remove();
		if(document.getElementById("checker") != null)
			$("#checker").remove();
		
		if(idchk == 1)
		{
			return true;	
		}
		else
		{
			var span = document.createElement("span");
			span.innerHTML = "인증번호 확인을 누르세요.";
			span.setAttribute("id","checker");
			span.setAttribute("style","color:red");
			//document.getElementById("dice").appendChild(span);
			document.getElementById("errorcheck").appendChild(span);
			return false;
		}
	 }
	 */
	// document.getElementById("myform").onsubmit = check;
	</script>
	<script>
		var contextPath = "${pageContext.request.contextPath}";
	</script>
	<script src="${pageContext.request.contextPath}/resources/js/finduser/email_findPw.js"></script>
</body>
</html>