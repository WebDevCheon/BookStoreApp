package spring.myapp.shoppingmall.service;

import java.util.List;
import spring.myapp.shoppingmall.dto.Coupon;

public interface CouponService {
	public void updateUseCouponService(String yes,String cnumber);
	public Integer useCoupon(String cnumber);
	public Integer receiveCoupon(String Id);
	public List<Coupon> getCouponsById(String id);
	public void updateDiscountPercent(String couponId,String merchant_id);
	public int usedCouponCheckMethod(String couponid);
	public int getCouponsCountByUserId(String id);
	public List<Coupon> canReceive(String id);
}
