package spring.myapp.shoppingmall.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import spring.myapp.shoppingmall.dto.CustomUserDetails;
import spring.myapp.shoppingmall.dto.User;
import spring.myapp.shoppingmall.service.UserService;

@Controller
public class NaverLoginController {		// 네이버 로그인 요청 기능 Controller
	private final String CLIENT_ID = "NaverClientId";	// 네이버 API 발급 아이디
	private final String CLIENT_SECRET_ID = "NaverClientSecretId";		// 네이버 API 발급 Secret ID
	private final String CALLBACK_URL = "https://localhost:8443/shoppingmall/naverlogincallback";	// 개발 버전
	//private final String CALLBACK_URL = "https://www.forallshoppingmall.com/naverlogincallback";	// 배포 버전
	private Logger logger = LoggerFactory.getLogger(NaverLoginController.class);
	private RequestCache requestCache = new HttpSessionRequestCache();
	private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();
	private String defaultUrl = "https://localhost:8443/shoppingmall/";			// 개발 버전
	//private final String defaultUrl = "https://www.forallshoppingmall.com/";	// 배포 버전
	private final String mockNaverTokenURL = "https://96729ffb-0d4a-4a77-b9e2-c403aaa2cab1.mock.pstmn.io/naverTestToken";		// POSTMAN mock server 네이버 토큰 발급 url
	private final String mockNaverProfileURL = "https://96729ffb-0d4a-4a77-b9e2-c403aaa2cab1.mock.pstmn.io/naverTestProfile";	// POSTMAN mock server 네이버 프로필 조회 url

	@Autowired
	private UserService userService;

	@RequestMapping("/naverlogin")	// 네이버 로그인 버튼을 클릭하였을 때 이동할 '네이버 로그인' URL을 지정하여 Redirect
	public void NaverLogin(HttpServletRequest request,HttpServletResponse response){
		logger.info("NaverLogin url Request Accepted");
		String token = getToken(request);			// csrf 공격 방지를 위한 토큰값 생성
		String loginurl = "https://nid.naver.com/oauth2.0/authorize?client_id=" + CLIENT_ID + "&response_type=code&"
				+ "redirect_uri=" + CALLBACK_URL + "&state=" + token;
		try {
			response.sendRedirect(loginurl);
		} catch(Exception e) {
			logger.info("naverlogin Redirect Exception 발생");
			logger.info("Error Content : {}",e);
		}
	}

