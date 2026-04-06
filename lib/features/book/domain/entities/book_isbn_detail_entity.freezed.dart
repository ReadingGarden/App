// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_isbn_detail_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookIsbnDetailEntity {

 String get title; String get author; String get description; String get isbn13; String? get cover; String get publisher;@JsonKey(name: 'itemPage') int get itemPage; int? get bookNo;
/// Create a copy of BookIsbnDetailEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookIsbnDetailEntityCopyWith<BookIsbnDetailEntity> get copyWith => _$BookIsbnDetailEntityCopyWithImpl<BookIsbnDetailEntity>(this as BookIsbnDetailEntity, _$identity);

  /// Serializes this BookIsbnDetailEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookIsbnDetailEntity&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.description, description) || other.description == description)&&(identical(other.isbn13, isbn13) || other.isbn13 == isbn13)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.itemPage, itemPage) || other.itemPage == itemPage)&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,author,description,isbn13,cover,publisher,itemPage,bookNo);

@override
String toString() {
  return 'BookIsbnDetailEntity(title: $title, author: $author, description: $description, isbn13: $isbn13, cover: $cover, publisher: $publisher, itemPage: $itemPage, bookNo: $bookNo)';
}


}

/// @nodoc
abstract mixin class $BookIsbnDetailEntityCopyWith<$Res>  {
  factory $BookIsbnDetailEntityCopyWith(BookIsbnDetailEntity value, $Res Function(BookIsbnDetailEntity) _then) = _$BookIsbnDetailEntityCopyWithImpl;
@useResult
$Res call({
 String title, String author, String description, String isbn13, String? cover, String publisher,@JsonKey(name: 'itemPage') int itemPage, int? bookNo
});




}
/// @nodoc
class _$BookIsbnDetailEntityCopyWithImpl<$Res>
    implements $BookIsbnDetailEntityCopyWith<$Res> {
  _$BookIsbnDetailEntityCopyWithImpl(this._self, this._then);

  final BookIsbnDetailEntity _self;
  final $Res Function(BookIsbnDetailEntity) _then;

/// Create a copy of BookIsbnDetailEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? author = null,Object? description = null,Object? isbn13 = null,Object? cover = freezed,Object? publisher = null,Object? itemPage = null,Object? bookNo = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isbn13: null == isbn13 ? _self.isbn13 : isbn13 // ignore: cast_nullable_to_non_nullable
as String,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,itemPage: null == itemPage ? _self.itemPage : itemPage // ignore: cast_nullable_to_non_nullable
as int,bookNo: freezed == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookIsbnDetailEntity].
extension BookIsbnDetailEntityPatterns on BookIsbnDetailEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookIsbnDetailEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookIsbnDetailEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookIsbnDetailEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookIsbnDetailEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookIsbnDetailEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookIsbnDetailEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String author,  String description,  String isbn13,  String? cover,  String publisher, @JsonKey(name: 'itemPage')  int itemPage,  int? bookNo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookIsbnDetailEntity() when $default != null:
return $default(_that.title,_that.author,_that.description,_that.isbn13,_that.cover,_that.publisher,_that.itemPage,_that.bookNo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String author,  String description,  String isbn13,  String? cover,  String publisher, @JsonKey(name: 'itemPage')  int itemPage,  int? bookNo)  $default,) {final _that = this;
switch (_that) {
case _BookIsbnDetailEntity():
return $default(_that.title,_that.author,_that.description,_that.isbn13,_that.cover,_that.publisher,_that.itemPage,_that.bookNo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String author,  String description,  String isbn13,  String? cover,  String publisher, @JsonKey(name: 'itemPage')  int itemPage,  int? bookNo)?  $default,) {final _that = this;
switch (_that) {
case _BookIsbnDetailEntity() when $default != null:
return $default(_that.title,_that.author,_that.description,_that.isbn13,_that.cover,_that.publisher,_that.itemPage,_that.bookNo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookIsbnDetailEntity extends BookIsbnDetailEntity {
  const _BookIsbnDetailEntity({required this.title, required this.author, required this.description, required this.isbn13, required this.cover, required this.publisher, @JsonKey(name: 'itemPage') required this.itemPage, this.bookNo}): super._();
  factory _BookIsbnDetailEntity.fromJson(Map<String, dynamic> json) => _$BookIsbnDetailEntityFromJson(json);

@override final  String title;
@override final  String author;
@override final  String description;
@override final  String isbn13;
@override final  String? cover;
@override final  String publisher;
@override@JsonKey(name: 'itemPage') final  int itemPage;
@override final  int? bookNo;

/// Create a copy of BookIsbnDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookIsbnDetailEntityCopyWith<_BookIsbnDetailEntity> get copyWith => __$BookIsbnDetailEntityCopyWithImpl<_BookIsbnDetailEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookIsbnDetailEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookIsbnDetailEntity&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.description, description) || other.description == description)&&(identical(other.isbn13, isbn13) || other.isbn13 == isbn13)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.itemPage, itemPage) || other.itemPage == itemPage)&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,author,description,isbn13,cover,publisher,itemPage,bookNo);

@override
String toString() {
  return 'BookIsbnDetailEntity(title: $title, author: $author, description: $description, isbn13: $isbn13, cover: $cover, publisher: $publisher, itemPage: $itemPage, bookNo: $bookNo)';
}


}

/// @nodoc
abstract mixin class _$BookIsbnDetailEntityCopyWith<$Res> implements $BookIsbnDetailEntityCopyWith<$Res> {
  factory _$BookIsbnDetailEntityCopyWith(_BookIsbnDetailEntity value, $Res Function(_BookIsbnDetailEntity) _then) = __$BookIsbnDetailEntityCopyWithImpl;
@override @useResult
$Res call({
 String title, String author, String description, String isbn13, String? cover, String publisher,@JsonKey(name: 'itemPage') int itemPage, int? bookNo
});




}
/// @nodoc
class __$BookIsbnDetailEntityCopyWithImpl<$Res>
    implements _$BookIsbnDetailEntityCopyWith<$Res> {
  __$BookIsbnDetailEntityCopyWithImpl(this._self, this._then);

  final _BookIsbnDetailEntity _self;
  final $Res Function(_BookIsbnDetailEntity) _then;

/// Create a copy of BookIsbnDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? author = null,Object? description = null,Object? isbn13 = null,Object? cover = freezed,Object? publisher = null,Object? itemPage = null,Object? bookNo = freezed,}) {
  return _then(_BookIsbnDetailEntity(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isbn13: null == isbn13 ? _self.isbn13 : isbn13 // ignore: cast_nullable_to_non_nullable
as String,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,itemPage: null == itemPage ? _self.itemPage : itemPage // ignore: cast_nullable_to_non_nullable
as int,bookNo: freezed == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
