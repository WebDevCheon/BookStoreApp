var csrf = document.getElementById("csrftoken").value;
function makecoupon(Id){
	$.ajax({
		url : contextPath + "/makecoupon",
		data : {"Id" : Id},
		headers : {"X-CSRF-Token":csrf},
		method : "POST",
		success : function(data){
			if(data == 0){
				alert('받을 수 있는 쿠폰이 없습니다.');
			}
			else if(data == 1)
			{
				alert('쿠폰을 모두 받으셨습니다.');
			}
		},
		error : function(err){
			alert("에러 발생");
		}
	});
}