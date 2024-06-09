package spring.myapp.shoppingmall.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import spring.myapp.shoppingmall.dto.Bookrecommend;
import spring.myapp.shoppingmall.dto.Reply;
import spring.myapp.shoppingmall.dto.ReviewReply;
import spring.myapp.shoppingmall.dto.Shoppingbasket;
import spring.myapp.shoppingmall.dto.User;
import spring.myapp.shoppingmall.exception.UserNotFindExceptionHandler;
import spring.myapp.shoppingmall.service.*;

@RestController
public class MallRestController {
	private static final Logger logger = LoggerFactory.getLogger(MallRestController.class);
	
	@Autowired
	private ShoppingBasketService shoppingBasketService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private AwsService awsService;
	
	@Autowired
	private CouponService couponService;
	
	@Autowired
	private ReplyService replyService;
	
	@PostMapping(value = "/cart")	// 책 한권의 상세보기 창에서 주문하기 또는 장바구니 버튼을 눌렀을때,DB에 그 책의 이름과 수량을 카트에 Insert
	public void cart(Shoppingbasket cart,@RequestParam String userid,@RequestParam int goods_id){
		logger.info("장바구니 정보 : " + cart);
		shoppingBasketService.setShoppingBasket(cart.getQty(),goods_id,cart.getPrice(),userid,cart.getName());  //카트 담기
	}
	
	@RequestMapping(value = "/shoppingbasket",method = RequestMethod.POST)	// 책의 아이디,책의 개수를 DB의 사용자 아이디의 장바구니에 Insert -> /cart와 차이는 JSON으로 데이터를 받느냐 안받느냐의 차이
	public ResponseEntity<String> shoppingbasket(@RequestBody HashMap<String,Object> map,HttpSession session){	// 공부 해보기 위해서 /cart와 같은 기능을 작성
		   String UserId = ((String)map.get("userid"));						//(String)(session.getAttribute("Userid"));
		   int goods_id = Integer.valueOf((String)map.get("goods_id"));		// 책의 ID
		   int price = Integer.valueOf((String)map.get("price"));			// 책의 가격
		   int qty = Integer.valueOf((String)map.get("qty"));
		   String name = (String)map.get("name");
		   logger.info("주문하고자 하는 책 정보 : " + map);
		   shoppingBasketService.setShoppingBasket(qty, goods_id,price,UserId,name);  //카트 담기
		   return new ResponseEntity<String>("yes",HttpStatus.CREATED);
	}
	
	@PostMapping("/cartspace")	// 장바구니의 허용 개수 확인
	public ResponseEntity<Integer> cartspace(@RequestBody HashMap<String,Object> map) {  //유저의 아이디 Serialization
		String Id = (String)(map.get("Id"));
		int cartspace = shoppingBasketService.checkCartSpace(Id);  //카트를 담을 수 있는 공간 확인
		return new ResponseEntity<Integer>(cartspace,HttpStatus.OK);
	}
	
	@PostMapping("/jeongbo")	// 주문창 페이지에서 주문 form에 '회원 정보로 입력하기' 버튼을 눌렀을때 회원 정보를 조회하기 위해서 사용
	public ResponseEntity<JSONObject> findUserInfoInOrder(@RequestBody HashMap<String,Object> map){
		String Id = (String)(map.get("Id"));
		logger.info("유저의 아이디 : {}",Id);
		JSONObject data = new JSONObject();
		User user = userService.findUserById(Id);  // 유저 객체 찾기
		if(user == null)
			throw new UserNotFindExceptionHandler(Id); // 유저가 없다면 에러 발생
		data.put("name",user.getName());
		data.put("address",user.getAddress());
		data.put("phone",user.getPhoneNumber());
		data.put("email",user.getEmail());
		return new ResponseEntity<JSONObject>(data,HttpStatus.OK);
	}
	
	@PostMapping("/deleteshoppingcart")		// 유저의 장바구니에서 특정 책만 삭제
	public int deleteshoppingcart(int pnum) {
		shoppingBasketService.deleteShoppingBasket(pnum);
		return pnum;
	}
	
	@PostMapping("/deleteallshoppingcart")	// 유저의 장바구니 모두 삭제
	public void deleteallshoppingmall(@RequestParam String Id){
		shoppingBasketService.deleteAll(Id);
	}
	
