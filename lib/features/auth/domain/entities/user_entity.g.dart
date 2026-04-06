// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => _UserEntity(
  userNo: (json['user_no'] as num?)?.toInt() ?? 0,
  userNick: json['user_nick'] as String? ?? '',
  userEmail: json['user_email'] as String? ?? '',
  userImage: json['user_image'] as String? ?? '',
  gardenCount: (json['garden_count'] as num?)?.toInt() ?? 0,
  readBookCount: (json['read_book_count'] as num?)?.toInt() ?? 0,
  likeBookCount: (json['like_book_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$UserEntityToJson(_UserEntity instance) =>
    <String, dynamic>{
      'user_no': instance.userNo,
      'user_nick': instance.userNick,
      'user_email': instance.userEmail,
      'user_image': instance.userImage,
      'garden_count': instance.gardenCount,
      'read_book_count': instance.readBookCount,
      'like_book_count': instance.likeBookCount,
    };
