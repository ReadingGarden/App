# Repository Guidelines

## 프로젝트 구조
이 저장소는 Flutter 앱입니다. 주요 앱 코드는 `lib/`에 있으며 `book/`, `garden/`, `memo/`, `mypage/`, `onboarding/`처럼 기능별로 나뉘어 있습니다. 공통 API, 모델, 프로바이더, 서비스는 `lib/core/`에 두고, 전역 유틸과 공통 위젯은 `lib/utils/`에서 관리합니다. 정적 리소스는 `assets/` 아래의 `fonts/`, `icons/`, `images/`를 사용합니다. 플랫폼별 설정과 네이티브 코드는 `android/`, `ios/`, `macos/`, `linux/`, `windows/`에 있습니다. 테스트 코드는 `test/`에 둡니다.

## 빌드, 테스트, 개발 명령어
- `flutter pub get`: 의존성 설치
- `flutter run`: 연결된 에뮬레이터 또는 기기에서 앱 실행
- `flutter analyze`: `analysis_options.yaml` 기준 정적 분석 실행
- `flutter test`: `test/`의 단위 테스트와 위젯 테스트 실행
- `flutter build apk`, `flutter build ios`: 배포 전 빌드 확인

모든 명령은 저장소 루트에서 실행합니다.

## 코딩 스타일 및 네이밍
기본 린트는 `analysis_options.yaml`의 `flutter_lints`를 따릅니다. 들여쓰기는 2칸을 사용하고, 커밋 전 `dart format .`로 포맷을 맞춥니다. 현재 코드베이스는 `lib/book/BookDetailPage.dart`처럼 파일명을 `PascalCase.dart`로 두는 패턴이 많고, 폴더명은 소문자를 사용합니다. 새 코드도 기존 구조를 우선 따르되, 구조 개편 시에는 기능별 응집도와 파일 위치 일관성을 더 중요하게 유지합니다.

## 테스트 가이드
테스트는 `flutter_test`를 사용합니다. 새 테스트는 가능하면 기능 경로를 반영해 `test/book/book_detail_page_test.dart`처럼 작성합니다. 최소한 푸시 전 `flutter analyze`와 `flutter test`를 실행합니다. 사용자 흐름에 영향이 있는 라우팅, Riverpod 상태 로직, 회귀 버그 수정에는 테스트를 함께 추가하는 것을 권장합니다.

## 커밋 및 PR 가이드
최근 커밋은 `feat:` 접두사와 짧은 한글 설명을 자주 사용합니다. 예: `feat: 가든 메인 배경 수정`. 권장 형식은 `feat: ...`, `fix: ...`, `refactor: ...`, `chore: ...`입니다. 큰 작업은 `stable`에서 직접 하지 말고 `feature/...`, `fix/...`, `refactor/...` 브랜치에서 진행합니다. PR에는 변경 목적, 영향 범위, 테스트 결과를 포함하고, UI 변경이 있으면 스크린샷을 첨부합니다.

## 설정 주의사항
비밀값이나 개인 로컬 설정은 커밋하지 않습니다. Firebase 설정과 플랫폼별 앱 설정은 각 플랫폼 디렉터리와 `lib/firebase_options.dart`에 있으므로, 번들 ID, 앱 버전, 푸시 알림, 딥링크 관련 변경 시 함께 검토해야 합니다.
