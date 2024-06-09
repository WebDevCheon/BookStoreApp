package spring.myapp.shoppingmall.dao;

import java.util.List;
import javax.inject.Inject;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import spring.myapp.shoppingmall.dto.User;

@Repository
public class UserDao {
	private static final Logger logger = LoggerFactory.getLogger(UserDao.class);

	@Autowired
	private SessionFactory sessionFactory;

	@Inject
	private BCryptPasswordEncoder passwordEncoder;

	private Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	public User getUser(String Id) {	//회원 정보 가져오기
		Session session = sessionFactory.getCurrentSession();
		User user = session.get(User.class,Id);
		return user;
	}

	public void join(User user) {
		logger.info("{}","start join...");
		Session session = sessionFactory.getCurrentSession();
		logger.info("{}","join check...");
		user.setAuthorities("ROLE_USER");
		user.setEnabled(0);
		user.setGrade("Bronze");
		session.save(user);
	}


	public boolean authId(String e_mail,String phoneNumber,String name){
		Session session = getSession();
		Query<User> query = session.createQuery("from User where name = :name and phoneNumber = :phoneNumber and email = :email",User.class);
		query.setParameter("name",name);
		query.setParameter("phoneNumber",phoneNumber);
		query.setParameter("email",e_mail);
		List<User> userlist = query.getResultList();
		if(userlist.size() > 0) {
			return true;
		} else {
			return false;
		}
	}

	public boolean authPw(String cId,String e_mail,String phoneNumber,String name){
		Session session = getSession();
		Query<User> query = session.createQuery("from User where id = :id and name = :name and email = :email and phoneNumber = :phoneNumber",User.class);
		query.setParameter("id",cId);
		query.setParameter("name",name);
		query.setParameter("phoneNumber",phoneNumber);
		query.setParameter("email",e_mail);
		List<User> userlist = query.getResultList();
		if(userlist.size() > 0) {
			return true;
		} else {
			return false;
		}
	}

	public User findId(String name,String phoneNumber){
		Session session = getSession();
		Query<User> query = session.createQuery("from User where name = :name and phoneNumber = :phoneNumber",User.class);
		query.setParameter("name",name);
		query.setParameter("phoneNumber",phoneNumber);
		List<User> userlist = query.getResultList();
		if(userlist.size() > 0) {
			return userlist.get(0);
		} else {
			return null;
		}
	}

	public User findPw(String cId){
		Session session = getSession();
		Query<User> query = session.createQuery("from User where id = :id",User.class);
		query.setParameter("id",cId);
		List<User> userlist = query.getResultList();
		if(userlist.size() == 1) {
			return userlist.get(0);
		}else {
			return null;
		}
	}
	public void repassword(String userId,String repassword){
		Session session = getSession();
		String encPassword = passwordEncoder.encode(repassword);
		Query query = session.createQuery("update User set password = :password where id = :id");
		query.setParameter("password",encPassword);
		query.setParameter("id",userId);
		query.executeUpdate();
	}

	public int check(String id){
		Session session = getSession();
		Query<User> query = session.createQuery("from User where id = :id",User.class);
		query.setParameter("id",id);
		List<User> userlist = query.getResultList();
		if(userlist.size() > 0) {
			return userlist.size();
		} else {
			return 0;
		}
	}

	public boolean checkNowPassword(String Userid,String Password){
		Session session = getSession();
		Query<User> query = session.createQuery("from User where id = :id",User.class);
		query.setParameter("id",Userid);
		User user = query.getSingleResult();
		if(passwordEncoder.matches(Password,user.getPassword())) {
			return true;
		} else {
			return false;
		}
	}

	public void updatePassword(String Userid,String Password){
		Session session = getSession();
		Query query = session.createQuery("update User set password = :password where id = :id");
		query.setParameter("password",Password);
		query.setParameter("id",Userid);
		query.executeUpdate();
	}

	public void authorizingemailconfirm(String email) {
		Session session = getSession();
		Query<User> query = session.createQuery("from User where email = :email",User.class);
		query.setParameter("email",email);
		User user = (User)(query.getSingleResult());
		query = session.createQuery("update User set emailconfirm = 1,enabled = 1 where id = :id");
		query.setParameter("id",user.getId());
		query.executeUpdate();
	}

	public boolean checkalreadyexistemail(String email) {
		Session session = getSession();
		Query<User> query = session.createQuery("from User where email = :email",User.class);
		query.setParameter("email",email);
		List<User> user = query.getResultList();
		if(user.size() > 0) {
			return true;  //이미 이메일이 존재하는 계정이 있음
		} else {
			return false; //없음
		}
	}

	public void joinnaveruser(User naveruser) {
		Session session = getSession();
		session.save(naveruser);
	}

	public int getUserNum(String userid) {
		Session session = getSession();
		int userNum = 0;
		User user = session.get(User.class,userid);
		return user.getId_num();
	}
}