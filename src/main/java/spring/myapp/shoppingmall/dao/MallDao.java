package spring.myapp.shoppingmall.dao;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import spring.myapp.shoppingmall.dto.Bookrecommend;
import spring.myapp.shoppingmall.dto.Coupon;
import spring.myapp.shoppingmall.dto.Goods;
import spring.myapp.shoppingmall.dto.Monthbook;
import spring.myapp.shoppingmall.dto.Order;
import spring.myapp.shoppingmall.dto.Ordergoods;
import spring.myapp.shoppingmall.dto.Refund;
import spring.myapp.shoppingmall.dto.Reply;
import spring.myapp.shoppingmall.dto.ReviewRecommend;
import spring.myapp.shoppingmall.dto.ReviewReply;
import spring.myapp.shoppingmall.dto.ReviewReplyRecommend;
import spring.myapp.shoppingmall.dto.Shoppingbasket;
import spring.myapp.shoppingmall.dto.Todaybook;
import spring.myapp.shoppingmall.dto.User;
import spring.myapp.shoppingmall.dto.Vbank;

@Repository
public class MallDao {
	private static final Logger logger = LoggerFactory.getLogger(MallDao.class);

	@Autowired
	private SessionFactory sessionFactory;
	
	public Session getSession() {
		Session session = sessionFactory.getCurrentSession();
		return session;
	}
	
	public List<Goods> getGoodsList() {
	      Session session = getSession();
	      
	      Query<Goods> query = session.createQuery("from Goods",Goods.class);
	      List<Goods> goodsList = query.getResultList();
	      
	      return goodsList;
	}
	
	public void insertMerchant(String id,String merchant_id,String phoneNumber,String address,String buyer_name,String memo,int price) {	//고객이 주문 결제 버튼을 누르는 순간 주문 아이디 DB에 넣기
		Session session = getSession();
		Order order = new Order();
		order.setId(id);
		order.setMerchant_id(merchant_id);
		order.setStatus("not paid");
		order.setPhoneNumber(phoneNumber);
		order.setAddress(address);
		order.setName(buyer_name);
		order.setMemo(memo);
		order.setPrice(price);
		order.setTime(new Timestamp(System.currentTimeMillis()));
		session.saveOrUpdate(order);
	}
	
	public void setShoppingbasket(int goods_id,String User_ID,int price,int qty,String name) {	// 장바구니 담기 + 주문하기 int gid, 첫번째
		Session session = getSession();
		User user = session.get(User.class,User_ID);
        Goods goods = session.get(Goods.class,goods_id);
        Shoppingbasket shoppingbasket = new Shoppingbasket();
        shoppingbasket.setUser_id(user);
        shoppingbasket.setPrice(price);
        shoppingbasket.setThumbnail(goods.getGoodsprofile());
        shoppingbasket.setName(name);
        shoppingbasket.setQty(qty);
        shoppingbasket.setGoods(goods);   
        user.getCarts().add(shoppingbasket);
        goods.getCart().add(shoppingbasket);
        session.saveOrUpdate(shoppingbasket);  
        session.flush();
	}
	
	public List<Shoppingbasket> getShoppingbasket(String User_ID) { // 장바구니 담았던 물품 정보들 가져오기
		Session session = getSession();
		User user = session.get(User.class,User_ID);
		List<Shoppingbasket> Shoppingbasketlist = new ArrayList<Shoppingbasket>();  
		for(int i = 0;i < user.getCarts().size();i++)
			Shoppingbasketlist.add(user.getCarts().get(i));
        return Shoppingbasketlist;
	}
	
	public Goods getGoodsInfo(int goods_id) { //하나의 물품 정보 확인
		Session session = getSession();
		Goods goods = session.get(Goods.class,goods_id);
        return goods;
	}
	
	public List<Goods> getShoppingGoodsInfo(String kind) { //하나의 물품 종류에 대하여 모든 물품을 가져옴 
		Session session = getSession();
		Query<Goods> query = session.createQuery("from Goods where kind = :kind",Goods.class);
		query.setParameter("kind",kind);
		List<Goods> goodslist = query.getResultList();
		return goodslist;
	}

	public void uploadgoods(Goods goods) {
	    Session session = getSession();
	    if(goods.getGoodscontent().contains("\r\n"))
	    	goods.setGoodscontent(goods.getGoodscontent().replace("\r\n","<br>"));
	    if(goods.getTcontent() != null && goods.getTcontent().contains("\r\n"))
	    	goods.setTcontent(goods.getTcontent().replace("\r\n","<br>"));
	    if(goods.getWriterintroduction() != null && goods.getWriterintroduction().contains("\r\n"))
	    	goods.setWriterintroduction(goods.getWriterintroduction().replace("\r\n","<br>"));
	    if(goods.getSummary() != null && goods.getSummary().contains("\r\n"))
	    	goods.setSummary(goods.getSummary().replace("\r\n","<br>"));
	    if(goods.getReview() != null && goods.getReview().contains("\r\n"))
	    	goods.setReview(goods.getReview().replace("\r\n","<br>"));
	    session.save(goods);
	}
	
	
	public void uploadProfilegoods(int goods_id,String uploadurl) { //이미 등록되어 있는 물품의 프로필을 등록
		Session session = getSession();
		Query query = session.createQuery("update Goods set goodsprofile = :goodsprofile where id = :id");
		query.setParameter("goodsprofile",uploadurl);
		query.setParameter("id",goods_id);
		query.executeUpdate();
	}

	
	
