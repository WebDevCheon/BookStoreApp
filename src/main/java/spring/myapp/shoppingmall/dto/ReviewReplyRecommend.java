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
@Table(name = "reviewreplyrecommend")
public class ReviewReplyRecommend {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int reviewreplyrecommendid;
	private String user_id;
	@ManyToOne
	@JoinColumn(name = "reviewreply_id")
	private ReviewReply reviewreplyid;
}
