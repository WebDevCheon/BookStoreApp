package spring.myapp.shoppingmall.service;

import java.util.List;
import spring.myapp.shoppingmall.dto.Order;
import spring.myapp.shoppingmall.dto.Ordergoods;
import spring.myapp.shoppingmall.dto.Vbank;

public interface OrderService {
	public void deleteMerchantId(String merchant_id);
	
	public String getImp_Uid(String merchant_uid);
	
	public Order getMerchantId(String merchant_id);
	
	public int getPriceByMerchantId(String merchant_uid);
	
	public List<Ordergoods> getOrderGoods(String merchant_id);
	
	public List<Order> getOrderInfo(String id,int curPageNum);
	
	public Vbank getVbankInfo(String merchant_id);
	
	public void insertPrice(String price,String merchant_uid);
	
	public void insertGoods(String merchant_id,String[] list,Integer[] glist);
	
	public void InsertVbank(String merchant_id,String vbanknum,String vbankname,String vbankdate,String vbankholder,String vbankperson,
			String vbankcode);
	
	public int InsertVbankAndUpdateStatus(Order order,Vbank vbank,String[] booknamelist, Integer[] bookqtylist);
	
	public void InsertMerchant(String id,String merchant_id,String phoneNumber,String address,String buyer_name,String memo,int price);
	
	public boolean mobileCheckByMerchantUid(String merchant_uid);
	
	public void updateStatusWebhook(Order vbankorder,Vbank vbank);
	
	public int updateStatusAndOrder(Order order,String[] booknamelist,Integer[] bookqtylist);
	
	public int orderPayCheck(String Userid,String price,String coupon);
	
	public boolean unitInStockCheck(List<String> booknamelist,List<Integer> bookqtylist,String merchant_id);
	
	public boolean unitInStockShortageMobileCheck(String[] booknamelist,Integer[] bookqtylist,String merchant_uid);
}
