<%@ page language="java" import = "spring.myapp.shoppingmall.dto.ReviewReply,java.text.DecimalFormat,spring.myapp.shoppingmall.dto.Reply,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	List<ReviewReply> reviewreplylist = (ArrayList<ReviewReply>)request.getAttribute("reviewreplylist");
	List<Reply> allreviewlist = (ArrayList<Reply>)request.getAttribute("reviewlist");
	List<Reply> list = (ArrayList<Reply>)request.getAttribute("list");
	int reviewcount = list.size();
	int onepoint = 0;
	int twopoint = 0;
	int threepoint = 0;
	int fourpoint = 0;
	int tag0 = 0;
	int tag1 = 0;
	int tag2 = 0;
	int tag3 = 0;
	int tag4 = 0;
	int tag5 = 0;
	double reviewpointscore = 0.0;
	if(allreviewlist.size() != 0){
	for(int i=0;i<allreviewlist.size();i++){
		if(allreviewlist.get(i).getReviewpoint() == 1){
			onepoint++;
		} else if(allreviewlist.get(i).getReviewpoint() == 2){
			twopoint++;
		} else if(allreviewlist.get(i).getReviewpoint() == 3){
			threepoint++;
		} else if(allreviewlist.get(i).getReviewpoint() == 4){
			fourpoint++;
		}
		
		if(allreviewlist.get(i).getTag() == 1){
			tag0++;
		} else if(allreviewlist.get(i).getTag() == 2){
			tag1++;
		} else if(allreviewlist.get(i).getTag() == 3){
			tag2++;
		} else if(allreviewlist.get(i).getTag() == 4){
			tag3++;
		} else if(allreviewlist.get(i).getTag() == 5){
			tag4++;
		}else if(allreviewlist.get(i).getTag() == 6){
			tag5++;
		}
	}
		reviewpointscore = 0;
 		reviewpointscore = (double)(onepoint * 1 + twopoint * 2 + threepoint * 3 + fourpoint * 4) / allreviewlist.size();
 		DecimalFormat form = new DecimalFormat("#.##");
 		reviewpointscore = Double.valueOf(form.format(reviewpointscore));
	}
	String mode = (String)request.getAttribute("mode");
