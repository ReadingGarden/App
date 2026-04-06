// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookshelf_book_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookshelfBookEntity {

 int get bookNo; String get bookTitle; String get bookAuthor; String get bookPublisher; String get bookInfo; String? get bookImageUrl; String? get bookTree; int get bookStatus; double get percent; int get bookPage; int? get gardenNo;
/// Create a copy of BookshelfBookEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookshelfBookEntityCopyWith<BookshelfBookEntity> get copyWith => _$BookshelfBookEntityCopyWithImpl<BookshelfBookEntity>(this as BookshelfBookEntity, _$identity);

  /// Serializes this BookshelfBookEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookshelfBookEntity&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookAuthor, bookAuthor) || other.bookAuthor == bookAuthor)&&(identical(other.bookPublisher, bookPublisher) || other.bookPublisher == bookPublisher)&&(identical(other.bookInfo, bookInfo) || other.bookInfo == bookInfo)&&(identical(other.bookImageUrl, bookImageUrl) || other.bookImageUrl == bookImageUrl)&&(identical(other.bookTree, bookTree) || other.bookTree == bookTree)&&(identical(other.bookStatus, bookStatus) || other.bookStatus == bookStatus)&&(identical(other.percent, percent) || other.percent == percent)&&(identical(other.bookPage, bookPage) || other.bookPage == bookPage)&&(identical(other.gardenNo, gardenNo) || other.gardenNo == gardenNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookNo,bookTitle,bookAuthor,bookPublisher,bookInfo,bookImageUrl,bookTree,bookStatus,percent,bookPage,gardenNo);

@override
String toString() {
  return 'BookshelfBookEntity(bookNo: $bookNo, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookPublisher: $bookPublisher, bookInfo: $bookInfo, bookImageUrl: $bookImageUrl, bookTree: $bookTree, bookStatus: $bookStatus, percent: $percent, bookPage: $bookPage, gardenNo: $gardenNo)';
}


}

