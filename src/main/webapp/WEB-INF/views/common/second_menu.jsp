<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="spring.myapp.shoppingmall.dto.Goods"%>
<%@page import="java.util.List"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

      <div class="widget catagory mb-50">
                <!-- Widget Title -->
                <h6 class="widget-title mb-30"><b>상품</b></h6>
                <!--  Catagories  -->
                <div class="catagories-menu">
                    <ul>       
                        <li>
	                        <div class="menu_close">&nbsp;</div><a href="#" class="menu_a ${ bigclass eq 'novel' ? 'second_menu_active':''}">소설</a>                        
                        	<ul class="sub_menu">
										<li><a href="${pageContext.request.contextPath}/shop?bigclass=novel&subclass=koreannovel">한국소설</a></li>
										<li><a href="${pageContext.request.contextPath}/shop?bigclass=novel&subclass=englishnovel">영미소설</a></li>
										<li><a href="${pageContext.request.contextPath}/shop?bigclass=novel&subclass=japannovel">일본소설</a></li>
										<li><a href="${pageContext.request.contextPath}/shop?bigclass=novel&subclass=chinanovel">중국소설</a></li>
										<li><a href="${pageContext.request.contextPath}/shop?bigclass=novel&subclass=europeanNovels">유럽소설</a></li>
										<li><a href="${pageContext.request.contextPath}/shop?bigclass=novel&subclass=childrennovel">청소년 소설</a></li>
										<li><a href="${pageContext.request.contextPath}/shop?bigclass=novel&subclass=classicnovel">고전소설</a></li>
										<li><a href="${pageContext.request.contextPath}/shop?bigclass=novel&subclass=genrenovel">장르소설</a></li>
							</ul>                        
	                    </li>
                        <li>
                        	<div class="menu_close">&nbsp;</div><a href="#" class="menu_a ${ bigclass eq 'economy' ? 'second_menu_active':''}">경제/경영</a>
                        	<ul class="sub_menu">
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=economy&subclass=managementgeneral">경영일반</a></li>
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=economy&subclass=managementtheory">경영이론</a></li>
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=economy&subclass=managementbusiness">경영관리</a></li>
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=economy&subclass=managementstrategy">경영전략</a></li>
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=economy&subclass=economygeneral">경제일반</a></li>
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=economy&subclass=economypractice">경제실무</a></li>
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=economy&subclass=worldeconomy">세계경제</a></li>
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=economy&subclass=taxAccounting">세무/회계</a></li>
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=economy&subclass=distributionandfoundation">유통/창업</a></li>
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=economy&subclass=tradeanddelivery">무역/운송</a></li>
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=economy&subclass=techFinance">재테크/금융</a></li>
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=economy&subclass=universityMaterials">대학교재</a></li>
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=economy&subclass=marketingAdvertising">마케팅/광고/고객</a></li>
							</ul>                          	
                        </li>
                        
                        
                    	<li>
                    		<div class="menu_close">&nbsp;</div><a href="#"  class="menu_a ${ bigclass eq 'humanity' ? 'second_menu_active':''}">인문</a>
                        	<ul class="sub_menu">
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=humanity&subclass=psychology">심리학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=humanities&subclass=educationalScience">교육학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=humanities&subclass=philosophy">철학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=humanities&subclass=literature">문학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=humanities&subclass=linguistics">언어학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=humanities&subclass=universityMaterials">대학교재</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=humanities&subclass=generalHumanities">인문학일반</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=humanities&subclass=epidemiologyKeynote">역학/사주</a></li>
							</ul>                      		
                    	</li>
                    	
                    	<li>
                    		<div class="menu_close">&nbsp;</div><a href="#"  class="menu_a ${ bigclass eq 'religion' ? 'second_menu_active':''}">종교</a>
                        	<ul class="sub_menu">
								<li><a href="${pageContext.request.contextPath}/shop?bigclass=religion&subclass=christianity">기독교</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=religion&subclass=catholic">카톨릭</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=religion&subclass=buddhism">불교</a></li>
							</ul>                     		
                    	</li>
                    	
                    	
                    	<li>
                    		<div class="menu_close">&nbsp;</div><a href="#"  class="menu_a ${ bigclass eq 'science' ? 'second_menu_active':''}">과학</a>
                        	<ul class="sub_menu">
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=science&subclass=theoryOfScience">과학이론 </a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=science&subclass=illustration">도감</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=science&subclass=liberalScience">교양과학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=science&subclass=mathematics">수학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=science&subclass=physics">물리학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=science&subclass=chemistry">화학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=science&subclass=biology">생물학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=science&subclass=earthScience">지구과학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=science&subclass=astronomy">천문학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=science&subclass=youthLiberalScience">청소년 교양과학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=science&subclass=scienceLiterature">과학문고</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=science&subclass=universityMaterials">대학교재</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=science&subclass=superScience">초과학</a></li>
							</ul>                     		
                    	</li>
                    	
                    	
                    	<li>
                    		<div class="menu_close">&nbsp;</div><a href="#"  class="menu_a ${ bigclass eq 'politicsAndSociety' ? 'second_menu_active':''}" >정치/사회</a>
                        	<ul class="sub_menu">
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=politicsAndSociety&subclass=politicsDiplomacy">정치/외교</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=politicsAndSociety&subclass=administrativePolicy">행정/정책</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=politicsAndSociety&subclass=defenseMilitary">국방/군사</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=politicsAndSociety&subclass=law">법학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=politicsAndSociety&subclass=socialStudies">사회학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=politicsAndSociety&subclass=socialIssuesWelfare">사회문제/복지</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=politicsAndSociety&subclass=pressNewspaperBroadcasting">언론/신문/방송 </a></li>
							</ul>                     		
                   		</li>
                   		
                   		
                    	<li>
                    		<div class="menu_close">&nbsp;</div><a href="#"  class="menu_a ${ bigclass eq 'computer' ? 'second_menu_active':''}" >컴퓨터/IT</a>
                        	<ul class="sub_menu">
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=computer&subclass=computerEngineering">컴퓨터공학</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=computer&subclass=computerHumanities">컴퓨터입문/활용</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=computerl&subclass=os">OS</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=computer&subclass=network">네트워크</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=computer&subclass=database">데이터베이스</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=computer&subclass=game">게임</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=computer&subclass=webProgramming">웹프로그래밍</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=computer&subclass=mobileProgramming">모바일프로그래밍</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=computer&subclass=graphics">그래픽</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=computer&subclass=cad">CAD</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=computer&subclass=certification">자격증</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=computer&subclass=securityHacking">보안/해킹</a></li>
							</ul>                     		
                    	</li>
                    	
                    	
                    	<li>
                    		<div class="menu_close">&nbsp;</div><a href="#" class="menu_a ${ bigclass eq 'child' ? 'second_menu_active':''}" >중/고등 참고서</a>
                        	<ul class="sub_menu">
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=child&subclass=childrenLiterature">고등학교 과목별</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=child&subclass=childrenLiberalArts">중학교 학년별</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=child&subclass=childrenComics">예비중학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=child&subclass=preparingForElementary">EBS 중학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=child&subclass=textbooksLinkedBooks">EBS 고등</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=child&subclass=elementary12">특목고 대비교재</a><li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=child&subclass=elementary34">논술/면접대비</a><li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=child&subclass=elementary56">중/고 학습문학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=child&subclass=elementary56">검정고시</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=child&subclass=elementary56">공부방법/진학</a></li>
							</ul>                     		
                    	</li>
                   
                    	<li>
                    		<div class="menu_close">&nbsp;</div><a href="#"  class="menu_a ${ bigclass eq 'teenager' ? 'second_menu_active':''}" >청소년</a>
                        	<ul class="sub_menu">
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=theEssay">논술</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=theStudyMethod">공부방법</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=theCareer">진로</a></li>
									 <li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=thePrestigious">명문대진학가이드</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=sexEducation">성교육</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=youthSelfDevelopment">청소년 자기계발</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=youthEssay">청소년 에세이</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=youthFiction">청소년 소설</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=youthPoetry">청소년 시</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=youthClassic">청소년 고전</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=youthLiteratureOothers">청소년 문학기타</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=youthPhilosophy">청소년 철학</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=youthHistory">청소년 역사</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=youthArt">청소년 예술</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=youthHumanities">청소년 인문교양</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=youthEconomy">청소년 경제</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=youthPoliticalSociety">청소년 정치사회</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=teenager&subclass=youthComputer">청소년 컴퓨터</a></li>
							</ul>                     		
                    	</li>                    	
                    	
                    	<li>
                    		<div class="menu_close">&nbsp;</div><a href="#"  class="menu_a ${ bigclass eq 'textbook' ? 'second_menu_active':''}" >교과서</a>
                        	<ul class="sub_menu">
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=textbook&subclass=ebsElementary">EBS 초등</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=textbook&subclass=korean">국어</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=textbook&subclass=mathematics">수학</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=textbook&subclass=english">영어</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=textbook&subclass=science">과학</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=textbook&subclass=social">사회</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=textbook&subclass=technologyHome">기술/가정</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=textbook&subclass=chinese">한문</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=textbook&subclass=physicalEducation">체육</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=textbook&subclass=music">음악</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=textbook&subclass=art">미술</a></li>
							</ul>                     		
                    	</li>
                    	
                    	
                    	<li>
                    		<div class="menu_close">&nbsp;</div><a href="#"  class="menu_a  ${ bigclass eq 'cooking' ? 'second_menu_active':''}" >요리</a>
                        	<ul class="sub_menu">
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=cooking&subclass=cookingGeneral">요리일반</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=cooking&subclass=cookingEssay">요리에세이</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=cooking&subclass=themedCooking">테마별요리</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=cooking&subclass=bakingSnack">베이킹/간식</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=cooking&subclass=seasonalCooking">계절요리</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=cooking&subclass=materialCooking">재료별요리</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=cooking&subclass=countryCooking">나라별요리</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=cooking&subclass=dailyCooking">생활요리</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=cooking&subclass=wineCooking">전문요리</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=cooking&subclass=wineCcoffee">와인/커피/음료</a></li>
									<li><a href="${pageContext.request.contextPath}/shopList?bigclass=cooking&subclass=cookingExamination">요리수험서</a></li>
							</ul>                     		
                    	</li>
                    	
                    	
                    	<li>
                    		<div class="menu_close">&nbsp;</div><a href="#"  class="menu_a ${ bigclass eq 'foreignLanguage' ? 'second_menu_active':''}" >외국어</a>
                        	<ul class="sub_menu">
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=englishGeneral">영어일반</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=englishConversationListening">영어회화/청취</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=businessEnglish">비즈니스영어</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=englishGrammar">영어문법/독해/작문</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=englishLibraries">영어문고</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=englishImportedTextbooks">영어수입교재</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=broadcastEnglishTextbooks">방송영어교재</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=experienceEnglish">수험영어</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=studyAbroad">유학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=translationInterpretation">번역/통역</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=japaneseGeneral">일본어일반</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=japaneseConversation">일본어회화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=japaneseGrammarComposition">일본어문법/작문</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=japaneseProficiencyJpt">일본어능력시험/JPT</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=chineseGeneral">중국어일반</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=chineseConversation">중국어회화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=chineseGrammarReading">중국어문법/독해</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=hskChineseTest">HSK/중국어시험</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=german">독일어</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=french">프랑스어</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=languageDictionary">어학사전</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=foreignLanguage&subclass=universityMaterials">대학교재</a></li>
							</ul>                     		
                    	</li>
                    	
                    	
                    	<li>
                    		<div class="menu_close">&nbsp;</div><a href="#"  class="menu_a ${ bigclass eq 'comics' ? 'second_menu_active':''}" >만화</a>
                        	<ul class="sub_menu">
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=educationalComics">교양만화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=historyComicsManga">직업만화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=occupationalComics">직업만화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=dailyLifeDramaComics">일상생활/드라마/가족만화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=animalComics">동물등장만화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=cookingComics">요리만화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=gamblingComics">도박만화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=classicLiteraryComics">고전/문학작품만화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=adultComics">성인만화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=romanceComics">로맨스만화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=sportsComics">스포츠만화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=sfFantasy">SF/판타지</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=actionMartialArts">액션/무협만화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=clearanceComicComics">명랑/코믹만화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=detectiveReasoning">탐정/추리</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=horrorThriller">공포/스릴러</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=comics&subclass=academyComics">학원만화</a></li>
							</ul>                     		
                    	</li>
                    	
                    	                     
	                   	<li>
	                   		<div class="menu_close">&nbsp;</div><a href="#"  class="menu_a ${ bigclass eq 'magazine' ? 'second_menu_active':''}">잡지</a>
                        	<ul class="sub_menu">
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=magazine&subclass=womenMenFashion">여성/남성/패션</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=magazine&subclass=humanitiesSociety">인문/사회/종교</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=magazine&subclass=natureEngineering">자연/공학</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=magazine&subclass=literatureCulture">문학/교양</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=magazine&subclass=languageEducation">어학/교육</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=magazine&subclass=artsPopularCulture">예술/대중문화</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=magazine&subclass=hobbyReports">취미/레포츠</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=magazine&subclass=computerGame">컴퓨터/게임</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=magazine&subclass=foreignMagazine">외국잡지</a></li>
								<li><a href="${pageContext.request.contextPath}/shopList?bigclass=magazine&subclass=weeklyMonthlyQuarterly">주간/월간/계간지</a></li>
							</ul> 	                   		
	                   	</li>
	       	
                    </ul>
                </div>
            </div>
      