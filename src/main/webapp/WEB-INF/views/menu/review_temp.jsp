<%@ page language="java" import = "spring.myapp.shoppingmall.dto.ReviewReply,java.text.DecimalFormat,spring.myapp.shoppingmall.dto.Reply,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- reviewlist : Reply 전부,list : 페이지 단위로 넘어오는 Reply,reviewreplylist : ReviewReply 전부 -->
<%
	List<Reply> list = (ArrayList<Reply>)request.getAttribute("list");  //책의 리뷰 order by rid asc
	List<Reply> allreviewlist = (ArrayList<Reply>)request.getAttribute("reviewlist"); //책의 리뷰(아무런 순서 상관없이)
	List<ReviewReply> reviewreplylist = (ArrayList<ReviewReply>)request.getAttribute("reviewreplylist");  //리뷰의 답변글(책의 이름 상관없이)
	int reviewcount = allreviewlist.size();
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
<div class="row">
<div class="col-lg-12">
	<div class="box_detail_content">
		<h2 class="title_detail_basic">평점/리뷰 <span class="kloverTotal" id="kloverTotal">(<%= reviewcount %>)</span></h2>
			<div class="box_detail_review">
				<div class="klover_review">
					<div class="header_klover">
						<h3>
							<strong>구매하신 책에 평점/리뷰를 남겨주시면 통합포인트를 적립해 드립니다.</strong> 
							<span class="popup_load"> <a href="#" class="btn_small">안내</a>
							</span>
						</h3>
						<span class="btn_write_review">
							<a href="#" onclick="pop_klover(this, '#klover-layer')">
								<img src="${pageContext.request.contextPath}/resources/img/review/btn_write_review.gif" alt="평가/리뷰쓰기">
							</a>
						</span>
					</div>
					
					<div class="klover_chart">
						<div class="review_level">
							<div class="level_chart">
								<div class="klover_area">
								<!--  네입 클로버  : level1 ~ level5  -->
								<% if(reviewpointscore >= 0 && reviewpointscore < 2) {%>
									<span class="klover level1"></span>
								<%
								}
								%>
								<% if(reviewpointscore >= 2 && reviewpointscore < 3) {%>
									<span class="klover level2"></span>
								<%
								}
								%>
								<% if(reviewpointscore >= 3 && reviewpointscore < 4) {%>
									<span class="klover level3"></span>
								<%
								}
								%>
								<% if(reviewpointscore >= 4 && reviewpointscore < 5) {%>
									<span class="klover level4"></span>
								<%
								}
								%>
								<% if(reviewpointscore >= 5) {%>
									<span class="klover level5"></span>
								<%
								}
								%>
									<span class="level"><strong class="score" style = "font-size : 15px;"><%= reviewpointscore %>  / 4.0</strong></span>									
								</div>
								<ul class="level_bar">							
							<!-- 	level04 하트 : 1개 , level03 하트 : 2개  , level02 하트 : 3개 , level01 하트 : 4개 --> 								
									<li class="level01">
										<div class="bar">
											<% if(fourpoint > 0 && fourpoint < 15) {
												fourpoint *= 10;
											%>
												<span style="width:<%=fourpoint%>px;"></span>
											<% 
												fourpoint /= 10;
											} else if(fourpoint >= 15) { 
											%>
												<span style="width:140px;"></span>
											<% } else {%>
												<span style = "width:0px;"></span>
											<%
											}	
											%>
											<strong><%= fourpoint %></strong>
										</div>
									</li>
									<li class="level02">
										<div class="bar">
											<% if(threepoint > 0 && threepoint < 15) {
												threepoint *= 10;
											%>
												<span style="width:<%=threepoint%>px;"></span>
											<%
												threepoint /= 10;
											} else if(threepoint >= 15) {
											%>
												<span style="width:140px;"></span>
											<%
												} else {
											%>
												<span style = "width:0px;"></span>
											<%
											}	
											%>
											<strong><%= threepoint %></strong>
										</div>
									</li>
									
									<li class="level03">
										<div class="bar">
										<% if(twopoint > 0 && twopoint < 15) {
												twopoint *= 10;
											%>
												<span style="width:<%=twopoint%>px;"></span>
											<%
												twopoint /= 10;
											} else if(twopoint >= 15){
											%>
												<span style="width:140px;"></span>
											<%
											} else {
											%>
												<span style = "width:0px;"></span>
											<%
											}	
											%>	
										<strong><%= twopoint %></strong>
										</div>
									</li>
									
									<li class="level04">
										<div class="bar">
											<% if(onepoint > 0 && onepoint < 15) {
												onepoint *= 10;
											%>
												<span style="width:<%=onepoint%>px;"></span>
											<%
												onepoint /= 10;
											} else if(onepoint >= 15) {
											%>
												<span style="width:140px;"></span>
											<% 
											} else {
											%>
												<span style = "width:0px;"></span>
											<%
											}	
											%>
											<strong><%= onepoint %></strong>
										</div>
									</li>
								</ul>
							</div>
						</div>
						<div class="review_express">
							<!-- 좋아요 -->
							<%
								if(tag0 < 40){
									tag0 += 50;
							%>
								<div class="express01" style="height: <%=tag0%>%;">
							<%
								tag0 -= 50;
							} else if(tag0 >= 40){
							%>
								<div class="express01" style="height: 98%;">
							<%
							}
							%>
								<strong class="num"><%= tag0 %></strong>
								<div class="bar"></div>
								<span class="emoticons">좋아요</span>
							</div>

							<!-- 잘읽혀요 -->
							<%
								if(tag1 < 40){
									tag1 += 50;
							%>
								<div class="express02" style="height: <%= tag1 %>%;">
							<%
								tag1 -= 50;
								} else if(tag1 >= 40){
							%>
								<div class="express02" style="height:98%;">
							<%
								}
							%>
								<strong class="num"><%= tag1 %></strong>
								<div class="bar"></div>
								<span class="emoticons">잘읽혀요</span>
							</div>
				
							<!-- 정독해요 -->
							<%
								if(tag2 < 40){
									tag2 += 50;
							%>
								<div class="express03" style="height: <%= tag2 %>%;">
							<%
								tag2 -= 50;
							} else if(tag2 >= 40){
							%>
							<div class="express03" style="height:98%;">
							<%
								}
							%>
								<strong class="num"><%= tag2 %></strong>
								<div class="bar"></div>
								<span class="emoticons">정독해요</span>
							</div>
							<!-- 기발해요 -->
							<%
								if(tag3 < 40){
									tag3 += 50;
							%>
								<div class="express04" style="height: <%= tag3 %>%;">
							<%
								tag3 -= 50;
							} else if(tag3 >= 40){
							%>
							<div class="express04" style="height:98%;">
							<%
								}
							%>
								<strong class="num"><%= tag3 %></strong>
								<div class="bar"></div>
								<span class="emoticons">기발해요</span>
							</div>
							<!-- 유용해요 -->
							<%
								if(tag4 < 40){
									tag4 += 50;
							%>
								<div class="express05" style="height: <%= tag4 %>%;">
							<%
								tag4 -= 50;
							} else if(tag4 >= 40){
							%>
								<div class="express05" style="height:98%;">
							<%
								}
							%>
								<strong class="num"><%= tag4 %></strong>
								<div class="bar"></div>
								<span class="emoticons">유용해요</span>
							</div>
							<!-- 기타 -->
							<%
								if(tag5 < 40){
									tag5 += 50;
							%>
								<div class="express06" style="height: <%= tag5 %>%;">
							<%
								tag5 -= 50;
							} else if(tag5 >= 40){
							%>
								<div class="express06" style="height:98%;">
							<%
								}
							%>
								<strong class="num"><%= tag5 %></strong>
								<div class="bar"></div>
								<span class="emoticons">기타</span>
							</div>
						</div>
						
					</div>
				</div>
				
				<!-- 정렬순서 -->
				<div class="sorting_wrap">
					<ul class="sorting_list" id="sorting_list2">
						<% if(mode.equals("'getreviewhelp'")){ %>
							<li id = "helpseq" class="on"><a href="#" onclick = "helpseq()" class="sorting_wrap_a">도움순</a></li>
							<li id = "latestseq"><a id = "alatestseq" href = "#" class="sorting_wrap_a">최신순</a></li>
						<% } else { %>
							<li id = "helpseq"><a href="#" onclick = "helpseq()" class="sorting_wrap_a">도움순</a></li>
							<li id = "latestseq" class = "on"><a href="#" onclick = "latestseq()" class="sorting_wrap_a">최신순</a></li>
						<% } %>  
					</ul>
				</div>
				
				<!-- 리뷰글 -->
			<div id = "getreview">
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
									if(reviewreplylist.get(i).getRid().getRid() == list.get(j).getRid()) {
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
										   <li></li>
											<li class="cmt_like"><a style = "cursor:pointer" onclick = "reviewreplyrecommend(<%=reviewreplylist.get(i).getReviewreplyid()%>,'${sessionScope.Userid}')"></a><span><%=reviewreplylist.get(i).getGood()%></span></li>
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
			    </div>
			</div> 
	  </div>
    </div>
</div>


<script>
	function addreviewreply(rid){
			$.ajax({
				url : '${pageContext.request.contextPath}/addreviewreply',
				method : 'post',
				contentType : "application/json",
				headers : {"X-CSRF-Token":csrf},
				data : JSON.stringify({
					"user_id" : '${sessionScope.Userid}',  //유저 아이디
					"bookname" : '${good.name}',  // 책 이름
					"reviewContent" : document.getElementById('reviewReply' + rid).value,  //리뷰글에 댓글을 다는 글의 내용
					"rid" : rid  //댓글을 달고자 하는 리뷰글의 글번호
				}),
				success : function(){
					alert('성공');
					location.reload();
				},
				error : function(){
					alert('에러 발생');
				}
			});
	}
</script>
<script>
	function reviewmodify(reviewreplyid){
		console.log(reviewreplyid);
		var modifyatag = document.getElementById('reviewmodify'+reviewreplyid);
		modifyatag.innerHTML = '수정완료';
		document.getElementById('reviewcontent'+reviewreplyid).setAttribute("contentEditable","true");
		document.getElementById('reviewcontent'+reviewreplyid).setAttribute("style","width:100%;text-align:left");
		modifyatag.setAttribute("onclick","executemodify(" + reviewreplyid + ")");
	}
</script>
<script>
	function executemodify(reviewreplyid){
			$.ajax({
				url : "${pageContext.request.contextPath}/reviewmodify",
				data : {"content" : document.getElementById("reviewcontent"+reviewreplyid).innerHTML,"reviewid" : reviewreplyid},
				headers : {"X-CSRF-Token":csrf},
				method : 'post',
				success : function(modifycontent){
					alert('수정 완료');
					document.getElementById('reviewcontent'+reviewreplyid).innerHTML = modifycontent;
					document.getElementById('reviewcontent'+reviewreplyid).setAttribute("contentEditable","false");
					var modifyatag = document.getElementById('reviewmodify'+reviewreplyid);
					modifyatag.innerHTML = '수정';
					modifyatag.setAttribute("onclick","reviewmodify(" + reviewreplyid + ")");
					return;
				},
				error : function(){
					error('수정 중에 에러 발생');
				}
			});
	}
</script>
<script>
	function reviewdelete(reviewid){
		$.ajax({
			url : "${pageContext.request.contextPath}/reviewdelete",
			method : 'post',
			headers : {"X-CSRF-Token":csrf},
			data : {"reviewid" : reviewid},
			success : function(){
				alert('삭제 성공');
				location.reload();
			},
			error : function(){
				alert('삭제 에러');
			}
		})
	}
</script>
<script>
	function reviewreplydelete(reviewreplyid){
		$.ajax({
			url : "${pageContext.request.contextPath}/reviewreplydelete",
			method : 'post',
			headers : {"X-CSRF-Token":csrf},
			data : {"reviewreplyid" : reviewreplyid},
			success : function(){
				alert('댓글 삭제 성공');
				location.reload();
			},
			error : function(){
				alert('댓글 삭제 에러');
			}
		});
	}
</script>
<script>
	function reviewrecommend(reviewid,userid){
		$.ajax({
			url : "${pageContext.request.contextPath}/reviewrecommendcheck",
			method : 'post',
			headers : {"X-CSRF-Token":csrf},
			data : {"reviewid" : reviewid,"userid" : userid},
			success : function(result){
			 if(result == true){
				$.ajax({
					url : "${pageContext.request.contextPath}/reviewrecommend",
					method : 'post',
					headers : {"X-CSRF-Token":csrf},
					data : {"reviewid" : reviewid,"userid" : userid},
					success : function(result){
						alert('좋아요 누르기 성공');
						location.reload();
					},
					error : function(){
						alert('좋아요 누르기 에러 발생');
					}
				});
			 } else{
				 alert('이미 좋아요를 누른 댓글입니다.');
				 return;
			 }
			},
			error : function(){
				alert('체크 확인 에러 발생');
			}
		});
	}
	
	function reviewreplyrecommend(reviewreplyid,userid){
		$.ajax({
			url : "${pageContext.request.contextPath}/reviewreplyrecommendcheck",
			method : 'post',
			headers : {"X-CSRF-Token":csrf},
			data : {"reviewreplyid" : reviewreplyid,"userid" : userid},
			success : function(result){
			 if(result == true){
				$.ajax({
					url : "${pageContext.request.contextPath}/reviewreplyrecommend",
					method : 'post',
					headers : {"X-CSRF-Token":csrf},
					data : {"reviewreplyid" : reviewreplyid,"userid" : userid},
					success : function(){
						alert('좋아요 누르기 성공');
						location.reload();
					},
					error : function(){
						alert('좋아요 누르기 에러 발생');
					}
				});
			  } else {
				  alert('이미 좋아요를 누른 댓글입니다.');
				  return;
			  }
		   },
		   error : function(){
			   alert('체크 확인 에러 발생');
		   }
	   });
	}
</script>
<script>
	function helpseq(){
		if(document.getElementById("latestseq").getAttribute("class") == "on"){
    		$.ajax({
    			url : "./review/getreviewhelp?goods_id=${good.id}&bookname=${good.name}",
    			method : 'GET',
    			dataType : 'html',
    			success : function(data){
    				document.getElementById("latestseq").setAttribute("class","");
    				document.getElementById("helpseq").setAttribute("class","on");
    				document.getElementById("getreview").innerHTML = data;
    				$(document).ready(function(){
    			  		$(".cmt_reply").on('click',"a",function(){
    			  			console.log(this);
    			  		});
    			  		$(".list_share li:first-child").on("click", function(e){
			  				if($(this).hasClass("cmt_del")===true){
			  					var $parnetLi =$(this).parent().parent().parent().parent();		
			  					//$parnetLi.children(":last").hide("fast");
			  					$parnetLi.children(":last").css("display", "none");
			  					$(this).removeClass("cmt_del").removeClass("reply_retract").addClass("cmt_reply");
			  					$(this).children("a").html("댓글");
			  					return false;
			  				}else{		
			  					var $parnetLi =$(this).parent().parent().parent().parent();
			  					//$parnetLi.children(":last").show("fast");
			  					$parnetLi.children(":last").css("display", "block");
			  					$(this).removeClass("cmt_reply").addClass("cmt_del").addClass("reply_retract");
			  					$(".re_write_wrap textarea").val("");			
			  					$(this).children("a").html("댓글취소");
			  					return false;
			  				}			
			  			});
    				});
    			},
    			error : function(){
    				console.log('에러 발생');
    			}
    		});
		}
	}
	
	function latestseq(){
		if(document.getElementById("helpseq").getAttribute("class") == "on"){
    		$.ajax({
    			url : "./review/getreviewlatest?goods_id=${good.id}&bookname=${good.name}",
    			method : 'GET',
    			dataType : 'html',
    			success : function(data){
    				document.getElementById("helpseq").setAttribute("class","");
    				document.getElementById("latestseq").setAttribute("class","on");
    				document.getElementById("getreview").innerHTML = data;
    				$(document).ready(function(){
    			  		$(".cmt_reply").on('click',"a",function(){
    			  			alert('확인');
    			  		    console.log(this);
    			  		});
    			  		$(".list_share li:first-child").on("click", function(e){
    			  			if($(this).hasClass("cmt_del")===true){
    			  				var $parnetLi =$(this).parent().parent().parent().parent();		
    			  				$parnetLi.children(":last").css("display", "none");
    			  				$(this).removeClass("cmt_del").removeClass("reply_retract").addClass("cmt_reply");
    			  				$(this).children("a").html("댓글");
    			  				return false;
    			  			}else{		
    			  				var $parnetLi =$(this).parent().parent().parent().parent();
    			  				$parnetLi.children(":last").css("display", "block");
    			  				$(this).removeClass("cmt_reply").addClass("cmt_del").addClass("reply_retract");
    			  				$(".re_write_wrap textarea").val("");			
    			  				$(this).children("a").html("댓글취소");
    			  				return false;
    			  			}			
    			  		});
    			    });
    			},
    			error : function(){
    				alert('에러 발생');
    			}
    		});
		}
	}
</script>