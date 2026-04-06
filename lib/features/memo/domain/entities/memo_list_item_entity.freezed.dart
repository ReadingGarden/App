// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memo_list_item_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemoListItemEntity {

 int get id; int get bookNo; String get bookTitle; String get bookAuthor; String? get bookImageUrl; String get memoContent; bool get memoLike; String? get imageUrl; String get memoCreatedAt;
/// Create a copy of MemoListItemEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemoListItemEntityCopyWith<MemoListItemEntity> get copyWith => _$MemoListItemEntityCopyWithImpl<MemoListItemEntity>(this as MemoListItemEntity, _$identity);

  /// Serializes this MemoListItemEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoListItemEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookAuthor, bookAuthor) || other.bookAuthor == bookAuthor)&&(identical(other.bookImageUrl, bookImageUrl) || other.bookImageUrl == bookImageUrl)&&(identical(other.memoContent, memoContent) || other.memoContent == memoContent)&&(identical(other.memoLike, memoLike) || other.memoLike == memoLike)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.memoCreatedAt, memoCreatedAt) || other.memoCreatedAt == memoCreatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bookNo,bookTitle,bookAuthor,bookImageUrl,memoContent,memoLike,imageUrl,memoCreatedAt);

@override
String toString() {
  return 'MemoListItemEntity(id: $id, bookNo: $bookNo, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookImageUrl: $bookImageUrl, memoContent: $memoContent, memoLike: $memoLike, imageUrl: $imageUrl, memoCreatedAt: $memoCreatedAt)';
}


}

