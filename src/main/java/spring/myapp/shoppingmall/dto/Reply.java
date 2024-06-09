package spring.myapp.shoppingmall.dto;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.hibernate.annotations.CreationTimestamp;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@Entity
@Table(name = "reply")
public class Reply {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="rId")
	private int rid;  //리뷰 댓글의 아이디 번호
	@Column(name="gId")
	private String gid;  //책의 이름
	private String user_id;  //리뷰 댓글 올린 유저 아이디
	private String content;  //리뷰 댓글의 글 내용
	private int reviewpoint;  //리뷰 포인트 점수
	private String imgfileurl;  //이미지 파일의 url 경로
	@CreationTimestamp
	private Timestamp uploadtime;  //업로드 시간
	private int bgroup;  //답변의 그룹
	private int tag;
	private int good;
	@OneToMany(mappedBy = "rid",cascade = CascadeType.REMOVE)
	private List<ReviewReply> reviewreplylist = new ArrayList<ReviewReply>();
	@OneToMany(mappedBy = "reviewid",cascade = CascadeType.REMOVE)
	private List<ReviewRecommend> reviewrecommend;
	@ManyToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "bookid")
	private Goods goodsid;  //댓글을 올린 책의 아이디
}