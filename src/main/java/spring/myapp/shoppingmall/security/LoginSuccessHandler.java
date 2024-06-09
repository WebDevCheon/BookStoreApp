package spring.myapp.shoppingmall.security;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Service;

@Service
public class LoginSuccessHandler implements AuthenticationSuccessHandler {		// 사이트에서 로그인 이후의 절차
    private static final Logger logger = LoggerFactory.getLogger(LoginSuccessHandler.class);
    private String loginidname;
    private String defaultUrl;
    private RequestCache requestCache = new HttpSessionRequestCache();
    private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();

    protected void resultRedirectStrategy(HttpServletRequest request, HttpServletResponse response,
                                          Authentication authentication) throws IOException, ServletException {
        SavedRequest savedRequest = requestCache.getRequest(request, response);
        logger.info("savedRequest: {}",savedRequest);
        if(savedRequest != null) { 	//인증 구간을 누르고 로그인 폼으로 이동
            String targetUrl = savedRequest.getRedirectUrl();
            redirectStratgy.sendRedirect(request, response, targetUrl);
        } else			//직접 브라우저 URL로 로그인 폼에 접근
            redirectStratgy.sendRedirect(request, response, defaultUrl);
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request) {		// 로그인 세션 삭제
        HttpSession session = request.getSession(false);
        if(session==null)
            return;
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {   //로그인 성공후에 호출될 메소드
        clearAuthenticationAttributes(request);
        request.getSession().setAttribute("Userid",request.getParameter("id"));		// 세션 Userid 속성값에 유저의 아이디를 저장
        if(request.getParameter("id").substring(0,5).equals("admin"))		// 관리자의 아이디일 경우에 admingrp라는 세션 속성값을 따로 저장
            request.getSession().setAttribute("admingrp","admingrp");
        if(request.getParameter("isRemember") != null && request.getParameter("isRemember").equals("on")){	// 아이디 기억하기 버튼을 누른 경우
            Cookie cookie = new Cookie("UserId",request.getParameter("id"));		// UserId라는 쿠키값에 아이디를 저장시켜서 클라이언트측에 보냄
            cookie.setMaxAge(60 * 60 * 24 * 30);		// 쿠키값의 기한 설정
            response.addCookie(cookie);
        }
        resultRedirectStrategy(request, response, authentication);		// 처음에 필터에 의하여 intercept 되었던 URL로 다시 보내기
    }

    public String getLoginidname() {
        return loginidname;
    }

    public void setLoginidname(String loginidname) {
        this.loginidname = loginidname;
    }

    public String getDefaultUrl() {
        return defaultUrl;
    }

    public void setDefaultUrl(String defaultUrl) {
        this.defaultUrl = defaultUrl;
    }
}