var csrf = document.getElementById("csrftoken").value;
function cancelPay() {
	      $.ajax({
	        "url": "/shoppingmall/cancel",
	        "type": "POST",
	        "headers" : {"X-CSRF-Token":csrf},
	        "contentType": "application/json",
	        "data": JSON.stringify({
	          "merchant_uid": "${Order.merchant_id}", // 주문번호
	          "cancel_request_amount": "${Order.price}", // 환불금액
	          "reason": document.getElementById('reason').value, // 환불사유
	          "refund_holder": "${vbank_holder}", // [가상계좌 환불시 필수입력] 환불 가상계좌 예금주
	          "refund_bank": "${vbank_code}", // [가상계좌 환불시 필수입력] 환불 가상계좌 은행코드(ex. KG이니시스의 경우 신한은행은 88번)
	          "refund_account": "${vbank_num}" // [가상계좌 환불시 필수입력] 환불 가상계좌 번호
	        }),
	        "dataType": "json"
	      }).done(function(result){
	    	  console.log(result);
	    	  var cancelstatus = result.status;
	    	  console.log("cancelstatus : " + cancelstatus);
	    	  var canceldata = {"cancel" : cancelstatus, "merchant_id" : "${Order.merchant_id}"}
	    	  
	    	  $.ajax({
				"url" : "/shoppingmall/cancelstatus",
				"type" : "POST",
				"headers" : { "Content-Type": "application/json","X-CSRF-Token":csrf},
				"data" : JSON.stringify(canceldata),
				success : function(){
					alert('status 변화 성공');
				},
				error : function(){
					alert('error');
				}
	    	  });
	    	  alert('환불 성공');
	      }).fail(function(error){
	    	  console.log(error);
	    	  alert('환불 실패'); 
	      });
	    }