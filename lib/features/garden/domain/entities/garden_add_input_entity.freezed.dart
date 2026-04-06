// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'garden_add_input_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GardenAddInputEntity {

 String get gardenTitle; String get gardenInfo; String get gardenColor;
/// Create a copy of GardenAddInputEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GardenAddInputEntityCopyWith<GardenAddInputEntity> get copyWith => _$GardenAddInputEntityCopyWithImpl<GardenAddInputEntity>(this as GardenAddInputEntity, _$identity);

  /// Serializes this GardenAddInputEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GardenAddInputEntity&&(identical(other.gardenTitle, gardenTitle) || other.gardenTitle == gardenTitle)&&(identical(other.gardenInfo, gardenInfo) || other.gardenInfo == gardenInfo)&&(identical(other.gardenColor, gardenColor) || other.gardenColor == gardenColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gardenTitle,gardenInfo,gardenColor);

@override
String toString() {
  return 'GardenAddInputEntity(gardenTitle: $gardenTitle, gardenInfo: $gardenInfo, gardenColor: $gardenColor)';
}


}

/// @nodoc
abstract mixin class $GardenAddInputEntityCopyWith<$Res>  {
  factory $GardenAddInputEntityCopyWith(GardenAddInputEntity value, $Res Function(GardenAddInputEntity) _then) = _$GardenAddInputEntityCopyWithImpl;
@useResult
$Res call({
 String gardenTitle, String gardenInfo, String gardenColor
});




}
/// @nodoc
class _$GardenAddInputEntityCopyWithImpl<$Res>
    implements $GardenAddInputEntityCopyWith<$Res> {
  _$GardenAddInputEntityCopyWithImpl(this._self, this._then);

  final GardenAddInputEntity _self;
  final $Res Function(GardenAddInputEntity) _then;

/// Create a copy of GardenAddInputEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gardenTitle = null,Object? gardenInfo = null,Object? gardenColor = null,}) {
  return _then(_self.copyWith(
gardenTitle: null == gardenTitle ? _self.gardenTitle : gardenTitle // ignore: cast_nullable_to_non_nullable
as String,gardenInfo: null == gardenInfo ? _self.gardenInfo : gardenInfo // ignore: cast_nullable_to_non_nullable
as String,gardenColor: null == gardenColor ? _self.gardenColor : gardenColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GardenAddInputEntity].
extension GardenAddInputEntityPatterns on GardenAddInputEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GardenAddInputEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GardenAddInputEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GardenAddInputEntity value)  $default,){
final _that = this;
switch (_that) {
case _GardenAddInputEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GardenAddInputEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GardenAddInputEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String gardenTitle,  String gardenInfo,  String gardenColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GardenAddInputEntity() when $default != null:
return $default(_that.gardenTitle,_that.gardenInfo,_that.gardenColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String gardenTitle,  String gardenInfo,  String gardenColor)  $default,) {final _that = this;
switch (_that) {
case _GardenAddInputEntity():
return $default(_that.gardenTitle,_that.gardenInfo,_that.gardenColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String gardenTitle,  String gardenInfo,  String gardenColor)?  $default,) {final _that = this;
switch (_that) {
case _GardenAddInputEntity() when $default != null:
return $default(_that.gardenTitle,_that.gardenInfo,_that.gardenColor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GardenAddInputEntity implements GardenAddInputEntity {
  const _GardenAddInputEntity({this.gardenTitle = '', this.gardenInfo = '', this.gardenColor = ''});
  factory _GardenAddInputEntity.fromJson(Map<String, dynamic> json) => _$GardenAddInputEntityFromJson(json);

@override@JsonKey() final  String gardenTitle;
@override@JsonKey() final  String gardenInfo;
@override@JsonKey() final  String gardenColor;

/// Create a copy of GardenAddInputEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GardenAddInputEntityCopyWith<_GardenAddInputEntity> get copyWith => __$GardenAddInputEntityCopyWithImpl<_GardenAddInputEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GardenAddInputEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GardenAddInputEntity&&(identical(other.gardenTitle, gardenTitle) || other.gardenTitle == gardenTitle)&&(identical(other.gardenInfo, gardenInfo) || other.gardenInfo == gardenInfo)&&(identical(other.gardenColor, gardenColor) || other.gardenColor == gardenColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gardenTitle,gardenInfo,gardenColor);

@override
String toString() {
  return 'GardenAddInputEntity(gardenTitle: $gardenTitle, gardenInfo: $gardenInfo, gardenColor: $gardenColor)';
}


}

/// @nodoc
abstract mixin class _$GardenAddInputEntityCopyWith<$Res> implements $GardenAddInputEntityCopyWith<$Res> {
  factory _$GardenAddInputEntityCopyWith(_GardenAddInputEntity value, $Res Function(_GardenAddInputEntity) _then) = __$GardenAddInputEntityCopyWithImpl;
@override @useResult
$Res call({
 String gardenTitle, String gardenInfo, String gardenColor
});




}
/// @nodoc
class __$GardenAddInputEntityCopyWithImpl<$Res>
    implements _$GardenAddInputEntityCopyWith<$Res> {
  __$GardenAddInputEntityCopyWithImpl(this._self, this._then);

  final _GardenAddInputEntity _self;
  final $Res Function(_GardenAddInputEntity) _then;

/// Create a copy of GardenAddInputEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gardenTitle = null,Object? gardenInfo = null,Object? gardenColor = null,}) {
  return _then(_GardenAddInputEntity(
gardenTitle: null == gardenTitle ? _self.gardenTitle : gardenTitle // ignore: cast_nullable_to_non_nullable
as String,gardenInfo: null == gardenInfo ? _self.gardenInfo : gardenInfo // ignore: cast_nullable_to_non_nullable
as String,gardenColor: null == gardenColor ? _self.gardenColor : gardenColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
