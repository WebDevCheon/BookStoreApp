package spring.myapp.shoppingmall.dto;

import java.util.Collection;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class CustomUserDetails implements UserDetails {
	private static final long serialVersionUID = 1L;
	private String id;					
	private String pw;	
	private Collection<? extends GrantedAuthority> authorities;
	
	public CustomUserDetails(String id,String pw,Collection<? extends GrantedAuthority> authorities) {
		this.id = id;
		this.pw = pw;
		this.authorities = authorities;
	}
	
	public String getId() {
		return id;
	}
	public String getPw() {
		return pw;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return this.authorities;
	}

	@Override
	public String getUsername() {
		return null;
	}
	@Override
	public boolean isAccountNonExpired() {
		return false;
	}
	@Override
	public boolean isAccountNonLocked() {
		return false;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return false;
	}
	@Override
	public boolean isEnabled() {
		return false;
	}
	@Override
	public String getPassword() {
		return null;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
}