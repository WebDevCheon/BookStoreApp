package spring.myapp.shoppingmall.controller;

import java.io.IOException;
import java.util.List;
import java.util.Random;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import spring.myapp.shoppingmall.dto.User;
import spring.myapp.shoppingmall.service.UserService;

@Controller
public class UserController
{
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserService userService;

	@Autowired
	private JavaMailSender mailSender;

	@RequestMapping("/joinform")	// 회원가입창으로 이동하는 페이지
	public String JoinForm(Model model) {
		model.addAttribute("user",new User());
		return "/join/joinform";
	}

	@RequestMapping("/loginForm") // 로그인 폼으로 이동하는 페이지
	public String loginForm(@RequestParam(value = "error",required = false) String error,
							@RequestParam(value = "logout",required = false) String logout,Model model,
							@CookieValue(value = "UserId",required = false) Cookie cookie,
							@RequestParam(value = "duplsession",required = false) String duplsession){
		if(cookie != null){
			User user = new User();
			user.setId(cookie.getValue());
			model.addAttribute("User",user);
		}
		if(error != null)
			model.addAttribute("error","아이디 또는 비밀번호가 일치하지 않습니다.");
		if(logout != null)
			model.addAttribute("logout","로그아웃 되었습니다.");
		if(duplsession != null)
			model.addAttribute("duplsession","중복 로그인을 하였습니다.");

		return "/login/loginForm";
	}

