package spring.myapp.shoppingmall.dto;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@Entity
@Table(name = "shoppingbasket")
public class Shoppingbasket{
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int pnum;
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user_id;
	private int price;
	private String thumbnail;
	private String name;
	private int qty;
	@ManyToOne
	@JoinColumn(name = "book_id")
	private Goods goods;
}