	var idchk = 0;

	function check() {
		if (document.getElementById("Id").value.length == 0) {
			alert("아이디를 입력하세요");
			return;
		}
		else if(document.getElementById("Id").value.length > 0 && document.getElementById("Id").value.length < 5){
			alert("최소한 아이디 길이는 5자리 이어야 합니다.");
			return;
		}
		else if(document.getElementById("Id").value.substring(0,5) == "admin"){
			alert('이미 등록되어 있는 아이디입니다.');
			return;
		}
		$.ajax({
			type : "GET",
			async : true,
			url : contextPath + "/check",
			data : {
				id : $("#Id").val()
			},
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			success : function(data, textStatus) {
				if (data > 0) {
					alert("이미 존재하는 회원입니다.");
				}else if (data == 0) {
					alert("등록 가능한 회원입니다.");
					idchk = 1;
				}
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete : function(data, textStatus) {
				
			}
		});
	}
	
	function chk() {
		if (idchk == 0) {
			alert("중복확인을 해주십시오.");
			return false;
		} else
			return true;
	}