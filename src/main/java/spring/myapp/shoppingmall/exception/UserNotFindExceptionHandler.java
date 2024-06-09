package spring.myapp.shoppingmall.exception;

public class UserNotFindExceptionHandler extends RuntimeException {
	private static final long serialVersionUID = -4311724323738824421L;
	private String id;
	
	public UserNotFindExceptionHandler(String id) { 
		super();
		this.id = id;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}