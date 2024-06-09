
## 프로젝트명
Forallshoppingmall BookStore

<hr>

## 영상 시연
> * Spring Security URL Intercept 적용
> <img src = "https://user-images.githubusercontent.com/57096651/169265448-c6c36d2c-78b4-4b17-9e85-cc30674fb393.gif" width = "50%">

> * 책 상세보기 / 리뷰 댓글
> <img src = "https://user-images.githubusercontent.com/57096651/169265770-fe255588-834c-4c4c-b6b2-706f266e2659.gif" width = "50%">

> * 장바구니 클릭 / 주문 페이지 이동
> <img src = "https://user-images.githubusercontent.com/57096651/169266055-ba8ded04-2730-4884-acc5-b0f5b44d08cd.gif" width = "50%">

> * 결제 API
> <img src = "https://user-images.githubusercontent.com/57096651/169266261-ba2ae107-167d-4d8a-a7ad-c2c8edad60ed.gif" width = "50%">

> * 결제 결과(네이버 영수증)
> <img src = "https://user-images.githubusercontent.com/57096651/170526844-0b5ec4c2-8a7b-40a2-9365-b71d3e834fa8.PNG" width = "50%">

> * 네이버 로그인 API
> <img src = "https://user-images.githubusercontent.com/57096651/169266585-7883dd3e-54a4-4a8b-81c3-4fdf756f2da4.gif" width = "50%">


## 프로젝트 기능

#### 1. 결제
<img src = "https://github.com/WebDevCheon/forallshoppingmall/assets/57096651/04b3fed7-dacb-4efc-9925-abe240608c8c" width = "60%">
<br>

> * 휴대폰 결제 / 카드 결제 / 무통장 입금 / 실시간 이체
> * 아임포트 서버 API 연동
> * 주문 정보(Client) -> 아임포트 서버 -> PG 서버 -> 카드사 서버 (요청의 흐름)

#### 2. REST
> * AJAX 비동기 요청 -> ResponseEntity 응답
> * Development Tool : PostMan

#### 3. 보안
> * Spring Security 적용
> * 권한 : 유저(ROLE_USER in MySQL) / 관리자(ROLE_ADMIN in MySQL)
> * CSRF ATTACK 방어
> * AWS의 HTTPS ssl 인증서 적용

#### 4.네이버 로그인 연동
> * 네아로(Naver Login API) 적용
> * 네이버 로그인 -> Naver Developers에서 발급해준 토큰값이 맞다면,CallBack URL Redirect(스프링 시큐리티 권한 승인) 

#### 5. 회원가입
> * 도로명 주소 API( https://www.juso.go.kr/addrlink/openApi/apiExprn.do )를 통한 주소 입력
> * 회원 가입시 가입 이메일 확인 메시지 발송 -> 메일에서 확인 버튼시에 회원 가입 완료(DB 속성 emailconfirm = 1, enabled = 1 updated)
> * enabled = 1이 아니면, LoginAuthenticationProvider 클래스의 authenticate 메소드에 의해서 로그인 차단

#### 6. 파일 업로드
> * AWS S3 파일 업로드 기능
> * 도서 리뷰 댓글 / 관리자 도서 등록에 사진 파일 업로드 기능
> * AwsServiceImpl 클래스 생성자에서 amazonS3 객체 생성

#### 7. 페이징
> * 한 블럭당 존재할 수 있는 페이지 수 지정( pageCount : 사이트 블럭당 페이지 수, adminpageCount : 관리자 페이지 블럭당 페이지 수)

#### 8. 로깅
> * 로깅을 통한 데이터 / 기록 저장( ex. 특정 사용자의 주문 , 버그 or 에러)
> * RollingFileAppender를 통한 하루동안의 로깅 정보 로컬에 저장

#### 10. JavaMailSender
> * 회원가입시 메일 인증을 위하여 JavaMailSender Class 이용(빈을 설정하여 IOC Container를 통하여 DI)

#### 11. 배포 환경
> * AWS EC2(Tomcat 설치)
> * 도서의 이미지 파일은 S3 FileSystem 업로드 / 저장
> * LoadBalancer 적용(확인 방법 : chrome dev tool에서 접속 IP 확인)


## 테스트
>* JUnit을 통하여 테스트 코드 작성
>* Mockito를 이용하여 Controller,Service에서 하위 Mock 객체를 만들어준 이후 @InjectMocks로 Mock객체 DI를 하여 테스트 진행
>* Controller에선 MockMvc 객체를 생성하여 진행
>* Controller,Service,Dao를 각각 나눠서 3개의 클래스로 나눠서 테스트 진행
>* 테스트를 통한 코드 리팩토링 작업

## DB 설계
<img src = "https://github.com/WebDevCheon/forallshoppingmall/assets/57096651/ba49ed2e-458a-4864-8d41-06545ed9ab5a" width = "60%">

<hr>

<h3>연동 API</h3>
아임포트 DOCS : https://docs.iamport.kr <br>
Naver Developers : https://developers.naver.com/main <br>