package spring.myapp.shoppingmall.handler;

import java.util.HashMap;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import spring.myapp.shoppingmall.service.CouponService;

public class EchoHandler extends TextWebSocketHandler {		// 유저의 쿠폰 알람 기능
	// 유저에게 관리자가 쿠폰을 발급했을 때,유저에게 알림이 가는 기능
	private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	private Map<String,Object> userSessions = new HashMap<>();
	private Map<String,Integer> couponAlarmChecklist = new HashMap<>();

	@Autowired
	private CouponService couponService;

	// 클라이언트와 연결 이후에 실행되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String senderId = getId(session);  //사용자의 ID를 반환
		userSessions.put(senderId,session);  //사용자의 ID를 아이디 : session 객체 식으로 mapping
		logger.info("senderId : " + senderId);
		logger.info("userSessions : " + userSessions.toString());
		logger.info("연결 성공");
		if(couponAlarmChecklist.get(senderId) == null)
			couponAlarmChecklist.put(senderId,0);
	}

	private String getId(WebSocketSession session) {
		Map<String,Object> httpSession = session.getAttributes();
		String loginUser = (String)httpSession.get("Userid");
		if(loginUser == null)
			return session.getId();
		else
			return loginUser;
	}

	// 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("text message : " + message.getPayload());
		String userid = message.getPayload();  //admin
		String[] strs = message.getPayload().split(",");  //admin,makecoupon
		if(strs.length == 1) {
			if(couponAlarmChecklist.get(userid) == 1) {  //쿠폰을 전에 확인 했을때
				return;
			} else {  //쿠폰을 아직 확인 안한 경우
				int canreceivecouponcount = couponService.getCouponsCountByUserId(userid);
				if(canreceivecouponcount > 0) {
					session.sendMessage(new TextMessage("받을 수 있는 쿠폰 개수가 " + canreceivecouponcount + "개가 있습니다."));
					couponAlarmChecklist.put(userid,1);
				}
			}
		} else {  //쿠폰을 받은 경우 (쿠폰 받기를 눌렀을때)
			couponAlarmChecklist.put(strs[0],null);
		}
	}
	// 클라이언트와 연결을 끊었을 때 실행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		logger.info("웹소켓 연결 끊겼습니다.");
		userSessions.remove(session.getAttributes().get("Userid"));
	}
}