	@RequestMapping(value = "/join",method = RequestMethod.POST)  // 사용자가 회원가입 버튼을 눌렀을때
	public String join(HttpServletRequest request,@Valid User user,BindingResult result,Model model) {
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			for(ObjectError error : errors)
				logger.info("{}",error.getDefaultMessage());
			return "/join/joinform";
		} else if(userService.checkAlreadyExistEmail(user.getEmail())) {
			return "/join/joinfailed";
		} else {
			try {
				joinbyemail(user.getEmail());  // 사용자가 회원가입 폼에 입력한 이메일로 회원가입 인증 번호를 발송
				model.addAttribute("user",user);
				userService.joinUser(user);
				return "/join/beforejoinconfirm";
			} catch(Exception e) {
				e.printStackTrace();
				return "/error/404code";
			}
		}
	}

	@RequestMapping("/afterjoinconfirm")
	public String afterjoinconfirm(@RequestParam String email) {		// 회원의 인증메일로부터 회원 가입 완료
		logger.info("email : {} 계정으로 가입이 완료되었습니다.",email);
		userService.authorizingEmailConfirm(email);
		return "/join/afterjoinconfirm";
	}

	private void joinbyemail(String email) throws IOException {
		String setfrom = "test@domain.com";  // 관리자의 이메일에서 사용자의 이메일로 인증 번호를 발송
		String title = "forallshoppingmall 회원 가입 인증 이메일 입니다."; 	// 메일 제목
		String content = //메일 내용
				System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성
						System.getProperty("line.separator") +
						"안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다" +
						System.getProperty("line.separator") +
						System.getProperty("line.separator") +
						//"<a href = 'https://www.forallshoppingmall.com/afterjoinconfirm?email=" + email + "'>회원가입 이메일 인증 완료</a>" +		// 배포 버전
						"<a href = 'https://localhost:8443/shoppingmall/afterjoinconfirm?email=" + email + "'>회원가입 이메일 인증 완료</a>" +		// 개발 버전
						System.getProperty("line.separator") +
						System.getProperty("line.separator");
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(email);
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content,true); // 메일 내용
			mailSender.send(message);
		} catch (Exception e) {
			logger.info("회원가입 이메일 발송 도중 에러 발생 : {}",e);
		}
	}

	@RequestMapping("findId")  //아이디 찾기 폼으로 이동
	public String findId(HttpServletRequest request){
		return "/finduser/email_findId";
	}

	@RequestMapping("findPassword")  //비밀번호 찾기 폼으로 이동
	public String findPassword(HttpServletRequest request) {
		return "/finduser/email_findPw";
	}

	@RequestMapping(value = "/authid",method = RequestMethod.POST)  // 아이디 찾기 위해서 사용자에게 인증 번호 이메일을 발송
	@ResponseBody
	public Integer authFindUserId(HttpServletResponse response_email,@RequestParam String e_mail,
								  @RequestParam String phoneNumber,@RequestParam String name,Model model) throws IOException {//(DB에 있는 이름,핸드폰번호,이메일로 조회)만약 DB에 저장되어 있는 이메일이 맞다면,String 이메일을 보내고,이메일에 인증 번호를 보낸다.만약 DB에 정보가 일치하지 않으면,그렇지 않으면 null값을 보낸다
		if(userService.authId(e_mail, phoneNumber, name)) {
			Random r = new Random();
			int dice = r.nextInt(4589362) + 49311; // 이메일로 받는 인증코드 부분 (난수)
			String setfrom = "test@domain.com";
			String title = "아이디 찾기 인증 이메일 입니다."; // 제목
			String content = //메일 내용
					System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성
							System.getProperty("line.separator") +
							"안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다" +
							System.getProperty("line.separator") +
							System.getProperty("line.separator") +
							" 인증번호는 " + dice + " 입니다. " +
							System.getProperty("line.separator") +
							System.getProperty("line.separator") +
							"받으신 인증번호를 홈페이지에 입력해 주시면 다음으로 넘어갑니다."; // 내용
			try{
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

				messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo(e_mail);
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(content); // 메일 내용
				mailSender.send(message);
			} catch (Exception e) {
				logger.info("아이디 찾기 이메일을 발송 도중 에러 발생 : " + e);
			}
			model.addAttribute("datacheck","인증을 성공하였습니다.");
			return dice; //이메일 인증 성공
		}
		else
			return 0;
	}

	@RequestMapping(value = "/authpw",method = RequestMethod.POST)  // 비밀번호 찾기 위해서 사용자에게 인증 번호 이메일을 발송
	@ResponseBody
	public Integer authFindUserPassword(HttpServletResponse response_email,@RequestParam String e_mail,@RequestParam String phoneNumber,
										@RequestParam String name,@RequestParam String cId,Model model) throws IOException { //(DB에 있는 이름,핸드폰번호,이메일로 조회)만약 DB에 저장되어 있는 이메일이 맞다면,String 이메일을 보내고,이메일에 인증 번호를 보낸다.만약 DB에 정보가 일치하지 않으면,그렇지 않으면 null값을 보낸다
		if(userService.authPw(cId,e_mail, phoneNumber, name)){
			Random r = new Random();
			int dice = r.nextInt(4589362) + 49311; // 이메일로 받는 인증코드 부분 (난수)

			String setfrom = "test@domain.com";
			String title = "forallshoppingmall 비밀번호 찾기 이메일 입니다."; // 제목
			String content = //메일 내용
					System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성
							System.getProperty("line.separator") +
							"안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다" +
							System.getProperty("line.separator") +
							System.getProperty("line.separator") +
							" 인증번호는 " + dice + " 입니다. " +
							System.getProperty("line.separator") +
							System.getProperty("line.separator") +
							"받으신 인증번호를 홈페이지에 입력해 주시면 다음으로 넘어갑니다."; // 내용
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo(e_mail);
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(content); // 메일 내용
				mailSender.send(message);
			} catch (Exception e) {
				logger.info("비밀번호 찾기 이메일을 발송 도중 에러 발생 -> " + e);
			}
			return dice; // 이메일 인증 성공
		}
		else {
			model.addAttribute("error","정보가 유효하지 않습니다.다시 입력해주십시오.");
			return 0; //이메일 인증 실패
		}
	}

	@RequestMapping(value = "/findUserId",method = RequestMethod.POST)	// 아이디 찾기 폼으로 받은 정보를 바탕으로 아이디 찾음
	public String findUserId(@RequestParam String name,@RequestParam String phoneNumber,Model model,HttpServletRequest request){
		logger.info("이름 : {},핸드폰 번호 : {} 정보로 아이디 찾기를 시도",name,phoneNumber);
		userService.find(name,phoneNumber,model);
		return "/finduser/findIdResult";
	}

	@RequestMapping(value = "/findUserPw",method = RequestMethod.POST)	// 비밀번호 찾기 폼으로부터 받은 정보를 바탕으로 비밀번호 찾음
	public String findUserPw(@RequestParam String cId,Model model){
		logger.info("아이디 : {} 정보로 비밀번호 찾기를 시도",cId);
		userService.find(cId,model);
		return "/finduser/findPwResult";
	}

	@RequestMapping(value = "/repassword",method = RequestMethod.POST) //비밀번호 찾기 결과 비밀번호 바꾸기
	public String repassword(@RequestParam String userId,@RequestParam String repw){
		logger.info("비밀번호 찾기에서 비밀번호 업데이트 - 계정 아이디 : {},계정 비밀번호 : {}",userId,repw);
		userService.execute(userId,repw);
		return "redirect:/home";
	}

	@RequestMapping("/check")
	@ResponseBody
	public int check(HttpServletRequest request,@RequestParam String id){
		int count = 0;
		count = userService.execute(id);
		return count;
	}

	@RequestMapping("/updatePasswordForm")	// 비밀번호 바꾸기 폼으로 이동
	public String updatePasswordForm(){
		return "updatePasswordForm";
	}

	@RequestMapping(value = "/updatePassword",method = RequestMethod.POST)	// 사용자의 비밀번호를 변경
	public ModelAndView updatePassword(@RequestParam String Userid,@RequestParam String password,
									   @RequestParam String nowPassword,RedirectAttributes redirectAttributes){
		logger.info("아이디 : {},비밀번호 : {} 정보로 비밀번호 업데이트 시도",Userid,password);
		if(!userService.checkNowPassword(Userid, nowPassword)){
			ModelAndView mv = new ModelAndView();
			mv.setViewName("redirect:/updatePasswordForm");
			redirectAttributes.addFlashAttribute("error","현재 비밀번호가 틀렸습니다");
			return mv;
		}
		userService.update(Userid,password);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("home");
		return mv;
	}
}