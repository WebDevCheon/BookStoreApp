package spring.myapp.shoppingmall.paging;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import spring.myapp.shoppingmall.dao.MallDao;
import spring.myapp.shoppingmall.dto.Coupon;
import spring.myapp.shoppingmall.dto.Goods;
import spring.myapp.shoppingmall.dto.Refund;
import spring.myapp.shoppingmall.dto.Reply;

@Service
@Transactional
public class Paging {
	private static final Logger logger = LoggerFactory.getLogger(Paging.class);
	@Autowired
	private MallDao Malldao;
	private final static int pageCount = 5;  //pageCount는 한 블럭당 존재할 수 있는 최대의 페이지 수
	private final static int shopPage = 6;   //shopPage는  한 페이지에 몇개의 책을 보여줄 것인지 결정해주는 수
	private final static int adminpageCount = 10;
	private final static int adminPage = 5;

	// 검색 결과 페이징
	public List<Goods> dtoWithKwd(int curPageNum,String search,String subject) {
		List<Goods> list = null;
		list = Malldao.getsearchinfo(curPageNum,search,subject);
		return list;
	}

	public void pagingforKwd(int curPageNum, Model model,String subject,String search) {
		int blockNum = 0;
		blockNum = (int)Math.floor((curPageNum-1)/ pageCount);
		int blockStartNum = (pageCount * blockNum) + 1;					//블록의 시작 숫자
		int blockLastNum = blockStartNum + (pageCount-1);
		int total = Malldao.getCountKwd(subject,search);
		int lastPageNum = 0;
		if(total % shopPage == 0) {
			lastPageNum = (int)Math.floor(total/shopPage);			//마지막 페이지의 수1
		}
		else {
			lastPageNum = (int)Math.floor(total/shopPage) + 1;		//마지막 페이지의 수2
		}
		model.addAttribute("curPageNum",curPageNum).addAttribute("blockStartNum",blockStartNum).addAttribute("blockLastNum",blockLastNum).addAttribute("lastPageNum",lastPageNum);
	}

	// 책의 리스트 페이징
	public List<Goods> dtosWithBook(int curPageNum, String bigclass, String subclass) {
		List<Goods> list = null;
		list = Malldao.getCurPageDtosWithBook(curPageNum,bigclass,subclass);					//현재 페이지에 해당하는 물품 리스트들
		return list;
	}

	public void pagingforBook(int curPageNum, Model model, String bigclass, String subclass) {
		int blockNum = 0;
		blockNum = (int)Math.floor((curPageNum-1)/ pageCount);
		int blockStartNum = (pageCount * blockNum) + 1;					// 블록의 시작 숫자
		int blockLastNum = blockStartNum + (pageCount-1);
		int total = Malldao.getCountWithBook(bigclass, subclass);
		int lastPageNum = 0;
		if(total % shopPage == 0)
			lastPageNum = (int)Math.floor(total/shopPage);			//마지막 페이지의 수1
		else
			lastPageNum = (int)Math.floor(total/shopPage) + 1;		//마지막 페이지의 수2
		model.addAttribute("curPageNum",curPageNum).addAttribute("blockStartNum",blockStartNum).
				addAttribute("blockLastNum",blockLastNum).addAttribute("lastPageNum",lastPageNum);
	}

	// 유저의 쿠폰 페이징
	public List<Coupon> coupons(int curPageNum, String id) {
		List<Coupon> list = null;
		list = Malldao.getCurPageCoupons(curPageNum,id);					// 현재 페이지에 해당하는 쿠폰 리스트
		return list;
	}

	public void pagingforCoupon(int curPageNum, Model model, String id) {
		int blockNum = 0;
		blockNum = (int)Math.floor((curPageNum-1)/ pageCount);
		int blockStartNum = (pageCount * blockNum) + 1;					//블록의 시작 숫자
		int blockLastNum = blockStartNum + (pageCount-1);
		int total = Malldao.getNumberCoupons(id);
		int lastPageNum = 0;
		if(total % shopPage == 0) {
			lastPageNum = (int)Math.floor(total/shopPage);			//마지막 페이지의 수1
		}
		else {
			lastPageNum = (int)Math.floor(total/shopPage) + 1;		//마지막 페이지의 수2
		}
		model.addAttribute("curPageNum",curPageNum).addAttribute("blockStartNum",blockStartNum).addAttribute("blockLastNum",blockLastNum).addAttribute("lastPageNum",lastPageNum);
	}

	// 책 상세보기 창에서 리뷰 보기 페이징
	public List<Reply> reply(int curPageNum, String bookname) {
		List<Reply> list = null;
		list = Malldao.getCurPageReplies(curPageNum,bookname);					//현재 페이지에 해당하는 리뷰 리스트
		return list;
	}

