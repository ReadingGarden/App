import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const UserEntity._();

  const factory UserEntity({
    @Default(0) int userNo,
    @Default('') String userNick,
    @Default('') String userEmail,
    @Default('') String userImage,
    @Default(0) int gardenCount,
    @Default(0) int readBookCount,
    @Default(0) int likeBookCount,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  static final empty = UserEntity();

  bool get isEmpty => userNo == 0;
}
