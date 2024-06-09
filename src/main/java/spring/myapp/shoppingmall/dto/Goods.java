package spring.myapp.shoppingmall.dto;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@Entity
@Table(name = "goods")
public class Goods {
	@Id
	@Column(name="Id")
	private int id;
	@NotEmpty(message = "도서명을 입력해주세요.")
	@Column(name="Name")
	private String name;
	@Min(value = 0,message = "가격이 최소한 0원이여야 합니다.")
	@Column(name="Price")
	private int price;
	@NotEmpty(message = "상품종류를 입력해주세요.")
	private String kind;
	@Min(value = 0,message = "잔여량을 입력해주세요.")
	private int remain;
	@NotEmpty(message = "상품의 이미지 파일을 등록해주세요.")
	private String goodsprofile;
	private String goodscontent;
	@NotEmpty(message = "글쓴이를 입력해주세요.")
	private String writer;
	private String wcompany;
	private String tcontent;
	private String review;
	private String summary;
	private String writerintroduction;
	@Min(value = 1,message = "페이지를 입력해주세요.")
	private int page;
	private String bigclass;
	private String subclass;
	private int recommend;
	private String cover;
	private int width;
	private int height;
	private int purchase;
	@NotEmpty(message = "책의 isbn 번호를 입력해주세요.")
	private String isbn;
	@NotEmpty(message = "책의 출판일을 입력해주세요.")
	private String publishday;
	@NotEmpty(message = "책의 커버 종류를 입력해주세요.")
	private String trastlationer;
	@OneToMany(mappedBy = "goods",cascade = CascadeType.ALL)
	List<Shoppingbasket> cart = new ArrayList<Shoppingbasket>();
	@OneToMany(mappedBy = "book_id",cascade = CascadeType.ALL)
	private List<Bookrecommend> recommendlist = new ArrayList<Bookrecommend>();
}