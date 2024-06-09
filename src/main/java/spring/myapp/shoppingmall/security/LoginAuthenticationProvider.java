package spring.myapp.shoppingmall.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import spring.myapp.shoppingmall.service.UserDetailsImpl;
import spring.myapp.shoppingmall.service.UserDetailsServiceImpl;

public class LoginAuthenticationProvider implements AuthenticationProvider {

    // UserDetail의 구현체인 UserDetails 객체를 가져와서 인증을 하여 권한을 줄지 말지 결정
    @Autowired
    private UserDetailsServiceImpl userDetailsService;
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    private SecurityContext securityContext = SecurityContextHolder.getContext();	// 테스트 코드 작성 위해서 getContext 할당 위치 바꿈

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {	// authentication : 클라이언트측으로부터 받은 id,password 등의 유저 정보 객체
        UsernamePasswordAuthenticationToken token = (UsernamePasswordAuthenticationToken) authentication;

        //입력한 ID, Password 조회
        String userId = token.getName();
        String userPw = (String)token.getCredentials();

        //UserDetailsService를 통해 DB에서 조회한 사용자
        UserDetailsImpl dbUser = (UserDetailsImpl)userDetailsService.loadUserByUsername(userId);

        if(dbUser == null)	// 계정 확인 불가
            throw new UsernameNotFoundException("DB User Not Found");
        else if(dbUser.getUser().getEmailconfirm() == 0)	// 계정 이메일 인증 안됨
            throw new LockedException("this User Locked Because of email auth");
        else if(dbUser.getUser().getEnabled() == 0)			// 계정 잠금
            throw new DisabledException("this User Locked");
        else if(!passwordEncoder.matches(userPw, dbUser.getPassword()))	// 비밀번호 불일치
            throw new BadCredentialsException(dbUser.getUsername() + "Not Matched Password");
        securityContext.setAuthentication(authentication);
        return new UsernamePasswordAuthenticationToken(dbUser, userPw, dbUser.getAuthorities());
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
}