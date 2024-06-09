package spring.myapp.shoppingmall.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import spring.myapp.shoppingmall.dto.Coupon;
import spring.myapp.shoppingmall.dto.Goods;
import spring.myapp.shoppingmall.dto.Order;
import spring.myapp.shoppingmall.dto.Ordergoods;
import spring.myapp.shoppingmall.dto.Reply;
import spring.myapp.shoppingmall.dto.Shoppingbasket;
import spring.myapp.shoppingmall.dto.User;
import spring.myapp.shoppingmall.dto.Vbank;
import spring.myapp.shoppingmall.paging.Paging;
import spring.myapp.shoppingmall.service.*;

@Controller
public class MallController {
	private static final Logger logger = LoggerFactory.getLogger(MallController.class);

	@Autowired
	private ShoppingBasketService shoppingBasketService;		// 장바구니 기능

	@Autowired
	private CouponService couponService;	// 쿠폰 기능

	@Autowired
	private ProductService productService;	// 책의 정보 조회 기능

	@Autowired
	private OrderService orderService;	// 주문,결제 기능

	@Autowired
	private ReplyService replyService;	// 책의 댓글 기능

	@Autowired
	private UserService userService;	// 유저의 정보 조회 기능

	@Autowired
	private Paging paging;	// 페이징 기능

	@RequestMapping("/") // 홈페이지
	public String home(HttpSession session, Model model, HttpServletResponse response,
					   @CookieValue(value = "JSESSIONID", required = false) String JSESSIONID) {
		return "home";
	}

	@RequestMapping("/shopentrance")			// 책 상세 보기 전에 있는 전체적인 책들의 소개 페이지
	public String shopdefault(Model model) {
		model.addAttribute("monthlist", productService.getMonthBookList()); // 이달의 인기 서적
		model.addAttribute("todaybook", productService.getTodayBook()); 	// 오늘의 인기 서적
		return "/menu/shopentrance";
	}

	@RequestMapping("/shop") 					// 책 카테고리 리스트
	public String shop(@RequestParam(value = "bigclass", required = false) String bigclass,
					   @RequestParam(value = "subclass", required = false) String subclass, Model model,
					   HttpServletRequest request) {
		if (bigclass == null || subclass == null) {
			bigclass = "novel"; 	 // 책의 대분류
			subclass = "japannovel"; // 책의 소분류
		}
		pagingModelWithBook(model, request, bigclass, subclass); // 책 상품들의 페이징처리
		model.addAttribute("bigclass", bigclass);
		model.addAttribute("subclass", subclass);
		return "/menu/shop"; 		// 책 목록 view
	}

	@RequestMapping("/product") 	// 책 상세보기
	public String product(@RequestParam(value = "bookname", required = false) String bookname, // gId는 책의 이름
						  @RequestParam(value = "goods_id", required = false) String goods_id,
						  @RequestParam(value = "mode", required = false) String mode, Model model, HttpSession session,
						  HttpServletRequest request) {		// mode는 책의 댓글을 최신순으로 볼지 도움순으로 볼지 선택
		model.addAttribute("good", productService.getProductDetails(Integer.valueOf(goods_id)));
		model.addAttribute("mode", mode);
		if (mode.equals("'getreviewlatest'")) {
			logger.info("리뷰 최신순 조회");
			pagingModelReplyLatest(model, request, bookname);
		} else {
			logger.info("리뷰 도움순 조회");
			pagingModelReply(model, request, bookname);
		}
		model.addAttribute("reviewreplylist", productService.getReviewReply(bookname));
		return "/menu/product";
	}

	@RequestMapping("/review/{reviewmode}")		// 사용자가 책의 리뷰를 최신순 또는 도움순으로 보려고 할때 선택해서 페이지를 반환해주는 ReqestMapping
	public String getreviewhelp(@PathVariable String reviewmode,
								@RequestParam(value = "bookname", required = false) String bookname,
								@RequestParam(value = "goods_id", required = false) String goods_id, Model model,
								HttpServletRequest request) {
		if(reviewmode.equals("getreviewhelp")) {
			model.addAttribute("good", productService.getProductDetails(Integer.valueOf(goods_id)));
			model.addAttribute("mode", "'getreviewhelp'");
			pagingModelReply(model, request, bookname);
			model.addAttribute("reviewreplylist", productService.getReviewReply(bookname));
			return "/menu/getreviewhelp";
		} else {
			model.addAttribute("good", productService.getProductDetails(Integer.valueOf(goods_id)));
			model.addAttribute("mode", "'getreviewlatest'");
			pagingModelReplyLatest(model, request, bookname);
			model.addAttribute("reviewreplylist", productService.getReviewReply(bookname));
			return "/menu/getreviewlatest";
		}
	}

	@RequestMapping("/showbasket") 	// 유저가 장바구니에 담은 책 조회
	public String showbasket(Model model, HttpSession session) {
		String UserId = (String) (session.getAttribute("Userid"));
		List<Shoppingbasket> shoppingbaskets = shoppingBasketService.getShoppingBasketList(UserId); // 유저가 담은 장바구니 목록을 담는다.
		User user = userService.findUserById(UserId);
		model.addAttribute("list", shoppingbaskets);
		model.addAttribute("User", user);
		return "/order/shoppingbasketdesign";
	}

