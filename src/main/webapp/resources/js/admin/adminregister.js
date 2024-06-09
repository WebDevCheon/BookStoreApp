	var csrf = document.getElementById("csrftoken").value;	
	
	function moveurl(){
 			 if($("#bigclass").val() == "novel"){
				location.href = contextPath + "/admin/registerForm?bigclass=novel";
			 } 
			 else if($("#bigclass").val() == "economy"){
				location.href = contextPath + "/admin/registerForm?bigclass=economy";
			 }
			 else if($("#bigclass").val() == "humanity"){
					location.href = contextPath + "/admin/registerForm?bigclass=humanity";
			 }
			 else if($("#bigclass").val() == "religion"){
					location.href = contextPath + "/admin/registerForm?bigclass=religion";
			 }
			 else if($("#bigclass").val() == "science"){
					location.href = contextPath + "/admin/registerForm?bigclass=science";
			 }
			 else if($("#bigclass").val() == "politics"){
					location.href = contextPath + "/admin/registerForm?bigclass=politics";
			 }
			 else if($("#bigclass").val() == "children"){
					location.href = contextPath + "/admin/registerForm?bigclass=children";
			 }
			 else if($("#bigclass").val() == "computer"){
					location.href = contextPath + "/admin/registerForm?bigclass=computer";
			 }
			 else if($("#bigclass").val() == "cook"){
					location.href = contextPath + "/admin/registerForm?bigclass=cook";
			 }
			 else if($("#bigclass").val() == "textbook"){
					location.href = contextPath + "/admin/registerForm?bigclass=textbook";
			 }
			 else if($("#bigclass").val() == "foreign"){
					location.href = contextPath + "/admin/registerForm?bigclass=foreign";
			 }
			 else if($("#bigclass").val() == "cartoon"){
					location.href = contextPath + "/admin/registerForm?bigclass=cartoon";
			 }
			 else if($("#bigclass").val() == "magazine"){
					location.href = contextPath + "/admin/registerForm?bigclass=magazine";
			 }
 		}

		function registerfile(){
		   var formData = new FormData();
	       formData.append('file',$("#imgfile")[0].files[0]);
	       formData.append('goods_id',1);
		   $.ajax({
			data: formData,
		  	method: 'post',
		  	headers : {"X-CSRF-Token":csrf},
		  	url: contextPath + '/upload',
		  	cache: false,
		  	contentType: false,
		  	processData: false,
		  	enctype: 'multipart/form-data',
		  	success: function(data)
		  	{
		  		var obj = JSON.parse(data);
		  		alert(obj.url)
		  		var img = document.createElement("img");
		      	img.src = obj.url;
		      	img.setAttribute("width","550px");
		  		img.setAttribute("height","550px");
		  		document.getElementById("loadimg").appendChild(img);
		  		$("#imgthumbnail").val(obj.url);
		  	},
		  	error:function(data)
		  	{
		  		console.log(data);
		  		alert('error');
		  	}
		  });
		}
		window.onload = function(){
			document.getElementById("imgfile").addEventListener("change",registerfile);
		}
		function makecoupon(Id)
		{
			$.ajax({
				url : contextPath + "/makecoupon",
				data : {"Id" : Id},
				headers : {"X-CSRF-Token":csrf},
				method : "POST",
				success : function(data){
					if(data == 0)
					{
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