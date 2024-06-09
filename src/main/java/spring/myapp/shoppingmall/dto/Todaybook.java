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
@Table(name = "todaybook")
public class Todaybook {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	private String summary;
	private int recommend;
	private String goodsprofile;
	private int width;
	private int height;
	private String writer;
	private String goodscontent;
	private int page;
	@OneToOne
	@JoinColumn(name = "book_id")
	private Goods goods_id;
}
