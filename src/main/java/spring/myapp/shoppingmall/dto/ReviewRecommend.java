package spring.myapp.shoppingmall.dto;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@Entity
@Table(name = "reviewrecommend")
public class ReviewRecommend { 
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int reviewrecommendid;
	private String user_id;
	@ManyToOne
	@JoinColumn(name = "review_id")
	private Reply reviewid;
}