	// 페이징 처리 시작
	public List<Goods> getsearchinfo(int curPageNum,String search,String subject){
		if(search == "") {
			return null;
		}
		search = search.trim();
		logger.info("search : {}",search);
		Session session = getSession();
		if(subject.equals("name")) {
			Query<Goods> query = session.createQuery("from Goods where name like '%" + search + "%' order by id asc",Goods.class);
			query.setFirstResult(6 * (curPageNum - 1)).setMaxResults(6);
			return query.getResultList();
		} else if(subject.equals("writer")) {
			Query<Goods> query = session.createQuery("from Goods where writer like '%" + search + "%' order by id asc",Goods.class);
			query.setFirstResult(6 * (curPageNum - 1)).setMaxResults(6);
			return query.getResultList();
		} else {
			Query<Goods> query = session.createQuery("from Goods where wcompany like '%" + search + "%' order by id asc",Goods.class);
			query.setFirstResult(6 * (curPageNum - 1)).setMaxResults(6);
			return query.getResultList();
		}
	}
	
	public int getCountKwd(String subject,String search) {
		if(search == "")
			return 1;
		search = search.trim();
		Session session = getSession();
		Query<Goods> query = null;
		
		if(subject.equals("name"))
			query = session.createQuery("from Goods where name like '%" + search + "%'",Goods.class);
		else if(subject.equals("writer"))
			query = session.createQuery("from Goods where writer like '%" + search + "%'",Goods.class);
		else
			query = session.createQuery("from Goods where wcompany like '%" + search + "%'",Goods.class);
		return query.getResultList().size();
	}
	
	public List<Goods> getCurPageDtos(int curPageNum,String kind,int displayBookNumbers) {
		Session session = getSession();
		Query<Goods> query = session.createQuery("from Goods where kind = :kind order by Id asc",Goods.class);
		query.setFirstResult(displayBookNumbers * (curPageNum - 1)).setMaxResults(displayBookNumbers);
		query.setParameter("kind",kind);
		List<Goods> goodslist = query.getResultList();
		return goodslist;
	}

	public List<Goods> getCurPageDtosWithBook(int curPageNum, String bigclass, String subclass) {
		Session session = getSession();
		Query<Goods> query = session.createQuery("from Goods where bigclass = :bigclass and subclass = :subclass",Goods.class);
		query.setFirstResult(6 * (curPageNum - 1)).setMaxResults(6);
		query.setParameter("bigclass",bigclass);
		query.setParameter("subclass",subclass);
		List<Goods> goodslist = query.getResultList();
		return goodslist;
	}
	// 페이징 처리 끝
	
	
	
	public int getCount(String kind) {
		Session session = getSession();
		Query<Goods> query = session.createQuery("from Goods where kind = :kind",Goods.class);
		query.setParameter("kind",kind);
		return query.getResultList().size();
	}
	
	public int getCountWithBook(String bigclass, String subclass) {
        Session session  = getSession();
		Query<Goods> query = session.createQuery("from Goods where bigclass = :bigclass and subclass = :subclass",Goods.class);
		query.setParameter("bigclass",bigclass);
		query.setParameter("subclass",subclass);
		List<Goods> goodslist = query.getResultList();
		return goodslist.size();
	}
	
	public int getCountOrder(String id) {
		Session session = getSession();
		Query<Order> orders = session.createQuery("from Order where id = :id",Order.class);
		orders.setParameter("id",id);
		List<Order> orderlist = orders.getResultList();
		return orderlist.size();
	}

	public void deletebasket(int pnum) {
		Session session = getSession();
		Shoppingbasket shoppingbasket = session.get(Shoppingbasket.class,pnum);
		session.delete(shoppingbasket);
	}
	
	@Transactional
	public void insertPrice(int price,String merchant_uid) {
		Session session = getSession();	
		Query query = session.createQuery("update Order set price = :price where merchant_id = :merchant_id");
		query.setParameter("price",price);
		query.setParameter("merchant_id",merchant_uid);
		query.executeUpdate();
	}
	
	public int getfindprice(String merchant_uid) {
		Session session = getSession();
		Query query = session.createQuery("from Order where merchant_id = :merchant_id");
		query.setParameter("merchant_id",merchant_uid);
		Order order = (Order)query.getSingleResult();
		return order.getPrice();
	}
	
	@Transactional
	public void statusupdate(String updatestatus,String merchant_uid,String imp_uid,String paymethod) {
		Session session = getSession();
		if(imp_uid != null) {			// 결제할때의 주문 상태를 변화	
			Query query = session.createQuery("update Order set status = :status,imp_uid = :imp_uid,paymethod = :paymethod where merchant_id = :merchant_id");
			query.setParameter("status",updatestatus);
			query.setParameter("imp_uid",imp_uid);
			query.setParameter("paymethod",paymethod);
			query.setParameter("merchant_id",merchant_uid);
			query.executeUpdate();
		} else {						// 환불할때의 주문 상태를 변화
			Query query = session.createQuery("update Order set status = :status where merchant_id = :merchant_id");
			query.setParameter("status",updatestatus);
			query.setParameter("merchant_id",merchant_uid);
			query.executeUpdate();
		}
	}
	
	public Order getMerchantid(String merchant_id) {
		Session session = getSession();
		Query query = session.createQuery("from Order where merchant_id = :merchant_id");
		query.setParameter("merchant_id",merchant_id);
		Order order = (Order)query.getSingleResult();
		return order;
	}
	
