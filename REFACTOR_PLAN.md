# Refactor Plan

## 목표
- 화면에서 비즈니스 로직과 API 호출 분리
- `Map`, `List` 중심 상태를 타입 기반 구조로 전환
- `utils`, `core`, 기능 폴더의 책임을 명확히 재정의

## 목표 구조
```text
lib/
  app/
  core/
    network/
    storage/
    error/
    ui/
  features/
    book/
      presentation/
      data/
      domain/
    garden/
      presentation/
      data/
      domain/
    memo/
      presentation/
      data/
      domain/
    auth/
      presentation/
      data/
      domain/
    mypage/
      presentation/
      data/
      domain/
```

## 1단계: 공통 기반 정리
목표: 이후 리팩토링의 기준이 될 공통 폴더 구조를 먼저 만든다.

- `lib/app/` 생성
- `lib/core/network/` 생성
- `lib/core/storage/` 생성
- `lib/core/error/` 생성
- `lib/core/ui/` 생성
- `lib/features/` 생성
- `lib/core/DioClient.dart` → `core/network/`
- `lib/core/TokenInterceptor.dart` → `core/network/`
- `lib/utils/SharedPreferences.dart` → `core/storage/token_storage.dart`
- `lib/utils/Router.dart` → `app/router/`
- `lib/utils/Widgets.dart` → `core/ui/`로 분해

완료 기준:
- 공통 파일 위치가 새 구조 기준으로 정리됨
- import 경로가 일관되게 변경됨

## 2단계: book 기능 시범 리팩토링
목표: 새 구조의 기준 샘플을 `book` 기능에서 먼저 완성한다.

대상 파일:
- `lib/book/BookDetailPage.dart`
- `lib/core/service/BookService.dart`
- `lib/core/model/Book.dart`
- `lib/core/provider/BookDetailNotifier.dart`

작업:
- `features/book/presentation/pages/`
- `features/book/presentation/widgets/`
- `features/book/presentation/providers/`
- `features/book/data/services/`
- `features/book/data/repositories/`
- `features/book/data/dtos/`
- `features/book/domain/entities/`
- `features/book/domain/usecases/`
- 페이지 내부 API 호출 제거
- `Map` 상태 제거
- `service -> repository -> provider -> page` 흐름 정리

완료 기준:
- `BookDetailPage`가 UI와 이벤트 처리만 담당
- provider가 로딩, 성공, 실패 상태를 관리
- 상세 조회 흐름이 타입 기반으로 동작

## 3단계: 라우터 분리
목표: 기능 간 결합도를 낮추고 라우팅 변경 비용을 줄인다.

- `app/router/app_router.dart`
- `features/book/presentation/routes.dart`
- `features/garden/presentation/routes.dart`
- `features/memo/presentation/routes.dart`
- `features/auth/presentation/routes.dart`

완료 기준:
- 기능별 라우트 정의가 분리됨
- 최상위 router는 조합만 담당함

## 4단계: 나머지 기능 확장
목표: `book`에서 정리한 패턴을 다른 기능으로 확장한다.

추천 순서:
1. `garden`
2. `memo`
3. `auth`
4. `mypage`

기준:
- 전역 상태 의존이 큰 기능부터 우선 정리
- 인증은 storage/network 정리 후 이동

## 5단계: utils 해체
목표: 광범위한 `utils` 의존을 줄이고 역할별 위치로 재배치한다.

대상:
- `lib/utils/Functions.dart`
- `lib/utils/Constant.dart`
- `lib/utils/Messaging.dart`
- `lib/utils/SocialLogin.dart`

이동 방향:
- 포맷팅, 문자열, 단순 헬퍼 → `core/common/`
- 권한, 딥링크, 메시징 → `core/services/` 또는 기능별 폴더
- 상수 → `core/constants/` 또는 feature constants

## 6단계: 환경값과 초기화 분리
목표: 하드코딩된 설정과 앱 초기화 책임을 분리한다.

대상:
- `lib/utils/Constant.dart`
- `lib/main.dart`

작업:
- API URL 분리
- SDK 초기화 분리
- 앱 부트스트랩 파일 분리

완료 기준:
- `main.dart`가 앱 진입과 초기 실행만 담당

## 7단계: 테스트 보강
목표: 구조 변경 이후 회귀를 막는다.

- provider 테스트 추가
- repository 테스트 추가
- 핵심 화면 widget 테스트 추가
- 최소 확인: `flutter analyze`
- 최소 확인: `flutter test`

## 작업 원칙
- 브랜치는 `refactor/project-structure` 유지
- 전체를 한 번에 옮기지 않는다
- 1단계와 `book` 기능 하나 완료 후 커밋한다
- 기능별로 패턴을 검증한 뒤 확장한다

## 추천 커밋 단위
- `refactor: create app/core/features structure`
- `refactor: move network and token storage to core`
- `refactor: migrate book detail to feature-based architecture`
- `refactor: split app router by feature`
