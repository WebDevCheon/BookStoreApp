package spring.myapp.shoppingmall.dto;

import java.sql.Timestamp;

import javax.persistence.CascadeType;
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
@Entity
@Table(name = "requestrefund")
public class Refund { 
	@Id
	private String merchant_id;
	private int amount;
	private String refundholder;
	private String refundbank;
	private String refundaccount;
	private String status;
	@CreationTimestamp
	private Timestamp requesttime;
	@OneToOne
	@JoinColumn(name = "orderid")
	private Order orderid;
}
