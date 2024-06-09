package spring.myapp.shoppingmall.dto;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import org.hibernate.annotations.CreationTimestamp;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@ToString
@Entity
@Table(name = "coupon")
public class Coupon {
	@Id
	@Column(name = "Id")
	private String id;
	private String usecheck;
	@CreationTimestamp
	private Timestamp maketime;
	private int type;
	private String receive;
	private String user;
	@OneToOne
	@JoinColumn(name = "order_id")
	private Order orderid;
}