	@PostMapping(value = "/upload",produces = "text/plain;charset=utf-8")		// 파일 업로드 기능 -> 1.관리자가 책을 등록할때, 책의 이미지를 파일 업로드   2.사용자가 댓글을 달때,댓글에 이미지 업로드
	public String upload(MultipartFile file,@RequestParam(required = false) Integer goods_id,
			@RequestParam(required = false) Integer reviewimgflag) throws Exception {	   
		JSONObject json = new JSONObject();
		UUID uuid = UUID.randomUUID();
		String org_filename = file.getOriginalFilename();
		String str_filename = uuid.toString() + org_filename;
		if(goods_id != null) {   //책의 이미지인 경우
			byte[] data = file.getBytes();		// 직렬화
			FileOutputStream fos = new FileOutputStream("C:\\SpringShoppingmall\\workplace\\ShoppingApp\\src\\main\\webapp\\goodsimgUpload\\" +  str_filename); //개발자 PC 파일 시스템
			//FileOutputStream fos = new FileOutputStream("/opt/tomcat/webapps/ROOT/upload/" +  str_filename);  // aws 파일 시스템
			fos.write(data);
			fos.close();
			logger.info("bookimagefile str_filename : {}",str_filename);
			File multitofile = convertFromMultipartToFile(str_filename,"book");
			//awsServiceImpl.s3FileUpload(multitofile,"book");  //관리자가 등록할 책 이미지 aws s3에 업로드
			//json.put("url","https://shoppingmallbucket.s3.ap-northeast-2.amazonaws.com/bookimage/" + str_filename);
			json.put("url","https://localhost:8443/shoppingmall/goodsimgUpload/" + str_filename);
			return json.toString();
		} else {  //리뷰 댓글 이미지인 경우
			try {
				byte[] data = file.getBytes();
				FileOutputStream fos = new FileOutputStream("C:\\SpringShoppingmall\\workplace\\ShoppingApp\\src\\main\\webapp\\reviewUpload\\" +  str_filename); //개발자 PC 파일 시스템
				//FileOutputStream fos = new FileOutputStream("/opt/tomcat/webapps/ROOT/reviewupload/" +  str_filename);  // aws 파일 시스템
				fos.write(data);
				fos.close();
				File multitofile = convertFromMultipartToFile(str_filename,"review");
				//awsServiceImpl.s3FileUpload(multitofile,"review");  //리뷰 댓글에 파일 업로드 이미지 aws s3에 업로드
				//json.put("url","https://shoppingmallbucket.s3.ap-northeast-2.amazonaws.com/reviewimage/" + str_filename);
				json.put("url","https://localhost:8443/shoppingmall/reviewUpload/" + str_filename);
				return json.toString();
			} catch(Exception e) {
				logger.info("파일 업로드중 오류 발생");
				json.put("thisiserror","error");
				return json.toString();
			}
		}
	}
	
	private File convertFromMultipartToFile(String filename,String whatupload) throws Exception {	// 파일 업로드 경로 지정
		if(whatupload.equals("book")) {
			File file = new File("C:\\SpringShoppingmall\\workplace\\ShoppingApp\\src\\main\\webapp\\goodsimgUpload\\" + filename);		// 개발 데스크탑 경로
			//File file = new File("/opt/tomcat/webapps/ROOT/upload/" +  filename);	AWS 리눅스 서버 경로
			logger.info("File upload name -> {}",filename);
			return file;
		} else {
			File file = new File("C:\\SpringShoppingmall\\workplace\\ShoppingApp\\src\\main\\webapp\\reviewUpload\\" + filename);
			//File file = new File("/opt/tomcat/webapps/ROOT/reviewupload/" +  filename);
			logger.info("File reviewimage name -> {}",filename);
			return file;
		}
	}
	
	@PostMapping("/usecoupon")		// 쿠폰을 적용하여 할인 적용
	public Integer usecoupon(@RequestParam String cnumber){
		Integer data = couponService.useCoupon(cnumber);
	    return data;
	}
	
	@PostMapping("/makecoupon")  // 쿠폰 받기
	public Integer makecoupon(@RequestParam String Id,HttpSession session){
		if(!session.getAttribute("Userid").equals(Id))
			return 3;
		else
			return couponService.receiveCoupon(Id);
	}
	 
	@PostMapping("/usedcouponcheck")  //사용된 쿠폰인지 체크
	public int usedcouponcheck(@RequestParam String cnumber){
		return couponService.usedCouponCheckMethod(cnumber);
	}
	
	@PostMapping("/productrecommend")  //책 추천하기
	public int productrecommend(Bookrecommend bookrecommend,@RequestParam int bookid,HttpSession session) {
		String userid = (String)session.getAttribute("Userid");
		bookrecommend.setUserid(userid);
		return productService.bookRecommend(bookrecommend,userid,bookid);
	}
	
