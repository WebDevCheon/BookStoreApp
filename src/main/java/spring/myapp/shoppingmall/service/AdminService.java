package spring.myapp.shoppingmall.service;

import java.util.HashMap;
import java.util.List;
import spring.myapp.shoppingmall.dto.Goods;
import spring.myapp.shoppingmall.dto.Refund;

public interface AdminService {
	public void register(Goods goods);
	public void updateStatusCancel(String merchant_id,String cancel);
	public void uploadProflie(int goods_id,String uploadurl);
	public Refund getRefund(String merchant_id);
	public List<Goods> getMonthBookList(int curPageNum);
	public void setMonthBookList(List<String> selectedbooklist);
	public void downMonthBookList();
	public Goods findBook(String name);
	public void setTodayBookSelect(int bookid);
	public void purchaseCancel(HashMap<String, Object> map);
}