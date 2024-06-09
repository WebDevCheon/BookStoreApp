package spring.myapp.shoppingmall.dto;

import java.sql.Timestamp;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
@Entity
@Table(name = "ordertable")
public class Order{
	@Id
	private int orderid;		// 주문 번호(DB PK)
	private String merchant_id;		// 아임포트 서버에서 결제할 ID
	private String phoneNumber;
	private String address;
	private int price;
	private String status;
	private String imp_uid;
	private String id;
	private String paymethod;
	private String tekbenumber;
	private Timestamp time;
	private String name;
	@Column(name = "couponId")
	private String couponid;
	private String memo;
	@OneToOne(mappedBy = "orderid",cascade = CascadeType.REMOVE)
	private Refund refundid;
}