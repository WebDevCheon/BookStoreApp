<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test = "${bigclass eq 'novel'}">
				<td>
					<sf:select path="subclass" style = "padding-bottom:3px;" id="subclass">
    					<sf:option value="koreannovel">한국소설</sf:option>
    					<sf:option value="englishnovel">영미소설</sf:option>
    					<sf:option value="japannovel">일본소설</sf:option>
   						<sf:option value="chinanovel">중국소설</sf:option>
   						<sf:option value="europenovel">유럽소설</sf:option>
   						<sf:option value="childrennovel">청소년소설</sf:option>
   						<sf:option value="classicnovel">고전소설</sf:option>
   						<sf:option value="genrenovel">장르소설</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'economy'}">
				<td>
					<sf:select path="subclass" style = "padding-bottom:3px;" id="subclass">
    					<sf:option value="managementgeneral">경영일반</sf:option>
    					<sf:option value="managementtheory">경영이론</sf:option>
    					<sf:option value="managementbusiness">경영관리</sf:option>
   						<sf:option value="managementstrategy">경영전략</sf:option>
   						<sf:option value="economygeneral">경제일반</sf:option>
   						<sf:option value="economypractice">경제실무</sf:option>
   						<sf:option value="worldeconomy">세계경제</sf:option>
    					<sf:option value="taxAccounting">세무/회계</sf:option>
    					<sf:option value="marketingAdvertising">마케팅/광고/고객</sf:option>
   						<sf:option value="tradeanddelivery">유통/창업</sf:option>
   						<sf:option value="techFinance">재테크/금융</sf:option>
   						<sf:option value="tradeanddelivery">무역/운송</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'humanity'}">
				<td>
					<sf:select path="subclass" style = "padding-bottom:3px;" id="subclass">
    					<sf:option value="psychology">심리학</sf:option>
    					<sf:option value="#">교육학</sf:option>
    					<sf:option value="#">철학</sf:option>
   						<sf:option value="#">문학</sf:option>
   						<sf:option value="#">언어학</sf:option>
   						<sf:option value="#">대학교재</sf:option>
   						<sf:option value="#">인문학일반</sf:option>
   						<sf:option value="#">역학/사주</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'science'}">
				<td>
					<sf:select path="subclass" style = "padding-bottom:3px;" id="subclass">
    					<sf:option value="#">과학이론</sf:option>
    					<sf:option value="#">도감</sf:option>
    					<sf:option value="#">교양과학</sf:option>
    					<sf:option value="#">수학</sf:option>
    					<sf:option value="#">물리학</sf:option>
    					<sf:option value="#">화학</sf:option>
    					<sf:option value="#">생물학</sf:option>
    					<sf:option value="#">지구과학</sf:option>
    					<sf:option value="#">천문학</sf:option>
    					<sf:option value="#">청소년 교양과학</sf:option>
    					<sf:option value="#">과학문고</sf:option>
						<sf:option value="#">대학교재</sf:option>
						<sf:option value="#">초과학</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'religion'}">
				<td>
					<sf:select path="subclass" style = "padding-bottom:3px;" id="subclass">
    					<sf:option value="#">기독교</sf:option>
    					<sf:option value="#">카톨릭</sf:option>
    					<sf:option value="#">불교</sf:option>
    					<sf:option value="#">이슬람교</sf:option>
    					<sf:option value="#">신토교</sf:option>
    					<sf:option value="#">조로아스터교</sf:option>
    					<sf:option value="#">동방정교</sf:option>
    					<sf:option value="#">힌두교</sf:option>
    					<sf:option value="#">시크교</sf:option>
    					<sf:option value="#">유대교</sf:option>
    					<sf:option value="#">천리교</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'politics'}">
				<td>
					<sf:select path="subclass" style = "padding-bottom:3px;" id="subclass">
    					<sf:option value="#">정치/외교</sf:option>
    					<sf:option value="#">행정/정책</sf:option>
    					<sf:option value="#">국방/군사</sf:option>
    					<sf:option value="#">법학</sf:option>
    					<sf:option value="#">사회학</sf:option>
    					<sf:option value="#">사회문제/복지</sf:option>
    					<sf:option value="#">언론/신문/방송</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'children'}">
				<td>
					<sf:select path="subclass" style = "padding-bottom:3px;" id="subclass">
    					<sf:option value="#">어린이문학</sf:option>
    					<sf:option value="#">어린이교양</sf:option>
    					<sf:option value="#">어린이만화</sf:option>
    					<sf:option value="#">초등학교 입학준비</sf:option>
    					<sf:option value="#">교과서수록/연계도서</sf:option>
    					<sf:option value="#">초등1-2학년</sf:option>
    					<sf:option value="#">초등3-4학년</sf:option>
    					<sf:option value="#">초등5-6학년</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'computer'}">
				<td>
					<sf:select path="subclass" style = "padding-bottom:3px;" id="subclass">
    					<sf:option value="#">컴퓨터공학</sf:option>
    					<sf:option value="#">컴퓨터인문</sf:option>
    					<sf:option value="#">운영체제</sf:option>
    					<sf:option value="#">네트워크</sf:option>
    					<sf:option value="#">데이터베이스</sf:option>
    					<sf:option value="#">게임프로그래밍</sf:option>
    					<sf:option value="#">웹프로그래밍</sf:option>
    					<sf:option value="#">모바일프로그래밍</sf:option>
    					<sf:option value="#">그래픽</sf:option>
    					<sf:option value="#">CAD</sf:option>
    					<sf:option value="#">자격증</sf:option>
    					<sf:option value="#">보안/해킹</sf:option>

					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'cook'}">
				<td>
					<sf:select path="subclass" style = "padding-bottom:3px;" id="subclass">
    					<sf:option value="#">요리일반</sf:option>
    					<sf:option value="#">요리에세이</sf:option>
    					<sf:option value="#">테마별요리</sf:option>
    					<sf:option value="#">베이킹/간식</sf:option>
    					<sf:option value="#">계절요리</sf:option>
    					<sf:option value="#">재료별요리</sf:option>
    					<sf:option value="#">나라별요리</sf:option>
    					<sf:option value="#">생활요리</sf:option>
    					<sf:option value="#">전문요리</sf:option>
    					<sf:option value="#">와인/커피/음료</sf:option>
    					<sf:option value="#">요리수험서</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'foreign'}">
				<td>
					<sf:select path="subclass" style = "padding-bottom:3px;" id="subclass">
    					<sf:option value="#">영어일반</sf:option>
    					<sf:option value="#">영어회화/청취</sf:option>
    					<sf:option value="#">비즈니스영어</sf:option>
    					<sf:option value="#">영어문법/독해/작문</sf:option>
    					<sf:option value="#">영어문고</sf:option>
    					<sf:option value="#">영어수업교재</sf:option>
    					<sf:option value="#">방송영어교재</sf:option>
    					<sf:option value="#">수험영어</sf:option>
    					<sf:option value="#">유학</sf:option>
    					<sf:option value="#">번역/통역</sf:option>
    					<sf:option value="#">일본어일반</sf:option>
    					<sf:option value="#">일본어회화</sf:option>
    					<sf:option value="#">일본어문법/작문</sf:option>
    					<sf:option value="#">일본어능력시험/JPT</sf:option>
    					<sf:option value="#">중국어일반</sf:option>
    					<sf:option value="#">중국어회화</sf:option>
    					<sf:option value="#">중국어문법/독해</sf:option>
    					<sf:option value="#">HSK/중국어시험</sf:option>
    					<sf:option value="#">독일어</sf:option>
    					<sf:option value="#">프랑스어</sf:option>
    					<sf:option value="#">어학사전</sf:option>
    					<sf:option value="#">대학교재</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'textbook'}">
				<td>
					<sf:select path="subclass" style = "padding-bottom:3px;" id="subclass">
    					<sf:option value="#">EBS</sf:option>
    					<sf:option value="#">국어</sf:option>
    					<sf:option value="#">수학</sf:option>
    					<sf:option value="#">영어</sf:option>
    					<sf:option value="#">과학</sf:option>
    					<sf:option value="#">사회</sf:option>
    					<sf:option value="#">기술/가정</sf:option>
    					<sf:option value="#">한문</sf:option>
    					<sf:option value="#">체육</sf:option>
    					<sf:option value="#">음악</sf:option>
    					<sf:option value="#">미술</sf:option>
    					<sf:option value="#">컴퓨터</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'cartoon'}">
				<td>
					<sf:select path="subclass" style = "padding-bottom:3px;" id="subclass">
    					<sf:option value="#">교양만화</sf:option>
    					<sf:option value="#">역사만화</sf:option>
    					<sf:option value="#">직업만화</sf:option>
    					<sf:option value="#">일상생활/드라마/가족만화</sf:option>
    					<sf:option value="#">동물등장만화</sf:option>
    					<sf:option value="#">요리만화</sf:option>
    					<sf:option value="#">도박만화</sf:option>
    					<sf:option value="#">고전/문학작품만화</sf:option>
    					<sf:option value="#">성인만화</sf:option>
    					<sf:option value="#">로맨스만화</sf:option>
    					<sf:option value="#">스포츠만화</sf:option>
    					<sf:option value="#">SF/판타지</sf:option>
    					<sf:option value="#">액션/무협만화</sf:option>
    					<sf:option value="#">명랑/코믹만화</sf:option>
    					<sf:option value="#">탐정/추리</sf:option>
    					<sf:option value="#">공포/스릴러</sf:option>
    					<sf:option value="#">학원만화</sf:option>
					</sf:select>
				</td>
				</c:if>
				<c:if test = "${bigclass eq 'magazine'}">
				<td>
					<sf:select path="subclass" style = "padding-bottom:3px;" id="subclass">
    					<sf:option value="#">여성/남성/패션</sf:option>
    					<sf:option value="#">인문/사회/종교</sf:option>
    					<sf:option value="#">자연/공학</sf:option>
    					<sf:option value="#">문학/교양</sf:option>
    					<sf:option value="#">어학/교육</sf:option>
    					<sf:option value="#">예술/대중만화</sf:option>
    					<sf:option value="#">취미/레포츠</sf:option>
    					<sf:option value="#">컴퓨터/게임</sf:option>
    					<sf:option value="#">외국잡지</sf:option>
    					<sf:option value="#">주간/월간/계간지</sf:option>
					</sf:select>
				</td>
				</c:if>
</body>
</html>