	public String getimp_uid(String merchant_uid) {
		Session session = getSession();
		Query query = session.createQuery("from Order where merchant_id = :merchant_id");
		query.setParameter("merchant_id",merchant_uid);
		Order order = (Order)query.getSingleResult();
		return order.getImp_uid();
	}
	
	public void deltemerchantid(String merchant_id) {
		Session session = getSession();
		Query query = session.createQuery("delete from Order where merchant_id = :merchant_id");
		query.setParameter("merchant_id",merchant_id);
		query.executeUpdate();
	}
	
	public void statusupdatecancel(String merchant_id, String cancel) {
		Session session = getSession();
		Query query = session.createQuery("update Order set status = :status where merchant_id = :merchant_id");
		query.setParameter("status",cancel);
		query.setParameter("merchant_id",merchant_id);
		query.executeUpdate();
		query = session.createQuery("update Refund set status = :status where merchant_id = :merchant_id");
		query.setParameter("status","finished");
		query.setParameter("merchant_id",merchant_id);
		query.executeUpdate();
	}
	
	@Transactional
	public void insertvbank(String merchant_id, String vbanknum, String vbankname, String vbankdate,
			String vbankholder,String vbankperson,String vbankcode) {
		Session session = getSession();
		Query<Order> query = session.createQuery("from Order where merchant_id = :merchant_id",Order.class);
		query.setParameter("merchant_id",merchant_id);
		Vbank vbank = new Vbank();
		vbank.setMerchant_id(merchant_id);
		vbank.setOrder_id(query.getSingleResult());
		vbank.setVbanknum(vbanknum);
		vbank.setVbankname(vbankname);
		vbank.setVbankdate(vbankdate);
		vbank.setVbankholder(vbankholder);
		vbank.setVbankperson(vbankperson);
		vbank.setVbankcode(vbankcode);
		session.saveOrUpdate(vbank);
	}
	
	public void insertgoods(String merchant_id, String[] booknamelist, Integer[] bookqtylist) {
		String name;
		int qty;
		Session session = getSession();
		for(int i = 0; i < booknamelist.length; i++) {
			name = booknamelist[i];  //물품명
			qty = bookqtylist[i];    //물품의 갯수
			Ordergoods ordergoods = new Ordergoods();
			ordergoods.setMerchant_id(merchant_id);
			ordergoods.setName(name);
			ordergoods.setQty(qty);
			Query<Order> orderselectbymerchantidquery = session.createQuery("from Order where merchant_id = :merchant_id",Order.class);
			orderselectbymerchantidquery.setParameter("merchant_id",merchant_id);
			Order order = (Order)orderselectbymerchantidquery.getSingleResult();
			ordergoods.setOrderid(order); //ManyToOne
			session.saveOrUpdate(ordergoods);
			Query<Goods> query = session.createQuery("from Goods where name = :name",Goods.class);   
			query.setParameter("name",name);
			Goods goods = query.getSingleResult();
			query = session.createQuery("update Ordergoods set goodsprofile = :goodsprofile where name = :name");
			query.setParameter("goodsprofile",goods.getGoodsprofile());
			query.setParameter("name",goods.getName());
			query.executeUpdate();
			query = session.createQuery("update Goods set remain = :remain where name = :name");
			query.setParameter("remain",goods.getRemain() - bookqtylist[i]);
			query.setParameter("name",booknamelist[i]);
			query.executeUpdate();
		}
		for(int j = 0; j < booknamelist.length;j++) {
			Query<Goods> query = session.createQuery("from Goods where name = :name",Goods.class);
			query.setParameter("name",booknamelist[j]);
			Goods goods = query.getSingleResult();
			query = session.createQuery("update Goods set remain = :remain where name = :name");
			query.setParameter("remain",goods.getRemain() - bookqtylist[j]);
			query.setParameter("name",booknamelist[j]);
			query.executeUpdate();
			query = session.createQuery("update Goods set purchase = purchase + " + bookqtylist[j] +" where id = :id");
			query.setParameter("id",goods.getId());
			query.executeUpdate();
		}
		logger.info("무통장 입금 이외 결제 - insertgoods Method Success");
	}
	
	@Transactional
	public void insertVbankgoods(String merchant_id, String[] booknamelist, Integer[] bookqtylist) {
		String name;
		int qty;
		Session session = getSession();
		for(int i = 0; i < booknamelist.length; i++) {
			name = booknamelist[i];
			qty = bookqtylist[i];
			Ordergoods ordergoods = new Ordergoods();
			ordergoods.setMerchant_id(merchant_id);
			ordergoods.setName(name);
			ordergoods.setQty(qty);
			session.saveOrUpdate(ordergoods);
			Query<Goods> query = session.createQuery("from Goods where name = :name",Goods.class);
			query.setParameter("name",name);
			Goods good = query.getSingleResult();
			String hql = "update Ordergoods set goodsprofile = :goodsprofile where name = :name";

			query = session.createQuery(hql);
			query.setParameter("goodsprofile",good.getGoodsprofile());
			query.setParameter("name",name);
			query.executeUpdate();
		}
		logger.info("insertVbankgoods Method success");
	}
	