%>
				<%
					int j = 0;
				%>
			<form action="subReview">
				  <ul class="board_list">
				  <c:if test = "${not empty list}">
				   <c:forEach items = "${list}" var = "review" varStatus = "status">
					<li>
						<div class="comment_wrap">
							<dl>
								<dt class="id">${review.user_id}</dt>   <!-- 리뷰 아이디 user_id -->
								<dd>${review.uploadtime}</dd>
								<dd class="kloverRating">
								<c:choose>
									<c:when test = "${review.reviewpoint eq 0}">
                                        0점
									</c:when>
									<c:otherwise> 
									 <c:forEach begin = "1" end = "${review.reviewpoint}">
                                        	<i class="fa fa-star" aria-hidden="true"></i>
                                     </c:forEach>
                                    </c:otherwise>
								</c:choose>
								</dd>

								<dd class="btns">
									<span> 
										<c:if test = "${review.tag eq 1}">
											<img src="${pageContext.request.contextPath}/resources/img/review/ico_commt_01.gif" alt="좋아요">
										</c:if>
										<c:if test = "${review.tag eq 2}">
											<img src="${pageContext.request.contextPath}/resources/img/review/ico_commt_02.gif" alt="잘읽혀요">
										</c:if>
										<c:if test = "${review.tag eq 3}">
											<img src="${pageContext.request.contextPath}/resources/img/review/ico_commt_03.gif" alt="정독해요">
										</c:if>
										<c:if test = "${review.tag eq 4}">
											<img src="${pageContext.request.contextPath}/resources/img/review/ico_commt_04.gif" alt="기발해요">
										</c:if>
										<c:if test = "${review.tag eq 5}">
											<img src="${pageContext.request.contextPath}/resources/img/review/ico_commt_05.gif" alt="유용해요">
										</c:if>
										<c:if test = "${review.tag eq 6}">
											<img src="${pageContext.request.contextPath}/resources/img/review/ico_commt_06.gif" alt="기타">
										</c:if>
									</span>
								</dd>
								<dd class="comment">
									<c:if test = "${not empty review.imgfileurl}">
										<img src = "${review.imgfileurl}" width = "100" height = "100">
									</c:if>
									<br>
									<div class="txt" id = "reviewcontent${review.rid}">${review.content}</div>
								</dd>
							</dl>
							<div class="cmt_rt">
								<ul class="list_share">
									<li class="cmt_reply" id = "cmt_reply"><a href = "#" style = "cursor:pointer">댓글</a></li>
									<c:if test= "${sessionScope.Userid eq review.user_id}">
										<li  class="cmt_del2"><a style = "cursor:pointer" onclick = "reviewdelete(${review.rid})">삭제</a></li>
									</c:if>
									<c:if test= "${sessionScope.Userid eq review.user_id}">
										<li  class="cmt_reply"><a style = "cursor:pointer" onclick = "reviewmodify(${review.rid})" id ="reviewmodify${review.rid}">수정</a></li>
									</c:if>
									<li class="cmt_like"><a style = "cursor:pointer" onclick = "reviewrecommend(${review.rid},'${sessionScope.Userid}')"></a><span>${review.good}</span></li>
								</ul>
							</div>
						</div>
						<c:if test = "${not empty reviewreplylist}">
							<% 
								for(int i=0;i<reviewreplylist.size();i++){
									if(reviewreplylist.get(i).getRid().getRid() == list.get(j).getRid()){
							%>
							<c:set var = "userid" value = "<%=reviewreplylist.get(i).getUser_id()%>"/>
								<div class="reply_wrap">
									<dl>
										<dt class="id"><%=reviewreplylist.get(i).getUser_id()%></dt>
										<dd><%=reviewreplylist.get(i).getUploadtime() %></dd>
										<dd class="comment">
											<div class="txt"><%=reviewreplylist.get(i).getContent() %></div>
										</dd>
									</dl>
									<div class="cmt_rt">
										<ul class="list_share">
										   <c:if test = "${sessionScope.Userid eq userid}">	 
											<li class="cmt_del">
												<a href = "#" onclick = "reviewreplydelete(<%=reviewreplylist.get(i).getReviewreplyid()%>)">
													삭제
												</a>
											</li>
										   </c:if>
											<li class="cmt_like"><a onclick = "reviewreplyrecommend(<%=reviewreplylist.get(i).getReviewreplyid()%>,'${sessionScope.Userid}')"></a><span><%=reviewreplylist.get(i).getGood()%></span></li>
										</ul>
									</div>	
								</div>			
							<%
									}
								}
							%>
						</c:if>
								
						<div class="reply_wrap" style="display:none;">
							<div class="re_write_wrap book_review">
								<textarea id = "reviewReply${review.rid}" onkeyup="chkword(this,1000)"></textarea>
								<input type = "hidden" id = "reviewreplygroupid" value = "${review.rid}">
								<button type="button" onclick = "addreviewreply(${review.rid})" class="btn_submit">
									<span>등록</span>
								</button>
								<span class="notice_reply">내용을 입력해주세요. 주제와 무관한 댓글, 악플, 배송문의 등의 글은 임의 삭제될 수 있습니다. <strong>0</strong>/1000자</span>
							</div>
						</div>
				     </li>
				      <%
				     	j++;
				      %>
				     </c:forEach>
				    </c:if> 
				    <c:if test = "${empty list}">
							<li>
							<dl>
								<dt><p style = "margin-top: 40px;text-align:center;">등록된 리뷰글이 존재하지 않습니다.</p></dt>
							</dl>
						    </li>
					</c:if>	
				  </ul>
				<!-- // 간단리뷰/평점 -->
    			<!-- 페이징 -->
				
				<div class="row">
					<!-- 페이징 부분 시작 -->
					 <div class="col-12">
					  <nav aria-label="navigation">
						<ul class="pagination justify-content-end mt-50" style="text-align: center;">        
        					<c:if test="${ curPageNum > 5 }">
        					  <% if(mode.equals("'getreviewhelp'")){ %>
            					<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/product?goods_id=${good.id}&page=1&bookname=${good.name}&mode='getreviewhelp'">◀◀</a></li>
            					<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/product?goods_id=${good.id}&page=${ blockStartNum - 1 }&bookname=${good.name}&mode='getreviewhelp'">◀</a></li>
        					  <% } else { %>
        					  	<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/product?goods_id=${good.id}&page=1&bookname=${good.name}&mode='getreviewlatest'">◀◀</a></li>
        					  	<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/product?goods_id=${good.id}&page=${ blockStartNum - 1 }&bookname=${good.name}&mode='getreviewlatest'">◀</a></li>
        						<% } %>
        					</c:if>
        					
        					<c:forEach var="i" begin="${ blockStartNum }" end="${ blockLastNum }">
            					<c:choose>
            						<c:when test="${ i > lastPageNum }">
            								
            						</c:when>
                					<c:when test="${ i == curPageNum }">
                    					<li class="page-item active" style = "color:black;"><a class="page-link">${ i }</a></li>
                					</c:when>
                					<c:otherwise>
                					<% if(mode.equals("'getreviewhelp'")) { %>
                    					<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/product?goods_id=${good.id}&page=${ i }&bookname=${good.name}&mode='getreviewhelp'">${ i }</a></li>
                					<% } else { %>
                						<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/product?goods_id=${good.id}&page=${ i }&bookname=${good.name}&mode='getreviewlatest'">${ i }</a></li>
                					<% } %>
                					</c:otherwise>
            					</c:choose>
        					</c:forEach>
        						<c:if test="${ lastPageNum > blockLastNum }">
        						 	<% if(mode.equals("'getreviewhelp'")) { %>
            							<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/product?goods_id=${good.id}&page=${ blockLastNum + 1 }&bookname=${good.name}&mode='getreviewhelp'">▶</a></li>
            							<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/product?goods_id=${good.id}&page=${ lastPageNum }&bookname=${good.name}&mode='getreviewhelp'">▶▶</a></li>
        							<% } else { %>
        								<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/product?goods_id=${good.id}&page=${ blockLastNum + 1 }&bookname=${good.name}&mode='getreviewlatest'">▶</a></li>
        								<li class="page-item"><a class="page-link" style = "color:black;" href="${pageContext.request.contextPath}/product?goods_id=${good.id}&page=${ lastPageNum }&bookname=${good.name}&mode='getreviewlatest'">▶▶</a></li>
        							<% } %>
        						</c:if>
    					</ul>
    				  </nav>
					</div>
					<!-- 페이징 부분 끝 -->
				</div>
			  </form>