	@RequestMapping("/OrderResult")		// 주문 결과 페이지
	public String orderresult(@RequestParam String merchant_id, Model model, Vbank vbank) {
		if (vbank.getVbanknum() != null) {
			model.addAttribute("vbank_date", vbank.getVbankdate());
			model.addAttribute("vbank_code", vbank.getVbankcode()); // 은행 코드 번호
			model.addAttribute("vbank_holder", vbank.getVbankholder()); // 구매자
			model.addAttribute("vbank_num", vbank.getVbanknum()); // 은행 계좌번호
			model.addAttribute("vbank_name", vbank.getVbankname()); // 은행 이름
		}
		if (orderService.getMerchantId(merchant_id) != null)
			model.addAttribute("Order", orderService.getMerchantId(merchant_id));
		model.addAttribute("Ordergoods", orderService.getOrderGoods(merchant_id));
		return "/order/orderresult";
	}

	@RequestMapping("/showorder")		// 사용자가 주문했던 내역 페이지
	public String showorder(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		String id = (String) session.getAttribute("Userid");
		int curPageNum; 	// 현재 사용자가 보는 페이지
		String page = request.getParameter("page");
		logger.info("page : {}",page);
		if (page != null)
			curPageNum = Integer.valueOf(page);
		else
			curPageNum = 1; // 처음 페이지에 들어가는 경우(페이징 처리된 페이지를 누르지 않았을 경우)
		pagingRefactoringForOrder(curPageNum, request, model, id);	// 고객의 주문 내역을 보는 페이지가 속한 Block의 첫번째 숫자와 마지막 숫자를 모델의 속성값을 넣음 -> 페이징 처리
		List<Order> orders = orderService.getOrderInfo(id, curPageNum); // ordertable의 주문 데이터들
		model.addAttribute("orders", orders);
		List<List<Ordergoods>> ordergoods = new ArrayList<List<Ordergoods>>();
		List<Vbank> vbanks = new ArrayList<Vbank>();
		for (int i = 0; i < orders.size(); i++) {
			ordergoods.add(orderService.getOrderGoods(orders.get(i).getMerchant_id())); // 주문 번호로 시킨 책들
			vbanks.add(orderService.getVbankInfo(orders.get(i).getMerchant_id()));
		}
		model.addAttribute("ordergoods", ordergoods);
		model.addAttribute("vbanks", vbanks);
		return "/order/orderinfo";
	}

	private int pagingRefactoringForOrder(int curPageNum, HttpServletRequest request, Model model, String id) {	// 고객의 주문 내역을 보는 페이지가 속한 Block의 첫번째 숫자와 마지막 숫자를 모델의 속성값을 넣음
		String page = request.getParameter("page");
		if (page != null)
			curPageNum = Integer.valueOf(page);
		else
			curPageNum = 1; 	// 처음 페이지에 들어가는 경우(페이징 처리된 페이지를 누르지 않았을 경우)
		paging.pagingforOrder(curPageNum, model, id);
		return curPageNum;
	}

	@RequestMapping("/search")				// 책을 검색
	public String search(@RequestParam String subject, @RequestParam(value = "search", required = false) String search,
						 HttpServletRequest request, Model model) {
		pagingModelKwd(subject, search, request, model);
		model.addAttribute("search", search);
		model.addAttribute("subject", subject);
		return "/menu/search";
	}

	@RequestMapping("/jusoPopup")		// 주소 찾기 API
	public String jusoPopup() {
		return "jusoPopup";
	}

	@RequestMapping(value = "/updatediscountpercent", method = RequestMethod.POST)
	public void updatediscountpercent(@RequestParam String couponId, @RequestParam String merchant_id) {
		couponService.updateDiscountPercent(couponId, merchant_id);
	}

	@RequestMapping("/showcoupon") // 쿠폰 내역 조회
	public String showcoupon(HttpServletRequest request, HttpSession session, Model model) {
		String Id = (String) (session.getAttribute("Userid"));
		pagingModelCoupon(model, request, Id);
		return "showcoupon";
	}

	private Model pagingModelKwd(String subject, String search, HttpServletRequest request, Model model) { // 사용자의 책 검색 리스트 모델을 DB에서 조회하여 반환
		int curPageNum = 0; 	// 현재 사용자가 보는 페이지
		logger.info("사용자 검색 키워드 : {}", search);
		curPageNum = pagingRefactoringForSearch(curPageNum, request, model, subject, search);	// 현재 해당하는 페이지가 속한 block의 첫번째 숫자,마지막 숫자 계산
		List<Goods> list = paging.dtoWithKwd(curPageNum, search, subject);		// 사용자가 검색한 키워드에 해당하는 책 리스트를 DB에서 조회
		model.addAttribute("list", list);
		return model;
	}