	@Transactional
	public void subordergoodsVbank(String merchant_uid) {
		Session session = getSession();
		Query<Ordergoods> query = session.createQuery("from Ordergoods where merchant_id = :merchant_id",Ordergoods.class);
		query.setParameter("merchant_id",merchant_uid);
		List<Ordergoods> ordergoodslist = query.getResultList();
		
		for(int j = 0;j < ordergoodslist.size();j++) {
			Query<Order> selectOrder = session.createQuery("from Order where merchant_id = :merchant_id",Order.class);
			selectOrder.setParameter("merchant_id",merchant_uid);
			ordergoodslist.get(j).setOrderid(selectOrder.getSingleResult());
			Query<Goods> query2 = session.createQuery("from Goods where name = :name",Goods.class);
			query2.setParameter("name",ordergoodslist.get(j).getName());
			Goods goods = query2.getSingleResult();
			
			query2 = session.createQuery("update Goods set remain = :remain where name = :name");
			query2.setParameter("remain",goods.getRemain() - ordergoodslist.get(j).getQty());
			query2.setParameter("name",ordergoodslist.get(j).getName());
			query2.executeUpdate();
			query2 = session.createQuery("update Goods set purchase = purchase + " 
					+ ((Ordergoods)(ordergoodslist.get(j))).getQty()
					+ " where id = :id");
			query2.setParameter("id",goods.getId());
			query2.executeUpdate();
		}
	}
	
	public List<Order> getorderinfo(String id,int curPageNum) {
		Session session = getSession();
		Query<Order> query = session.createQuery("from Order where id = :id order by time desc",Order.class);
		query.setParameter("id",id);
		query.setFirstResult(6 * (curPageNum -1)).setMaxResults(6);
		List<Order> orderlist = query.getResultList();
		return orderlist;
	}
	
	public List<Ordergoods> getordergoods(String merchant_id) {
		Session session = getSession();
		Query<Ordergoods> query = session.createQuery("from Ordergoods where merchant_id = :merchant_id",Ordergoods.class);
		query.setParameter("merchant_id",merchant_id);
		List<Ordergoods> ordergoodslist = query.getResultList();
		return ordergoodslist;
	}
	
	public Vbank getvbankinfo(String merchant_id){
		Session session = getSession();
		Query<Vbank> query = session.createQuery("from Vbank where merchant_id = :merchant_id",Vbank.class);
		query.setParameter("merchant_id",merchant_id);
		List<Vbank> vbanklist = query.getResultList();
		if(vbanklist.size() == 0) {
			return new Vbank();
		} else {
			Vbank vbank = query.getSingleResult();
			return vbank;
		}
	}
	
	public int requestrefund(String merchant_id, Integer amount, String holder, String bank, String account) {
		Session session = getSession();
		logger.info("requestrefund 메소드 실행");
		Refund requestrefund = new Refund();
		requestrefund.setMerchant_id(merchant_id);
		requestrefund.setAmount(amount);
		requestrefund.setRefundholder(holder);
		requestrefund.setRefundbank(bank);
		requestrefund.setRefundaccount(account);
		requestrefund.setStatus("in progress");
		Query query = session.createQuery("from Order where merchant_id = :merchant_id");
		query.setParameter("merchant_id",merchant_id);
		logger.info("requestrefund 메소드 실행2");
		Order order = (Order)query.getSingleResult();
		logger.info("order : {}",order);
		requestrefund.setOrderid(order);
		order.setRefundid(requestrefund);
		logger.info("requestrefund와 order의 일대일 연결");
		logger.info("requestrefund 메소드 실행3");
		session.saveOrUpdate(requestrefund);
		return 0;
	}
	
	public Refund getrefund(String merchant_id) {
		Session session = getSession();
		Query<Refund> query = session.createQuery("from Refund where merchant_id = :merchant_id",Refund.class);
		query.setParameter("merchant_id",merchant_id);
		List<Refund> refundlist = query.getResultList();
		if(refundlist.size() > 0)
			return refundlist.get(0);
		else
			return null;
	}
	
	public int remaincheck(String[] newname, Integer[] newqty) {
		Session session = getSession();
		Query query = null;
		for(int i=0;i<newname.length;i++) {
			query = session.createQuery("from Goods where name = :name");
			query.setParameter("name",newname[i]);
			Goods good = (Goods)query.getSingleResult();
			if(good.getRemain() < newqty[i]) {
				return 0;
			}
		} 
		return 1;
	}
	
	public int cartspace(String Id) {
		Session session = getSession();
		User user = session.get(User.class,Id);
		return user.getCarts().size();
	}
	
	public Integer usecoupon(String cnumber) {  //쿠폰 사용 버튼을 누름으로써,어떤 종류의 쿠폰이 사용되었는지 확인하여 그만큼 액수를 감소
		Session session = getSession();
		int couponresult = 10;
		Coupon coupon = null;
		Query<Coupon> query = session.createQuery("from Coupon where id = :id",Coupon.class);
		query.setParameter("id",cnumber);
		List<Coupon> coupons = query.getResultList();
		if(coupons.size() == 0) {
			couponresult = 10;
		} else {
			coupon = coupons.get(0);
			couponresult = coupon.getType();
		}
	 	return couponresult;
	}
	 
	public Integer receivecoupon(String id) {
		Session session = getSession();
		int receivecoupon = 1;
		Query<Coupon> query = session.createQuery("from Coupon where user = :user and receive = :receive",Coupon.class);
		query.setParameter("user",id);
		query.setParameter("receive","no");
		List<Coupon> couponlist = query.getResultList();
		if(couponlist.size() > 0) {
			query = session.createQuery("update Coupon set receive = :receive where user = :user");
			query.setParameter("receive","yes");
			query.setParameter("user",id);
			query.executeUpdate();
			receivecoupon = 1; //쿠폰 모두 받음
		} else {
			receivecoupon = 0;	//받을수 있는 쿠폰 없음
		}
		return receivecoupon;
	}

