package spring.myapp.shoppingmall.dto;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@Entity
@Table(name = "monthbook")
public class Monthbook {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	private String cover;
	private int width;
	private int height;
	private int price;
	private int recommend;
	private String goodsprofile;
	private String bigclass;
	private String subclass;
	@OneToOne
	@JoinColumn(name = "book_id")
	private Goods goods_id; 
}