	public void pagingforReply(int curPageNum, Model model, String bookname) {
		int blockNum = 0;
		blockNum = (int)Math.floor((curPageNum-1)/ pageCount);
		int blockStartNum = (pageCount * blockNum) + 1;					//블록의 시작 숫자
		int blockLastNum = blockStartNum + (pageCount-1);
		int total = Malldao.getNumberReply(bookname);
		int lastPageNum = 0;
		if(total % shopPage == 0) {
			lastPageNum = (int)Math.floor(total/shopPage);			//마지막 페이지의 수1
		}
		else {
			lastPageNum = (int)Math.floor(total/shopPage) + 1;		//마지막 페이지의 수2
		}
		logger.info("blockNum : {}",blockNum);
		logger.info("blockStartNum : {}",blockStartNum);
		logger.info("blockLastNum : {}",blockLastNum);
		model.addAttribute("curPageNum",curPageNum).addAttribute("blockStartNum",blockStartNum).addAttribute("blockLastNum",blockLastNum).addAttribute("lastPageNum",lastPageNum);
	}

	// 책 상세보기 창에서 최신순으로 리뷰 보기 페이징
	public List<Reply> replylatest(int curPageNum, String bookname) {
		List<Reply> list = null;
		list = Malldao.getCurPageRepliesLatest(curPageNum,bookname);					//현재 페이지에 해당하는 물품 리스트들
		return list;
	}

	public void pagingforReplyLatest(int curPageNum, Model model, String bookname) {
		int blockNum = 0;
		blockNum = (int)Math.floor((curPageNum-1)/ pageCount);
		int blockStartNum = (pageCount * blockNum) + 1;					//블록의 시작 숫자
		int blockLastNum = blockStartNum + (pageCount-1);
		int total = Malldao.getNumberReply(bookname);
		int lastPageNum = 0;
		if(total % shopPage == 0) {
			lastPageNum = (int)Math.floor(total/shopPage);			//마지막 페이지의 수1
		}
		else {
			lastPageNum = (int)Math.floor(total/shopPage) + 1;		//마지막 페이지의 수2
		}
		model.addAttribute("curPageNum",curPageNum).addAttribute("blockStartNum",blockStartNum).addAttribute("blockLastNum",blockLastNum).addAttribute("lastPageNum",lastPageNum);
	}

	// 주문 내역 페이징
	public void pagingforOrder(int curPageNum,Model model,String id) {
		int blockNum = 0;
		blockNum = (int)Math.floor((curPageNum-1)/ pageCount);
		int blockStartNum = (pageCount * blockNum) + 1;					//블록의 시작 숫자
		int blockLastNum = blockStartNum + (pageCount-1);
		int total = Malldao.getCountOrder(id);
		int lastPageNum = 0;
		if(total % shopPage == 0)
			lastPageNum = (int)Math.floor(total/shopPage);			//마지막 페이지의 수1
		else
			lastPageNum = (int)Math.floor(total/shopPage) + 1;		//마지막 페이지의 수2
		model.addAttribute("curPageNum",curPageNum).addAttribute("blockStartNum",blockStartNum).addAttribute("blockLastNum",blockLastNum).addAttribute("lastPageNum",lastPageNum);
	}

	// 이달의 인기서적 등록 페이지(관리자 페이지)에서 관리자가 구매량의 순으로 책을 볼 수 있도록 해주는 페이징 처리
	public void pagingforAdmin(int curPageNum, Model model) {
		int blockNum = 0;
		blockNum = (int)Math.floor((curPageNum-1)/ adminpageCount);
		int blockStartNum = (adminpageCount * blockNum) + 1;					//블록의 시작 숫자
		int blockLastNum = blockStartNum + (adminpageCount-1);
		int total = Malldao.getCountGoods();
		int lastPageNum = 0;
		if(total % adminPage == 0)
			lastPageNum = (int)Math.floor(total/adminPage);			//마지막 페이지의 수1
		else
			lastPageNum = (int)Math.floor(total/adminPage) + 1;		//마지막 페이지의 수2
		model.addAttribute("curPageNum",curPageNum).addAttribute("blockStartNum",blockStartNum).addAttribute("blockLastNum",blockLastNum).addAttribute("lastPageNum",lastPageNum);
	}

	// 관리자 계정의 환불 페이징
	public List<Refund> refundlist(int curPageNum) {
		List<Refund> refundlist = null;
		refundlist = Malldao.getCurPageRequestRefund(curPageNum);					//현재 페이지에 해당하는 물품 리스트들
		return refundlist;
	}

	public void pagingforRefund(int curPageNum, Model model) {
		int blockNum = 0;
		blockNum = (int)Math.floor((curPageNum-1)/ pageCount);
		int blockStartNum = (pageCount * blockNum) + 1;					//블록의 시작 숫자
		int blockLastNum = blockStartNum + (pageCount-1);
		int total = Malldao.getRequertRefundCount();
		int lastPageNum = 0;
		if(total % shopPage == 0)
			lastPageNum = (int)Math.floor(total/shopPage);			//마지막 페이지의 수1
		else
			lastPageNum = (int)Math.floor(total/shopPage) + 1;		//마지막 페이지의 수2
		model.addAttribute("curPageNum",curPageNum).addAttribute("blockStartNum",blockStartNum).addAttribute("blockLastNum",blockLastNum).addAttribute("lastPageNum",lastPageNum);
	}
}