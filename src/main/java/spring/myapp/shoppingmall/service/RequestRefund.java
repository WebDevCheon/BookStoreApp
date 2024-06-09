package spring.myapp.shoppingmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import spring.myapp.shoppingmall.dao.MallDao;

@Service
public class RequestRefund 
{
	@Autowired
	private MallDao Malldao;
	
	public int requestRefund(String merchant_id,Integer amount,String holder,String bank,String account){
		return Malldao.requestrefund(merchant_id,amount,holder,bank,account);
	}

	public int requestRefundOverlappingCheck(String merchant_id) {
		int overlapflag = 0;
		overlapflag = Malldao.requestrefundoverlappingcheck(merchant_id);
		if(overlapflag > 0)
			return 1;
		else
			return 0;
	}
}