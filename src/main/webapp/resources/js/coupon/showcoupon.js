var csrf = document.getElementById("csrftoken").value;
var ws = new WebSocket("wss://localhost:8443/shoppingmall/echo");
//var ws = new WebSocket("wss://www.forallshoppingmall.com/echo");

ws.onopen = function(){
	console.log('웹 소켓 연결 성공');
	console.log(user);
	ws.send(user);
}

ws.onmessage = function onMessage(msg){
	alert(msg.data);
}

ws.onclose = function onClose(evt) {
	console.log('웹 소켓 연결 끊김');
}

var csrf = document.getElementById("csrftoken").value;

function makecoupon(Id,contextPath){
	$.ajax({
		url : contextPath + "/makecoupon",
		data : {"Id" : Id},
		headers : {"X-CSRF-Token":csrf},
		method : "POST",
		success : function(data){
			if(data == 0){
				alert('받을 수 있는 쿠폰이 없습니다.');
			}
			else if(data == 1){
				alert('쿠폰을 모두 받으셨습니다.');
				ws.send(Id + ",makecoupon");
			}
		},
		error : function(err){
			alert("에러 발생");
		}
	});
}
