// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memo_write_input_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemoWriteInputEntity {

 int get bookNo; String get bookTitle; String get bookAuthor; String? get bookImageUrl; String get memoContent; String? get imageUrl; int? get gardenNo; int? get id;
/// Create a copy of MemoWriteInputEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemoWriteInputEntityCopyWith<MemoWriteInputEntity> get copyWith => _$MemoWriteInputEntityCopyWithImpl<MemoWriteInputEntity>(this as MemoWriteInputEntity, _$identity);

  /// Serializes this MemoWriteInputEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoWriteInputEntity&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookAuthor, bookAuthor) || other.bookAuthor == bookAuthor)&&(identical(other.bookImageUrl, bookImageUrl) || other.bookImageUrl == bookImageUrl)&&(identical(other.memoContent, memoContent) || other.memoContent == memoContent)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.gardenNo, gardenNo) || other.gardenNo == gardenNo)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookNo,bookTitle,bookAuthor,bookImageUrl,memoContent,imageUrl,gardenNo,id);

@override
String toString() {
  return 'MemoWriteInputEntity(bookNo: $bookNo, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookImageUrl: $bookImageUrl, memoContent: $memoContent, imageUrl: $imageUrl, gardenNo: $gardenNo, id: $id)';
}


}

/// @nodoc
abstract mixin class $MemoWriteInputEntityCopyWith<$Res>  {
  factory $MemoWriteInputEntityCopyWith(MemoWriteInputEntity value, $Res Function(MemoWriteInputEntity) _then) = _$MemoWriteInputEntityCopyWithImpl;
@useResult
$Res call({
 int bookNo, String bookTitle, String bookAuthor, String? bookImageUrl, String memoContent, String? imageUrl, int? gardenNo, int? id
});




}
/// @nodoc
class _$MemoWriteInputEntityCopyWithImpl<$Res>
    implements $MemoWriteInputEntityCopyWith<$Res> {
  _$MemoWriteInputEntityCopyWithImpl(this._self, this._then);

  final MemoWriteInputEntity _self;
  final $Res Function(MemoWriteInputEntity) _then;

/// Create a copy of MemoWriteInputEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookNo = null,Object? bookTitle = null,Object? bookAuthor = null,Object? bookImageUrl = freezed,Object? memoContent = null,Object? imageUrl = freezed,Object? gardenNo = freezed,Object? id = freezed,}) {
  return _then(_self.copyWith(
bookNo: null == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookAuthor: null == bookAuthor ? _self.bookAuthor : bookAuthor // ignore: cast_nullable_to_non_nullable
as String,bookImageUrl: freezed == bookImageUrl ? _self.bookImageUrl : bookImageUrl // ignore: cast_nullable_to_non_nullable
as String?,memoContent: null == memoContent ? _self.memoContent : memoContent // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,gardenNo: freezed == gardenNo ? _self.gardenNo : gardenNo // ignore: cast_nullable_to_non_nullable
as int?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MemoWriteInputEntity].
extension MemoWriteInputEntityPatterns on MemoWriteInputEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemoWriteInputEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemoWriteInputEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemoWriteInputEntity value)  $default,){
final _that = this;
switch (_that) {
case _MemoWriteInputEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemoWriteInputEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MemoWriteInputEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int bookNo,  String bookTitle,  String bookAuthor,  String? bookImageUrl,  String memoContent,  String? imageUrl,  int? gardenNo,  int? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemoWriteInputEntity() when $default != null:
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.memoContent,_that.imageUrl,_that.gardenNo,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int bookNo,  String bookTitle,  String bookAuthor,  String? bookImageUrl,  String memoContent,  String? imageUrl,  int? gardenNo,  int? id)  $default,) {final _that = this;
switch (_that) {
case _MemoWriteInputEntity():
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.memoContent,_that.imageUrl,_that.gardenNo,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int bookNo,  String bookTitle,  String bookAuthor,  String? bookImageUrl,  String memoContent,  String? imageUrl,  int? gardenNo,  int? id)?  $default,) {final _that = this;
switch (_that) {
case _MemoWriteInputEntity() when $default != null:
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.memoContent,_that.imageUrl,_that.gardenNo,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemoWriteInputEntity extends MemoWriteInputEntity {
  const _MemoWriteInputEntity({this.bookNo = 0, this.bookTitle = '', this.bookAuthor = '', this.bookImageUrl, this.memoContent = '', this.imageUrl, this.gardenNo, this.id}): super._();
  factory _MemoWriteInputEntity.fromJson(Map<String, dynamic> json) => _$MemoWriteInputEntityFromJson(json);

@override@JsonKey() final  int bookNo;
@override@JsonKey() final  String bookTitle;
@override@JsonKey() final  String bookAuthor;
@override final  String? bookImageUrl;
@override@JsonKey() final  String memoContent;
@override final  String? imageUrl;
@override final  int? gardenNo;
@override final  int? id;

/// Create a copy of MemoWriteInputEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemoWriteInputEntityCopyWith<_MemoWriteInputEntity> get copyWith => __$MemoWriteInputEntityCopyWithImpl<_MemoWriteInputEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemoWriteInputEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemoWriteInputEntity&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookAuthor, bookAuthor) || other.bookAuthor == bookAuthor)&&(identical(other.bookImageUrl, bookImageUrl) || other.bookImageUrl == bookImageUrl)&&(identical(other.memoContent, memoContent) || other.memoContent == memoContent)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.gardenNo, gardenNo) || other.gardenNo == gardenNo)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookNo,bookTitle,bookAuthor,bookImageUrl,memoContent,imageUrl,gardenNo,id);

@override
String toString() {
  return 'MemoWriteInputEntity(bookNo: $bookNo, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookImageUrl: $bookImageUrl, memoContent: $memoContent, imageUrl: $imageUrl, gardenNo: $gardenNo, id: $id)';
}


}

/// @nodoc
abstract mixin class _$MemoWriteInputEntityCopyWith<$Res> implements $MemoWriteInputEntityCopyWith<$Res> {
  factory _$MemoWriteInputEntityCopyWith(_MemoWriteInputEntity value, $Res Function(_MemoWriteInputEntity) _then) = __$MemoWriteInputEntityCopyWithImpl;
@override @useResult
$Res call({
 int bookNo, String bookTitle, String bookAuthor, String? bookImageUrl, String memoContent, String? imageUrl, int? gardenNo, int? id
});




}
/// @nodoc
class __$MemoWriteInputEntityCopyWithImpl<$Res>
    implements _$MemoWriteInputEntityCopyWith<$Res> {
  __$MemoWriteInputEntityCopyWithImpl(this._self, this._then);

  final _MemoWriteInputEntity _self;
  final $Res Function(_MemoWriteInputEntity) _then;

/// Create a copy of MemoWriteInputEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookNo = null,Object? bookTitle = null,Object? bookAuthor = null,Object? bookImageUrl = freezed,Object? memoContent = null,Object? imageUrl = freezed,Object? gardenNo = freezed,Object? id = freezed,}) {
  return _then(_MemoWriteInputEntity(
bookNo: null == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookAuthor: null == bookAuthor ? _self.bookAuthor : bookAuthor // ignore: cast_nullable_to_non_nullable
as String,bookImageUrl: freezed == bookImageUrl ? _self.bookImageUrl : bookImageUrl // ignore: cast_nullable_to_non_nullable
as String?,memoContent: null == memoContent ? _self.memoContent : memoContent // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,gardenNo: freezed == gardenNo ? _self.gardenNo : gardenNo // ignore: cast_nullable_to_non_nullable
as int?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