/// @nodoc
abstract mixin class $MemoListItemEntityCopyWith<$Res>  {
  factory $MemoListItemEntityCopyWith(MemoListItemEntity value, $Res Function(MemoListItemEntity) _then) = _$MemoListItemEntityCopyWithImpl;
@useResult
$Res call({
 int id, int bookNo, String bookTitle, String bookAuthor, String? bookImageUrl, String memoContent, bool memoLike, String? imageUrl, String memoCreatedAt
});




}
/// @nodoc
class _$MemoListItemEntityCopyWithImpl<$Res>
    implements $MemoListItemEntityCopyWith<$Res> {
  _$MemoListItemEntityCopyWithImpl(this._self, this._then);

  final MemoListItemEntity _self;
  final $Res Function(MemoListItemEntity) _then;

/// Create a copy of MemoListItemEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookNo = null,Object? bookTitle = null,Object? bookAuthor = null,Object? bookImageUrl = freezed,Object? memoContent = null,Object? memoLike = null,Object? imageUrl = freezed,Object? memoCreatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,bookNo: null == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookAuthor: null == bookAuthor ? _self.bookAuthor : bookAuthor // ignore: cast_nullable_to_non_nullable
as String,bookImageUrl: freezed == bookImageUrl ? _self.bookImageUrl : bookImageUrl // ignore: cast_nullable_to_non_nullable
as String?,memoContent: null == memoContent ? _self.memoContent : memoContent // ignore: cast_nullable_to_non_nullable
as String,memoLike: null == memoLike ? _self.memoLike : memoLike // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,memoCreatedAt: null == memoCreatedAt ? _self.memoCreatedAt : memoCreatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MemoListItemEntity].
extension MemoListItemEntityPatterns on MemoListItemEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemoListItemEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemoListItemEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemoListItemEntity value)  $default,){
final _that = this;
switch (_that) {
case _MemoListItemEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemoListItemEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MemoListItemEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int bookNo,  String bookTitle,  String bookAuthor,  String? bookImageUrl,  String memoContent,  bool memoLike,  String? imageUrl,  String memoCreatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemoListItemEntity() when $default != null:
return $default(_that.id,_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.memoContent,_that.memoLike,_that.imageUrl,_that.memoCreatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int bookNo,  String bookTitle,  String bookAuthor,  String? bookImageUrl,  String memoContent,  bool memoLike,  String? imageUrl,  String memoCreatedAt)  $default,) {final _that = this;
switch (_that) {
case _MemoListItemEntity():
return $default(_that.id,_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.memoContent,_that.memoLike,_that.imageUrl,_that.memoCreatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int bookNo,  String bookTitle,  String bookAuthor,  String? bookImageUrl,  String memoContent,  bool memoLike,  String? imageUrl,  String memoCreatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MemoListItemEntity() when $default != null:
return $default(_that.id,_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.memoContent,_that.memoLike,_that.imageUrl,_that.memoCreatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemoListItemEntity implements MemoListItemEntity {
  const _MemoListItemEntity({required this.id, required this.bookNo, required this.bookTitle, required this.bookAuthor, required this.bookImageUrl, required this.memoContent, required this.memoLike, required this.imageUrl, required this.memoCreatedAt});
  factory _MemoListItemEntity.fromJson(Map<String, dynamic> json) => _$MemoListItemEntityFromJson(json);

@override final  int id;
@override final  int bookNo;
@override final  String bookTitle;
@override final  String bookAuthor;
@override final  String? bookImageUrl;
@override final  String memoContent;
@override final  bool memoLike;
@override final  String? imageUrl;
@override final  String memoCreatedAt;

/// Create a copy of MemoListItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemoListItemEntityCopyWith<_MemoListItemEntity> get copyWith => __$MemoListItemEntityCopyWithImpl<_MemoListItemEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemoListItemEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemoListItemEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookAuthor, bookAuthor) || other.bookAuthor == bookAuthor)&&(identical(other.bookImageUrl, bookImageUrl) || other.bookImageUrl == bookImageUrl)&&(identical(other.memoContent, memoContent) || other.memoContent == memoContent)&&(identical(other.memoLike, memoLike) || other.memoLike == memoLike)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.memoCreatedAt, memoCreatedAt) || other.memoCreatedAt == memoCreatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bookNo,bookTitle,bookAuthor,bookImageUrl,memoContent,memoLike,imageUrl,memoCreatedAt);

@override
String toString() {
  return 'MemoListItemEntity(id: $id, bookNo: $bookNo, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookImageUrl: $bookImageUrl, memoContent: $memoContent, memoLike: $memoLike, imageUrl: $imageUrl, memoCreatedAt: $memoCreatedAt)';
}


}

/// @nodoc
abstract mixin class _$MemoListItemEntityCopyWith<$Res> implements $MemoListItemEntityCopyWith<$Res> {
  factory _$MemoListItemEntityCopyWith(_MemoListItemEntity value, $Res Function(_MemoListItemEntity) _then) = __$MemoListItemEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int bookNo, String bookTitle, String bookAuthor, String? bookImageUrl, String memoContent, bool memoLike, String? imageUrl, String memoCreatedAt
});




}
/// @nodoc
class __$MemoListItemEntityCopyWithImpl<$Res>
    implements _$MemoListItemEntityCopyWith<$Res> {
  __$MemoListItemEntityCopyWithImpl(this._self, this._then);

  final _MemoListItemEntity _self;
  final $Res Function(_MemoListItemEntity) _then;

/// Create a copy of MemoListItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookNo = null,Object? bookTitle = null,Object? bookAuthor = null,Object? bookImageUrl = freezed,Object? memoContent = null,Object? memoLike = null,Object? imageUrl = freezed,Object? memoCreatedAt = null,}) {
  return _then(_MemoListItemEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,bookNo: null == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookAuthor: null == bookAuthor ? _self.bookAuthor : bookAuthor // ignore: cast_nullable_to_non_nullable
as String,bookImageUrl: freezed == bookImageUrl ? _self.bookImageUrl : bookImageUrl // ignore: cast_nullable_to_non_nullable
as String?,memoContent: null == memoContent ? _self.memoContent : memoContent // ignore: cast_nullable_to_non_nullable
as String,memoLike: null == memoLike ? _self.memoLike : memoLike // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,memoCreatedAt: null == memoCreatedAt ? _self.memoCreatedAt : memoCreatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