/// @nodoc
abstract mixin class $BookshelfBookEntityCopyWith<$Res>  {
  factory $BookshelfBookEntityCopyWith(BookshelfBookEntity value, $Res Function(BookshelfBookEntity) _then) = _$BookshelfBookEntityCopyWithImpl;
@useResult
$Res call({
 int bookNo, String bookTitle, String bookAuthor, String bookPublisher, String bookInfo, String? bookImageUrl, String? bookTree, int bookStatus, double percent, int bookPage, int? gardenNo
});




}
/// @nodoc
class _$BookshelfBookEntityCopyWithImpl<$Res>
    implements $BookshelfBookEntityCopyWith<$Res> {
  _$BookshelfBookEntityCopyWithImpl(this._self, this._then);

  final BookshelfBookEntity _self;
  final $Res Function(BookshelfBookEntity) _then;

/// Create a copy of BookshelfBookEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookNo = null,Object? bookTitle = null,Object? bookAuthor = null,Object? bookPublisher = null,Object? bookInfo = null,Object? bookImageUrl = freezed,Object? bookTree = freezed,Object? bookStatus = null,Object? percent = null,Object? bookPage = null,Object? gardenNo = freezed,}) {
  return _then(_self.copyWith(
bookNo: null == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookAuthor: null == bookAuthor ? _self.bookAuthor : bookAuthor // ignore: cast_nullable_to_non_nullable
as String,bookPublisher: null == bookPublisher ? _self.bookPublisher : bookPublisher // ignore: cast_nullable_to_non_nullable
as String,bookInfo: null == bookInfo ? _self.bookInfo : bookInfo // ignore: cast_nullable_to_non_nullable
as String,bookImageUrl: freezed == bookImageUrl ? _self.bookImageUrl : bookImageUrl // ignore: cast_nullable_to_non_nullable
as String?,bookTree: freezed == bookTree ? _self.bookTree : bookTree // ignore: cast_nullable_to_non_nullable
as String?,bookStatus: null == bookStatus ? _self.bookStatus : bookStatus // ignore: cast_nullable_to_non_nullable
as int,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as double,bookPage: null == bookPage ? _self.bookPage : bookPage // ignore: cast_nullable_to_non_nullable
as int,gardenNo: freezed == gardenNo ? _self.gardenNo : gardenNo // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookshelfBookEntity].
extension BookshelfBookEntityPatterns on BookshelfBookEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookshelfBookEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookshelfBookEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookshelfBookEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookshelfBookEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookshelfBookEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookshelfBookEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int bookNo,  String bookTitle,  String bookAuthor,  String bookPublisher,  String bookInfo,  String? bookImageUrl,  String? bookTree,  int bookStatus,  double percent,  int bookPage,  int? gardenNo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookshelfBookEntity() when $default != null:
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookPublisher,_that.bookInfo,_that.bookImageUrl,_that.bookTree,_that.bookStatus,_that.percent,_that.bookPage,_that.gardenNo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int bookNo,  String bookTitle,  String bookAuthor,  String bookPublisher,  String bookInfo,  String? bookImageUrl,  String? bookTree,  int bookStatus,  double percent,  int bookPage,  int? gardenNo)  $default,) {final _that = this;
switch (_that) {
case _BookshelfBookEntity():
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookPublisher,_that.bookInfo,_that.bookImageUrl,_that.bookTree,_that.bookStatus,_that.percent,_that.bookPage,_that.gardenNo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int bookNo,  String bookTitle,  String bookAuthor,  String bookPublisher,  String bookInfo,  String? bookImageUrl,  String? bookTree,  int bookStatus,  double percent,  int bookPage,  int? gardenNo)?  $default,) {final _that = this;
switch (_that) {
case _BookshelfBookEntity() when $default != null:
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookPublisher,_that.bookInfo,_that.bookImageUrl,_that.bookTree,_that.bookStatus,_that.percent,_that.bookPage,_that.gardenNo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookshelfBookEntity implements BookshelfBookEntity {
  const _BookshelfBookEntity({this.bookNo = 0, this.bookTitle = '', this.bookAuthor = '', this.bookPublisher = '', this.bookInfo = '', this.bookImageUrl, this.bookTree, this.bookStatus = 0, this.percent = 0, this.bookPage = 0, this.gardenNo});
  factory _BookshelfBookEntity.fromJson(Map<String, dynamic> json) => _$BookshelfBookEntityFromJson(json);

@override@JsonKey() final  int bookNo;
@override@JsonKey() final  String bookTitle;
@override@JsonKey() final  String bookAuthor;
@override@JsonKey() final  String bookPublisher;
@override@JsonKey() final  String bookInfo;
@override final  String? bookImageUrl;
@override final  String? bookTree;
@override@JsonKey() final  int bookStatus;
@override@JsonKey() final  double percent;
@override@JsonKey() final  int bookPage;
@override final  int? gardenNo;

/// Create a copy of BookshelfBookEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookshelfBookEntityCopyWith<_BookshelfBookEntity> get copyWith => __$BookshelfBookEntityCopyWithImpl<_BookshelfBookEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookshelfBookEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookshelfBookEntity&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookAuthor, bookAuthor) || other.bookAuthor == bookAuthor)&&(identical(other.bookPublisher, bookPublisher) || other.bookPublisher == bookPublisher)&&(identical(other.bookInfo, bookInfo) || other.bookInfo == bookInfo)&&(identical(other.bookImageUrl, bookImageUrl) || other.bookImageUrl == bookImageUrl)&&(identical(other.bookTree, bookTree) || other.bookTree == bookTree)&&(identical(other.bookStatus, bookStatus) || other.bookStatus == bookStatus)&&(identical(other.percent, percent) || other.percent == percent)&&(identical(other.bookPage, bookPage) || other.bookPage == bookPage)&&(identical(other.gardenNo, gardenNo) || other.gardenNo == gardenNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookNo,bookTitle,bookAuthor,bookPublisher,bookInfo,bookImageUrl,bookTree,bookStatus,percent,bookPage,gardenNo);

@override
String toString() {
  return 'BookshelfBookEntity(bookNo: $bookNo, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookPublisher: $bookPublisher, bookInfo: $bookInfo, bookImageUrl: $bookImageUrl, bookTree: $bookTree, bookStatus: $bookStatus, percent: $percent, bookPage: $bookPage, gardenNo: $gardenNo)';
}


}

/// @nodoc
abstract mixin class _$BookshelfBookEntityCopyWith<$Res> implements $BookshelfBookEntityCopyWith<$Res> {
  factory _$BookshelfBookEntityCopyWith(_BookshelfBookEntity value, $Res Function(_BookshelfBookEntity) _then) = __$BookshelfBookEntityCopyWithImpl;
@override @useResult
$Res call({
 int bookNo, String bookTitle, String bookAuthor, String bookPublisher, String bookInfo, String? bookImageUrl, String? bookTree, int bookStatus, double percent, int bookPage, int? gardenNo
});




}
/// @nodoc
class __$BookshelfBookEntityCopyWithImpl<$Res>
    implements _$BookshelfBookEntityCopyWith<$Res> {
  __$BookshelfBookEntityCopyWithImpl(this._self, this._then);

  final _BookshelfBookEntity _self;
  final $Res Function(_BookshelfBookEntity) _then;

/// Create a copy of BookshelfBookEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookNo = null,Object? bookTitle = null,Object? bookAuthor = null,Object? bookPublisher = null,Object? bookInfo = null,Object? bookImageUrl = freezed,Object? bookTree = freezed,Object? bookStatus = null,Object? percent = null,Object? bookPage = null,Object? gardenNo = freezed,}) {
  return _then(_BookshelfBookEntity(
bookNo: null == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookAuthor: null == bookAuthor ? _self.bookAuthor : bookAuthor // ignore: cast_nullable_to_non_nullable
as String,bookPublisher: null == bookPublisher ? _self.bookPublisher : bookPublisher // ignore: cast_nullable_to_non_nullable
as String,bookInfo: null == bookInfo ? _self.bookInfo : bookInfo // ignore: cast_nullable_to_non_nullable
as String,bookImageUrl: freezed == bookImageUrl ? _self.bookImageUrl : bookImageUrl // ignore: cast_nullable_to_non_nullable
as String?,bookTree: freezed == bookTree ? _self.bookTree : bookTree // ignore: cast_nullable_to_non_nullable
as String?,bookStatus: null == bookStatus ? _self.bookStatus : bookStatus // ignore: cast_nullable_to_non_nullable
as int,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as double,bookPage: null == bookPage ? _self.bookPage : bookPage // ignore: cast_nullable_to_non_nullable
as int,gardenNo: freezed == gardenNo ? _self.gardenNo : gardenNo // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
