		var csrf = document.getElementById("csrftoken").value;
		function makeid(){
			var text = "";
			var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzdskjlAFDSGDFHGDFGjlsdfkjsdfjlsdgA";
			for( var i=0; i < 15; i++ )
				text += possible.charAt(Math.floor(Math.random() * possible.length));
			return text;
		}
		var csrf = $("#csrftoken").val();
		function paymentPhone(userid){
					$("#paymentPhone").removeAttr("onclick");
					var user_merchant = null;
					 if(userid == "")
						 location.href = contextPath + "/loginForm";
					var sname = document.getElementById("sname").value;
					//var sphone = document.getElementById("sphone1").value.trim()+document.getElementById("sphone2").value.trim()+document.getElementById("sphone3").value.trim();
					var sphone = document.getElementById("sphone").value.trim();
					var saddr = document.getElementById("saddr").value;
					var semail = document.getElementById("semail").value;
					var smemo = document.getElementById("smemo").value; 
					var scoupon = document.getElementById("scoupon").value.trim();
					
					if(sname == "" || sphone == "" || saddr == "" || semail == "" || smemo == "") {
						alert("배송 정보를 모두 기입해주세요.");
						return;
					}
					
					if(document.getElementById('tmoney').value == 0) {
						alert('물품을 장바구니에 담아주세요');
					}
					
					var ordernum = makeid();
					var obj = {"id" : userid,"merchant_id" : ordernum,"phoneNumber" : sphone,"address" : saddr,
							"buyer_name" : sname,"memo" : smemo,"price" : document.getElementById("tmoney").value,
							"coupon" : scoupon} //"${User.phoneNumber}" "${User.address}"
					var IMP = window.IMP; 
					IMP.init('imp79913276');
					$.ajax({
				        type:"POST",
				        url: contextPath + "/InsertMerchantId",
				        data : JSON.stringify(obj),
				        headers: { "Content-Type": "application/json","X-CSRF-Token":csrf},
				        success: function(data){
				        	if(data == "formupdated"){
				        		alert("폼 값을 수정하셨습니다.다시 시도해주십시오.");
				        		return;
				        	}
				        	user_merchant = data;
				        	console.log("user_merchant : " + user_merchant);
							document.onkeydown = noEvent;
							$.ajax({
								type : "POST",
								url : contextPath + "/unitInStockShortageCheck",
								data : JSON.stringify({"booknamelist" : booknamelist,"bookqtylist" : bookqtylist,"merchant_uid" : ordernum}),
								headers : { "Content-Type": "application/json","X-CSRF-Token":csrf},
								success : function(data){
									if(data == true) {
										alert('결제 도중에 책의 재고가 부족하여 결제를 할 수가 없습니다.');
										return;
									}
							IMP.request_pay({
							    pg : 'inicis', // version 1.1.0부터 지원.
							    pay_method : 'phone',
							    merchant_uid : user_merchant,
							    name : "forallshoppingmall 주문 결제",
							    amount : document.getElementById('tmoney').value,
							    buyer_name : sname, //"${User.name}"
							    buyer_tel : sphone, //"${User.phoneNumber}"
							    buyer_addr : saddr, //"${User.address}"
							    buyer_email : semail,
							    //m_redirect_url: "https://www.forallshoppingmall.com/mobile?booknamelist=" + booknamelist + "&bookqtylist=" + bookqtylist + "&amount=" + document.getElementById('tmoney').value + "&coupon=" + document.getElementById('CouponId').value
							    m_redirect_url: "https://192.168.0.198:8443/shoppingmall/mobile?booknamelist=" + booknamelist + "&bookqtylist=" + bookqtylist + "&amount=" + document.getElementById('tmoney').value + "&coupon=" + document.getElementById('CouponId').value
							}, function(rsp) {
							    if ( rsp.success ) {
							    	console.log(rsp);
						   			console.log("user_merchant : " + user_merchant);
							    	console.log("merchant_uid : " + rsp.merchant_uid);
							    	var mydata = {
							    			"imp_uid" : rsp.imp_uid,
							    			"merchant_uid" : rsp.merchant_uid, 
							    			"booknamelist" : booknamelist,
							    			"bookqtylist" : bookqtylist,
							    			"merchant_id" : user_merchant,
							    			"price" : rsp.paid_amount,
							    			"coupon" : document.getElementById("CouponId").value,
							    			"getTokenURL" : "https://api.iamport.kr/users/getToken",
						    				"getPayResultURL" : "https://api.iamport.kr/payments/"
							    			};
							        var msg = '결제가 완료되었습니다.';
							        msg += '고유ID : ' + rsp.imp_uid;
							        msg += '상점 거래ID : ' + rsp.merchant_uid;
							        msg += '결제 금액 : ' + rsp.paid_amount;
							        $.ajax({
							            url: contextPath + "/completeToken", // 가맹점 서버
							            method: "POST",
							            headers: { "Content-Type": "application/json","X-CSRF-Token":csrf},
							            data: JSON.stringify(mydata)
							        }).done(function (data) {		//만약 컨트롤러에서 json.toString()으로 해주었다면,JSON.parse(data)를 했어야 했음!
							        	console.log(data);
							        	  switch(data.check) {
							              	case 'success':
												location.href = contextPath + "/OrderResult?merchant_id=" + rsp.merchant_uid;
												return false;
							              	case 'failed':
							              		alert('결제 실패');
							              		location.href = contextPath + "/error";
							        	 }
							        });
							      } else {
							    	  var merchantdata = { "merchant_id" : user_merchant }
							    	  document.onkeydown = null;
							    	  $.ajax({
							    		url : contextPath + "/stop",
							    		method : "POST",
							    		headers : {"Content-Type" : "application/json","X-CSRF-Token":csrf},
							    		data : JSON.stringify(merchantdata),
							    		success : function(){
							    			alert("결제에 실패하였습니다");
							    		},
							    		complete : function(){
							    			$("#paymentPhone").attr("onclick","paymentPhone(" + "'" + userid + "'" + ");return false");
							    		}
							    	  });
							        }
						     });
						  },
						  error : function(){
							  $("#paymentPhone").attr("onclick","paymentPhone(" + "'" + userid + "'" + ");return false");
							  alert('에러 발생');
						  }
						});
				        }
						,
				        error: function(xhr, status, error) {
				        	$("#paymentPhone").attr("onclick","paymentPhone(" + "'" + userid + "'" + ");return false");
				        }  
				    });
				}
				
	function paymentCard(userid){		//카드 결제
	$("#paymentCard").removeAttr("onclick");
	var user2_merchant = null;	
	 if(userid == "")
		 location.href = contextPath + "/loginForm";
	var sname = document.getElementById("sname").value;
	//var sphone = document.getElementById("sphone1").value.trim()+document.getElementById("sphone2").value.trim()+document.getElementById("sphone3").value.trim();
	var sphone = document.getElementById("sphone").value.trim();
	var saddr = document.getElementById("saddr").value;
	var semail = document.getElementById("semail").value;
	var smemo = document.getElementById("smemo").value; 
	var scoupon = document.getElementById("scoupon").value;
	
	if(sname == "" || sphone == "" || saddr == "" || semail == "" || smemo == "") {
		alert("배송 정보를 모두 기입해주세요.");
		return;
	}
	if(document.getElementById('tmoney').value == 0) {
		alert('물품을 장바구니에 담아주세요');
	}
	
	var ordernum = makeid();
	var obj = {"id" : userid,"merchant_id" : ordernum,"phoneNumber" : sphone,"address" : saddr,
				"buyer_name" : sname,"memo" : smemo,"price" : document.getElementById("tmoney").value,
				"coupon" : scoupon}
		var IMP = window.IMP; 
		IMP.init('imp79913276');
		$.ajax({
	        type:"POST",
	        url: contextPath + "/InsertMerchantId",
	        data : JSON.stringify(obj),
	        headers: { "Content-Type": "application/json","X-CSRF-Token":csrf},
	        success: function(data){
	        	if(data == "formupdated"){
	        		alert("폼 값을 수정하셨습니다.다시 시도해주십시오.");
	        		return;
	        	}
	        	user2_merchant = data;
				document.onkeydown = noEvent;
				
				$.ajax({
					type : "POST",
					url : contextPath + "/unitInStockShortageCheck",
					data : JSON.stringify({"booknamelist" : booknamelist,"bookqtylist" : bookqtylist,"merchant_uid" : ordernum}),
					headers : { "Content-Type": "application/json","X-CSRF-Token":csrf},
					success : function(data){
						if(data == true){
							alert('결제 도중에 책의 재고가 부족하여 결제를 할 수가 없습니다.');
							return;
						}
				IMP.request_pay({
				    pg : 'inicis', // version 1.1.0부터 지원.
				    pay_method : 'card',
				    merchant_uid : user2_merchant,
				    name : "forallshoppingmall 주문 결제",
				    amount : document.getElementById('tmoney').value,
				    buyer_name : sname,
				    buyer_tel : sphone,
				    buyer_addr : saddr,
				    buyer_email : semail,
				    m_redirect_url: "https://www.forallshoppingmall.com/mobile?booknamelist=" + booknamelist + "&bookqtylist=" + bookqtylist + "&amount=" + document.getElementById('tmoney').value + "&coupon=" + document.getElementById('CouponId').value
				}, function(rsp) {
				    if ( rsp.success ) {
				    	console.log("rsp : " + rsp);
				    	console.log("merchant_uid : " + rsp.merchant_uid);
				    	var mydata = {
				    			"imp_uid" : rsp.imp_uid,
				    			"merchant_uid" : rsp.merchant_uid,
				    			"booknamelist" : booknamelist,
				    			"bookqtylist" : bookqtylist,
				    			"merchant_id" : user2_merchant,
				    			"price" : rsp.paid_amount,
				    			"coupon" : document.getElementById("CouponId").value,
				    			"getTokenURL" : "https://api.iamport.kr/users/getToken",
			    				"getPayResultURL" : "https://api.iamport.kr/payments/"
			    				};
				        var msg = '결제가 완료되었습니다.';
				        msg += '고유ID : ' + rsp.imp_uid;
				        msg += '상점 거래ID : ' + rsp.merchant_uid;
				        msg += '결제 금액 : ' + rsp.paid_amount;
				        msg += '카드 승인번호 : ' + rsp.apply_num;
				        $.ajax({
				            url: contextPath + "/completeToken", // 가맹점 서버
				            method: "POST",
				            headers: { "Content-Type": "application/json","X-CSRF-Token":csrf},
				            data: JSON.stringify(mydata),
				            dataType : "json",
				        }).done(function (data) {
				        	  switch(data.check) {
				              	case 'success':
									alert('결제 성공');
									location.href = contextPath + "/OrderResult?merchant_id=" + rsp.merchant_uid;
									return false;
				              	case 'fail':
				              		alert('결제 실패');
				            }
				        });
				      } else {
				    	  var merchantdata = { "merchant_id" : user2_merchant }
				    	  document.onkeydown = null;
				    	  $.ajax({
				    		url : contextPath + "/stop",
				    		method : "POST",
				    		headers : {"Content-Type" : "application/json","X-CSRF-Token":csrf},
				    		data : JSON.stringify(merchantdata),
				    		success : function(){
				    			alert("결제에 실패하였습니다");
				    		},
				    		complete : function(){
				    			$("#paymentCard").attr("onclick","paymentCard(" + "'" + userid + "'" + ");return false");
				    		}
				    	  });
				        }
			     });
				},error : function(){
					$("#paymentCard").attr("onclick","paymentCard(" + "'" + userid + "'" + ");return false");
				}
			 });
	        },
	        error: function(xhr, status, error) {
	        	$("#paymentCard").attr("onclick","paymentCard(" + "'" + userid + "'" + ");return false");
	        }  
	  });
   }
	
	function paymentWithOutDeposit(userid){
		$("#paymentWithOutDeposit").removeAttr("onclick");
		var user3_merchant;
		alert('송금자명과 배송자 정보의 이름을 동일하게 입력해주세요.');
		 if(userid == "")
			 location.href = contextPath + "/loginForm";
		var sname = document.getElementById("sname").value;
		//var sphone = document.getElementById("sphone1").value.trim()+document.getElementById("sphone2").value.trim()+document.getElementById("sphone3").value.trim();
		var sphone = document.getElementById("sphone").value;
		var smemo = document.getElementById("smemo").value; 
		var saddr = document.getElementById("saddr").value;
		var semail = document.getElementById("semail").value;
		var scoupon = document.getElementById("scoupon").value;
		
		if(sname == "" || sphone == "" || saddr == "" || semail == "" || smemo == "") {
			alert("배송 정보를 모두 기입해주세요.");
			return;
		}
		
		if(document.getElementById('tmoney').value == 0) {
			alert('물품을 장바구니에 담아주세요');
		}
		var ordernum = makeid();
		var obj = {"id" : userid,"merchant_id" : ordernum,"phoneNumber" : sphone,"address" : saddr,
				"buyer_name" : sname,"memo" : smemo,"price" : document.getElementById("tmoney").value,
				"coupon" : scoupon}
		var IMP = window.IMP; 
		IMP.init('imp79913276');
		$.ajax({
	        type:"POST",
	        url: contextPath + "/InsertMerchantId",
	        data : JSON.stringify(obj),
	        headers: { "Content-Type": "application/json","X-CSRF-Token":csrf},
	        success: function(data){
	        	if(data == "formupdated"){
	        		alert("폼 값을 수정하셨습니다.다시 시도해주십시오.");
	        		return;
	        	}
	        	user3_merchant = data;
	        	console.log("user3_merchant : " + user3_merchant);
				document.onkeydown = noEvent;
				$.ajax({
					type : "POST",
					url : contextPath + "/unitInStockShortageCheck",
					data : JSON.stringify({"booknamelist" : booknamelist,"bookqtylist" : bookqtylist,"merchant_uid" : ordernum}),
					headers : { "Content-Type": "application/json","X-CSRF-Token":csrf},
					success : function(data){
						if(data == true){
							alert('결제 도중에 책의 재고가 부족하여 결제를 할 수가 없습니다.');
							return;
						}
				IMP.request_pay({
				    pg : 'inicis', // version 1.1.0부터 지원.
				    pay_method : 'vbank',
				    merchant_uid : user3_merchant,
				    name : "forallshoppingmall 주문 결제",
				    amount : document.getElementById('tmoney').value,  //결제 금액
				    buyer_name : sname,
				    buyer_tel : sphone,
				    buyer_addr : saddr,
				    buyer_email : semail,
				    m_redirect_url: "https://www.forallshoppingmall.com/mobile?booknamelist=" + booknamelist + "&bookqtylist=" + bookqtylist + "&amount=" + document.getElementById('tmoney').value + "&coupon=" + document.getElementById('CouponId').value
				    //m_redirect_url: "https://192.168.0.20:8443/shoppingmall/mobile?booknamelist=" + booknamelist + "&bookqtylist=" + bookqtylist + "&amount=" + document.getElementById('tmoney').value + "&coupon=" + document.getElementById('CouponId').value
				}, function(rsp) {
				    if ( rsp.success ) {
				    	console.log(rsp);
				    	console.log(rsp.vbank_holder);
				    	console.log("merchant_uid : " + rsp.merchant_uid);
				    	var mydata = {"imp_uid" : rsp.imp_uid,
				    				  "merchant_uid" : rsp.merchant_uid,
						    		  "booknamelist" : booknamelist,
						    		  "bookqtylist" : bookqtylist,
						    		  "merchant_id" : user3_merchant,
						    		  "price" : rsp.paid_amount,
				    				  "vbanknum": rsp.vbank_num,
				    				  "vbankname": rsp.vbank_name,
				    				  "vbankdate": rsp.vbank_date,
				    				  "vbankholder" : rsp.vbank_holder,
				    				  "coupon" : document.getElementById("CouponId").value,
				    				  "getTokenURL" : "https://api.iamport.kr/users/getToken",
				    				  "getPayResultURL" : "https://api.iamport.kr/payments/"
				    				  }
				    	var msg = '결제가 완료되었습니다.';
				        msg += '고유ID : ' + rsp.imp_uid;
				        msg += '상점 거래ID : ' + rsp.merchant_uid;
				        msg += '결제 금액 : ' + rsp.paid_amount;
				        msg += '카드 승인번호 : ' + rsp.apply_num;
				        $.ajax({
				            url: contextPath + "/completeToken", // 가맹점 서버
				            method: "POST",
				            headers: { "Content-Type": "application/json","X-CSRF-Token":csrf},
				            dataType : "json",
				            data: JSON.stringify(mydata),
				        }).done(function (data) {
				        	  switch(data.check) {
				              	case 'vbankIssued':
				              		alert('무통장 입금 결제 성공');
				              		console.log(data.data);
									location.href = contextPath + "/OrderResult?merchant_id=" + rsp.merchant_uid + "&vbanknum=" + data.vbanknum + "&vbankname=" + rsp.vbank_name + "&vbankholder=" + data.data.buyer_name + "&vbankcode=" + data.data.vbank_code + "&vbankdate=" + rsp.vbank_date;
				              		break;
				              	case 'success':
									alert('결제 성공');
									location.href = contextPath + "/OrderResult?merchant_id=" + rsp.merchant_uid;
									return false;
				              	case 'failed':
				              		alert('결제 실패');
				              		location.href = contextPath + "/error";
				            }
				        });
				      } else {
				    	  var merchantdata = { "merchant_id" : user3_merchant }
				    	  document.onkeydown = null;
				    	  $.ajax({
				    		url : contextPath + "/stop",
				    		method : "POST",
				    		headers : {"Content-Type" : "application/json","X-CSRF-Token":csrf},
				    		data : JSON.stringify(merchantdata),
				    		success : function(){
				    			alert("결제에 실패하였습니다");
				    		},
				    		complete : function(){
				    			$("#paymentWithOutDeposit").attr("onclick","paymentWithOutDeposit(" + "'" + userid + "'" + ");return false");
				    		}
				    	  });
				        }
			     });
				},error : function() {
					$("#paymentWithOutDeposit").attr("onclick","paymentWithOutDeposit(" + "'" + userid + "'" + ");return false");
				}
			  });
	        },
	        error: function(xhr, status, error) {
	        	$("#paymentWithOutDeposit").attr("onclick","paymentWithOutDeposit(" + "'" + userid + "'" + ");return false");
	        }  
	    });
	}
		function paymentWithDeposit(userid){
			$("#paymentWithDeposit").removeAttr("onclick");
			var user4_merchant = null;
					if(userid == "")
						location.href = contextPath + "/loginForm";
					var sname = document.getElementById("sname").value;
					//var sphone = document.getElementById("sphone1").value.trim()+document.getElementById("sphone2").value.trim()+document.getElementById("sphone3").value.trim();
					var sphone = document.getElementById("sphone").value.trim();
					var smemo = document.getElementById("smemo").value; 
					var saddr = document.getElementById("saddr").value;
					var semail = document.getElementById("semail").value;
					var scoupon = document.getElementById("scoupon").value;
					
					if(sname == "" || sphone == "" || saddr == "" || semail == "") {
						alert("배송 정보를 모두 기입해주세요.");
						return;
					}			
					
					if(document.getElementById('tmoney').value == 0) {
						alert('물품을 장바구니에 담아주세요');
					}
						
			var ordernum = makeid();
			var obj = {"id" : userid,"merchant_id" : ordernum,"phoneNumber" : sphone,
					"address" : saddr,"buyer_name" : sname,"memo" : smemo,
					"price" : document.getElementById("tmoney").value,
					"coupon" : scoupon}
			var IMP = window.IMP; 
			IMP.init('imp79913276');
			$.ajax({
		        type:"POST",
		        url: contextPath + "/InsertMerchantId",
		        data : JSON.stringify(obj),
		        headers: { "Content-Type": "application/json" },
		        success: function(data){
		        	if(data == "formupdated"){
		        		alert("폼 값을 수정하셨습니다.다시 시도해주십시오.");
		        		return;
		        	}
		        	user4_merchant = data;
		        	console.log("user4_merchant : " + user4_merchant);
					document.onkeydown = noEvent;
					$.ajax({
						type : "POST",
						url : contextPath + "/unitInStockShortageCheck",
						data : JSON.stringify({"booknamelist" : booknamelist,"bookqtylist" : bookqtylist,"merchant_uid" : ordernum}),
						headers : { "Content-Type": "application/json","X-CSRF-Token":csrf},
						success : function(data){
							if(data == true){
								alert('결제 도중에 책의 재고가 부족하여 결제를 할 수가 없습니다.');
								return;
							}
					IMP.request_pay({
					    pg : 'inicis', // version 1.1.0부터 지원.
					    pay_method : 'trans',
					    merchant_uid : user4_merchant,
					    name : "forallshoppingmall 주문 결제",
					    amount : document.getElementById('tmoney').value,
					    buyer_name : sname,
					    buyer_tel : sphone,
					    buyer_addr : saddr,
					    buyer_email : semail,
					    m_redirect_url: "https://www.forallshoppingmall.com/mobile?booknamelist=" + booknamelist + "&bookqtylist=" + bookqtylist + "&amount=" + document.getElementById('tmoney').value + "&coupon=" + document.getElementById('CouponId').value
					}, function(rsp) {
					    if ( rsp.success ) {
					    	console.log(rsp);
					    	console.log("merchant_uid : " + rsp.merchant_uid);
					    	var mydata = {
					    			"imp_uid" : rsp.imp_uid ,
					    			"merchant_uid" : rsp.merchant_uid,
					    			"booknamelist" : booknamelist,
					    			"bookqtylist" : bookqtylist,
					    			"merchant_id" : user4_merchant,
					    			"price" : rsp.paid_amount,
					    			"coupon" : document.getElementById("CouponId").value,
					    			"getTokenURL" : "https://api.iamport.kr/users/getToken",
				    				"getPayResultURL" : "https://api.iamport.kr/payments/"
					    			};
					        var msg = '결제가 완료되었습니다.';
					        msg += '고유ID : ' + rsp.imp_uid;
					        msg += '상점 거래ID : ' + rsp.merchant_uid;
					        msg += '결제 금액 : ' + rsp.paid_amount;
					        msg += '카드 승인번호 : ' + rsp.apply_num;
					        $.ajax({
					            url: contextPath + "/completeToken", // 가맹점 서버
					            method: "POST",
					            headers: { "Content-Type": "application/json","X-CSRF-Token":csrf},
					            data: JSON.stringify(mydata),
					        }).done(function (data) {
					        	  switch(data.check) {
					              	case 'success':
										alert('결제 성공');
										location.href = contextPath + "/OrderResult?merchant_id=" + rsp.merchant_uid;
										return false;
					            }
					        });
					      } else {
					    	  var merchantdata = { "merchant_id" : user4_merchant }
					    	  document.onkeydown = null;
					    	  $.ajax({
					    		url : contextPath + "/stop",
					    		method : "POST",
					    		headers : {"Content-Type" : "application/json","X-CSRF-Token":csrf},
					    		data : JSON.stringify(merchantdata),
					    		success : function(){
					    			alert("결제에 실패하였습니다");
					    		},
					    		complete : function(){
					    			$("#paymentWithDeposit").attr("onclick","paymentWithDeposit(" + "'" + userid + "'" + ");return false");
					    		}
					    	  });
					       }
				     });
				   },error : function() {
					   $("#paymentWithDeposit").attr("onclick","paymentWithDeposit(" + "'" + userid + "'" + ");return false");
				   }
				 });
		        },
		        error: function(xhr, status, error) {
		        	$("#paymentWithDeposit").attr("onclick","paymentWithDeposit(" + "'" + userid + "'" + ");return false");
		        }  
		    });
		}
		
	function noEvent() {
		if (event.keyCode == 116) {
			event.keyCode= 2;
			return false;
		} else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82)) {
		  return false;
		}
	}
	
  		function usecoupon(cnumber){
  			if(cnumber.trim() == ""){
  				alert("쿠폰 번호를 입력해주세요");
  				return;
  			}
  			if(couponcheck == 1){
  				alert('쿠폰 중복 적용은 불가능합니다.');
  				return;
  			}
  			$.ajax({
  				url : contextPath + "/usedcouponcheck",
  				method : "POST",
  				headers : {"X-CSRF-Token":csrf},
  				data : {"cnumber" : cnumber.trim()},
  				success : function(data){
  					if(data == "1"){	//쿠폰 사용한 적 있음
  						alert("이미 사용한 쿠폰이거나 존재하지 않는 쿠폰입니다.");
  						return;
  					} else {
  						document.getElementById("CouponId").value = cnumber.trim();
  						$.ajax({
  							url : contextPath + "/usecoupon",
  							method: "POST",
  							data : {"cnumber" : cnumber.trim()},
  							success : function(data) {
  								if(data == 0 && couponcheck == 0){			//5% 할인
  									alert('쿠폰을 적용했습니다.');
  									document.getElementById('tmoney').value = $("#subtotal").html() * 0.95;
  									$("#subtotal").html($("#subtotal").html() * 0.95);
  									$("#total").html($("#total").html() * 0.95);
  									couponcheck = 1;
  								}
  								else if(data == 1 && couponcheck ==0){		//10%할인
  									alert('쿠폰을 적용했습니다.');
  									document.getElementById('tmoney').value = $("#subtotal").html() * 0.9;
  									$("#subtotal").html($("#subtotal").html() * 0.9);
  									$("#total").html($("#total").html() * 0.9);
  									couponcheck = 1;
  								}
  								else if(data == 2 && couponcheck ==0){ 		//15%할인
  									alert('쿠폰을 적용했습니다.');
  									document.getElementById('tmoney').value = $("#subtotal").html() * 0.85;
  									$("#subtotal").html($("#subtotal").html() * 0.85);
  									$("#total").html($("#total").html() * 0.85);
  									couponcheck = 1;
  								}
  								else if(data == 3 && couponcheck ==0){		//20%할인
  									alert('쿠폰을 적용했습니다.');
  									document.getElementById('tmoney').value = $("#subtotal").html() * 0.8;
  									$("#subtotal").html($("#subtotal").html() * 0.8);
  									$("#total").html($("#total").html() * 0.8);
  									couponcheck = 1;
  								}
  								else if(data == 10)
  									alert("쿠폰이 존재하지 않거나 이미 사용한 쿠폰입니다");
  							},
  							error : function(err) {
  								alert('에러가 발생하였습니다.');
  							}
  						});
  					}
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
 function jeongbo(userid){ 
	 console.log(csrf);
	 $.ajax({
		 url : contextPath + "/jeongbo",
		 data : JSON.stringify({"Id" : userid}),
		 headers: {"Content-Type": "application/json","X-CSRF-Token":csrf},
		 method : "POST",
		 success : function(data) {
			document.getElementById("sname").value = data.name;
			document.getElementById("saddr").value = data.address;
			document.getElementById("sphone").value = data.phone;
			document.getElementById("semail").value = data.email;
		 },
		 error : function(err) {
			 console.log(err);
		}
	 })
 }