	public List<Coupon> getcoupons(String id) {
		Session session = getSession();
		Query<Coupon> query = session.createQuery("from Coupon where id = :id",Coupon.class);
		query.setParameter("id",id);
		List<Coupon> couponlist = query.getResultList();
		return couponlist;
	}

	public Coupon getcoupon(String id) {
		Session session = getSession();
		Coupon coupon = session.get(Coupon.class,id);
		return coupon;
	}
	
	public int getNumberCoupons(String id) {
		Session session = getSession();
		Query<Coupon> query = session.createQuery("from Coupon where user = :user and receive = :receive",Coupon.class);
		query.setParameter("user",id);
		query.setParameter("receive","yes");
		List<Coupon> couponlist = query.getResultList();
		return couponlist.size();
	}

	public List<Coupon> getCurPageCoupons(int curPageNum, String id) {
		Session session = getSession();
		Query<Coupon> query = session.createQuery("from Coupon where user = :user and receive = :receive order by maketime desc",Coupon.class);
		query.setParameter("user",id);
		query.setParameter("receive","yes");
		query.setFirstResult(6 * (curPageNum - 1)).setMaxResults(6);
		List<Coupon> couponlist = query.getResultList();
		return couponlist;
	}

	public void updateusecouponservice(String yes,String cnumber) {
		Session session = getSession();
		Coupon coupon = session.get(Coupon.class,cnumber);
		Query query = null;
		if(coupon.getUsecheck().equals("no")) {
			query = session.createQuery("update Coupon set usecheck = :usecheck where id = :id");
			query.setParameter("usecheck",yes);  //쿠폰이 사용되었음
			query.setParameter("id",cnumber);
			query.executeUpdate();
		}
	}

	public void updatediscountpercent(String couponId,String merchant_id) {  //주문 테이블에 어떤 쿠폰이 쓰였는지 Insert
		Session session = getSession();
		Query query = session.createQuery("update Order set couponid = :couponid where merchant_id = :merchant_id");
		query.setParameter("couponid",couponId);
		query.setParameter("merchant_id",merchant_id);
		query.executeUpdate();
	}

	public User getJeongbo(String id) {
		Session session = getSession();
		User user = session.get(User.class,id);
		return user;
	}

	public void deleteall(String id) {
		Session session = getSession();
		User user = session.get(User.class,id);
		logger.info("{}",user.getCarts().get(0).getName());
		for(int i=0;i<user.getCarts().size();i++) {
			Query<Shoppingbasket> query = session.createQuery("delete from Shoppingbasket where pnum = :pnum");
			query.setParameter("pnum",user.getCarts().get(i).getPnum());
			query.executeUpdate();
		}
	}

	public List<Reply> commentlist(String goods_id) {
		Session session = getSession();
		Query<Reply> query = session.createQuery("from Reply where gid = :gid order by rid",Reply.class);
		query.setParameter("gid",goods_id);
		List<Reply> replylist = query.getResultList();
		return replylist;
	}

	public boolean addComment(String bookname, String user_id, String reply) {
		logger.info("addcomment 메소드 실행");
		Session session = getSession();
		Reply Newreply = new Reply();
		Newreply.setGid(bookname);
		Newreply.setUser_id(user_id);
		Newreply.setContent(reply);
		Newreply.setReviewpoint(0);
		Query<Goods> selectgid = session.createQuery("from Goods where name = :name");
		selectgid.setParameter("name",bookname);
		Goods book = (Goods)selectgid.getSingleResult();
		Newreply.setGoodsid(book);
		session.saveOrUpdate(Newreply);
		return true;
	}
	
	public boolean addreview(Reply reply) {
		logger.info("addreview 메소드 실행");
		Session session = getSession();
		Query selectbook = session.createQuery("from Goods where name = :name");
		selectbook.setParameter("name",reply.getGid());
		Goods book = (Goods)selectbook.getSingleResult();
		reply.setGoodsid(book);
		session.saveOrUpdate(reply);
		return true;
	}

	public void contentreplymodify(String bookname, String rId, String content) {
		Session session = getSession();
		Query query = session.createQuery("update Reply set content = :content where gid = :gid and rid = :rid");
		query.setParameter("content",content);
		query.setParameter("gid",bookname);
		query.setParameter("rid",Integer.valueOf(rId));
		query.executeUpdate();
	}

	public void contentreplydelete(String bookname, String rId) {
		Session session = getSession();
		Query query = session.createQuery("delete from Reply where gid = :gid and rid = :rid");
		query.setParameter("gid",bookname);
		query.setParameter("rid",Integer.valueOf(rId));
		query.executeUpdate();
	}

	public int getNumberReply(String bookname) {
		Session session = getSession();
		Query<Reply> query = session.createQuery("from Reply where gid = :gid",Reply.class);
		query.setParameter("gid",bookname);
		List<Reply> replylist = query.getResultList();
		return replylist.size();
	}

	public List<Reply> getCurPageReplies(int curPageNum, String bookname) {  //gId는 책의 이름
		Session session = getSession();
		Query<Reply> query = session.createQuery("from Reply where gid = :gid order by rid asc",Reply.class);
		query.setFirstResult(6 * (curPageNum - 1)).setMaxResults(6);
		query.setParameter("gid",bookname);
		List<Reply> replylist = query.getResultList(); 
        return replylist;
	}

