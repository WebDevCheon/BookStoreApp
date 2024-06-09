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
@Table(name = "ordergoods")
public class Ordergoods {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int ordergoodsnum;
	private String merchant_id;
	private String name;
	private int qty;
	private String goodsprofile;
	@ManyToOne
	@JoinColumn(name = "orderid")
	private Order orderid;
}