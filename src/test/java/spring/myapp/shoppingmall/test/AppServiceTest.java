package spring.myapp.shoppingmall.test;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.verify;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import spring.myapp.shoppingmall.dao.MallDao;
import spring.myapp.shoppingmall.dao.UserDao;
import spring.myapp.shoppingmall.security.LoginAuthenticationProvider;
import spring.myapp.shoppingmall.service.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/security-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/service-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/dao-context.xml",
		"file:src/main/webapp/WEB-INF/spring/root-context.xml" })
@WebAppConfiguration
public class AppServiceTest {

	@Mock
	private MallDao mallDao;

	@Mock
	private UserDao userDao;

	@Mock
	private UserDetailsServiceImpl userDetailsServiceImpl;

	@Mock
	private BCryptPasswordEncoder passwordEncoder;

	@Mock
	private SecurityContext securityContext;

	@InjectMocks
	private LoginAuthenticationProvider loginAuthenticationProvider;

	@InjectMocks
	private OrderService orderService;

	@InjectMocks
	private ShoppingBasketService shoppingBasket;

	@Before
	public void initMock() {
		MockitoAnnotations.initMocks(this);
	}

	@Test
	@DisplayName("setShoppingBasket 테스트")
	public void setShoppingBasketTest() {
		int qty = 8; int goods_id = 34; int price = 100; String User_ID = "admin3"; String name = "�İ��� ����";
		doNothing().when(mallDao).setShoppingbasket(goods_id, User_ID, price, qty, name);
		shoppingBasketImpl.setShoppingBasket(qty, goods_id, price, User_ID, name);
		verify(mallDao).setShoppingbasket(goods_id,User_ID, price, qty, name);
	}

	@Test
	@DisplayName("getShoppingBasket 테스트")
	public void getShoppingBasketListTest(){
		List<Shoppingbasket> cartList = new ArrayList<Shoppingbasket>();
		cartList.add(new Shoppingbasket());	cartList.add(new Shoppingbasket());	cartList.add(new Shoppingbasket());
		when(mallDao.getShoppingbasket("testId")).thenReturn(cartList);
		List<Shoppingbasket> getCartList = shoppingBasketImpl.getShoppingBasketList("testId");
		assertEquals(getCartList.size(),3);
		verify(mallDao).getShoppingbasket("testId");
	}

	@Test
	@DisplayName("checkCartSpace 테스트")
	public void checkCartSpaceTest() {
		String UserId = "admin";
		when(mallDao.cartspace(UserId)).thenReturn(0);
		int cartSpace = shoppingBasketImpl.checkCartSpace(UserId);
		assertEquals(cartSpace,0);
		verify(mallDao).cartspace(UserId);
	}

	@Test
	@DisplayName("사이트 로그인 테스트")
	public void authenticateTest() {
		String id = "testId";
		String passWord = "1234";
		User user = new User();
		user.setPassword(passWord);
		user.setEmailconfirm(1);
		user.setEnabled(1);
		Authentication authentication = new UsernamePasswordAuthenticationToken("testId",passWord);

		when(userDetailsServiceImpl.loadUserByUsername(id)).thenReturn(new UserDetailsImpl(user));
		when(passwordEncoder.matches("1234",user.getPassword())).thenReturn(true);
		doNothing().when(securityContext).setAuthentication(authentication);

		loginAuthenticationProvider.authenticate(authentication);

		verify(passwordEncoder).matches("1234", user.getPassword());
		verify(userDetailsServiceImpl).loadUserByUsername(id);
		verify(securityContext).setAuthentication(authentication);
	}
}