	@RequestMapping("/naverlogincallback")	// 네이버 로그인과 정보 제공 동의 과정이 완료되면 CallBack URL(도서 쇼핑몰 Server)로 code값과 state 값이 URL 문자열로 전송
	public String naverlogincallback(@RequestParam(required = false) String state,@RequestParam String code,@RequestParam(required = false) String error,
									 @RequestParam(required = false) String error_description,HttpSession session,HttpServletRequest request,HttpServletResponse response,
									 @RequestParam(required = false) boolean isTesting) {
		if(error != null) {
			logger.info("Naver Login Callback Error : {}",error_description);
			return "home";
		}
		String ServerToken = (String)session.getAttribute("state");
		if(!stateCheck(state,ServerToken)) {	// 네이버 서버의 토큰값과 도서 쇼핑몰 서버에서 발급해준 토큰값과 비교
			logger.info("토큰 인증 에러 발생 , Request : {}",request);
			return "home";
		} else {
			String tokenurl = null;
			String getprofileurl = null;

			if(isTesting) {			// POSTMAN mock server URL로 설정
				tokenurl = mockNaverTokenURL;
				getprofileurl = mockNaverProfileURL;
			} else {
				tokenurl = "https://nid.naver.com/oauth2.0/token?client_id=" + CLIENT_ID + "&client_secret="
						+ CLIENT_SECRET_ID + "&grant_type=authorization_code&state=" + (String)session.getAttribute("state") +
						"&code=" + code;	// Callback으로 전달받은 정보를 이용하여 인증 이후에 접근 토큰을 발급 요청할 URL,접근 토큰은 사용자가 인증을 완료했다는 것을 보장할 수 있는 인증 정보
				getprofileurl = "https://openapi.naver.com/v1/nid/me";	// 접근 토큰을 이용하여 프로필 정보 조회 API를 호출
			}

			logger.info("tokenurl = " + tokenurl);
			logger.info("getprofileurl = " + getprofileurl);

			try {
				/*String tokenurl = "https://nid.naver.com/oauth2.0/token?client_id=" + CLIENT_ID + "&client_secret="
						+ CLIENT_SECRET_ID + "&grant_type=authorization_code&state=" + (String)session.getAttribute("state") +
						"&code=" + code;
				*/
				URL url = new URL(tokenurl);
				HttpURLConnection con = (HttpURLConnection)url.openConnection();
				con.setRequestMethod("GET");
				con.setRequestProperty("User-Agent", "Mozilla/5.0");
				con.setRequestProperty("Accept", "application/json");
				con.setDoInput(true);
				con.connect();
				StringBuilder sb = new StringBuilder();
				String requestString = null;
				if (con.getResponseCode() == HttpURLConnection.HTTP_OK) {
					BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
					String line = null;
					while ((line = br.readLine()) != null) {
						sb.append(line + "\n");
					}
					br.close();
					requestString = sb.toString();
				}
				con.disconnect();
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);
				logger.info("네이버 접근 토큰 정보 : {}",jsonObj);
				String access_token = null;
				String token_type = null;
				access_token = (String)jsonObj.get("access_token");
				token_type = (String)jsonObj.get("token_type");
				try {
					//String getprofileurl = "https://openapi.naver.com/v1/nid/me";	// 접근 토큰을 이용하여 프로필 정보 조회 API를 호출
					url = new URL(getprofileurl);
					HttpURLConnection GetProfileConnection = (HttpURLConnection)url.openConnection();
					GetProfileConnection.setDoOutput(true);
					GetProfileConnection.setInstanceFollowRedirects(false);
					GetProfileConnection.setRequestMethod("GET");
					GetProfileConnection.setRequestProperty("Authorization",token_type + " " + access_token);
					GetProfileConnection.connect();
					sb = new StringBuilder();
					if (GetProfileConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
						BufferedReader br = new BufferedReader(new InputStreamReader(GetProfileConnection.getInputStream(), "utf-8"));
						String line = null;
						while ((line = br.readLine()) != null) {
							sb.append(line + "\n");
						}
						br.close();
						requestString = sb.toString();
					}
					GetProfileConnection.disconnect();
					jsonObj = (JSONObject) jsonParser.parse(requestString);
					logger.info("네이버 프로필 정보 조회 결과 : {}",jsonObj);
					JSONObject profilejson = (JSONObject)jsonObj.get("response");
					logger.info("profilejson : {}",profilejson);
					String navernickname = (String)profilejson.get("nickname");
					if(userService.findUserById(navernickname) == null) {  // 회원가입을 하지 않은 경우
						User naveruser = new User();
						naveruser.setId(navernickname);
						naveruser.setPassword("forallshoppingmallnaveruserpassword");  // 네이버 유저만 특별하게 DB에 저장되는 비밀번호(의미 업음)
						naveruser.setAuthorities("ROLE_USER");
						naveruser.setEmail("forallshoppingmallnaveremail");
						naveruser.setAddress("forallshoppingmallnaveraddress");
						naveruser.setPhoneNumber("forallshoppingmallphoneNumber");
						naveruser.setName((String)profilejson.get("name"));
						naveruser.setSex((String)profilejson.get("gender"));
						naveruser.setGrade("Bronze");
						naveruser.setEnabled(0);  //로그인폼으로 접속 금지
						naveruser.setNaver(1);  //네이버용 계정으로 로그인함
						userService.joinNaverUser(naveruser);
					}
					session.setAttribute("Userid",navernickname);
					User userinfo = new User();
					userinfo.setAuthorities("ROLE_USER");
					userinfo.setEnabled(1);
					userinfo.setPassword(null);		// 도서 쇼핑몰 서버에서 알아서 네이버 아이디 연동 로그인 같은 경우는 특별하게 지정
					// 스프링 시큐리티에 의해서 권한 승인
					SimpleGrantedAuthority simpleGrantedAuthority = new SimpleGrantedAuthority("ROLE_USER");	// 유저 권한 승인(네이버 로그인 인증에 성공한 유저에게 줄 권한을 가진 객체)
					List<SimpleGrantedAuthority> collection = new ArrayList<>();
					collection.add(simpleGrantedAuthority);
					CustomUserDetails customUserDetails = new CustomUserDetails(navernickname,null,collection);
					Authentication authentication =
							new UsernamePasswordAuthenticationToken(customUserDetails.getId(),null,customUserDetails.getAuthorities());
					SecurityContextHolder.getContext().setAuthentication(authentication);

					SavedRequest savedRequest = requestCache.getRequest(request, response);	// 접근하려고 했던 Request
					session.removeAttribute("state");		// session에 저장되어 있던 state값 해제

					if(savedRequest != null) {
						String targetUrl = savedRequest.getRedirectUrl();
						redirectStratgy.sendRedirect(request, response, targetUrl); // 권한이 필요한 URL을 누르고 로그인 폼으로 이동 했다면,다시 그 URL로 Redirect
					} else
						redirectStratgy.sendRedirect(request, response, defaultUrl); // 직접 브라우저 URL로 로그인 폼에 접근
					return "home";
				} catch(Exception e) {
					logger.info("접근 토큰을 이용하여 프로필 정보 조회 API를 호출 도중 에러 발생");
					session.setAttribute("getprofileerror","네이버 프로필 에러가 발생했습니다.");
					return "home";
				}
			} catch(Exception e) {
				logger.info("네이버 아이디 접근 토큰을 발급 받던 도중 에러 발생");
				session.setAttribute("gettokenerror","네이버 토큰 에러가 발생했습니다.");
				return "home";
			}
		}
	}

	private String generateState() {	// csrf 공격을 방지하기 위해 애플리케이션에서 생성한 상태 토큰값으로 URL인코딩을 적용한 값을 사용
		SecureRandom random = new SecureRandom();
		return new BigInteger(130, random).toString(32);
	}

	private String getToken(HttpServletRequest request) {	// 토큰값 생성 -> 나중에 네이버 서버에서 온 토큰값과 비교할 토큰값(csrf 방어 목적)
		String state = generateState();
		request.getSession().setAttribute("state", state);
		return state;
	}

	private boolean stateCheck(String ServerState,String sessionstate) {	// 네이버 서버의 토큰값과 도서 쇼핑몰 서버에서 발급해준 토큰값과 비교
		if(ServerState.equals(sessionstate))
			return true;
		else
			return false;
	}
}