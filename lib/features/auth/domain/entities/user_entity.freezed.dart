// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserEntity {

 int get userNo; String get userNick; String get userEmail; String get userImage; int get gardenCount; int get readBookCount; int get likeBookCount;
/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntityCopyWith<UserEntity> get copyWith => _$UserEntityCopyWithImpl<UserEntity>(this as UserEntity, _$identity);

  /// Serializes this UserEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntity&&(identical(other.userNo, userNo) || other.userNo == userNo)&&(identical(other.userNick, userNick) || other.userNick == userNick)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.userImage, userImage) || other.userImage == userImage)&&(identical(other.gardenCount, gardenCount) || other.gardenCount == gardenCount)&&(identical(other.readBookCount, readBookCount) || other.readBookCount == readBookCount)&&(identical(other.likeBookCount, likeBookCount) || other.likeBookCount == likeBookCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userNo,userNick,userEmail,userImage,gardenCount,readBookCount,likeBookCount);

@override
String toString() {
  return 'UserEntity(userNo: $userNo, userNick: $userNick, userEmail: $userEmail, userImage: $userImage, gardenCount: $gardenCount, readBookCount: $readBookCount, likeBookCount: $likeBookCount)';
}


}

/// @nodoc
abstract mixin class $UserEntityCopyWith<$Res>  {
  factory $UserEntityCopyWith(UserEntity value, $Res Function(UserEntity) _then) = _$UserEntityCopyWithImpl;
@useResult
$Res call({
 int userNo, String userNick, String userEmail, String userImage, int gardenCount, int readBookCount, int likeBookCount
});




}
/// @nodoc
class _$UserEntityCopyWithImpl<$Res>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._self, this._then);

  final UserEntity _self;
  final $Res Function(UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userNo = null,Object? userNick = null,Object? userEmail = null,Object? userImage = null,Object? gardenCount = null,Object? readBookCount = null,Object? likeBookCount = null,}) {
  return _then(_self.copyWith(
userNo: null == userNo ? _self.userNo : userNo // ignore: cast_nullable_to_non_nullable
as int,userNick: null == userNick ? _self.userNick : userNick // ignore: cast_nullable_to_non_nullable
as String,userEmail: null == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String,userImage: null == userImage ? _self.userImage : userImage // ignore: cast_nullable_to_non_nullable
as String,gardenCount: null == gardenCount ? _self.gardenCount : gardenCount // ignore: cast_nullable_to_non_nullable
as int,readBookCount: null == readBookCount ? _self.readBookCount : readBookCount // ignore: cast_nullable_to_non_nullable
as int,likeBookCount: null == likeBookCount ? _self.likeBookCount : likeBookCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserEntity].
extension UserEntityPatterns on UserEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userNo,  String userNick,  String userEmail,  String userImage,  int gardenCount,  int readBookCount,  int likeBookCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.userNo,_that.userNick,_that.userEmail,_that.userImage,_that.gardenCount,_that.readBookCount,_that.likeBookCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userNo,  String userNick,  String userEmail,  String userImage,  int gardenCount,  int readBookCount,  int likeBookCount)  $default,) {final _that = this;
switch (_that) {
case _UserEntity():
return $default(_that.userNo,_that.userNick,_that.userEmail,_that.userImage,_that.gardenCount,_that.readBookCount,_that.likeBookCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userNo,  String userNick,  String userEmail,  String userImage,  int gardenCount,  int readBookCount,  int likeBookCount)?  $default,) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.userNo,_that.userNick,_that.userEmail,_that.userImage,_that.gardenCount,_that.readBookCount,_that.likeBookCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserEntity extends UserEntity {
  const _UserEntity({this.userNo = 0, this.userNick = '', this.userEmail = '', this.userImage = '', this.gardenCount = 0, this.readBookCount = 0, this.likeBookCount = 0}): super._();
  factory _UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

@override@JsonKey() final  int userNo;
@override@JsonKey() final  String userNick;
@override@JsonKey() final  String userEmail;
@override@JsonKey() final  String userImage;
@override@JsonKey() final  int gardenCount;
@override@JsonKey() final  int readBookCount;
@override@JsonKey() final  int likeBookCount;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserEntityCopyWith<_UserEntity> get copyWith => __$UserEntityCopyWithImpl<_UserEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserEntity&&(identical(other.userNo, userNo) || other.userNo == userNo)&&(identical(other.userNick, userNick) || other.userNick == userNick)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.userImage, userImage) || other.userImage == userImage)&&(identical(other.gardenCount, gardenCount) || other.gardenCount == gardenCount)&&(identical(other.readBookCount, readBookCount) || other.readBookCount == readBookCount)&&(identical(other.likeBookCount, likeBookCount) || other.likeBookCount == likeBookCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userNo,userNick,userEmail,userImage,gardenCount,readBookCount,likeBookCount);

@override
String toString() {
  return 'UserEntity(userNo: $userNo, userNick: $userNick, userEmail: $userEmail, userImage: $userImage, gardenCount: $gardenCount, readBookCount: $readBookCount, likeBookCount: $likeBookCount)';
}


}

/// @nodoc
abstract mixin class _$UserEntityCopyWith<$Res> implements $UserEntityCopyWith<$Res> {
  factory _$UserEntityCopyWith(_UserEntity value, $Res Function(_UserEntity) _then) = __$UserEntityCopyWithImpl;
@override @useResult
$Res call({
 int userNo, String userNick, String userEmail, String userImage, int gardenCount, int readBookCount, int likeBookCount
});




}
/// @nodoc
class __$UserEntityCopyWithImpl<$Res>
    implements _$UserEntityCopyWith<$Res> {
  __$UserEntityCopyWithImpl(this._self, this._then);

  final _UserEntity _self;
  final $Res Function(_UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userNo = null,Object? userNick = null,Object? userEmail = null,Object? userImage = null,Object? gardenCount = null,Object? readBookCount = null,Object? likeBookCount = null,}) {
  return _then(_UserEntity(
userNo: null == userNo ? _self.userNo : userNo // ignore: cast_nullable_to_non_nullable
as int,userNick: null == userNick ? _self.userNick : userNick // ignore: cast_nullable_to_non_nullable
as String,userEmail: null == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String,userImage: null == userImage ? _self.userImage : userImage // ignore: cast_nullable_to_non_nullable
as String,gardenCount: null == gardenCount ? _self.gardenCount : gardenCount // ignore: cast_nullable_to_non_nullable
as int,readBookCount: null == readBookCount ? _self.readBookCount : readBookCount // ignore: cast_nullable_to_non_nullable
as int,likeBookCount: null == likeBookCount ? _self.likeBookCount : likeBookCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
