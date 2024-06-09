package spring.myapp.shoppingmall.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import spring.myapp.shoppingmall.dao.MallDao;
import spring.myapp.shoppingmall.dto.Bookrecommend;
import spring.myapp.shoppingmall.dto.Goods;
import spring.myapp.shoppingmall.dto.Monthbook;
import spring.myapp.shoppingmall.dto.ReviewReply;
import spring.myapp.shoppingmall.dto.Todaybook;

@Service
@Transactional
public class ProductServiceImpl implements ProductService{
	@Autowired
	private MallDao Malldao;
	
	@Override
	public Goods getProductDetails(int goods_id) {
		return Malldao.getGoodsInfo(goods_id);
	}
	
	@Override
	public int remainCheck(String[] newname,Integer[] newqty) {
		return Malldao.remaincheck(newname,newqty);
	}
	
	@Override
	public List<Goods> getGoodsInfo(String kind){
		return Malldao.getShoppingGoodsInfo(kind);
	}
	
	@Override
	public int bookRecommend(Bookrecommend recommend,String userid,int bookid) {
		if(Malldao.bookrecommendcheck(userid,bookid) == 1)
			return 1;
		return Malldao.bookrecommend(recommend,bookid);
	}

	@Override
	public List<Monthbook> getMonthBookList() {
		return Malldao.getmonthbooklistInmonthbooktable();
	}

	@Override
	public Todaybook getTodayBook() {
		return Malldao.gettodaybook();
	}
	
	@Override
	public List<ReviewReply> getReviewReply(String bookname) {
		return Malldao.getreviewreply(bookname);
	}
}