	@PostMapping(value = "/addreview",produces = "application/text; charset=utf8")	// 특정 책의 리뷰 남기기
	public String addreview(@RequestBody HashMap<String,Object> map) {
		int reviewRating = (Integer)map.get("reviewRating");
		String reviewimgurl = (String)map.get("reviewimgurl");
		String user_id = (String)map.get("user_id");
		String reviewcontent = (String)map.get("reviewContent");
		int tag = Integer.valueOf((String)map.get("feelTagRating"));
		logger.info("tag : {}",tag);
		logger.info("reviewcontent : {}",reviewcontent);
		String bookname = (String)map.get("bookname");
		Reply userreview = new Reply();
		userreview.setContent(reviewcontent);
		userreview.setReviewpoint(reviewRating);
		userreview.setUser_id(user_id);
		userreview.setImgfileurl(reviewimgurl);
		userreview.setGid(bookname);
		userreview.setTag(tag);
		if(replyService.addReview(userreview)) {
			return "리뷰 업로드 성공";
		} else {
			return "리뷰 업로드 실패";
		}
	}
	
	@PostMapping("/addreviewreply")		// 리뷰에 대한 커멘트를 남기기
	public void addreviewreply(@RequestBody HashMap<String,Object> map) {
		String user_id = (String)map.get("user_id");
		String bookname = (String)map.get("bookname");
		String reviewContent = (String)map.get("reviewContent");
		int rid = (Integer)map.get("rid");  //rid는 리뷰의 아이디
		ReviewReply userreview = new ReviewReply();
		userreview.setUser_id(user_id);
		userreview.setBookname(bookname);
		userreview.setContent(reviewContent);
		replyService.addReviewReply(userreview,rid);  //리뷰에 대한 답변 달기
	}
	
	@PostMapping(value = "/reviewmodify",produces = "application/text; charset=utf8")		// 리뷰 수정
	public String reviewmodify(@RequestParam String content,@RequestParam int reviewid) {
		String modifycontent = content;
		replyService.reviewModify(content,reviewid);
		return modifycontent;
	}
	
	@PostMapping(value = "/reviewdelete")		// 리뷰 삭제
	public void reviewdelete(@RequestParam int reviewid,HttpServletRequest request,HttpServletResponse response){
		String[] arr = replyService.getReviewByReviewId(reviewid).getImgfileurl().split("/");
		logger.info("{}",(replyService.getReviewByReviewId(reviewid).getImgfileurl().split("/"))[arr.length-1]);
		awsService.s3FileDelete((replyService.getReviewByReviewId(reviewid).getImgfileurl().split("/"))[arr.length-1]);
		File file = new File("C:\\SpringShoppingmall\\workplace\\ShoppingApp\\src\\main\\webapp\\reviewUpload\\" + (replyService.getReviewByReviewId(reviewid).getImgfileurl().split("/"))[arr.length-1]);
		//File file = new File("/opt/tomcat/webapps/ROOT/reviewupload/" + (replyServiceImpl.getreviewbyrid(reviewid).getImgfileurl().split("/"))[arr.length-1]);
		if(file.delete())
			logger.info("리뷰 업로드 파일 삭제");
		else
			logger.info("리뷰 업로드 파일 삭제 실패");
		replyService.reviewDelete(reviewid);
	}
	
	@PostMapping("/reviewreplydelete")		// 리뷰에 대한 커멘트 삭제
	public void reviewreplydelete(@RequestParam int reviewreplyid,HttpServletRequest request,HttpServletResponse response) {
		replyService.reviewReplyDelete(reviewreplyid);
	}
	
	@PostMapping("/reviewrecommend")		// 리뷰 추천
	public void reviewrecommend(@RequestParam int reviewid,@RequestParam String userid) {
		replyService.reviewRecommend(reviewid,userid);
	}
	
	@PostMapping("/reviewreplyrecommend")	// 리뷰에 대한 커멘트 추천
	public void reviewreplyrecommend(@RequestParam int reviewreplyid,@RequestParam String userid) {
		replyService.reviewReplyRecommend(reviewreplyid,userid);
	}

	@PostMapping("/reviewrecommendcheck")	// 리뷰를 전에 추천한 적이 있는지 체크
	public boolean reviewrecommendcheck(@RequestParam int reviewid,@RequestParam String userid) {
		return replyService.reviewRecommendCheck(reviewid,userid);
	}
	
	@PostMapping("/reviewreplyrecommendcheck")	// 리뷰에 대한 커멘트를 추천한 적이 있는지 체크
	public boolean reviewreplyrecommendcheck(@RequestParam int reviewreplyid,@RequestParam String userid) {
		return replyService.reviewReplyRecommendCheck(reviewreplyid,userid);
	}
	
	@GetMapping("/pastreviewcheck")		// 책에 대한 리뷰를 단 적이 있는지 체크
	public int pastreviewcheck(HttpSession session,@RequestParam String bookname) {
		return replyService.pastReviewCheck((String)(session.getAttribute("Userid")),bookname);
	}
}