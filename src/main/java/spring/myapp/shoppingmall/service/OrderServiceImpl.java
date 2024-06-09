package spring.myapp.shoppingmall.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import spring.myapp.shoppingmall.controller.PaymentAndRefundController;
import spring.myapp.shoppingmall.dao.MallDao;
import spring.myapp.shoppingmall.dto.Coupon;
import spring.myapp.shoppingmall.dto.Order;
import spring.myapp.shoppingmall.dto.Ordergoods;
import spring.myapp.shoppingmall.dto.Shoppingbasket;
import spring.myapp.shoppingmall.dto.Vbank;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {		// 결제 핵심 코드
	private static final Logger logger = LoggerFactory.getLogger(OrderServiceImpl.class);

	@Autowired
	private MallDao Malldao;

	@Override
	public void deleteMerchantId(String merchant_id) {
		Malldao.deltemerchantid(merchant_id);
	}

	@Override
	public String getImp_Uid(String merchant_uid){
		return Malldao.getimp_uid(merchant_uid);
	}

	@Override
	public Order getMerchantId(String merchant_id){
		return Malldao.getMerchantid(merchant_id);
	}

	@Override
	public int getPriceByMerchantId(String merchant_uid){
		return Malldao.getfindprice(merchant_uid);
	}

	@Override
	public List<Ordergoods> getOrderGoods(String merchant_id){
		return Malldao.getordergoods(merchant_id);
	}

	@Override
	public List<Order> getOrderInfo(String id,int curPageNum){
		return Malldao.getorderinfo(id,curPageNum);
	}

	@Override
	public Vbank getVbankInfo(String merchant_id){
		return Malldao.getvbankinfo(merchant_id);
	}

	@Override
	public void insertPrice(String price,String merchant_uid){
		Malldao.insertPrice(Integer.valueOf(price),merchant_uid);
	}

	@Override
	public void insertGoods(String merchant_id,String[] list,Integer[] glist){
		Malldao.insertgoods(merchant_id,list,glist);
	}

	@Override
	public void InsertVbank(String merchant_id,String vbanknum,String vbankname,String vbankdate,String vbankholder,String vbankperson,
							String vbankcode) {
		Malldao.insertvbank(merchant_id,vbanknum,vbankname,vbankdate,vbankholder,vbankperson,vbankcode);
	}

	@Override
	public void InsertMerchant(String id,String merchant_id,String phoneNumber,String address,String buyer_name,String memo,int price) {
		Malldao.insertMerchant(id,merchant_id,phoneNumber,address,buyer_name,memo,price);
	}

	@Override
	public boolean mobileCheckByMerchantUid(String merchant_uid) {
		return Malldao.mobilecheck(merchant_uid);
	}

	@Override
	public int InsertVbankAndUpdateStatus(Order order,Vbank vbank,String[] booknamelist, Integer[] bookqtylist) {	// 무통장 입금으로 고객이 결제를 신청했을때(돈 입금 안된 상태)
		try {
			Malldao.insertVbankgoods(order.getMerchant_id(),booknamelist,bookqtylist);	// 처음 가상 계좌 신청했을때 책의 이름/수량을 DB에 insert
			Malldao.insertPrice(order.getPrice(),order.getMerchant_id());	// 무통장 입금 주문 번호에 결제할 금액을 update
			Malldao.insertvbank(order.getMerchant_id(),vbank.getVbanknum(),vbank.getVbankname(),vbank.getVbankdate(),vbank.getVbankholder(),order.getName(),vbank.getVbankcode());	// 무통장 정보를 insert
			Malldao.statusupdate(order.getStatus(),order.getMerchant_id(),order.getImp_uid(),order.getPaymethod());	 // 결제ID의 상태를 update
			if(!order.getCouponid().equals(""))
				Malldao.updatestatususecoupon(order.getCouponid(),order.getMerchant_id());
			return 1;
		} catch(Exception e) {
			logger.info("에러 발생 In InsertVbankAndUpdateStatus Method -> " + e,e);
			Order failedorder = Malldao.getMerchantid(order.getMerchant_id());
			logger.info("에러 발생 주문 DB 상태 : {}",failedorder.getStatus());
			if(failedorder.getStatus().equals("not paid")) {
				logger.info("주문 실패 번호 : {}",failedorder.getOrderid());
				logger.info("롤백 성공 주문 ID :" + order.getMerchant_id());
			}
			return 0;
		}
	}

	@Override
	public void updateStatusWebhook(Order vbankorder,Vbank vbank) {	// 무통장 가상 계좌에 고객이 돈을 입금했을때
		try {
			Malldao.statusupdate(vbankorder.getStatus(),vbankorder.getMerchant_id(),vbankorder.getImp_uid(),vbankorder.getPaymethod());
			Malldao.subordergoodsVbank(vbankorder.getMerchant_id());
		} catch(Exception e) {
			logger.info("에러 발생 In updateStatusWebhook Method -> " + e,e);
			RefundIMPORTServerException(vbankorder,vbank);
			if(Malldao.getMerchantid(vbankorder.getMerchant_id()).getStatus().equals("ready")) {
				logger.info("무통장 입금 주문 실패 번호 : {}",vbankorder.getOrderid());
				logger.info("무통장 입금 롤백 성공 결제 ID :" + vbankorder.getMerchant_id());
			}
		}
	}

	@Override
	public int updateStatusAndOrder(Order order,String[] booknamelist,Integer[] bookqtylist) {	// 결제 완료로 인해서 주문할 책,금액,주문 상태를 update
		try {
			Malldao.insertgoods(order.getMerchant_id(),booknamelist,bookqtylist);	// 결제ID를 바탕으로 주문할 책의 이름/수량을 DB에 update
			Malldao.insertPrice(order.getPrice(),order.getMerchant_id());			// 결제ID의 가격을 DB에 insert
			Malldao.statusupdate(order.getStatus(),order.getMerchant_id(),order.getImp_uid(),order.getPaymethod());	// 주문의 상태를 update
			if(!order.getCouponid().equals(""))	// 쿠폰을 적용했으면,그 쿠폰을 사용처리 update
				Malldao.updatestatususecoupon(order.getCouponid(),order.getMerchant_id());
			return 1;
		} catch(Exception e) {
			logger.info("에러 발생 In updateStatusAndOrder Method -> " + e,e);
			RefundIMPORTServerException(order,null);
			Order failedorder = Malldao.getMerchantid(order.getMerchant_id());
			if(failedorder.getStatus().equals("not paid")) {
				logger.info("주문 실패 번호 : {}",failedorder.getOrderid());
				logger.info("롤백 성공 결제 ID : " + order.getMerchant_id());
			}
			return 0;
		}
	}

	@Override
	public int orderPayCheck(String Userid,String price,String couponid) {
		List<Shoppingbasket> shoppingbasketlist = Malldao.getShoppingbasket(Userid);
		int sum = 0;
		if(couponid.equals("")) {
			for(Shoppingbasket goods : shoppingbasketlist)
				sum += goods.getPrice() * goods.getQty();
			if(sum != Integer.valueOf(price))	// 가격이 다름
				return 1;
			else
				return 0;
		} else {
			Coupon coupon = Malldao.getcoupon(couponid);
			for(Shoppingbasket goods : shoppingbasketlist)
				sum += goods.getPrice() * goods.getQty();

			if(coupon.getType() == 0)
				sum = sum - (int)(0.05 * sum);
			else if(coupon.getType() == 1)
				sum = sum - (int)(0.1 * sum);
			else if(coupon.getType() == 2)
				sum = sum - (int)(0.15 * sum);
			else if(coupon.getType() == 3)
				sum = sum - (int)(0.2 * sum);

			if(sum != Integer.valueOf(price))	// 가격이 다름
				return 1;
			else
				return 0;
		}
	}

	private void RefundIMPORTServerException(Order order,Vbank vbank) {		// 에러 발생시에 아임포트 서버에 환불 처리
		String cancelstatus = null;
		try {
			JSONObject json = new JSONObject();
			String imp_key = URLEncoder.encode("IamPortKey", "UTF-8");
			String imp_secret =	URLEncoder.encode("IamPortSecretKey", "UTF-8");
			json.put("imp_key",imp_key);
			json.put("imp_secret", imp_secret);
			logger.info(String.valueOf(json));
			logger.info("imp_key : " + json.get("imp_key"));
			logger.info("imp_secret : " + json.get("imp_secret"));
			JSONObject obj = new JSONObject();
			String token = PaymentAndRefundController.getToken(json,"https://api.iamport.kr/users/getToken");
			int amount = order.getPrice();
			int cancel_request_amount = order.getPrice();

			if(vbank != null) {
				obj.put("refund_holder",vbank.getVbankholder());
				obj.put("refund_bank",vbank.getVbankcode());
				obj.put("refund_account",vbank.getVbanknum());
			}
			if(amount - cancel_request_amount <= 0)
				logger.info("이미 전액환불된 상품입니다.");
			obj.put("imp_uid",order.getImp_uid());
			obj.put("cancel_request_amount",order.getPrice());
			JSONObject getcanceldata = null;		// 아임포트 서버에서 환불 받은 정보

			try{
				String requestString = "";
				URL url = new URL("https://api.iamport.kr/payments/cancel");
				HttpURLConnection connection = (HttpURLConnection) url.openConnection();
				connection.setDoOutput(true);
				connection.setInstanceFollowRedirects(false);
				connection.setRequestMethod("POST");
				connection.setRequestProperty("Content-Type", "application/json");
				connection.setRequestProperty("Authorization", token);
				OutputStream os= connection.getOutputStream();
				os.write(obj.toString().getBytes());
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
				os.flush();
				connection.disconnect();
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);
				logger.info("jsonObj " + jsonObj);
				if((Long)jsonObj.get("code")  == 0) {
					getcanceldata = (JSONObject) jsonObj.get("response");
					logger.info("환불정보 -> " + getcanceldata);
				}
			} catch(Exception e) {
				logger.info("에러 발생 In RefundIMPORTServerException Method -> " + e,e);
			}
			cancelstatus = String.valueOf(getcanceldata.get("status"));
			logger.info("환불 정보 -> {}",getcanceldata);
			logger.info("환불 확정 상태 -> " + cancelstatus);
		} catch (Exception e) {
			logger.info("에러 발생 In RefundIMPORTServerException Method -> " + e,e);
		}
	}

	@Override
	public boolean unitInStockCheck(List<String> booknamelist,List<Integer> bookqtylist,String merchant_id) {
		return Malldao.unitInStockCheck(booknamelist,bookqtylist,merchant_id);
	}

	@Override
	public boolean unitInStockShortageMobileCheck(String[] booknamelist,Integer[] bookqtylist,String merchant_uid) {
		return Malldao.unitInStockShortageMobileCheck(booknamelist,bookqtylist,merchant_uid);
	}
}