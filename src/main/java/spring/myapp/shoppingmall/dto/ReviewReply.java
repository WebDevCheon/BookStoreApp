package spring.myapp.shoppingmall.dto;

import java.sql.Timestamp;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.hibernate.annotations.CreationTimestamp;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "reviewreply")
public class ReviewReply {
	@Id
	private int reviewreplyid;
	private String user_id;
	private String content;
	private String bookname;
	@CreationTimestamp
	private Timestamp uploadtime;
	private int good;
	@OneToMany(mappedBy = "reviewreplyid",cascade = CascadeType.REMOVE)
	private List<ReviewReplyRecommend> reviewreplyrecommend;
	@ManyToOne
	@JoinColumn(name = "rid")
	private Reply rid; 
}
