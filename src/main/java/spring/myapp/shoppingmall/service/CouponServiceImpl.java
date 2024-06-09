package spring.myapp.shoppingmall.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import spring.myapp.shoppingmall.dao.MallDao;
import spring.myapp.shoppingmall.dto.Coupon;

@Service
@Transactional
public class CouponServiceImpl implements CouponService{
	@Autowired
	private MallDao Malldao;
	
	@Override
	public void updateUseCouponService(String yes,String cnumber){
		Malldao.updateusecouponservice(yes,cnumber);
	}
	
	@Override
	public Integer useCoupon(String cnumber){
		return Malldao.usecoupon(cnumber);
	}
	
	@Override
	public Integer receiveCoupon(String Id){
		return Malldao.receivecoupon(Id);
	}
	
	@Override
	public List<Coupon> getCouponsById(String id) {
		return Malldao.getcoupons(id);
	}
	
	@Override
	public void updateDiscountPercent(String couponId,String merchant_id){
		Malldao.updatediscountpercent(couponId,merchant_id);
	}
	
	@Override
	public int usedCouponCheckMethod(String couponid) {
		return Malldao.usedcouponcheckmethod(couponid);
	}
	
	@Override
	public int getCouponsCountByUserId(String id) {
		return Malldao.getcouponscountbyuserId(id);
	}
	
	@Override
	public List<Coupon> canReceive(String id) {
		return Malldao.canreceive(id);
	}
}
