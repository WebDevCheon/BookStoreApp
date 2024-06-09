package spring.myapp.shoppingmall.dto;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@Entity
@Table(name = "vbank")
public class Vbank { 
	@Id
	private String merchant_id;
	@OneToOne
	@JoinColumn(name = "order_id")
	private Order order_id;
	private String vbanknum;
	private String vbankdate;
	private String vbankname;
	private String vbankholder;
	private String vbankperson;
	private String vbankcode;
}