	public boolean mobilecheck(String merchant_uid) {
		Session session = getSession();
		Query<Ordergoods> query = session.createQuery("from Ordergoods where merchant_id = :merchant_id",Ordergoods.class);
		query.setParameter("merchant_id",merchant_uid);
		List<Ordergoods> ordergoodslist = query.getResultList();
		if(ordergoodslist.size() > 0) {
			return true;
		} else {
			return false;
		}
	}

	@Transactional
	public void updatestatususecoupon(String couponid,String merchant_id) {
		Session session = getSession();
		Query query = session.createQuery("update Coupon set usecheck = :usecheck where id = :id");
		query.setParameter("usecheck","yes");
		query.setParameter("id",couponid);
		query.executeUpdate();
		query = session.createQuery("update Order set couponid = :couponid where merchant_id = :merchant_id");
		query.setParameter("couponid",couponid);
		query.setParameter("merchant_id",merchant_id);
		query.executeUpdate();
		query = session.createQuery("from Order where merchant_id = :merchant_id");
		query.setParameter("merchant_id",merchant_id);
		Order order = (Order)query.getSingleResult();
		Coupon coupon = session.get(Coupon.class,couponid);
		coupon.setOrderid(order);
	}

	public int usedcouponcheckmethod(String couponid) {  //사용된 쿠폰인지 확인
		Session session = getSession();
		Coupon whetherusedcoupon = session.get(Coupon.class,couponid);
		if(whetherusedcoupon == null || whetherusedcoupon.getUsecheck().equals("yes"))
			return 1;
		else
			return 0;
	}

	public int bookrecommend(Bookrecommend recommend,int bookid) {
		Session session = getSession();
		Query<Goods> query = session.createQuery("from Goods where name = :bookname",Goods.class);
		query.setParameter("bookname",recommend.getBookname());
		Goods goods = (Goods)query.getSingleResult();
		recommend.setBook_id(goods);
		goods.getRecommendlist().add(recommend);
		session.save(recommend);
		query = session.createQuery("update Goods set recommend = recommend + 1 where id = :id");
		query.setParameter("id",bookid);
		int rowAffected = query.executeUpdate();
		if(rowAffected > 0)
			return 0;
		else
			return 1;
	}

	public int bookrecommendcheck(String userid, int bookid) {
		Session session = getSession();
		Query<Bookrecommend> query = session.createQuery("from Bookrecommend where userid = :userid and bookid = :bookid",Bookrecommend.class);
		query.setParameter("userid",userid);
		query.setParameter("bookid",bookid);
		List<Bookrecommend> recommendcheck = query.getResultList();
		if(recommendcheck.size() > 0) {
			return 1;
		} else {
			return 0;
		}
	}

	public int getcouponscountbyuserId(String id) {
		Session session = getSession();
		Query<Coupon> query = session.createQuery("from Coupon where user = :user and receive = :receive",Coupon.class);
		query.setParameter("user",id);
		query.setParameter("receive","no");
		List<Coupon> coupon = query.getResultList();
		if(coupon.size() == 0) {
			return 0;
		} else {
			return coupon.size();
		}
	}

	public List<Goods> getmonthbooklist(int curPageNum) {
		Session session = getSession();
		Query<Goods> query = session.createQuery("from Goods order by purchase desc",Goods.class);
		query.setFirstResult(5 * (curPageNum - 1)).setMaxResults(5);
		List<Goods> goodslist = query.getResultList();
		return goodslist;
	}

	public void setmonthbooklist(List<String> selectedbooklist) {
		Session session = getSession();
		for(int i=0;i<selectedbooklist.size();i++) {
			Goods goods = session.get(Goods.class,Integer.valueOf(selectedbooklist.get(i)));
			Monthbook monthbook = new Monthbook();
			monthbook.setName(goods.getName());
			monthbook.setPrice(goods.getPrice());
			monthbook.setWidth(goods.getWidth());
			monthbook.setHeight(goods.getHeight());
			monthbook.setCover(goods.getCover());
			monthbook.setGoodsprofile(goods.getGoodsprofile());
			monthbook.setRecommend(goods.getRecommend());
			monthbook.setGoods_id(goods);
			monthbook.setBigclass(goods.getBigclass());
			monthbook.setSubclass(goods.getSubclass());
			session.save(monthbook);
		}
	}

	public List<Monthbook> getmonthbooklistInmonthbooktable() {
		Session session = getSession();
		Query<Monthbook> query = session.createQuery("from Monthbook",Monthbook.class);
		return query.getResultList();
	}

	public int getCountGoods() {
		Session session = getSession();
		Query<Goods> query = session.createQuery("from Goods",Goods.class);
		return query.getResultList().size();
	}

	public void downmonthbooklist() {
		Session session = getSession();
		Query query = session.createQuery("delete from Monthbook where id > 0");
		query.executeUpdate();
	}

	public Goods findbook(String name) {
		Session session = getSession();
		Query<Goods> query = session.createQuery("from Goods where name = :name",Goods.class);
		query.setParameter("name",name);
		Goods goods = (Goods)(query.getSingleResult());
		return goods;
	}

	public void settodaybookselect(int bookid) {
		Session session = getSession();
		Goods goods = session.get(Goods.class,bookid);
		Todaybook todaybook = new Todaybook();
		todaybook.setName(goods.getName());
		todaybook.setSummary(goods.getSummary());
		todaybook.setGoodsprofile(goods.getGoodsprofile());
		todaybook.setRecommend(goods.getRecommend());
		todaybook.setGoods_id(goods);
		todaybook.setPage(goods.getPage());
		todaybook.setWidth(goods.getWidth());
		todaybook.setHeight(goods.getHeight());
		todaybook.setWriter(goods.getWriter());
		todaybook.setGoodscontent(goods.getGoodscontent());
		session.save(todaybook);
	}

