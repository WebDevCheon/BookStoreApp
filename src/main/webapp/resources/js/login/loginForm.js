var csrf = document.getElementById("csrftoken").value;
function naverlogin() {
		$("[name=id]").attr("required" , false);
		$("[name=password]").attr("required" , false);
		location.href = contextPath + "/naverlogin";
		//location.href= contextPath + "/naverlogin";
	}