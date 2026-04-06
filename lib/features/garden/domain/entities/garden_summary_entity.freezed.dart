// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'garden_summary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GardenSummaryEntity {

 int get gardenNo; String get gardenTitle; String get gardenInfo; String get gardenColor; int get bookCount;
/// Create a copy of GardenSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GardenSummaryEntityCopyWith<GardenSummaryEntity> get copyWith => _$GardenSummaryEntityCopyWithImpl<GardenSummaryEntity>(this as GardenSummaryEntity, _$identity);

  /// Serializes this GardenSummaryEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GardenSummaryEntity&&(identical(other.gardenNo, gardenNo) || other.gardenNo == gardenNo)&&(identical(other.gardenTitle, gardenTitle) || other.gardenTitle == gardenTitle)&&(identical(other.gardenInfo, gardenInfo) || other.gardenInfo == gardenInfo)&&(identical(other.gardenColor, gardenColor) || other.gardenColor == gardenColor)&&(identical(other.bookCount, bookCount) || other.bookCount == bookCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gardenNo,gardenTitle,gardenInfo,gardenColor,bookCount);

@override
String toString() {
  return 'GardenSummaryEntity(gardenNo: $gardenNo, gardenTitle: $gardenTitle, gardenInfo: $gardenInfo, gardenColor: $gardenColor, bookCount: $bookCount)';
}


}

/// @nodoc
abstract mixin class $GardenSummaryEntityCopyWith<$Res>  {
  factory $GardenSummaryEntityCopyWith(GardenSummaryEntity value, $Res Function(GardenSummaryEntity) _then) = _$GardenSummaryEntityCopyWithImpl;
@useResult
$Res call({
 int gardenNo, String gardenTitle, String gardenInfo, String gardenColor, int bookCount
});




}
/// @nodoc
class _$GardenSummaryEntityCopyWithImpl<$Res>
    implements $GardenSummaryEntityCopyWith<$Res> {
  _$GardenSummaryEntityCopyWithImpl(this._self, this._then);

  final GardenSummaryEntity _self;
  final $Res Function(GardenSummaryEntity) _then;

/// Create a copy of GardenSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gardenNo = null,Object? gardenTitle = null,Object? gardenInfo = null,Object? gardenColor = null,Object? bookCount = null,}) {
  return _then(_self.copyWith(
gardenNo: null == gardenNo ? _self.gardenNo : gardenNo // ignore: cast_nullable_to_non_nullable
as int,gardenTitle: null == gardenTitle ? _self.gardenTitle : gardenTitle // ignore: cast_nullable_to_non_nullable
as String,gardenInfo: null == gardenInfo ? _self.gardenInfo : gardenInfo // ignore: cast_nullable_to_non_nullable
as String,gardenColor: null == gardenColor ? _self.gardenColor : gardenColor // ignore: cast_nullable_to_non_nullable
as String,bookCount: null == bookCount ? _self.bookCount : bookCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GardenSummaryEntity].
extension GardenSummaryEntityPatterns on GardenSummaryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GardenSummaryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GardenSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GardenSummaryEntity value)  $default,){
final _that = this;
switch (_that) {
case _GardenSummaryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GardenSummaryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GardenSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int gardenNo,  String gardenTitle,  String gardenInfo,  String gardenColor,  int bookCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GardenSummaryEntity() when $default != null:
return $default(_that.gardenNo,_that.gardenTitle,_that.gardenInfo,_that.gardenColor,_that.bookCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int gardenNo,  String gardenTitle,  String gardenInfo,  String gardenColor,  int bookCount)  $default,) {final _that = this;
switch (_that) {
case _GardenSummaryEntity():
return $default(_that.gardenNo,_that.gardenTitle,_that.gardenInfo,_that.gardenColor,_that.bookCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int gardenNo,  String gardenTitle,  String gardenInfo,  String gardenColor,  int bookCount)?  $default,) {final _that = this;
switch (_that) {
case _GardenSummaryEntity() when $default != null:
return $default(_that.gardenNo,_that.gardenTitle,_that.gardenInfo,_that.gardenColor,_that.bookCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GardenSummaryEntity implements GardenSummaryEntity {
  const _GardenSummaryEntity({this.gardenNo = 0, this.gardenTitle = '', this.gardenInfo = '', this.gardenColor = '', this.bookCount = 0});
  factory _GardenSummaryEntity.fromJson(Map<String, dynamic> json) => _$GardenSummaryEntityFromJson(json);

@override@JsonKey() final  int gardenNo;
@override@JsonKey() final  String gardenTitle;
@override@JsonKey() final  String gardenInfo;
@override@JsonKey() final  String gardenColor;
@override@JsonKey() final  int bookCount;

/// Create a copy of GardenSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GardenSummaryEntityCopyWith<_GardenSummaryEntity> get copyWith => __$GardenSummaryEntityCopyWithImpl<_GardenSummaryEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GardenSummaryEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GardenSummaryEntity&&(identical(other.gardenNo, gardenNo) || other.gardenNo == gardenNo)&&(identical(other.gardenTitle, gardenTitle) || other.gardenTitle == gardenTitle)&&(identical(other.gardenInfo, gardenInfo) || other.gardenInfo == gardenInfo)&&(identical(other.gardenColor, gardenColor) || other.gardenColor == gardenColor)&&(identical(other.bookCount, bookCount) || other.bookCount == bookCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gardenNo,gardenTitle,gardenInfo,gardenColor,bookCount);

@override
String toString() {
  return 'GardenSummaryEntity(gardenNo: $gardenNo, gardenTitle: $gardenTitle, gardenInfo: $gardenInfo, gardenColor: $gardenColor, bookCount: $bookCount)';
}


}

/// @nodoc
abstract mixin class _$GardenSummaryEntityCopyWith<$Res> implements $GardenSummaryEntityCopyWith<$Res> {
  factory _$GardenSummaryEntityCopyWith(_GardenSummaryEntity value, $Res Function(_GardenSummaryEntity) _then) = __$GardenSummaryEntityCopyWithImpl;
@override @useResult
$Res call({
 int gardenNo, String gardenTitle, String gardenInfo, String gardenColor, int bookCount
});




}
/// @nodoc
class __$GardenSummaryEntityCopyWithImpl<$Res>
    implements _$GardenSummaryEntityCopyWith<$Res> {
  __$GardenSummaryEntityCopyWithImpl(this._self, this._then);

  final _GardenSummaryEntity _self;
  final $Res Function(_GardenSummaryEntity) _then;

/// Create a copy of GardenSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gardenNo = null,Object? gardenTitle = null,Object? gardenInfo = null,Object? gardenColor = null,Object? bookCount = null,}) {
  return _then(_GardenSummaryEntity(
gardenNo: null == gardenNo ? _self.gardenNo : gardenNo // ignore: cast_nullable_to_non_nullable
as int,gardenTitle: null == gardenTitle ? _self.gardenTitle : gardenTitle // ignore: cast_nullable_to_non_nullable
as String,gardenInfo: null == gardenInfo ? _self.gardenInfo : gardenInfo // ignore: cast_nullable_to_non_nullable
as String,gardenColor: null == gardenColor ? _self.gardenColor : gardenColor // ignore: cast_nullable_to_non_nullable
as String,bookCount: null == bookCount ? _self.bookCount : bookCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
