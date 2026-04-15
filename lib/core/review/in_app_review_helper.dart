import 'package:book_flutter/core/logger.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 인앱 리뷰 프롬프트 도우미
///
/// 독서 완독 같은 긍정적인 순간에 한 번씩 호출하면,
/// - 누적 완독 횟수가 임계치(기본 2회)를 넘고
/// - 아직 리뷰 요청을 띄운 적이 없을 때만
/// 시스템 리뷰 팝업을 띄운다.
///
/// iOS는 Apple이 연 3회로 표시 빈도를 자체 제한하므로 본 로직은 여분의 안전장치 역할.
class InAppReviewHelper {
  static const _keyCompletedCount = 'review_book_completed_count';
  static const _keyRequested = 'review_requested';
  static const _triggerAfter = 2;

  static Future<void> maybeRequestAfterBookCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (prefs.getBool(_keyRequested) ?? false) return;

      final count = (prefs.getInt(_keyCompletedCount) ?? 0) + 1;
      await prefs.setInt(_keyCompletedCount, count);
      if (count < _triggerAfter) return;

      final review = InAppReview.instance;
      if (!await review.isAvailable()) return;

      await review.requestReview();
      await prefs.setBool(_keyRequested, true);
    } catch (e) {
      logger.e('인앱 리뷰 요청 실패: $e');
    }
  }
}
