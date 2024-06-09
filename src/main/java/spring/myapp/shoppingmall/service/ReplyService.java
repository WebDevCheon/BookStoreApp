package spring.myapp.shoppingmall.service;

import java.util.List;
import spring.myapp.shoppingmall.dto.Reply;
import spring.myapp.shoppingmall.dto.ReviewReply;

public interface ReplyService {
	public List<Reply> commentList(String goodsId);
	public void contentReplyDelete(String goodsId, String reviewId);
	public void contentReplyModify(String goodsId, String reviewId, String content);
	public boolean addComment(String goodsId,String user_id,String reply);
	public boolean addReview(Reply reply); 
	public List<Reply> getAllReply(String bookName);
	public void addReviewReply(ReviewReply userReview,int reviewId);
	public void reviewModify(String content, int reviewId);
	public void reviewDelete(int reviewId);
	public void reviewReplyDelete(int reviewReplyId);
	public void reviewRecommend(int reviewId,String userId);
	public void reviewReplyRecommend(int reviewReplyId,String userId);
	public boolean reviewRecommendCheck(int reviewId,String userId);
	public boolean reviewReplyRecommendCheck(int reviewReplyId, String userId);
	public Reply getReviewByReviewId(int reviewId);
	public int pastReviewCheck(String userId,String bookName);
}