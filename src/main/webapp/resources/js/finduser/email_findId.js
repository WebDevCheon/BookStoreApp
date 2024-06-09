 idchk = 0;
 var csrf = document.getElementById("csrftoken").value;
 
 function regive() {		// 인증 번호 다시 보내기
	clearInterval(refreshIntervalId);
 	m = "4";
 	s = "0";
 	k = "59";
 	refreshIntervalId = setInterval(mytimerfunc,1000);

 	$.ajax({
 		url: contextPath + '/authid',
 		headers : {"X-CSRF-Token":csrf},
 		type:'post',
 		data:{e_mail:$("#store_email").val(),phoneNumber:$("#userphone").val(),name:$("#username").val()},
 		success:function(data) {
 			$("#check").val(data);	
 			window.open(contextPath + "/resources/html/emailhtml.html", "", "width=450, height=300");
 		}
 	})
 }

 function auth() {
	 $("#store_email").val(document.getElementById("useremail").value);
	 if(document.getElementById("username").value.length == 0 || document.getElementById("userphone").value.length == 0) {
		 alert("아이디 또는 핸드폰 번호를 먼저 작성해주세요.");
		 return;
	 } else {
	 $.ajax({
		url: contextPath + '/authid',
		type:'post',
		headers : {"X-CSRF-Token":csrf},
		data:{e_mail:$("#useremail").val(),phoneNumber:$("#userphone").val(),name:$("#username").val()},
		success:function(data) {
			if(data != 0) {
				//alert("해당 이메일로 인증번호가 발송되었습니다.인증번호를 넣어주십시오.");
				window.open(contextPath + "/resources/html/emailhtml.html", "", "width=450, height=300");
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
			} else {
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

 function mytimerfunc() {
     if(m == "0" && k == "00"){
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
 
 
 function checking() //이메일 번호 인증 확인
 {
	 if(document.getElementById("checker") != null)
			$("#checker").remove();
	 if(document.getElementById("checkingnumber") != null)
		 $("#checkingnumber").remove();
	 
	 if($("#authcheck").val() == $("#check").val()) {
		 idchk = 1;
		 clearInterval(refreshIntervalId);
		 document.getElementById('timerdiv').innerHTML = " ";
		 $("#success").html("인증이 되었습니다.");
	 	 $("#emailbtn").remove();
	 }
	 else {
		var span = document.createElement("span");
		span.innerHTML = "인증번호가 틀렸습니다.다시 확인하여 주십시오.";
		span.setAttribute("style","color:red");
		span.setAttribute("id","checkingnumber");
		document.getElementById("errorcheck").appendChild(span);
		//document.getElementById("dice").appendChild(span);
	 }
 }
 
 function checker() //submit할때
 {	
	/*if(document.getElementById("authcheck").value == document.getElementById("check").value)
	{
		return true;
	}
	else
	{
		//alert("인증번호가 틀렸습니다.다시 확인하여 주십시오.");
		var span = document.createElement("span");
		span.innerHTML = "인증번호가 틀렸습니다.다시 확인하여 주십시오.";
		span.setAttribute("id","checker");
		span.setAttribute("style","color:red");
		document.getElementById("dice").appendChild(span);
		return false;
	}*/
	
	if(document.getElementById("checkingnumber") != null)
		 $("#checkingnumber").remove();
	if(document.getElementById("checker") != null)
		$("#checker").remove();
	
	if(idchk == 1) {
		return true;	
	} else {
		var span = document.createElement("span");
		span.innerHTML = "인증번호 확인을 누르세요.";
		span.setAttribute("id","checker");
		span.setAttribute("style","color:red");
		document.getElementById("errorcheck").appendChild(span)
		return false;
	}
 }