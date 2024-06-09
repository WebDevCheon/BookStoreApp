package spring.myapp.shoppingmall.service;

import java.util.List;
import spring.myapp.shoppingmall.dto.Bookrecommend;
import spring.myapp.shoppingmall.dto.Goods;
import spring.myapp.shoppingmall.dto.Monthbook;
import spring.myapp.shoppingmall.dto.ReviewReply;
import spring.myapp.shoppingmall.dto.Todaybook;

public interface ProductService {
	public Goods getProductDetails(int goods_id);
	
	public int remainCheck(String[] newname,Integer[] newqty);
	
	public List<Goods> getGoodsInfo(String kind);
	
	public int bookRecommend(Bookrecommend recommend,String userid,int bookid);
	
	public List<Monthbook> getMonthBookList();
	
	public Todaybook getTodayBook();
	
	public List<ReviewReply> getReviewReply(String gId);
}