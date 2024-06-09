<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

        <div class="search-wrapper section-padding-100">
        <div class="search-close">
            <i class="fa fa-close" aria-hidden="true"></i>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="search-content">
                       <form action="${pageContext.request.contextPath}/search" method="get">
                           <select name = "subject" class = "form-control">
                            	<option value = "name" style = "color:black;">서명</option>
                            	<option value = "writer" style = "color:black;">저자</option>
                            	<option value = "wcompany" style = "color:black;">출판사</option>
                            </select>
                            <br>
                            <br>
                            <input type="search" name="search" id="search" placeholder="검색어를 입력해주세요." style = "font-weight:bold;font-size:100%;">
                            <div>
                            	<button type="submit" style = "margin-left:1040px;margin-top:50px;"><img src="${pageContext.request.contextPath}/resources/img/core-img/search.png" alt=""></button>
                      		</div>
                      </form>
                    </div>
                </div>
            </div>
        </div>
    </div>