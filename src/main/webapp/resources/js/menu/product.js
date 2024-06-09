 	var csrf = document.getElementById("csrftoken").value;
	var effect;
    var remain = document.getElementById('remain').value; //상품의 현재 재고량
    var myqty;        //선택한 갯수
    	window.onload = function()
    	{
    		effect = document.getElementById('qty');
    		document.getElementById('qty').onchange = function(){
    			myqty = effect.value;
    		}
    		myqty = effect.value;
    	}
    	
    function plusfunc(remain){
    	if(remain > $("#qty").val())
    		document.getElementById("qty").value++;
    	return;
    }	
    
    function minusfunc(){
    	if($("#qty").val() > 1)
    		document.getElementById("qty").value--;
    	return;
    }
    
    function cart(bookid,bookprice,bookname,qty,userid,thumbnail,remain){  // qty는 주문량, 주문하기 버튼 클릭
    		var hqty = document.getElementById('hqty');
    		hqty.value = document.getElementById('qty').value;

    		if(hqty.value > remain){
    			alert("재고의 개수보다 더 많이 담으셨습니다.");
    			return;
    		}
    		else if(hqty.value <= 0){
    			alert('주문량을 1권이상으로 해주시기 바랍니다.');
    			return;
    		}
    		$.ajax({
    			url : contextPath + "/cartspace",
    			type : "post",
    			headers: { "Content-Type": "application/json","X-CSRF-Token":csrf},
    			data : JSON.stringify({"Id" : userid}),
    			success : function(data){
    				console.log(data);
    				if(data < 10){
    					$.ajax({
    				        type:"POST",
    				        url: contextPath + "/shoppingbasket",
    				        headers: {"Content-Type": "application/json;charset=utf-8","X-CSRF-Token":csrf},
				        	data : JSON.stringify({goods_id : bookid,price : bookprice,name : bookname,qty : qty,userid : userid,thumbnail : thumbnail}),
    						success : function(data){
    							if(data == "yes")
    								location.href = contextPath + "/showbasket";
    						},
    						error:function(request,status,error){
    						    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    						}
    					});
    				} else {
    					alert('장바구니의 최대 갯수는 10개입니다.');
    				}
    			},
    			error : function() {
    			
    			}
    		});
    	}
    	
    	function shoppingbasket(userid,remain,bookid,bookprice,bookname,qty,thumbnail) {	// 장바구니 버튼 클릭
    		if($("#qty").val() > remain){
    			alert("재고의 개수보다 더 많이 담으셨습니다.");
    			return;
    		}
    		else if($("#qty").val() <= 0){
    			alert('주문량을 1권이상으로 해주시기 바랍니다.');
    			return;
    		}
    		$.ajax({
    			url : contextPath + "/cartspace",
    			type : "post",
    			headers: { "Content-Type": "application/json","X-CSRF-Token":csrf},
    			data : JSON.stringify({"Id" : userid}),
    			success : function(data){
    				if(data < 10){
    					$.ajax({
    				        type:"POST",
    				        headers : {"X-CSRF-Token":csrf},
    				        url: contextPath + "/cart",
    				        data : {goods_id : bookid,price : bookprice,name : bookname,qty : qty,userid : userid,thumbnail : thumbnail},
    				        success: function(){
    				          alert('장바구니에 담았습니다');
    				        },
    				        error: function(xhr, status, error) {
    				            alert('에러');
    				        }  
    				    });
    				}
    				else {
    					alert('장바구니의 최대 갯수는 10개입니다.');
    				}
    			},
    			error : function(){
    				alert('오류');
    			}
    		});
    	} 	
    
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
    			},
    			error : function(err){
    				alert("에러 발생");
    			}
    		});
    	}
    
    /*
	function replydelete(id,goodsname,goodsid) {
		$.ajax({
			type : "GET",
			url : contextPath + "/contentreplydelete",
			data : {
				bookname : goodsname,
			    rId : id
			},
			success : function(data) {
				alert('delete success');
				location.href = contextPath + "/product?goods_id="+goodsid;
			},
			error : function(data) {
				alert('error');
			}
		});
	}

  function replymodify(id,goodsname,goodsid) {
		document.getElementById("modifier" + id).innerHTML = "완료";
		document.getElementById(id).setAttribute("contentEditable","true");
		document.getElementById(id).setAttribute("style","width:100%;height:100%;text-align:left;font-size:20px;padding-bottom:45px;");
		//document.getElementById("spancontent").setAttribute("style","vertical-align:middle;");
		document.getElementById("modifier" + id).onclick = function(e) {
			$.ajax({
				type : "GET",
				url : contextPath + '/contentreplymodify',
				data : {
					bookname : goodsname,
					rId : id,
					content : document.getElementById(id).innerHTML
				},
				success : function(data) {
					alert('success');
					document.getElementById(id).setAttribute("contentEditable",
							false);
					document.getElementById("modifier" + id).innerHTML = "수정";
					location.href = contextPath + "/product?goods_id="+goodsid
					//getCommentList();
				},
				error : function(data) {
					alert('error');
				}
			});
		}
	}
  
  //댓글 작성하고 답변 누르기
  function reply(userid,goodsname,goodsid){
		if($("#reply").html() == ""){
			alert("내용을 입력하세요.");
			return;
		}
		
		$.ajax({
			type : 'POST',
			url : contextPath + "/addComment",
			data : {
				reply : $("#reply").html(),
				bookname : goodsname,
				user_id : userid
				//bId : $("#id").val(),
				//cId : $("#userid").val(),
				//bHit:$("#bHit").val()
			},
			success : function(data) {
				if (data == true) {
					//getCommentList();
					$("#reply").html("");
					location.href = contextPath + "/product?goods_id="+goodsid;
				}
			},
			error : function(data) {
				alert('error');
			}
		});
  }
  */
  function productrecommend(goodid,goodname){
	 alert(goodid);
	 alert(typeof goodid);
	 $.ajax({
		type : "POST",
		url : contextPath + "/productrecommend",
		headers : {"X-CSRF-Token":csrf},
		data : {good : 1,bookid : goodid,bookname : goodname},
		success : function(data){
			if(data == 1){
				alert('이미 추천을 한 도서입니다.');
				return;
			} else {
				alert('도서 추천을 하셨습니다.');
			}
		},
		error : function(){
			alert('에러 발생');
		}
	 });
  }