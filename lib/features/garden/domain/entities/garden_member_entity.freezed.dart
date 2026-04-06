// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'garden_member_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GardenMemberEntity {

 int get userNo; String get userNick; String get userImage; bool get gardenLeader;
/// Create a copy of GardenMemberEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GardenMemberEntityCopyWith<GardenMemberEntity> get copyWith => _$GardenMemberEntityCopyWithImpl<GardenMemberEntity>(this as GardenMemberEntity, _$identity);

  /// Serializes this GardenMemberEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GardenMemberEntity&&(identical(other.userNo, userNo) || other.userNo == userNo)&&(identical(other.userNick, userNick) || other.userNick == userNick)&&(identical(other.userImage, userImage) || other.userImage == userImage)&&(identical(other.gardenLeader, gardenLeader) || other.gardenLeader == gardenLeader));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userNo,userNick,userImage,gardenLeader);

@override
String toString() {
  return 'GardenMemberEntity(userNo: $userNo, userNick: $userNick, userImage: $userImage, gardenLeader: $gardenLeader)';
}


}

/// @nodoc
abstract mixin class $GardenMemberEntityCopyWith<$Res>  {
  factory $GardenMemberEntityCopyWith(GardenMemberEntity value, $Res Function(GardenMemberEntity) _then) = _$GardenMemberEntityCopyWithImpl;
@useResult
$Res call({
 int userNo, String userNick, String userImage, bool gardenLeader
});




}
/// @nodoc
class _$GardenMemberEntityCopyWithImpl<$Res>
    implements $GardenMemberEntityCopyWith<$Res> {
  _$GardenMemberEntityCopyWithImpl(this._self, this._then);

  final GardenMemberEntity _self;
  final $Res Function(GardenMemberEntity) _then;

/// Create a copy of GardenMemberEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userNo = null,Object? userNick = null,Object? userImage = null,Object? gardenLeader = null,}) {
  return _then(_self.copyWith(
userNo: null == userNo ? _self.userNo : userNo // ignore: cast_nullable_to_non_nullable
as int,userNick: null == userNick ? _self.userNick : userNick // ignore: cast_nullable_to_non_nullable
as String,userImage: null == userImage ? _self.userImage : userImage // ignore: cast_nullable_to_non_nullable
as String,gardenLeader: null == gardenLeader ? _self.gardenLeader : gardenLeader // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GardenMemberEntity].
extension GardenMemberEntityPatterns on GardenMemberEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GardenMemberEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GardenMemberEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GardenMemberEntity value)  $default,){
final _that = this;
switch (_that) {
case _GardenMemberEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GardenMemberEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GardenMemberEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userNo,  String userNick,  String userImage,  bool gardenLeader)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GardenMemberEntity() when $default != null:
return $default(_that.userNo,_that.userNick,_that.userImage,_that.gardenLeader);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userNo,  String userNick,  String userImage,  bool gardenLeader)  $default,) {final _that = this;
switch (_that) {
case _GardenMemberEntity():
return $default(_that.userNo,_that.userNick,_that.userImage,_that.gardenLeader);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userNo,  String userNick,  String userImage,  bool gardenLeader)?  $default,) {final _that = this;
switch (_that) {
case _GardenMemberEntity() when $default != null:
return $default(_that.userNo,_that.userNick,_that.userImage,_that.gardenLeader);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GardenMemberEntity implements GardenMemberEntity {
  const _GardenMemberEntity({this.userNo = 0, this.userNick = '', this.userImage = '', this.gardenLeader = false});
  factory _GardenMemberEntity.fromJson(Map<String, dynamic> json) => _$GardenMemberEntityFromJson(json);

@override@JsonKey() final  int userNo;
@override@JsonKey() final  String userNick;
@override@JsonKey() final  String userImage;
@override@JsonKey() final  bool gardenLeader;

/// Create a copy of GardenMemberEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GardenMemberEntityCopyWith<_GardenMemberEntity> get copyWith => __$GardenMemberEntityCopyWithImpl<_GardenMemberEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GardenMemberEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GardenMemberEntity&&(identical(other.userNo, userNo) || other.userNo == userNo)&&(identical(other.userNick, userNick) || other.userNick == userNick)&&(identical(other.userImage, userImage) || other.userImage == userImage)&&(identical(other.gardenLeader, gardenLeader) || other.gardenLeader == gardenLeader));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userNo,userNick,userImage,gardenLeader);

@override
String toString() {
  return 'GardenMemberEntity(userNo: $userNo, userNick: $userNick, userImage: $userImage, gardenLeader: $gardenLeader)';
}


}

/// @nodoc
abstract mixin class _$GardenMemberEntityCopyWith<$Res> implements $GardenMemberEntityCopyWith<$Res> {
  factory _$GardenMemberEntityCopyWith(_GardenMemberEntity value, $Res Function(_GardenMemberEntity) _then) = __$GardenMemberEntityCopyWithImpl;
@override @useResult
$Res call({
 int userNo, String userNick, String userImage, bool gardenLeader
});




}
/// @nodoc
class __$GardenMemberEntityCopyWithImpl<$Res>
    implements _$GardenMemberEntityCopyWith<$Res> {
  __$GardenMemberEntityCopyWithImpl(this._self, this._then);

  final _GardenMemberEntity _self;
  final $Res Function(_GardenMemberEntity) _then;

/// Create a copy of GardenMemberEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userNo = null,Object? userNick = null,Object? userImage = null,Object? gardenLeader = null,}) {
  return _then(_GardenMemberEntity(
userNo: null == userNo ? _self.userNo : userNo // ignore: cast_nullable_to_non_nullable
as int,userNick: null == userNick ? _self.userNick : userNick // ignore: cast_nullable_to_non_nullable
as String,userImage: null == userImage ? _self.userImage : userImage // ignore: cast_nullable_to_non_nullable
as String,gardenLeader: null == gardenLeader ? _self.gardenLeader : gardenLeader // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
