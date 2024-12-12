# Overview

![image.jpg1](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/c34604ef-93e6-42de-8307-84d8b5f91ed2) |![image.jpg2](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/18c18b81-7c12-4cef-a1fd-c46a7de816e7) |![image.jpg3](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/b4953a64-6030-44e6-a249-5764a314c4de)
--- | --- | --- | 

<br/><br/>

# 사용한 기술 스택
- UiKit
- Combine
- Firebase
- SnapKit
- Then
- DGCharts
- FSCalendar
- Toast

<br/><br/>

# 구현 기능
- 계정 관련
  - 이메일 로그인, 애플 로그인, 로그아웃
    
- 홈 화면
  - Firebase에서 영화 리뷰 가져오기
  - 해당 리뷰 클릭 시 자세히 보기
 
- 영화 리뷰 작성
  - 영화 검색
  - 영화 정보 추가
  - 리뷰 등록
  - 리뷰 삭제

- 박스오피스
  - 어제 날짜의 박스오피스 확인
  - 영화 별 댓글 기능 (추가예정)

- 캘린더
  - 날짜 별 작성 리뷰 목록 확인

- 차트
  - 일주일간 작성한 리뷰 확인

<br/><br/>

# Screenshots

- 로그인, 로그아웃
  - 이메일, 애플 로그인이 가능합니다.
  - 로그아웃이 가능합니다.
    
![image.jpg1](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/41639117-be58-4ae0-8f5d-947dd8f52920) |![image.jpg2](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/3d130f06-cfd5-4bce-a31a-d57aca76b38f)
--- | --- |

<br/><br/>

- 회원가입
  - 이메일, 비밀번호, 비밀번호 확인이 전부 통과되어야만 회원가입 버튼이 작동합니다.
  - 보안상의 문제로 비밀번호를 입력했음에도 불구하고 캡쳐하니 아예 안뜨니 참고해주세요.
    
| ![image.jpg4](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/c79aaf81-a1a6-42ad-ac85-4fa82ca417eb) | ![image.jpg3](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/2a6d4dc8-a7fb-4566-9116-ee7f7f89d5d3) | ![image.jpg2](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/88e18e78-4f64-49c8-94b7-cd081bb9801f) | ![image.jpg1](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/17abd140-5b01-4444-a8e7-b4a96a17744e) |
|---|---|---|---|

<br/><br/>

- 홈 화면 & 리뷰 상세 화면
  - Firebase를 통해 지금까지 작성한 리뷰들을 홈 화면에 불러옵니다.
  - UICollectionViewDiffableDataSource를 적용해 데이터의 변화에 유연하게 대응할 수 있습니다.
  - 작성한 리뷰를 상세하게 확인 할 수 있습니다.

![image.jpg1](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/226db573-e295-4cc1-ab9f-25c3c4fe3313) |![image.jpg2](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/3ca13744-89d5-4d08-8af8-713f6c415391)
--- | --- |
<br/><br/>
 
- 영화 검색 화면
  - 리뷰를 작성할 영화의 제목을 검색합니다.
  - 만약 영화가 존재하지 않는다면, 직접 영화 정보를 추가 할 수도 있습니다.
    
![image.jpg1](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/52378183-588d-4a6c-b913-692c17278223) |![image.jpg2](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/a0330187-1399-4865-82ff-c79f4df00898) |![image.jpg3](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/17d48b5e-a93f-45ab-8427-2cb42c1adcbd)
--- | --- | --- | 

<br/><br/>

- 리뷰 작성 화면
  - 리뷰를 작성할 영화의 제목을 선택한 뒤 리뷰를 작성합니다.
  - 영화가 어땠는지, 어떤 점이 좋았는지, 상세 리뷰를 작성할 수 있습니다.
    
| ![image.jpg1](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/6df02554-449b-47a3-bf3b-c97c099495d4) | ![image.jpg2](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/6bf25379-f6be-4800-9cda-e7200290a188) | ![image.jpg3](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/60500f7d-c564-4354-80d9-92e7764676ee) | ![image.jpg4](https://github.com/KangMinGyo/MovieDiary_/assets/98341623/7e089e3d-33f5-424d-8b01-69897c3046c2) |
|---|---|---|---|

<br/><br/>

# 프로젝트 최적화를 위한 도전들
- **SnapKit 및 Then 라이브러리를 도입한 이유**
    - 이전 앱에서 사용했던 기존의 Auto Layout 코드는 복잡하고 가독성이 낮아 유지보수에 어려움을 겪었고, 반복적인 코드 작성으로 인해 개발 생산성이 저하되었습니다.
    - 이번 앱에서 SnapKit을 사용하여 Auto Layout을 구현하고 Then을 사용하여 **코드의 가독성을 높였으며**, 이를 통해 **코드의 재사용성을 향상**시켰습니다. <br>
      
    
- **UICollectionViewDiffableDataSource를 사용하게 된 이유**
    - **데이터의 변화에 유연하게 대응할 수 있어서 도입하게 되었습니다.**
    - 기존의 방식처럼 reloadData를 쓰면 애니메이션이 끊깁니다. DiffiableDataSource는 **View를 다시 그릴 때 Snapshot의 변화를 스스로 파악하고, 애니메이션으로 나타내줌으로써 더 나은 UX가 가능합니다.** 
      

- **Firebase** **Auth를 이용해 로그인, 로그아웃 구현하게 된 이유**
    - **영화 리뷰를 저장하기 위해 로그인, 로그아웃 기능이 필요**했습니다. 혼자 개발을 해야했기에 Firebase Auth를 사용하여 사용자 인증을 관리하고 로그인 및 로그아웃 기능을 구현하는 것이 목표였습니다.
    - 따라서 이메일, Apple ID를 이용한 로그인, 로그아웃을 구현하게 되었습니다. <br>
      

- **Firebase를 이용해 서버 구현하게 된 이유**
    - 이전 앱에서는 CoreData, Realm을 통해 영화 리뷰를 저장했지만 앱을 삭제하면 기록이 날아가는 경험을 하게되었습니다.
    - **Firebase와 같은 서버를 통해 영화 리뷰를 저장함으로써 앱을 삭제하고 다시 깔더라도 기록이 날아 가지 않도록 수정하게 되었습니다.** <br>
      

- **클린 아키텍처 도입**
    - 유지보수와 테스트를 쉽게 하기 위해 클린 아키텍처에 대해 공부하고 적용 중에 있습니다. <br>
