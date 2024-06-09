package spring.myapp.shoppingmall.service;

import javax.inject.Inject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import spring.myapp.shoppingmall.dao.UserDao;
import spring.myapp.shoppingmall.dto.User;

@Service
@Transactional
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDao Userdao;
	
	@Inject
	private BCryptPasswordEncoder passwordEncoder;
	
	@Override
	public boolean authId(String e_mail,String phoneNumber,String name){
		return Userdao.authId(e_mail,phoneNumber,name);
	}
	
	@Override
	public boolean authPw(String cId,String e_mail,String phoneNumber,String name){
		return Userdao.authPw(cId,e_mail,phoneNumber,name);
	}

	@Override
	public void joinUser(User user) {
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		Userdao.join(user);
	}
	
	@Override
	public int execute(String id){
		int count = Userdao.check(id);
		return count;
	}
	
	@Override
	public boolean checkNowPassword(String Userid,String Password){
		return Userdao.checkNowPassword(Userid,Password);
	}
	
	@Override
	public void find(String name,String phoneNumber,Model model){
		model.addAttribute("findUser",Userdao.findId(name,phoneNumber));
	}
	
	@Override
	public void find(String cId,Model model){
		model.addAttribute("findUser",Userdao.findPw(cId));
	}
	
	@Override
	public void update(String Userid,String Password){
		String encPassword = passwordEncoder.encode(Password);
		Userdao.updatePassword(Userid, encPassword);
	}
	
	@Override
	public void execute(String userId,String repassword){
		Userdao.repassword(userId,repassword);
	}
	
	@Override
	public User findUserById(String id) {
		User user = Userdao.getUser(id);
		return user;
	}
	
	@Override
	public void authorizingEmailConfirm(String email) {
		Userdao.authorizingemailconfirm(email);
	}

	@Override
	public boolean checkAlreadyExistEmail(String email) {
		return Userdao.checkalreadyexistemail(email);
	}
	
	@Override
	public void joinNaverUser(User naveruser) {
		Userdao.joinnaveruser(naveruser);
	}
}