	public Todaybook gettodaybook() {
		Session session = getSession();
		Query query = session.createQuery("from Todaybook order by id desc");
		List<Todaybook> todaybooklist = query.getResultList();
		if(todaybooklist.size() > 0)
			return todaybooklist.get(0);
		else
			return null;
	}

	public void purchasecancel(HashMap<String, Object> map) { //pusrchase 다시 복구 시키기
		Session session = getSession();
		String merchant_id = (String)(map.get("merchant_uid"));
		Query<Ordergoods> query = session.createQuery("from Ordergoods where merchant_id = :merchant_id",Ordergoods.class);
		query.setParameter("merchant_id",merchant_id);
		List<Ordergoods> ordergoodslist = query.getResultList();
		for(int i=0;i<ordergoodslist.size();i++) {
			query = session.createQuery("update Goods set purchase = purchase - " + 
					(ordergoodslist.get(i).getQty()) + 
					" where name = :name");
			query.setParameter("name",ordergoodslist.get(i).getName());
			query.executeUpdate();
			query = session.createQuery("update Goods set remain = remain + " + (ordergoodslist.get(i).getQty()) +
					" where name = :name");
			query.setParameter("name",ordergoodslist.get(i).getName());
			query.executeUpdate();
		}
	}

	public List<Reply> getAllReply(String bookname) {
		Session session = getSession();
		Query<Reply> query = session.createQuery("from Reply where gId = :gId",Reply.class);
		query.setParameter("gId",bookname);
		return query.getResultList();
	}

	public void addreviewreply(ReviewReply userreview,int rid) {
		Session session = getSession();
		Reply reply = session.get(Reply.class,rid); //one to many
		userreview.setRid(reply);   							
		reply.getReviewreplylist().add(userreview);	//one to many
		for(int i=0;i<reply.getReviewreplylist().size();i++)
			logger.info("reviewreplyid : {}",reply.getReviewreplylist().get(i).getReviewreplyid());
		session.saveOrUpdate(userreview);
	}

	public List<ReviewReply> getreviewreply(String bookname) {
		Session session = getSession();
		Query<ReviewReply> query = session.createQuery("from ReviewReply where bookname = :bookname order by reviewreplyid desc",ReviewReply.class);
		query.setParameter("bookname",bookname);
		List<ReviewReply> reviewreplylist = query.getResultList();
		return reviewreplylist;
	}

	public void reviewmodify(String content, int reviewid) {
		Session session = getSession();
		Query query = session.createQuery("update Reply set content = :content where rid = :reviewreplyid");
		query.setParameter("content",content);
		query.setParameter("reviewreplyid",reviewid);
		query.executeUpdate();
	}

	public void reviedelete(int reviewid) {
		Session session = getSession();
		Reply reply = session.get(Reply.class,reviewid);
		session.delete(reply);
	}
 
	public void reviewreplydelete(int reviewreplyid) {
		Session session = getSession();
		ReviewReply reviewreply = session.get(ReviewReply.class,reviewreplyid);
		session.delete(reviewreply);
	}

	public void reviewrecommend(int reviewid,String userid) {
		Session session = getSession();
		Reply reply = session.get(Reply.class,reviewid);
		ReviewRecommend recommend = new ReviewRecommend();
		recommend.setReviewid(reply);
		recommend.setUser_id(userid);
		reply.getReviewrecommend().add(recommend);
		session.save(recommend);
		logger.info("reviewrecommend 실행 완료");
		Query query = session.createQuery("update Reply set good = good + 1 where rid = :rid");
		query.setParameter("rid",reviewid);
		query.executeUpdate();
	}

	public void reviewreplyrecommend(int reviewreplyid,String userid){
		Session session = getSession();
		ReviewReply reply = session.get(ReviewReply.class,reviewreplyid);
		ReviewReplyRecommend recommend = new ReviewReplyRecommend();
		recommend.setReviewreplyid(reply);
		recommend.setUser_id(userid);
		reply.getReviewreplyrecommend().add(recommend);
		session.save(recommend);
		Query query = session.createQuery("update ReviewReply set good = good + 1 where reviewreplyid = :reviewreplyid");
		query.setParameter("reviewreplyid",reviewreplyid);
		query.executeUpdate();
	}

	public boolean reviewrecommendcheck(int reviewid,String userid) {
		Session session = getSession();
		Query<ReviewRecommend> query = session.createQuery("from ReviewRecommend where user_id = :user_id",ReviewRecommend.class);
		query.setParameter("user_id",userid);
		List<ReviewRecommend> reviewrecommendlist = query.getResultList();
		boolean reviewrecommendflag = true;
		for(int i=0;i < reviewrecommendlist.size();i++) {
			if(reviewrecommendlist.get(i).getReviewid().getRid() == reviewid) {
				reviewrecommendflag = false;  //이미 좋아요 버튼을 눌렀음
				break;
			}
		}
		return reviewrecommendflag;
	}

