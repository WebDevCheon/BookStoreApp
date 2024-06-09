package spring.myapp.shoppingmall.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import spring.myapp.shoppingmall.dto.Order;
import spring.myapp.shoppingmall.dto.Vbank;
import spring.myapp.shoppingmall.service.AdminService;
import spring.myapp.shoppingmall.service.OrderService;

@Controller
public class PaymentAndRefundController {

	private static final Logger logger = LoggerFactory.getLogger(PaymentAndRefundController.class);

	@Autowired
	private OrderService orderService;

	@Autowired
	private AdminService adminService;

	@RequestMapping(value = "/iamport-webhook", method = RequestMethod.POST) // 고객이 무통장 입금으로 결제를 하거나,가상 계좌에 금액을 넣었을때 발생 -> 프로젝트에선 무통장 입금시만 처리
	public void webhook(@RequestParam(required = false) String imp_uid,		 // 다른 결제 수단은 웹훅 사용 안함
						@RequestParam(required = false) String merchant_uid, HttpServletRequest request,
						HttpServletResponse response, @RequestParam(required = false) String status, Model model) {
		if(status != null && !status.equals("paid")) // 가상계좌에 입금했거나 결제 완료
			return;
		int webhookflag = 0;
		Order order = orderService.getMerchantId(merchant_uid);
		if (!order.getPaymethod().equals("vbank")) {
			webhookflag = 0;
			logger.info("아임포트 서버 요청 stopping.");
			return;
		} else
			webhookflag = 1;

		if (webhookflag == 1) {
			try {
				JSONObject json = new JSONObject();
				String imp_key = URLEncoder.encode("IamPortKey", "UTF-8");
				String imp_secret = URLEncoder.encode(
						"IamPortSecretKey", "UTF-8");
				json.put("imp_key", imp_key);
				json.put("imp_secret", imp_secret);
				String token = getToken(json, "https://api.iamport.kr/users/getToken");
				JSONObject getdata = null;
				try {
					String requestString = "";
					URL url = new URL("https://api.iamport.kr/payments/" + imp_uid);
					HttpURLConnection connection = (HttpURLConnection) url.openConnection();
					connection.setDoOutput(true);
					connection.setInstanceFollowRedirects(false);
					connection.setRequestMethod("GET");
					connection.setRequestProperty("Authorization", token);
					connection.connect();
					StringBuilder sb = new StringBuilder();
					if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
						BufferedReader br = new BufferedReader(
								new InputStreamReader(connection.getInputStream(), "utf-8"));
						String line = null;
						while ((line = br.readLine()) != null) {
							sb.append(line + "\n");
						}
						br.close();
						requestString = sb.toString();
					}
					connection.disconnect();
					JSONParser jsonParser = new JSONParser();
					JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);
					logger.info("반환된 JSON객체 -> {}" + jsonObj);
					if ((Long) jsonObj.get("code") == 0) {
						getdata = (JSONObject) jsonObj.get("response"); // 이전에 책을 주문 할때,무통장 입금 신청을 했던 정보를 다시 가져옴
						logger.info("아임포트 서버로부터 가져온 결제 정보(다른 결제 방식과 무통장 입금 결제 방식의 결제 정보들도 있음) -> {}",getdata);
						int bepaid = getamount(merchant_uid);
						String amount = String.valueOf(getdata.get("amount"));
						String mystatus = String.valueOf(getdata.get("status"));
						if (String.valueOf(getdata.get("vbank_num")) == null) // 무통장 입금이 아니면 webhook을 종료시킨다. -> 무통장 입금만
							return;											  // 웹훅을 사용할 것이기 때문이다.
						String vbankholder = String.valueOf(getdata.get("vbank_holder"));
						String vbanknum = String.valueOf(getdata.get("vbank_num"));
						String vbankcode = String.valueOf(getdata.get("vbank_code"));
						String paymethod = String.valueOf(getdata.get("pay_method"));

						Vbank vbank = new Vbank();
						vbank.setVbanknum(vbanknum);
						vbank.setVbankholder(vbankholder);
						vbank.setVbankcode(vbankcode);

						Order vbankorder = new Order();
						vbankorder.setMerchant_id(merchant_uid);
						vbankorder.setStatus(mystatus);
						vbankorder.setImp_uid(imp_uid);
						vbankorder.setPaymethod(paymethod);
						vbankorder.setPrice(bepaid);

						if (bepaid <= Integer.valueOf(amount) && vbanknum != null) {
							switch (mystatus) {
								case "paid": // 고객이 가상 계좌에 돈을 입금 했을때
									orderService.updateStatusWebhook(vbankorder, vbank); // 결제 완료로 바꾸기
							}
						}
					}
				} catch (Exception e) {
					logger.info("에러 발생 In webhook Method -> " + e,e);
				}
			} catch (Exception e) {
				logger.info("에러 발생 In webhook Method -> " + e,e);
			}
		}
	}

	@RequestMapping("/mobile")	// IMPORT 서버에서 카드사 서버로 결제가 완료된 이후에 쇼핑몰 서버에 결제 정보를 돌려주고 Redirect 될 URL(Mobile기기로 결제했을때만)
	public String mobile(@RequestParam String coupon, @RequestParam String imp_uid, @RequestParam String merchant_uid,
						 HttpServletRequest request, HttpServletResponse response, Model model, @RequestParam String[] booknamelist,
						 @RequestParam Integer[] bookqtylist, @RequestParam String amount, HttpSession session) {
		String referer = (String) request.getHeader("REFERER");		// REFERER 사용 이유 : 사용자가 만약에 주문 도중에 뒤로 가기 버튼을 누르게 되면,
		// 정확한 주문이 DB에 저장이 안될수 있기 때문에 사전에 차단하기 위함
		try {
			JSONObject json = new JSONObject();
			orderService.insertPrice(amount, merchant_uid);
			String imp_key = URLEncoder.encode("IamPortKey", "UTF-8");
			String imp_secret = URLEncoder.encode(
					"IamPortSecretKey", "UTF-8");
			json.put("imp_key", imp_key);
			json.put("imp_secret", imp_secret);
			String token = getToken(json, "https://api.iamport.kr/users/getToken");
			JSONObject getdata = null;
			try {
				String requestString = "";
				URL url = new URL("https://api.iamport.kr/payments/" + imp_uid);
				HttpURLConnection connection = (HttpURLConnection) url.openConnection();
				connection.setDoOutput(true);
				connection.setInstanceFollowRedirects(false);
				connection.setRequestMethod("POST");
				connection.setRequestProperty("Authorization", token);
				connection.connect();
				StringBuilder sb = new StringBuilder();
				if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
					BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
					String line = null;
					while ((line = br.readLine()) != null) {
						sb.append(line + "\n");
					}
					br.close();
					requestString = sb.toString();
				}
				connection.disconnect();
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);

				if ((Long) jsonObj.get("code") == 0) {
					getdata = (JSONObject) jsonObj.get("response");
					logger.info("모바일 결제 결과 -> {}", getdata);
					int bepaid = getamount(merchant_uid);
					String getamount = String.valueOf(getdata.get("amount"));
					String mystatus = String.valueOf(getdata.get("status"));
					String paymethod = String.valueOf(getdata.get("pay_method"));

					if (mystatus.equals("paid")
							&& referer.contains("https://ksmobile.inicis.com/smart/mobileAcsCancel")) {
						return "redirect:/showbasket";
					}
					if (bepaid <= Integer.valueOf(getamount) && merchant_uid.equals(getdata.get("merchant_uid"))) {
						switch (mystatus) {
							case "ready":
								SimpleDateFormat timeformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
								Calendar time = Calendar.getInstance();
								String vbank_num = String.valueOf(getdata.get("vbank_num"));
								String vbank_code = String.valueOf(getdata.get("vbank_code"));
								String vbank_date = timeformat.format(time.getTime());
								String vbank_name = String.valueOf(getdata.get("vbank_name"));
								String vbank_holder = String.valueOf(getdata.get("vbank_holder"));
								String vbank_person = String.valueOf(getdata.get("buyer_name"));

								Vbank vbank = new Vbank();
								vbank.setVbanknum(vbank_num);
								vbank.setVbankname(vbank_name);
								vbank.setVbankdate(vbank_date);
								vbank.setVbankholder(vbank_holder);
								vbank.setVbankcode(vbank_code);

								Order vbankorder = new Order();
								vbankorder.setMerchant_id(merchant_uid);
								vbankorder.setName((String) getdata.get("buyer_name"));
								vbankorder.setStatus((String) getdata.get("status"));
								vbankorder.setImp_uid(imp_uid);
								vbankorder.setPaymethod(paymethod);
								vbankorder.setPrice(Integer.valueOf(getamount));
								vbankorder.setCouponid(coupon);

								if (orderService.mobileCheckByMerchantUid(merchant_uid)) {
									model.addAttribute("vbank_date", vbank_date);
									model.addAttribute("vbank_holder", vbank_holder); // 구매자
									model.addAttribute("vbank_num",
											orderService.getVbankInfo(merchant_uid).getVbanknum()); // 은행 계좌번호
									model.addAttribute("vbank_name", vbank_name); // 은행 이름
									model.addAttribute("vbank_code", vbank_code);
									model.addAttribute("Order", orderService.getMerchantId(merchant_uid));
									model.addAttribute("Ordergoods", orderService.getOrderGoods(merchant_uid));
									model.addAttribute("method", "mobile");
									return "/order/orderresult";
								}

								int vbankinsertcheck = orderService.InsertVbankAndUpdateStatus(vbankorder, vbank,
										booknamelist, bookqtylist);

								if (vbankinsertcheck == 1) {
									model.addAttribute("vbank_date", vbank_date);
									model.addAttribute("vbank_holder", vbank_holder); // 구매자
									model.addAttribute("vbank_num",
											orderService.getVbankInfo(merchant_uid).getVbanknum()); // 은행 계좌번호
									model.addAttribute("vbank_name", vbank_name); // 은행 이름
									model.addAttribute("vbank_code", vbank_code);
									model.addAttribute("Order", orderService.getMerchantId(merchant_uid));
									model.addAttribute("Ordergoods", orderService.getOrderGoods(merchant_uid));
									model.addAttribute("method", "mobile");
									return "/order/orderresult";
								} else
									return "/error/404code";

							case "paid":
								Order order = new Order();
								order.setMerchant_id(merchant_uid);
								order.setName((String) getdata.get("buyer_name"));
								order.setStatus((String) getdata.get("status"));
								order.setImp_uid(imp_uid);
								order.setPaymethod(paymethod);
								order.setPrice(Integer.valueOf(getamount));
								order.setCouponid(coupon);

								if (orderService.mobileCheckByMerchantUid(merchant_uid)) {
									model.addAttribute("Order", orderService.getMerchantId(merchant_uid));
									model.addAttribute("Ordergoods", orderService.getOrderGoods(merchant_uid));
									model.addAttribute("method", "mobile");
									return "/order/orderresult";
								}

								int paidcheck = orderService.updateStatusAndOrder(order, booknamelist, bookqtylist);	// 주문 정보를 갱신

								if (paidcheck == 1) {
									model.addAttribute("Order", orderService.getMerchantId(merchant_uid));
									model.addAttribute("Ordergoods", orderService.getOrderGoods(merchant_uid));
									model.addAttribute("method", "mobile");
									return "/order/orderresult";
								} else {
									return "/error/404code";
								}
							case "failed":	// 결제 실패
								orderService.deleteMerchantId((String) getdata.get("merchant_uid"));
						}
					} else
						return "mobilefailed";
				}
			} catch (Exception e) {
				logger.info("에러 발생 In mobile Method -> " + e,e);
			}
		} catch (Exception e) {
			logger.info("에러 발생 In mobile Method -> " + e,e);
		}
		return null;
	}

	@PostMapping("/InsertMerchantId")	// 결제창을 눌렀을때 미리 DB에 주문에 대하여 DB 정보를 삽입함,주문 취소되면 삭제됨
	@ResponseBody
	public ResponseEntity<String> InsertMerchantId(HttpSession session,@RequestBody HashMap<String,Object> map){
		if(orderService.orderPayCheck((String)session.getAttribute("Userid"),(String)map.get("price"),
				(String)map.get("coupon")) == 1) {  //결제할 돈의 액수를 클라이언트에서 수정한 경우 체크
			return new ResponseEntity<String>("formupdated",HttpStatus.OK);
		}
		String Userid = (String)map.get("id");
		String merchant_id = (String)map.get("merchant_id");
		String phoneNumber = (String)map.get("phoneNumber");
		String address = (String)map.get("address");
		String buyer_name = (String)map.get("buyer_name");
		String memo = (String)map.get("memo");
		String price = (String)map.get("price");
		orderService.InsertMerchant(Userid,merchant_id,phoneNumber,address,buyer_name,memo,Integer.valueOf(price));
		return new ResponseEntity<String>(merchant_id,HttpStatus.OK);
	}

	@PostMapping("/unitInStockShortageCheck")	// 결제창을 누를때 만약 책의 개수가 부족한지 아닌지 확인
	@ResponseBody
	public boolean unitInStockShortageCheck(@RequestBody HashMap<String,Object> map) {
		List<String> booknamelist = (ArrayList<String>)(map.get("booknamelist"));
		List<Integer> bookqtylist = (ArrayList<Integer>)(map.get("bookqtylist"));
		String merchant_id = (String)map.get("merchant_uid");
		return orderService.unitInStockCheck(booknamelist,bookqtylist,merchant_id);
	}

	@PostMapping("/completeToken")  // 결제 이후에 IMPORT서버로부터 온 결제 정보를 쇼핑몰 서버의 MySQL DB에 주문 정보를 동기화 과정
	public ResponseEntity<JSONObject> synchronizationOrderTable(@RequestBody HashMap<String,Object> map,HttpSession session) throws Exception{
		JSONObject json = new JSONObject();
		String imp_key = URLEncoder.encode("IamPortKey", "UTF-8");
		String imp_secret =	URLEncoder.encode("IamPortSecretKey", "UTF-8");
		String getTokenURL = (String)map.get("getTokenURL");
		String getPayResultURL = (String)map.get("getPayResultURL");
		json.put("imp_key",imp_key);
		json.put("imp_secret", imp_secret);
		try {
			String token = getToken(json,getTokenURL);
			JSONObject getdata = null; // 아임포트 서버에서 받아올 json 객체 null로 초기화
			JSONObject paymentjson = requestPaymentinfo(map,token,getdata,getPayResultURL + (String)map.get("imp_uid"),session);		// 결제가 적절하게 된 것인지 import 서버에 결제 정보를 요청
			if(paymentjson == null)
				return new ResponseEntity<JSONObject>(HttpStatus.BAD_REQUEST);
			return new ResponseEntity<JSONObject>(paymentjson,HttpStatus.OK);
		} catch(Exception e) {
			logger.info("에러 발생 In synchronizationOrderTable Method -> " + e,e);
			JSONObject exceptionjson = new JSONObject();
			exceptionjson.put("check","failed");
			return new ResponseEntity<JSONObject>(exceptionjson,HttpStatus.OK);
		}
	}

	public static String getToken(JSONObject json, String requestURL) {		// 아임포트 서버로부터 토큰 받아오기
		String _token = "";
		try {
			String requestString = "";
			URL url = new URL(requestURL);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setInstanceFollowRedirects(false);
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Content-Type", "application/json");
			connection.connect();
			OutputStream os = connection.getOutputStream();
			os.write(json.toString().getBytes());
			os.flush();
			StringBuilder sb = new StringBuilder();
			if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
				BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
				String line = null;
				while ((line = br.readLine()) != null) {
					sb.append(line + "\n");
				}
				br.close();
				requestString = sb.toString();
			}
			connection.disconnect();
			try {
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);
				if ((Long) jsonObj.get("code") == 0) {
					JSONObject getToken = (JSONObject) jsonObj.get("response");
					_token = (String) getToken.get("access_token");
				}
			} catch (Exception e) {
				logger.info("에러 발생 In getToken Method -> " + e,e);
			}
		} catch (Exception e) {
			logger.info("에러 발생 In getToken Method -> " + e,e);
			_token = "";
		}
		return _token;
	}

	private JSONObject requestPaymentinfo(HashMap<String,Object> map,String token,JSONObject getdata,String requestURL,
										  HttpSession session) {		// 결제 요청 메소드
		try{
			String requestString = "";
			URL url = new URL(requestURL);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setInstanceFollowRedirects(false);
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Authorization", token);
			connection.connect();
			StringBuilder sb = new StringBuilder();
			if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
				BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
				String line = null;
				while ((line = br.readLine()) != null) {
					sb.append(line + "\n");
				}
				br.close();
				requestString = sb.toString();
			}
			connection.disconnect();
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);
			if((Long)jsonObj.get("code")  == 0){
				getdata = (JSONObject) jsonObj.get("response");
				if(getdata != null)
					logger.info("MySQL에서 관리하는 주문 정보 ID : {},Payment Info from IamportServer : {}",(String)(map.get("merchant_uid")),getdata);
			}
		} catch(Exception e){
			logger.info("유저 아이디 : {}",session.getAttribute("Userid"));
			logger.info("에러 발생 In requestPaymentinfo Method -> " + e,e);
			JSONObject exceptionjson = new JSONObject();
			exceptionjson.put("check","failed");
			return exceptionjson;
		}
		String amount = String.valueOf(getdata.get("amount"));
		String status = String.valueOf(getdata.get("status"));
		int bepaid = getamount((String)(map.get("merchant_uid")));
		String couponid = (String)(map.get("coupon"));
		ArrayList<String> booknamelistArraylist = (ArrayList<String>)map.get("booknamelist");
		String[] list = booknamelistArraylist.toArray(new String[booknamelistArraylist.size()]);
		ArrayList<Integer> bookqtylistArraylist = (ArrayList<Integer>)map.get("bookqtylist");
		Integer[] bookqtylist = new Integer[bookqtylistArraylist.size()];
		for (int i = 0; i < bookqtylist.length; i++)
			bookqtylist[i] = bookqtylistArraylist.get(i);
		String merchant_uid = (String)map.get("merchant_uid");
		String imp_uid = (String)map.get("imp_uid");
		String merchant_id = (String)map.get("merchant_id");
		int pricefromserver = (Integer)map.get("price");
		String price = Integer.toString(pricefromserver);
		String paymethod = String.valueOf(getdata.get("pay_method"));
		logger.info("고객이 지불한 액수 -> {},지불해야할 액수 -> {}",Integer.valueOf(amount),bepaid);
		logger.info("주문 상태 -> {}",status);
		logger.info("아임포트 서버에서 관리하는 주문 ID : {}",imp_uid);
		logger.info("책 쇼핑몰 DB에서 관리되는 주문 번호 -> {}",merchant_id);
		logger.info("아임포트 서버에서 보내준 주문 아이디 -> {}",merchant_uid);
		JSONObject resjson = new JSONObject();
		if(Integer.valueOf(amount) >= bepaid && merchant_uid.equals(merchant_id)){  //amount : 고객이 지불한 금액(아임포트 서버에서 거래 내역 조회) >= bepaid(지불 되어야할 금액)
			// && merchant_uid == merchant_id를 확인하여 위조 방지
			logger.info("결제 방식 -> {},구매자 이름 -> {}",String.valueOf(getdata.get("pay_method")),
					String.valueOf(map.get("buyer_name")));
			switch(status) {
				case "ready":  //무통장 입금인 경우
					String vbanknum = (String)(map.get("vbanknum"));
					String vbankname = (String)(map.get("vbankname"));
					String vbankdate = (String)(map.get("vbankdate"));
					String vbankholder = (String)(map.get("vbankholder"));
					String buyer_name = String.valueOf(getdata.get("buyer_name"));
					String vbank_code = String.valueOf(getdata.get("vbank_code"));

					Vbank vbank = new Vbank();
					vbank.setVbanknum(vbanknum);
					vbank.setVbankname(vbankname);
					vbank.setVbankdate(vbankdate);
					vbank.setVbankholder(vbankholder);
					vbank.setVbankcode(vbank_code);

					Order vbankorder = new Order();
					vbankorder.setMerchant_id(merchant_id);
					vbankorder.setName(buyer_name);
					vbankorder.setStatus(status);
					vbankorder.setImp_uid(imp_uid);
					vbankorder.setPaymethod(paymethod);
					vbankorder.setPrice(Integer.valueOf(price));
					vbankorder.setCouponid(couponid);

					int vbankinsertcheck = orderService.InsertVbankAndUpdateStatus(vbankorder,vbank,list,bookqtylist);

					if(vbankinsertcheck == 1) {
						resjson.put("check","vbankIssued");
						resjson.put("data",getdata);
						resjson.put("vbanknum", orderService.getVbankInfo(merchant_uid).getVbanknum());
					} else
						resjson.put("check","failed");		// 에러 발생
					return resjson;

				case "paid":  // 무통장 입금 이외의 결제 수단
					Order order = new Order();
					order.setMerchant_id(merchant_id);
					order.setName(String.valueOf(getdata.get("buyer_name")));
					order.setStatus(status);
					order.setImp_uid(imp_uid);
					order.setPaymethod(paymethod);
					order.setPrice(Integer.valueOf(price));
					order.setCouponid(couponid);

					int paidcheck = orderService.updateStatusAndOrder(order,list,bookqtylist);
					if(paidcheck == 1) {
						resjson.put("check","success");
						resjson.put("data",getdata);
						logger.info("결제 완료");
					} else {
						resjson.put("check","failed");
						logger.info("결제 실패");
					}
					return resjson;
				default :
					logger.info("결제 실패");
					resjson.put("check","failed");
					return resjson;
			}
		} else {
			resjson.put("check","failed");
			resjson.put("data",getdata);
			return resjson;
		}
	}

	private int getamount(String merchant_uid){		// 주문의 가격
		return orderService.getPriceByMerchantId(merchant_uid);
	}

	@PostMapping("/stop")		// 결제 도중 에러가 발생하면 DB의 주문 정보를 삭제
	public void stopPayment(@RequestBody HashMap<String,Object> map){
		String merchant_id = (String)map.get("merchant_id");
		orderService.deleteMerchantId(merchant_id);
	}

	@PostMapping("/cancel")		// 환불 메소드
	public Map<String,Object> cancel(HttpServletRequest request,HttpServletResponse response,
									 @RequestBody HashMap<String,Object> map) throws Exception{
		JSONObject json = new JSONObject();
		String imp_key = URLEncoder.encode("IamPortKey", "UTF-8");
		String imp_secret =	URLEncoder.encode("IamPortSecretKey", "UTF-8");
		json.put("imp_key",imp_key);
		json.put("imp_secret", imp_secret);
		logger.info("json 객체 확인 : {}",json);
		logger.info("imp_key : {}",json.get("imp_key"));
		logger.info("imp_secret : {}",json.get("imp_secret"));
		JSONObject obj = new JSONObject();
		String token = getToken(json,"https://api.iamport.kr/users/getToken");
		String reason;
		if((String)map.get("reason") != null){
			reason = (String)map.get("reason");
			obj.put("reason",reason);
		}

		int amount = Integer.valueOf(orderService.getPriceByMerchantId((String)map.get("merchant_uid")));
		int cancel_request_amount = Integer.valueOf((String)map.get("cancel_request_amount")); //Integer.valueOf((String)map.get("cancel_request_amount"));

		if((String)map.get("refund_holder") != null){  // 환불할 결제 수단이 무통장 입금인 경우
			String imp_uid = orderService.getImp_Uid((String)(map.get("merchant_uid")));
			obj.put("imp_uid",imp_uid);
			obj.put("merchant_uid",(String)(map.get("merchant_uid")));
			//obj.put("cancel_request_amount",(String)map.get("cancel_request_amount"));  (optional)
			obj.put("refund_holder",(String)map.get("refund_holder"));
			obj.put("refund_bank",(String)map.get("refund_bank"));
			obj.put("refund_account",(String)map.get("refund_account"));
			logger.info("환불할 JSON 객체 : {}",obj);
		} else {  // 환불한 수단이 무통장 입금 이외인 경우
			obj.put("imp_uid", orderService.getImp_Uid((String)(map.get("merchant_uid"))));
			//obj.put("cancel_request_amount",(String)map.get("cancel_request_amount"));  (optional)
			logger.info("환불 JSON 객체 : {}",obj);
		}
		adminService.purchaseCancel(map);
		JSONObject getcanceldata = null;		// 아임포트 서버에서 받아올 환불 이후의 json 객체
		try{
			String requestString = "";
			URL url = new URL("https://api.iamport.kr/payments/cancel");
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true);
			connection.setInstanceFollowRedirects(false);
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Content-Type", "application/json");
			connection.setRequestProperty("Authorization", token);
			connection.connect();
			OutputStream os= connection.getOutputStream();
			os.write(obj.toString().getBytes());
			os.flush();
			StringBuilder sb = new StringBuilder();
			if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
				BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
				String line = null;
				while ((line = br.readLine()) != null) {
					sb.append(line + "\n");
				}
				br.close();
				requestString = sb.toString();
			}
			connection.disconnect();
			try {
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);
				logger.info("아임포트 서버에서 받아온 환불 json 객체 : {}",jsonObj);
				if((Long)jsonObj.get("code")  == 0) {
					getcanceldata = (JSONObject)jsonObj.get("response");
					logger.info("getcanceldata(환불 정보) : {}",getcanceldata);
				}
			} catch(Exception e) {
				logger.info("환불 json 객체 정보 파싱 실패 -> " + e,e);
			}
		} catch(Exception e) {
			logger.info("아임포트 서버와 환불 도중 네트워크 장애 오류 -> " + e,e);
		}
		return getcanceldata;
	}

	@PostMapping("/cancelstatus")		// 주문 정보를 환불 완료 상태로 바꾸는 메소드
	public void cancelstatus(@RequestBody HashMap<String,Object> map){
		String merchant_id = (String)map.get("merchant_id");
		String cancel = (String)map.get("cancel");
		adminService.updateStatusCancel(merchant_id, cancel);
	}
}