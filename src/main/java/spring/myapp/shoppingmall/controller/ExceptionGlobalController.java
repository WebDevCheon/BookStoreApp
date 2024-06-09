package spring.myapp.shoppingmall.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import spring.myapp.shoppingmall.exception.ErrorResponse;
import spring.myapp.shoppingmall.exception.UserNotFindExceptionHandler;

@ControllerAdvice
public class ExceptionGlobalController {		// 에러 처리
	@ExceptionHandler(UserNotFindExceptionHandler.class)
	public ResponseEntity<ErrorResponse> UserNotFindExceptionHandlerResponse(HttpServletRequest req,UserNotFindExceptionHandler exp){
		String requestURL = req.getRequestURI();
		ErrorResponse errresponse = new ErrorResponse();
		errresponse.setRequestUrl(requestURL);
		errresponse.setErrorMsg("유저 " + exp.getId() + "를 찾지 못했거나 네트워크 장애가 발생하였습니다.");
		return new ResponseEntity<ErrorResponse>(errresponse,HttpStatus.NOT_FOUND);
	}
}