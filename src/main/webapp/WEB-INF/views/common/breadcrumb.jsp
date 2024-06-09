<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>         
            <div class="row">
            <div class="col-12">
			     <div class="range-breadcrumb text-right">
					<nav role="navigation"  class="range-breadcrumb__nav">
						<ol class="range-breadcrumb__list">				
							<li class="range-breadcrumb__list-item">
							<a href="${pageContext.request.contextPath}/" class="range-breadcrumb__link link link--black" >
							   <span class="range-breadcrumb-span"><i class="nav-icon fa fa-home"></i></span>						
							</a>
							<strong class="range-breadcrumb-strong">></strong>
							</li>
							<li class="range-breadcrumb__list-item">
							<a href="${pageContext.request.contextPath}/shop" class="range-breadcrumb__link link link--black" >
							   <span class="range-breadcrumb-span">상품</span>						
							</a>
							<c:if test="${not empty bigclassKor }">
							<strong class="range-breadcrumb-strong">></strong>
							</c:if>
							</li>
							<c:if test="${not empty bigclassKor }">
							<li class="range-breadcrumb__list-item">
							<a href="#" class="range-breadcrumb__link link link--black">
							   <span  class="range-breadcrumb-span">${bigclassKor}</span>						
							</a>							
								<c:if test="${not empty subclassKor }">
								<strong class="range-breadcrumb-strong">></strong>
								</c:if>							
							</li>
							</c:if>
							<c:if test="${not empty subclassKor }">
							<li class="range-breadcrumb__list-item">
							<a href="#" class="range-breadcrumb__link link link--black">
							   <strong class="range-breadcrumb-span range-breadcrumb-strong current_pange_active">${subclassKor}</strong>						
							</a>
							</li>
							</c:if>
							</ol>
						</nav>
					</div>	
			</div>
        </div>  
