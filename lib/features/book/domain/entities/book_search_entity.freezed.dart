// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_search_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookSearchEntity {

 String get title; String get author; String get description; String get isbn13; String get cover; String get publisher;
/// Create a copy of BookSearchEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookSearchEntityCopyWith<BookSearchEntity> get copyWith => _$BookSearchEntityCopyWithImpl<BookSearchEntity>(this as BookSearchEntity, _$identity);

  /// Serializes this BookSearchEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookSearchEntity&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.description, description) || other.description == description)&&(identical(other.isbn13, isbn13) || other.isbn13 == isbn13)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.publisher, publisher) || other.publisher == publisher));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,author,description,isbn13,cover,publisher);

@override
String toString() {
  return 'BookSearchEntity(title: $title, author: $author, description: $description, isbn13: $isbn13, cover: $cover, publisher: $publisher)';
}


}

/// @nodoc
abstract mixin class $BookSearchEntityCopyWith<$Res>  {
  factory $BookSearchEntityCopyWith(BookSearchEntity value, $Res Function(BookSearchEntity) _then) = _$BookSearchEntityCopyWithImpl;
@useResult
$Res call({
 String title, String author, String description, String isbn13, String cover, String publisher
});




}
/// @nodoc
class _$BookSearchEntityCopyWithImpl<$Res>
    implements $BookSearchEntityCopyWith<$Res> {
  _$BookSearchEntityCopyWithImpl(this._self, this._then);

  final BookSearchEntity _self;
  final $Res Function(BookSearchEntity) _then;

/// Create a copy of BookSearchEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? author = null,Object? description = null,Object? isbn13 = null,Object? cover = null,Object? publisher = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isbn13: null == isbn13 ? _self.isbn13 : isbn13 // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BookSearchEntity].
extension BookSearchEntityPatterns on BookSearchEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookSearchEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookSearchEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookSearchEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookSearchEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookSearchEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookSearchEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String author,  String description,  String isbn13,  String cover,  String publisher)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookSearchEntity() when $default != null:
return $default(_that.title,_that.author,_that.description,_that.isbn13,_that.cover,_that.publisher);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String author,  String description,  String isbn13,  String cover,  String publisher)  $default,) {final _that = this;
switch (_that) {
case _BookSearchEntity():
return $default(_that.title,_that.author,_that.description,_that.isbn13,_that.cover,_that.publisher);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String author,  String description,  String isbn13,  String cover,  String publisher)?  $default,) {final _that = this;
switch (_that) {
case _BookSearchEntity() when $default != null:
return $default(_that.title,_that.author,_that.description,_that.isbn13,_that.cover,_that.publisher);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookSearchEntity implements BookSearchEntity {
  const _BookSearchEntity({required this.title, required this.author, required this.description, required this.isbn13, required this.cover, required this.publisher});
  factory _BookSearchEntity.fromJson(Map<String, dynamic> json) => _$BookSearchEntityFromJson(json);

@override final  String title;
@override final  String author;
@override final  String description;
@override final  String isbn13;
@override final  String cover;
@override final  String publisher;

/// Create a copy of BookSearchEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookSearchEntityCopyWith<_BookSearchEntity> get copyWith => __$BookSearchEntityCopyWithImpl<_BookSearchEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookSearchEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookSearchEntity&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.description, description) || other.description == description)&&(identical(other.isbn13, isbn13) || other.isbn13 == isbn13)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.publisher, publisher) || other.publisher == publisher));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,author,description,isbn13,cover,publisher);

@override
String toString() {
  return 'BookSearchEntity(title: $title, author: $author, description: $description, isbn13: $isbn13, cover: $cover, publisher: $publisher)';
}


}

/// @nodoc
abstract mixin class _$BookSearchEntityCopyWith<$Res> implements $BookSearchEntityCopyWith<$Res> {
  factory _$BookSearchEntityCopyWith(_BookSearchEntity value, $Res Function(_BookSearchEntity) _then) = __$BookSearchEntityCopyWithImpl;
@override @useResult
$Res call({
 String title, String author, String description, String isbn13, String cover, String publisher
});




}
/// @nodoc
class __$BookSearchEntityCopyWithImpl<$Res>
    implements _$BookSearchEntityCopyWith<$Res> {
  __$BookSearchEntityCopyWithImpl(this._self, this._then);

  final _BookSearchEntity _self;
  final $Res Function(_BookSearchEntity) _then;

/// Create a copy of BookSearchEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? author = null,Object? description = null,Object? isbn13 = null,Object? cover = null,Object? publisher = null,}) {
  return _then(_BookSearchEntity(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isbn13: null == isbn13 ? _self.isbn13 : isbn13 // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
