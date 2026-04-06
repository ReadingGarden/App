// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_memo_summary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookMemoSummaryEntity {

 int get id; String get memoContent; String get memoCreatedAt; bool get memoLike; String? get imageUrl;
/// Create a copy of BookMemoSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookMemoSummaryEntityCopyWith<BookMemoSummaryEntity> get copyWith => _$BookMemoSummaryEntityCopyWithImpl<BookMemoSummaryEntity>(this as BookMemoSummaryEntity, _$identity);

  /// Serializes this BookMemoSummaryEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookMemoSummaryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.memoContent, memoContent) || other.memoContent == memoContent)&&(identical(other.memoCreatedAt, memoCreatedAt) || other.memoCreatedAt == memoCreatedAt)&&(identical(other.memoLike, memoLike) || other.memoLike == memoLike)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,memoContent,memoCreatedAt,memoLike,imageUrl);

@override
String toString() {
  return 'BookMemoSummaryEntity(id: $id, memoContent: $memoContent, memoCreatedAt: $memoCreatedAt, memoLike: $memoLike, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $BookMemoSummaryEntityCopyWith<$Res>  {
  factory $BookMemoSummaryEntityCopyWith(BookMemoSummaryEntity value, $Res Function(BookMemoSummaryEntity) _then) = _$BookMemoSummaryEntityCopyWithImpl;
@useResult
$Res call({
 int id, String memoContent, String memoCreatedAt, bool memoLike, String? imageUrl
});




}
/// @nodoc
class _$BookMemoSummaryEntityCopyWithImpl<$Res>
    implements $BookMemoSummaryEntityCopyWith<$Res> {
  _$BookMemoSummaryEntityCopyWithImpl(this._self, this._then);

  final BookMemoSummaryEntity _self;
  final $Res Function(BookMemoSummaryEntity) _then;

/// Create a copy of BookMemoSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? memoContent = null,Object? memoCreatedAt = null,Object? memoLike = null,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,memoContent: null == memoContent ? _self.memoContent : memoContent // ignore: cast_nullable_to_non_nullable
as String,memoCreatedAt: null == memoCreatedAt ? _self.memoCreatedAt : memoCreatedAt // ignore: cast_nullable_to_non_nullable
as String,memoLike: null == memoLike ? _self.memoLike : memoLike // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookMemoSummaryEntity].
extension BookMemoSummaryEntityPatterns on BookMemoSummaryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookMemoSummaryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookMemoSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookMemoSummaryEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookMemoSummaryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookMemoSummaryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookMemoSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String memoContent,  String memoCreatedAt,  bool memoLike,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookMemoSummaryEntity() when $default != null:
return $default(_that.id,_that.memoContent,_that.memoCreatedAt,_that.memoLike,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String memoContent,  String memoCreatedAt,  bool memoLike,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _BookMemoSummaryEntity():
return $default(_that.id,_that.memoContent,_that.memoCreatedAt,_that.memoLike,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String memoContent,  String memoCreatedAt,  bool memoLike,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _BookMemoSummaryEntity() when $default != null:
return $default(_that.id,_that.memoContent,_that.memoCreatedAt,_that.memoLike,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookMemoSummaryEntity extends BookMemoSummaryEntity {
  const _BookMemoSummaryEntity({required this.id, required this.memoContent, required this.memoCreatedAt, required this.memoLike, required this.imageUrl}): super._();
  factory _BookMemoSummaryEntity.fromJson(Map<String, dynamic> json) => _$BookMemoSummaryEntityFromJson(json);

@override final  int id;
@override final  String memoContent;
@override final  String memoCreatedAt;
@override final  bool memoLike;
@override final  String? imageUrl;

/// Create a copy of BookMemoSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookMemoSummaryEntityCopyWith<_BookMemoSummaryEntity> get copyWith => __$BookMemoSummaryEntityCopyWithImpl<_BookMemoSummaryEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookMemoSummaryEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookMemoSummaryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.memoContent, memoContent) || other.memoContent == memoContent)&&(identical(other.memoCreatedAt, memoCreatedAt) || other.memoCreatedAt == memoCreatedAt)&&(identical(other.memoLike, memoLike) || other.memoLike == memoLike)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,memoContent,memoCreatedAt,memoLike,imageUrl);

@override
String toString() {
  return 'BookMemoSummaryEntity(id: $id, memoContent: $memoContent, memoCreatedAt: $memoCreatedAt, memoLike: $memoLike, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$BookMemoSummaryEntityCopyWith<$Res> implements $BookMemoSummaryEntityCopyWith<$Res> {
  factory _$BookMemoSummaryEntityCopyWith(_BookMemoSummaryEntity value, $Res Function(_BookMemoSummaryEntity) _then) = __$BookMemoSummaryEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String memoContent, String memoCreatedAt, bool memoLike, String? imageUrl
});




}
/// @nodoc
class __$BookMemoSummaryEntityCopyWithImpl<$Res>
    implements _$BookMemoSummaryEntityCopyWith<$Res> {
  __$BookMemoSummaryEntityCopyWithImpl(this._self, this._then);

  final _BookMemoSummaryEntity _self;
  final $Res Function(_BookMemoSummaryEntity) _then;

/// Create a copy of BookMemoSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? memoContent = null,Object? memoCreatedAt = null,Object? memoLike = null,Object? imageUrl = freezed,}) {
  return _then(_BookMemoSummaryEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,memoContent: null == memoContent ? _self.memoContent : memoContent // ignore: cast_nullable_to_non_nullable
as String,memoCreatedAt: null == memoCreatedAt ? _self.memoCreatedAt : memoCreatedAt // ignore: cast_nullable_to_non_nullable
as String,memoLike: null == memoLike ? _self.memoLike : memoLike // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
