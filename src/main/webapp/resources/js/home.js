function makecoupon(Id){
    		$.ajax({
    			url : contextPath + "/makecoupon",
    			data : {"Id" : Id},
    			method : "POST",
    			headers : {"X-CSRF-Token":csrf},
    			success : function(data){
    				if(data == 0)
					{
    					alert('받을 수 있는 쿠폰이 없습니다.');
					}
    				else if(data == 1)
    				{
    					alert('쿠폰을 모두 받으셨습니다.');
    				}
    				else {
    					alert('사용자의 정보가 올바르지 않습니다.');
    					return;
    				}
    			},
    			error:function(request,status,error){
    		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    		       }
    		});
}