// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_edit_input_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookEditInputEntity {

 int get bookNo; String get bookTitle; String get bookAuthor; String? get bookImageUrl; int get bookRating;
/// Create a copy of BookEditInputEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookEditInputEntityCopyWith<BookEditInputEntity> get copyWith => _$BookEditInputEntityCopyWithImpl<BookEditInputEntity>(this as BookEditInputEntity, _$identity);

  /// Serializes this BookEditInputEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookEditInputEntity&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookAuthor, bookAuthor) || other.bookAuthor == bookAuthor)&&(identical(other.bookImageUrl, bookImageUrl) || other.bookImageUrl == bookImageUrl)&&(identical(other.bookRating, bookRating) || other.bookRating == bookRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookNo,bookTitle,bookAuthor,bookImageUrl,bookRating);

@override
String toString() {
  return 'BookEditInputEntity(bookNo: $bookNo, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookImageUrl: $bookImageUrl, bookRating: $bookRating)';
}


}

/// @nodoc
abstract mixin class $BookEditInputEntityCopyWith<$Res>  {
  factory $BookEditInputEntityCopyWith(BookEditInputEntity value, $Res Function(BookEditInputEntity) _then) = _$BookEditInputEntityCopyWithImpl;
@useResult
$Res call({
 int bookNo, String bookTitle, String bookAuthor, String? bookImageUrl, int bookRating
});




}
/// @nodoc
class _$BookEditInputEntityCopyWithImpl<$Res>
    implements $BookEditInputEntityCopyWith<$Res> {
  _$BookEditInputEntityCopyWithImpl(this._self, this._then);

  final BookEditInputEntity _self;
  final $Res Function(BookEditInputEntity) _then;

/// Create a copy of BookEditInputEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookNo = null,Object? bookTitle = null,Object? bookAuthor = null,Object? bookImageUrl = freezed,Object? bookRating = null,}) {
  return _then(_self.copyWith(
bookNo: null == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookAuthor: null == bookAuthor ? _self.bookAuthor : bookAuthor // ignore: cast_nullable_to_non_nullable
as String,bookImageUrl: freezed == bookImageUrl ? _self.bookImageUrl : bookImageUrl // ignore: cast_nullable_to_non_nullable
as String?,bookRating: null == bookRating ? _self.bookRating : bookRating // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BookEditInputEntity].
extension BookEditInputEntityPatterns on BookEditInputEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookEditInputEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookEditInputEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookEditInputEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookEditInputEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookEditInputEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookEditInputEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int bookNo,  String bookTitle,  String bookAuthor,  String? bookImageUrl,  int bookRating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookEditInputEntity() when $default != null:
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.bookRating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int bookNo,  String bookTitle,  String bookAuthor,  String? bookImageUrl,  int bookRating)  $default,) {final _that = this;
switch (_that) {
case _BookEditInputEntity():
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.bookRating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int bookNo,  String bookTitle,  String bookAuthor,  String? bookImageUrl,  int bookRating)?  $default,) {final _that = this;
switch (_that) {
case _BookEditInputEntity() when $default != null:
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.bookRating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookEditInputEntity implements BookEditInputEntity {
  const _BookEditInputEntity({required this.bookNo, required this.bookTitle, required this.bookAuthor, required this.bookImageUrl, this.bookRating = 0});
  factory _BookEditInputEntity.fromJson(Map<String, dynamic> json) => _$BookEditInputEntityFromJson(json);

@override final  int bookNo;
@override final  String bookTitle;
@override final  String bookAuthor;
@override final  String? bookImageUrl;
@override@JsonKey() final  int bookRating;

/// Create a copy of BookEditInputEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookEditInputEntityCopyWith<_BookEditInputEntity> get copyWith => __$BookEditInputEntityCopyWithImpl<_BookEditInputEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookEditInputEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookEditInputEntity&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookAuthor, bookAuthor) || other.bookAuthor == bookAuthor)&&(identical(other.bookImageUrl, bookImageUrl) || other.bookImageUrl == bookImageUrl)&&(identical(other.bookRating, bookRating) || other.bookRating == bookRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookNo,bookTitle,bookAuthor,bookImageUrl,bookRating);

@override
String toString() {
  return 'BookEditInputEntity(bookNo: $bookNo, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookImageUrl: $bookImageUrl, bookRating: $bookRating)';
}


}

/// @nodoc
abstract mixin class _$BookEditInputEntityCopyWith<$Res> implements $BookEditInputEntityCopyWith<$Res> {
  factory _$BookEditInputEntityCopyWith(_BookEditInputEntity value, $Res Function(_BookEditInputEntity) _then) = __$BookEditInputEntityCopyWithImpl;
@override @useResult
$Res call({
 int bookNo, String bookTitle, String bookAuthor, String? bookImageUrl, int bookRating
});




}
/// @nodoc
class __$BookEditInputEntityCopyWithImpl<$Res>
    implements _$BookEditInputEntityCopyWith<$Res> {
  __$BookEditInputEntityCopyWithImpl(this._self, this._then);

  final _BookEditInputEntity _self;
  final $Res Function(_BookEditInputEntity) _then;

/// Create a copy of BookEditInputEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookNo = null,Object? bookTitle = null,Object? bookAuthor = null,Object? bookImageUrl = freezed,Object? bookRating = null,}) {
  return _then(_BookEditInputEntity(
bookNo: null == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookAuthor: null == bookAuthor ? _self.bookAuthor : bookAuthor // ignore: cast_nullable_to_non_nullable
as String,bookImageUrl: freezed == bookImageUrl ? _self.bookImageUrl : bookImageUrl // ignore: cast_nullable_to_non_nullable
as String?,bookRating: null == bookRating ? _self.bookRating : bookRating // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
