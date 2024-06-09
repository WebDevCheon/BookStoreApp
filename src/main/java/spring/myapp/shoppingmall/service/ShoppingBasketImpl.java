package spring.myapp.shoppingmall.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import spring.myapp.shoppingmall.dao.MallDao;
import spring.myapp.shoppingmall.dto.Shoppingbasket;

@Service
@Transactional
public class ShoppingBasketImpl implements ShoppingBasketService{
	@Autowired
	private MallDao Malldao;

	@Override
	public void setShoppingBasket(int qty,int goods_id,int price,String User_ID,String name) {
		Malldao.setShoppingbasket(goods_id,User_ID, price, qty, name);  //gid 첫번째
	}

	@Override
	public List<Shoppingbasket> getShoppingBasketList(String User_ID){
		return Malldao.getShoppingbasket(User_ID);  //장바구니 담았던 물품 정보들	-> 이것은 장바구니 쇼핑 안의 개별 물품에 대한 각각의 정보들..
	}

	@Override
	public int checkCartSpace(String Id) {
		return Malldao.cartspace(Id); //장바구니 리스트에서 가져오기 이것은 장바구니에 담은 쇼핑 안의 개별 물품의 갯수들..
	}

	@Override
	public void deleteShoppingBasket(int pnum) {  //장바구니 창에서 담은 물품 삭제하기
		Malldao.deletebasket(pnum);
	}

	@Override
	public void deleteAll(String id) { //장바구니 창에서 담은 물품 모두 삭제하기
		Malldao.deleteall(id);
	}
}