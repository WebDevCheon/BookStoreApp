package spring.myapp.shoppingmall.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import spring.myapp.shoppingmall.dao.MallDao;
import spring.myapp.shoppingmall.dto.Reply;
import spring.myapp.shoppingmall.dto.ReviewReply;

@Service
@Transactional
public class ReplyServiceImpl implements ReplyService {
	@Autowired
	private MallDao Malldao;
	
	@Override
	public List<Reply> commentList(String goodsId) {
		return Malldao.commentlist(goodsId);
	}
	
	@Override
	public void contentReplyDelete(String bookname, String reviewId) {
		Malldao.contentreplydelete(bookname,reviewId);
	}
	
	@Override
	public void contentReplyModify(String bookname, String reviewId, String content) {
		Malldao.contentreplymodify(bookname,reviewId,content);
	}
	
	@Override
	public boolean addComment(String bookname,String user_id,String reply) {
		return Malldao.addComment(bookname,user_id,reply);
	}
	
	@Override
	public boolean addReview(Reply reply) {
		return Malldao.addreview(reply);
	}
	
	@Override
	public List<Reply> getAllReply(String bookname) {
		return Malldao.getAllReply(bookname);
	}
	
	@Override
	public void addReviewReply(ReviewReply userreview,int reviewId) {
		Malldao.addreviewreply(userreview,reviewId);
	}
	@Override
	public void reviewModify(String content, int reviewId) {
		Malldao.reviewmodify(content,reviewId);
	}

	@Override
	public void reviewDelete(int reviewId) {
		Malldao.reviedelete(reviewId);
	}
	
	@Override
	public void reviewReplyDelete(int reviewReplyId) {
		Malldao.reviewreplydelete(reviewReplyId);
	}

	@Override
	public void reviewRecommend(int reviewId,String userId) {
		Malldao.reviewrecommend(reviewId,userId);
	}

	@Override
	public void reviewReplyRecommend(int reviewReplyId,String userId) {
		Malldao.reviewreplyrecommend(reviewReplyId,userId);
	}

	@Override
	public boolean reviewRecommendCheck(int reviewId,String userId) {
		return Malldao.reviewrecommendcheck(reviewId,userId);
	}
	
	@Override
	public boolean reviewReplyRecommendCheck(int reviewReplyId, String userId) {
		return Malldao.reviewreplyrecommendcheck(reviewReplyId,userId);
	}
	
	@Override
	public Reply getReviewByReviewId(int reviewId) {
		return Malldao.getreviewbyid(reviewId);
	}

	@Override
	public int pastReviewCheck(String userId,String bookName) {
		return Malldao.pastreviewcheck(userId,bookName);
	}
}
