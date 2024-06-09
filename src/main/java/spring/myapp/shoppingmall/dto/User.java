package spring.myapp.shoppingmall.dto;

import java.util.ArrayList;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.List;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@Entity
@Table(name = "user")
public class User{
	@Id
	@Column(name="Id")
	@Size(min=5,max=20,message = "아이디의 길이는 최소 5글자 최대 20글자 이하입니다.")
	private String id;
	@Size(min=5,max=60,message = "최소 다섯 글자 이상 60 글자 이하 비밀번호를 입력하셔야합니다.")
	@Column(name="Password")
	private String password;
	@NotEmpty(message = "이름을 입력하셔야 합니다.")
	private String name;
	@NotEmpty(message = "주소를 입력하셔야 합니다.")
	private String address;
	@NotEmpty(message = "성별을 입력하셔야 합니다.")
	private String sex;
	@NotNull(message = "나이를 입력하셔야 합니다.")
	private int age;
	@NotEmpty(message = "전화번호를 입력해주시기 바랍니다.")
	@Column(name="phonenumber")
	private String phoneNumber;
	@NotEmpty(message = "이메일을 입력해주시기 바랍니다.")
	private String email;
	private String authorities;
	private int enabled;
	private String grade;
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int emailconfirm;
	private int naver;
	private int id_num;
	@OneToMany(mappedBy="user_id",cascade=CascadeType.ALL)
	private List<Shoppingbasket> carts = new ArrayList<Shoppingbasket>();
}