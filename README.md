# 📱 독서가든

- **Flutter**: 3.24.3
- **Dart**: 3.5.3

## 🔥 프로젝트 개요

이 프로젝트는 **Flutter 기반 모바일 애플리케이션**으로, **친구를 초대하여 함께 책을 기록하고 가든을 가꾸는 서비스**입니다.
사용자는 독서 활동을 공유하고, 서로의 책장을 관리하며, 독서 기록을 시각적으로 표현할 수 있습니다.
Firebase, Kakao SDK, Branch SDK 등을 활용하여 소셜 로그인, 푸시 알림, 딥링크 등의 기능을 포함합니다.

---

## 🛠️ 기술 스택

- **Framework:** Flutter (Dart)
- **State Management:** Riverpod, Riverpod Annotation
- **Routing:** GoRouter
- **Networking:** Dio
- **UI Utilities:** Flutter ScreenUtil, Flutter SVG
- **Local Storage:** Shared Preferences
- **Authentication:** Firebase Auth, Google Sign-In, Kakao SDK
- **Camera & Media:** Image Picker, Camera, Gallery Saver
- **Permissions:** Permission Handler
- **Notifications:** Firebase Messaging, Flutter Local Notifications
- **Deep Linking:** Flutter Branch SDK, App Links, URL Launcher
- **Other:** Flutter Barcode Scanner, In-App WebView, Flutter Email Sender, Share Plus

---

## 📌 주요 기능

- ✅ **Firebase 기반 로그인 및 인증** (Google, Kakao 지원, Apple은 추후 지원 예정)
- ✅ **푸시 알림 및 로컬 알림** (Firebase Messaging, Local Notifications)
- ✅ **실시간 데이터 저장 및 공유** (Firebase Firestore, Shared Preferences)
- ✅ **바코드 스캐너 기능** (Flutter Barcode Scanner)
- ✅ **Flutter Branch SDK를 통한 딥링크 기능**
- ✅ **Flutter ScreenUtil을 활용한 반응형 UI**
- ✅ **Flutter In-App WebView를 통한 웹 컨텐츠 표시**
- ✅ **Flutter Email Sender 및 Share Plus를 통한 공유 기능**

---

## 📂 폴더 구조

```bash
lib
┣ book # 책 관련 기능
┃ ┣ BookAddGardenPage.dart
┃ ┣ BookAddPage.dart
┃ ┣ BookDetailPage.dart
┃ ┣ BookEditPage.dart
┃ ┣ BookRegisterPage.dart
┃ ┣ BookSearchPage.dart
┃ ┣ BookUserWritePage.dart
┃ ┗ BookshelfPage.dart
┣ core # 앱의 핵심 로직 및 공통 기능
┃ ┣ api # Riverpod 프로바이더를 활용한 상태 관리 및 API 연동
┃ ┃ ┣ AuthAPI.dart
┃ ┃ ┗ GardenAPI.dart
┃ ┣ model # 데이터 모델
┃ ┃ ┣ Book.dart
┃ ┃ ┣ BookSearch.dart
┃ ┃ ┗ Memo.dart
┃ ┣ provider # 상태 관리 (Riverpod)
┃ ┃ ┣ BookDetailNotifier.dart
┃ ┃ ┣ BookSearchListNotifier.dart
┃ ┃ ┣ BookStatusAllListNotifier.dart
┃ ┃ ┣ BookStatusListNotifier.dart
┃ ┃ ┣ FcmTokenProvider.dart
┃ ┃ ┗ MemoListNotifier.dart
┃ ┣ service # Dio를 활용한 백엔드 API 통신
┃ ┃ ┣ AuthService.dart
┃ ┃ ┣ BookService.dart
┃ ┃ ┣ GardenService.dart
┃ ┃ ┣ MemoService.dart
┃ ┃ ┗ PushService.dart
┃ ┣ DioClient.dart # API 요청을 위한 Dio 설정
┃ ┗ TokenInterceptor.dart # 토큰 관리
┣ garden # 가든 관련 기능
┃ ┣ GardenAddPage.dart
┃ ┣ GardenBookListPage.dart
┃ ┣ GardenDetailPage.dart
┃ ┣ GardenEditPage.dart
┃ ┣ GardenInvitePage.dart
┃ ┣ GardenLeaderPage.dart
┃ ┣ GardenMemberPage.dart
┃ ┗ GardenPage.dart
┣ memo # 메모 기능
┃ ┣ MemoBookPage.dart
┃ ┣ MemoDetailPage.dart
┃ ┣ MemoPage.dart
┃ ┗ MemoWrite.dart
┣ mypage # 마이페이지 및 설정
┃ ┣ AlertSettingPage.dart
┃ ┣ AuthManagePage.dart
┃ ┣ MyPage.dart
┃ ┣ NickNamePage.dart
┃ ┣ ProfileImagePage.dart
┃ ┣ ProfilePage.dart
┃ ┗ TosPage.dart
┣ onboarding # 온보딩 및 로그인
┃ ┣ LoginPage.dart
┃ ┣ PwdFindPage.dart
┃ ┣ PwdSettingPage.dart
┃ ┣ SignupPage.dart
┃ ┗ StartPage.dart
┣ utils # 유틸리티 함수 및 설정
┃ ┣ AppColors.dart
┃ ┣ AutoInputFormatter.dart
┃ ┣ Constant.dart
┃ ┣ Functions.dart
┃ ┣ Messaging.dart
┃ ┣ Router.dart
┃ ┣ SharedPreferences.dart
┃ ┣ SocialLogin.dart
┃ ┣ TimerNotifier.dart
┃ ┗ Widgets.dart
┣ BottomNaviPage.dart # 하단 네비게이션 바
┣ ErrorPage.dart # 오류 페이지
┣ firebase_options.dart # Firebase 설정 파일
┗ main.dart
```