	private int pagingRefactoringForSearch(int curPageNum, HttpServletRequest request, Model model, String subject,
										   String search) {		// 현재 사용자가 검색을 하려는 페이지가 속한 block의 첫번째 숫자,마지막 숫자 계산
		String page = request.getParameter("page");
		if (page != null)
			curPageNum = Integer.valueOf(page);
		else
			curPageNum = 1; 	// 처음 페이지에 들어가는 경우(페이징 처리된 페이지를 누르지 않았을 경우)
		paging.pagingforKwd(curPageNum, model, subject, search);
		return curPageNum;
	}



	private Model pagingModelWithBook(Model model, HttpServletRequest request, String bigclass, String subclass) {	// 사용자가 대분류중에서 소분류에 해당하는 책 리스트를 DB에서 조회하여 모델을 반환
		int curPageNum = 0; 	// 현재 사용자가 보는 페이지
		curPageNum = pagingRefactoringForBook(curPageNum, request, model, bigclass, subclass);		// 현재 해당하는 페이지가 속한 block의 첫번째 숫자,마지막 숫자 계산
		List<Goods> list = paging.dtosWithBook(curPageNum, bigclass, subclass);	// 해당하는 페이지의 책 리스트를 뽑아옴
		model.addAttribute("list", list);
		return model;
	}

	private int pagingRefactoringForBook(int curPageNum, HttpServletRequest request, Model model, String bigclass,
										 String subclass) {			// 현재 해당하는 페이지가 속한 block의 처음 숫자,마지막 숫자 계산
		String page = request.getParameter("page");
		if (page != null)
			curPageNum = Integer.valueOf(page);
		else
			curPageNum = 1; // 처음 페이지에 들어가는 경우(페이징 처리된 페이지를 누르지 않았을 경우)
		paging.pagingforBook(curPageNum, model, bigclass, subclass);
		return curPageNum;
	}



	private Model pagingModelCoupon(Model model, HttpServletRequest request, String Id) { // 특정 사용자가 가지고 있는 쿠폰 리스트를 DB에서 조회하여 모델을 반환
		int curPageNum = 0; // 현재 사용자가 보는 페이지
		curPageNum = pagingRefactoringForCoupon(curPageNum, request, model, Id); // 현재 특정 사용자가 받은 쿠폰리스트 중에서 해당하는 페이지가 속한 block의 첫번째 숫자,마지막 숫자 계산
		List<Coupon> list = paging.coupons(curPageNum, Id);
		model.addAttribute("list", list);
		return model;
	}

	private int pagingRefactoringForCoupon(int curPageNum, HttpServletRequest request, Model model, String Id) {
		String page = request.getParameter("page");		// 현재 특정 사용자가 받은 쿠폰리스트 중에서 해당하는 페이지가 속한 block의 첫번째 숫자,마지막 숫자 계산
		if (page != null)
			curPageNum = Integer.valueOf(page);
		else
			curPageNum = 1; // 처음 페이지에 들어가는 경우(페이징 처리된 페이지를 누르지 않았을 경우)
		paging.pagingforCoupon(curPageNum, model, Id);
		return curPageNum;
	}



	private Model pagingModelReply(Model model, HttpServletRequest request, String bookname) { // 특정 책의 리뷰 댓글을 DB에서 조회하여 모델을 반환
		int curPageNum = 0; // 현재 사용자가 보는 페이지
		curPageNum = pagingRefactoringForReply(curPageNum, request, model, bookname);
		List<Reply> list = paging.reply(curPageNum, bookname);
		model.addAttribute("list", list);
		model.addAttribute("reviewlist", replyService.getAllReply(bookname));
		return model;
	}

	private int pagingRefactoringForReply(int curPageNum, HttpServletRequest request, Model model, String bookname) {
		String page = request.getParameter("page");
		if (page != null)
			curPageNum = Integer.valueOf(page);
		else
			curPageNum = 1; // 처음 페이지에 들어가는 경우(페이징 처리된 페이지를 누르지 않았을 경우)
		paging.pagingforReply(curPageNum, model, bookname);
		return curPageNum;
	}

	private Model pagingModelReplyLatest(Model model, HttpServletRequest request, String bookname) {	// 특정 책의 리뷰 댓글 중에 최신순에 해당하는 댓글 리뷰를 DB에 조회하여 모델을 반환
		int curPageNum = 0; // 현재 사용자가 보는 페이지
		curPageNum = pagingRefactoringForReplyLatest(curPageNum, request, model, bookname);
		List<Reply> list = paging.replylatest(curPageNum, bookname);
		model.addAttribute("list", list);
		model.addAttribute("reviewlist", replyService.getAllReply(bookname));
		return model;
	}

	private int pagingRefactoringForReplyLatest(int curPageNum, HttpServletRequest request, Model model,
												String bookname) {
		String page = request.getParameter("page");
		if (page != null)
			curPageNum = Integer.valueOf(page);
		else
			curPageNum = 1; 	// 처음 페이지에 들어가는 경우(페이징 처리된 페이지를 누르지 않았을 경우)
		paging.pagingforReplyLatest(curPageNum, model, bookname);
		return curPageNum;
	}
}