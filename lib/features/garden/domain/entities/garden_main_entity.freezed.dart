// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'garden_main_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GardenMainEntity {

 int get gardenNo; String get gardenTitle; String get gardenInfo; String get gardenColor; List<GardenMainBookEntity> get bookList; List<GardenMemberEntity> get gardenMembers;
/// Create a copy of GardenMainEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GardenMainEntityCopyWith<GardenMainEntity> get copyWith => _$GardenMainEntityCopyWithImpl<GardenMainEntity>(this as GardenMainEntity, _$identity);

  /// Serializes this GardenMainEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GardenMainEntity&&(identical(other.gardenNo, gardenNo) || other.gardenNo == gardenNo)&&(identical(other.gardenTitle, gardenTitle) || other.gardenTitle == gardenTitle)&&(identical(other.gardenInfo, gardenInfo) || other.gardenInfo == gardenInfo)&&(identical(other.gardenColor, gardenColor) || other.gardenColor == gardenColor)&&const DeepCollectionEquality().equals(other.bookList, bookList)&&const DeepCollectionEquality().equals(other.gardenMembers, gardenMembers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gardenNo,gardenTitle,gardenInfo,gardenColor,const DeepCollectionEquality().hash(bookList),const DeepCollectionEquality().hash(gardenMembers));

@override
String toString() {
  return 'GardenMainEntity(gardenNo: $gardenNo, gardenTitle: $gardenTitle, gardenInfo: $gardenInfo, gardenColor: $gardenColor, bookList: $bookList, gardenMembers: $gardenMembers)';
}


}

