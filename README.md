# Login

RxSwift, MVVM 아키텍처, 그리고 CoreData를 활용한 간단한 iOS 사용자 인증 애플리케이션입니다.

## 기능

- **회원가입**: 이메일/비밀번호 유효성 검사와 계정 생성
- **로그인**: 로컬 저장된 계정으로 인증
- **계정 관리**: 로그아웃 및 계정 삭제 기능
- **데이터 저장**: CoreData와 UserDefaults 활용

## 요구 사항

- iOS 18.0+
- Xcode 16.3+
- Swift 5.0+

## 프로젝트 구조

```
Login/      
├── Source/      
│   ├── AppDelegate.swift & SceneDelegate.swift   
│   ├── Common/   
│   │   ├── Checker/    
│   │   ├── CustomView/   
│   │   ├── Error/    
│   │   ├── Extension/   
│   │   ├── Manager/   
│   │   ├── Regex/   
│   ├── Model/   
│   │   └── UserInfo.swift   
│   └── View/   
│       ├── SignIn/    
│       ├── SignUp/    
│       └── Welcome/   
├── Resource/   
│   ├── Assets.xcassets   
│   └── Base.lproj/   
└── Login.xcdatamodeld/
```

## 핵심 구성 요소

### 회원가입 입력 조건
- **이메일**: 영문 소문자로 시작, 8-20자, 올바른 이메일 형식 필요, 중복 불가
- **비밀번호**: 8자 이상, 대/소문자, 숫자, 특수문자 각 1개 이상 필요
- **비밀번호 확인**: 입력한 비밀번호와 일치해야 함
- **닉네임**: 필수 입력 항목

### UI 컴포넌트
- **SignTextField**: 커스텀 텍스트 필드 (에러 메시지, 지우기 버튼, 반응형 바인딩)

### 데이터 관리
- **CoreData**: 사용자 계정 정보 영구 저장
- **UserDefaults**: 현재 로그인 세션 관리

### 의존성
- RxSwift, RxCocoa, RxRelay: 반응형 프로그래밍
- CoreData: 데이터 지속성