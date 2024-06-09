var csrf = document.getElementById("csrftoken").value;
$(document).ready(function(){
    var myKey = "3e55oKGbQ4in2yahYWBuFA"; // sweet tracker에서 발급받은 자신의 키 넣는다.
        // 택배사 목록 조회 company-api
        $.ajax({
            type:"GET",
            dataType : "json",
            url:"https://info.sweettracker.co.kr/api/v1/companylist?t_key="+myKey,
            success:function(data){
                    var CompanyArray = data.Company;
                    console.log(CompanyArray); 
                    var myData="";
                    $.each(CompanyArray,function(key,value) {
                            myData += ('<option value='+value.Code+'>' +'key:'+key+', Code:'+value.Code+',Name:'+value.Name + '</option>');                        
                    });
                    $("#tekbeCompanyList").html(myData);
            }
        });
   
        // 배송정보와 배송추적 tracking-api
        $("#tekbebutton").click(function() {
            var t_code = $('#tekbeCompanyList option:selected').attr('value');
            var t_invoice = $('#invoiceNumberText').val();
            $.ajax({
                type:"GET",
                dataType : "json",
                url:"https://info.sweettracker.co.kr/api/v1/trackingInfo?t_key="+myKey+"&t_code="+t_code+"&t_invoice="+t_invoice,
                success:function(data){
                    console.log(data);
                    var myInvoiceData = "";
                    if(data.status == false){
                        myInvoiceData += ('<td>'+"오류"+'</td>');
                        myInvoiceData += ('<td>'+data.msg+'</td>');
                        myInvoiceData += ('<td>'+'</td>');
                        myInvoiceData += ('<td>'+'</td>');
                    }else{
                        myInvoiceData += ('<th>'+"보내는사람"+'</td>');                     
                        myInvoiceData += ('<th>'+data.senderName+'</td>');                     
                        myInvoiceData += ('</tr>');     
                        myInvoiceData += ('<tr>');                
                        myInvoiceData += ('<th>'+"제품정보"+'</td>');                     
                        myInvoiceData += ('<th>'+data.itemName+'</td>');                     
                        myInvoiceData += ('</tr>');     
                        myInvoiceData += ('<tr>');                
                        myInvoiceData += ('<th>'+"송장번호"+'</td>');                     
                        myInvoiceData += ('<th>'+data.invoiceNo+'</td>');                     
                        myInvoiceData += ('</tr>');     
                        myInvoiceData += ('<tr>');                
                        myInvoiceData += ('<th>'+"송장번호"+'</td>');                     
                        myInvoiceData += ('<th>'+data.receiverAddr+'</td>');                     
                    }
                    
                    $("#invoicefind").html(myInvoiceData)
                    var trackingDetails = data.trackingDetails;
                    
                    var myTracking="";
                    var header ="";
                    header += ('<th>'+"시간"+'</th>');
                    header += ('<th>'+"장소"+'</th>');
                    header += ('<th>'+"유형"+'</th>');
                    header += ('<th>'+"전화번호"+'</th>');                     
                    $("#trackingtekbe").html(header);
                    
                    $.each(trackingDetails,function(key,value) {
                    	var td1 = document.createElement("td"); 
                        td1.innerHTML = value.timeString; 
                        var td2 = document.createElement("td"); 
                        td2.innerHTML = value.where; 
                        var td3 = document.createElement("td"); 
                        td3.innerHTML = value.kind; 
                        var td4 = document.createElement("td"); 
                        td4.innerHTML = value.telno; 
                        
                   		var tr = document.createElement("tr"); 
                        tr.appendChild(td1); 
                        tr.appendChild(td2); 
                        tr.appendChild(td3); 
                        tr.appendChild(td4); 
                        
                        document.getElementById("tekbetable").appendChild(tr);
                    	
						//myTracking += ('<tr>');
						//myTracking += ('<td>' + value.timeString + '</td>');
						//myTracking += ('<td>' + value.where + '</td>');
					    //myTracking += ('<td>' + value.kind + '</td>');
						//myTracking += ('<td>' + value.telno + '</td>');
					    //myTracking += ('</tr>');
					    
				    });
						//$("#trackingtekbe2").html(myTracking);
				}
			});
		});
	});
				function cancelPay(i) {
					$.ajax({
						"url" : contextPath + "/refundadmin",
						"type" : "POST",
						"headers" : {"X-CSRF-Token":csrf},
						"contentType" : "application/json",
						"data" : JSON.stringify({
							"merchant_uid" : document.getElementById(i + 'merchantid').innerHTML, // 주문번호
							"cancel_request_amount" : document.getElementById(i + 'price').innerHTML // 환불금액
								}),
						success : function(result){
							var json = JSON.parse(result);
							if(json.check == 1){		//1이면 이미 존재,0이면 존재하지 않음
								alert("이미 환불 요청을 하셨습니다.");
								return;
							}
							if(json.result == 0)
								alert('요청 성공');
							},
							error : function() {
								alert('이미 환불 요청을 하셨습니다.');
							}
						});
				}
				
				function cancelPayVbank(i) {
					$.ajax({
							"url" : contextPath + "/refundadmin",
							"type" : "POST",
							"headers" : {"X-CSRF-Token":csrf},
							"contentType" : "application/json",
							"data" : JSON.stringify({
								"merchant_uid" : document.getElementById(i + 'merchant_uid').value, // 주문번호
								"cancel_request_amount" : document.getElementById(i + 'vbankprice').value, // 환불금액
								"refund_holder" : document.getElementById(i + 'holder').value, // [가상계좌 환불시 필수입력] 환불 가상계좌 예금주
								"refund_bank" : document.getElementById(i + 'code').value, // [가상계좌 환불시 필수입력] 환불 가상계좌 은행코드(ex. KG이니시스의 경우 신한은행은 88번)
								"refund_account" : document.getElementById(i + 'num').value
								}),
								success : function() {
									alert('환불 요청 성공');
								},
								error : function() {
									alert('이미 환불 요청을 하셨습니다.');
								}
							});
				}