/// @nodoc
abstract mixin class $GardenMainEntityCopyWith<$Res>  {
  factory $GardenMainEntityCopyWith(GardenMainEntity value, $Res Function(GardenMainEntity) _then) = _$GardenMainEntityCopyWithImpl;
@useResult
$Res call({
 int gardenNo, String gardenTitle, String gardenInfo, String gardenColor, List<GardenMainBookEntity> bookList, List<GardenMemberEntity> gardenMembers
});




}
/// @nodoc
class _$GardenMainEntityCopyWithImpl<$Res>
    implements $GardenMainEntityCopyWith<$Res> {
  _$GardenMainEntityCopyWithImpl(this._self, this._then);

  final GardenMainEntity _self;
  final $Res Function(GardenMainEntity) _then;

/// Create a copy of GardenMainEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gardenNo = null,Object? gardenTitle = null,Object? gardenInfo = null,Object? gardenColor = null,Object? bookList = null,Object? gardenMembers = null,}) {
  return _then(_self.copyWith(
gardenNo: null == gardenNo ? _self.gardenNo : gardenNo // ignore: cast_nullable_to_non_nullable
as int,gardenTitle: null == gardenTitle ? _self.gardenTitle : gardenTitle // ignore: cast_nullable_to_non_nullable
as String,gardenInfo: null == gardenInfo ? _self.gardenInfo : gardenInfo // ignore: cast_nullable_to_non_nullable
as String,gardenColor: null == gardenColor ? _self.gardenColor : gardenColor // ignore: cast_nullable_to_non_nullable
as String,bookList: null == bookList ? _self.bookList : bookList // ignore: cast_nullable_to_non_nullable
as List<GardenMainBookEntity>,gardenMembers: null == gardenMembers ? _self.gardenMembers : gardenMembers // ignore: cast_nullable_to_non_nullable
as List<GardenMemberEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [GardenMainEntity].
extension GardenMainEntityPatterns on GardenMainEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GardenMainEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GardenMainEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GardenMainEntity value)  $default,){
final _that = this;
switch (_that) {
case _GardenMainEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GardenMainEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GardenMainEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int gardenNo,  String gardenTitle,  String gardenInfo,  String gardenColor,  List<GardenMainBookEntity> bookList,  List<GardenMemberEntity> gardenMembers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GardenMainEntity() when $default != null:
return $default(_that.gardenNo,_that.gardenTitle,_that.gardenInfo,_that.gardenColor,_that.bookList,_that.gardenMembers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int gardenNo,  String gardenTitle,  String gardenInfo,  String gardenColor,  List<GardenMainBookEntity> bookList,  List<GardenMemberEntity> gardenMembers)  $default,) {final _that = this;
switch (_that) {
case _GardenMainEntity():
return $default(_that.gardenNo,_that.gardenTitle,_that.gardenInfo,_that.gardenColor,_that.bookList,_that.gardenMembers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int gardenNo,  String gardenTitle,  String gardenInfo,  String gardenColor,  List<GardenMainBookEntity> bookList,  List<GardenMemberEntity> gardenMembers)?  $default,) {final _that = this;
switch (_that) {
case _GardenMainEntity() when $default != null:
return $default(_that.gardenNo,_that.gardenTitle,_that.gardenInfo,_that.gardenColor,_that.bookList,_that.gardenMembers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GardenMainEntity extends GardenMainEntity {
  const _GardenMainEntity({this.gardenNo = 0, this.gardenTitle = '', this.gardenInfo = '', this.gardenColor = '', final  List<GardenMainBookEntity> bookList = const [], final  List<GardenMemberEntity> gardenMembers = const []}): _bookList = bookList,_gardenMembers = gardenMembers,super._();
  factory _GardenMainEntity.fromJson(Map<String, dynamic> json) => _$GardenMainEntityFromJson(json);

@override@JsonKey() final  int gardenNo;
@override@JsonKey() final  String gardenTitle;
@override@JsonKey() final  String gardenInfo;
@override@JsonKey() final  String gardenColor;
 final  List<GardenMainBookEntity> _bookList;
@override@JsonKey() List<GardenMainBookEntity> get bookList {
  if (_bookList is EqualUnmodifiableListView) return _bookList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookList);
}

 final  List<GardenMemberEntity> _gardenMembers;
@override@JsonKey() List<GardenMemberEntity> get gardenMembers {
  if (_gardenMembers is EqualUnmodifiableListView) return _gardenMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gardenMembers);
}


/// Create a copy of GardenMainEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GardenMainEntityCopyWith<_GardenMainEntity> get copyWith => __$GardenMainEntityCopyWithImpl<_GardenMainEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GardenMainEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GardenMainEntity&&(identical(other.gardenNo, gardenNo) || other.gardenNo == gardenNo)&&(identical(other.gardenTitle, gardenTitle) || other.gardenTitle == gardenTitle)&&(identical(other.gardenInfo, gardenInfo) || other.gardenInfo == gardenInfo)&&(identical(other.gardenColor, gardenColor) || other.gardenColor == gardenColor)&&const DeepCollectionEquality().equals(other._bookList, _bookList)&&const DeepCollectionEquality().equals(other._gardenMembers, _gardenMembers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gardenNo,gardenTitle,gardenInfo,gardenColor,const DeepCollectionEquality().hash(_bookList),const DeepCollectionEquality().hash(_gardenMembers));

@override
String toString() {
  return 'GardenMainEntity(gardenNo: $gardenNo, gardenTitle: $gardenTitle, gardenInfo: $gardenInfo, gardenColor: $gardenColor, bookList: $bookList, gardenMembers: $gardenMembers)';
}


}

/// @nodoc
abstract mixin class _$GardenMainEntityCopyWith<$Res> implements $GardenMainEntityCopyWith<$Res> {
  factory _$GardenMainEntityCopyWith(_GardenMainEntity value, $Res Function(_GardenMainEntity) _then) = __$GardenMainEntityCopyWithImpl;
@override @useResult
$Res call({
 int gardenNo, String gardenTitle, String gardenInfo, String gardenColor, List<GardenMainBookEntity> bookList, List<GardenMemberEntity> gardenMembers
});




}
/// @nodoc
class __$GardenMainEntityCopyWithImpl<$Res>
    implements _$GardenMainEntityCopyWith<$Res> {
  __$GardenMainEntityCopyWithImpl(this._self, this._then);

  final _GardenMainEntity _self;
  final $Res Function(_GardenMainEntity) _then;

/// Create a copy of GardenMainEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gardenNo = null,Object? gardenTitle = null,Object? gardenInfo = null,Object? gardenColor = null,Object? bookList = null,Object? gardenMembers = null,}) {
  return _then(_GardenMainEntity(
gardenNo: null == gardenNo ? _self.gardenNo : gardenNo // ignore: cast_nullable_to_non_nullable
as int,gardenTitle: null == gardenTitle ? _self.gardenTitle : gardenTitle // ignore: cast_nullable_to_non_nullable
as String,gardenInfo: null == gardenInfo ? _self.gardenInfo : gardenInfo // ignore: cast_nullable_to_non_nullable
as String,gardenColor: null == gardenColor ? _self.gardenColor : gardenColor // ignore: cast_nullable_to_non_nullable
as String,bookList: null == bookList ? _self._bookList : bookList // ignore: cast_nullable_to_non_nullable
as List<GardenMainBookEntity>,gardenMembers: null == gardenMembers ? _self._gardenMembers : gardenMembers // ignore: cast_nullable_to_non_nullable
as List<GardenMemberEntity>,
  ));
}


}

// dart format on