	public boolean reviewreplyrecommendcheck(int reviewreplyid, String userid) {
		Session session = getSession();
		Query<ReviewReplyRecommend> query = session.createQuery("from ReviewReplyRecommend where user_id = :user_id",ReviewReplyRecommend.class);
		query.setParameter("user_id",userid);
		List<ReviewReplyRecommend> reviewreplyrecommendlist = query.getResultList();
		boolean reviewreplyrecommendflag = true;
		for(int i=0;i < reviewreplyrecommendlist.size();i++) {
			if(reviewreplyrecommendlist.get(i).getReviewreplyid().getReviewreplyid() == reviewreplyid) {
				reviewreplyrecommendflag = false;  //이미 좋아요 버튼을 눌렀음
				break;
			}
		}
		return reviewreplyrecommendflag;
	}

	public int getRequertRefundCount() {
		Session session = getSession();
		Query<Refund> query = session.createQuery("from Refund");
		return query.getResultList().size();
	}

	public List<Refund> getCurPageRequestRefund(int curPageNum) {
		Session session = getSession();
		Query<Refund> query = session.createQuery("from Refund order by requesttime desc");
		query.setFirstResult(6 * (curPageNum - 1)).setMaxResults(6);
		List<Refund> refundlist = query.getResultList();
		return refundlist;
	}

	public int requestrefundoverlappingcheck(String merchant_id) {
		Session session = getSession();
		Query<Refund> query = session.createQuery("from Refund where merchant_id = :merchant_id");
		query.setParameter("merchant_id",merchant_id);
		return query.getResultList().size();
	}

	public List<Reply> getCurPageRepliesLatest(int curPageNum, String bookname) {
		Session session = getSession();
		Query<Reply> query = session.createQuery("from Reply where gid = :gid order by uploadtime desc",Reply.class);
		query.setFirstResult(6 * (curPageNum - 1)).setMaxResults(6);
		query.setParameter("gid",bookname);
		List<Reply> replylist = query.getResultList(); 
        return replylist;
	}

	public Reply getreviewbyid(int reviewid) {
		Session session = getSession();
		return session.get(Reply.class,reviewid);
	}

	public List<String> getbooknamelistbyid(String userId) {
		Session session = getSession();
		List<String> booknamelist = new ArrayList<String>();
		User user = session.get(User.class,userId);
		for(int i=0;i<user.getCarts().size();i++) {
			booknamelist.add(user.getCarts().get(i).getName());
		}
		return booknamelist;
	}

	public List<Integer> getbookqtylistbyid(String userId) {
		Session session = getSession();
		List<Integer> bookqtylist = new ArrayList<Integer>();
		User user = session.get(User.class,userId);
		for(int i=0;i<user.getCarts().size();i++)
			bookqtylist.add(user.getCarts().get(i).getQty());
		return bookqtylist;
	}

	public List<Coupon> canreceive(String id) {
		Session session = getSession();
		Query<Coupon> query = session.createQuery("from Coupon where receive = :receive and usecheck = :usecheck and id = :id",Coupon.class);
		query.setParameter("receive","no");
		query.setParameter("usecheck","no");
		query.setParameter("id",id);
		return query.getResultList();
	}

	public int pastreviewcheck(String Userid,String bookname) {
		Session session = getSession();
		Query<Reply> query = session.createQuery("from Reply where user_id = :user_id and gid = :gid",Reply.class);
		query.setParameter("user_id",Userid);
		query.setParameter("gid",bookname);
		List<Reply> replylist = query.getResultList();
		if(replylist.size() > 0)
			return 0;  //이미 리뷰글에 작성
		else
			return 1;  //리뷰글 작성을 한번도 안했음
	}
	
	public int getReviewNum(String userid) {
		Session session = getSession();
		Query<Reply> query = session.createQuery("from Reply where user_id = :userid",Reply.class);
		query.setParameter("userid", userid);
		List<Reply> reviewNum = query.getResultList();
		int rnum = reviewNum.size();
		return rnum;
	}

	public boolean unitInStockCheck(List<String> booknamelist, List<Integer> bookqtylist,String merchant_id) {
		Session session = getSession();
		boolean checkflag = false;
		for(int i=0;i<booknamelist.size();i++) {
			Query<Goods> query = session.createQuery("from Goods where name = :name",Goods.class);
			query.setParameter("name",booknamelist.get(i));
			Goods checkbook = query.getSingleResult();
			if(checkbook.getRemain() < bookqtylist.get(i)) {
				Query<Order> nextQuery = session.createQuery("from Order where merchant_id = :merchant_id",Order.class);
				nextQuery.setParameter("merchant_id",merchant_id);
				Order order = nextQuery.getSingleResult();
				order.setStatus("shortage");
				session.saveOrUpdate(order);
				checkflag = true;
				return checkflag;
			}
		}
		return checkflag;
	}

	public boolean unitInStockShortageMobileCheck(String[] booknamelist, Integer[] bookqtylist,String merchant_uid) {
		Session session = getSession();
		boolean checkflag = false;
		for(int i=0;i<booknamelist.length;i++) {
			Query<Goods> query = session.createQuery("from Goods where name = :name",Goods.class);
			query.setParameter("name",booknamelist[i]);
			Goods checkbook = query.getSingleResult();
			if(checkbook.getRemain() < bookqtylist[i]) {
				Query<Order> nextQuery = session.createQuery("from Order where merchant_id = :merchant_id",Order.class);
				nextQuery.setParameter("merchant_id",merchant_uid);
				Order order = nextQuery.getSingleResult();
				order.setStatus("shortage");
				session.saveOrUpdate(order);
				checkflag = true;
				return checkflag;
			}
		}
		return checkflag;
	}
}