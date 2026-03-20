class UserEntity {
  const UserEntity({
    required this.userNo,
    required this.userNick,
    required this.userEmail,
    required this.userImage,
    required this.gardenCount,
    required this.readBookCount,
    required this.likeBookCount,
    required this.raw,
  });

  final int userNo;
  final String userNick;
  final String userEmail;
  final String userImage;
  final int gardenCount;
  final int readBookCount;
  final int likeBookCount;
  final Map<String, dynamic> raw;

  static const empty = UserEntity(
    userNo: 0,
    userNick: '',
    userEmail: '',
    userImage: '',
    gardenCount: 0,
    readBookCount: 0,
    likeBookCount: 0,
    raw: {},
  );

  bool get isEmpty => userNo == 0;

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      userNo: map['user_no'] as int? ?? 0,
      userNick: map['user_nick'] as String? ?? '',
      userEmail: map['user_email'] as String? ?? '',
      userImage: map['user_image'] as String? ?? '',
      gardenCount: map['garden_count'] as int? ?? 0,
      readBookCount: map['read_book_count'] as int? ?? 0,
      likeBookCount: map['like_book_count'] as int? ?? 0,
      raw: map,
    );
  }
}
