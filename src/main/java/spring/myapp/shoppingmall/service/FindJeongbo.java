package spring.myapp.shoppingmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import spring.myapp.shoppingmall.dao.MallDao;
import spring.myapp.shoppingmall.dto.User;

@Service
public class FindJeongbo {
	@Autowired
	private MallDao Malldao;
	
	public User getJeongbo(String Id) {
		return Malldao.getJeongbo(Id);
	}
}