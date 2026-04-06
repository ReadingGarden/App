// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_detail_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookDetailEntity {

 int? get bookNo; int? get userNo; int? get gardenNo; String get gardenTitle; String get gardenColor; int get bookStatus; String get bookTitle; String get bookAuthor; String get bookPublisher; String get bookInfo; String? get bookImageUrl; String get bookTree; int get bookCurrentPage; int get bookPage; List<BookReadHistoryEntity> get bookReadList; List<BookMemoSummaryEntity> get memoList;
/// Create a copy of BookDetailEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookDetailEntityCopyWith<BookDetailEntity> get copyWith => _$BookDetailEntityCopyWithImpl<BookDetailEntity>(this as BookDetailEntity, _$identity);

  /// Serializes this BookDetailEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookDetailEntity&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.userNo, userNo) || other.userNo == userNo)&&(identical(other.gardenNo, gardenNo) || other.gardenNo == gardenNo)&&(identical(other.gardenTitle, gardenTitle) || other.gardenTitle == gardenTitle)&&(identical(other.gardenColor, gardenColor) || other.gardenColor == gardenColor)&&(identical(other.bookStatus, bookStatus) || other.bookStatus == bookStatus)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookAuthor, bookAuthor) || other.bookAuthor == bookAuthor)&&(identical(other.bookPublisher, bookPublisher) || other.bookPublisher == bookPublisher)&&(identical(other.bookInfo, bookInfo) || other.bookInfo == bookInfo)&&(identical(other.bookImageUrl, bookImageUrl) || other.bookImageUrl == bookImageUrl)&&(identical(other.bookTree, bookTree) || other.bookTree == bookTree)&&(identical(other.bookCurrentPage, bookCurrentPage) || other.bookCurrentPage == bookCurrentPage)&&(identical(other.bookPage, bookPage) || other.bookPage == bookPage)&&const DeepCollectionEquality().equals(other.bookReadList, bookReadList)&&const DeepCollectionEquality().equals(other.memoList, memoList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookNo,userNo,gardenNo,gardenTitle,gardenColor,bookStatus,bookTitle,bookAuthor,bookPublisher,bookInfo,bookImageUrl,bookTree,bookCurrentPage,bookPage,const DeepCollectionEquality().hash(bookReadList),const DeepCollectionEquality().hash(memoList));

@override
String toString() {
  return 'BookDetailEntity(bookNo: $bookNo, userNo: $userNo, gardenNo: $gardenNo, gardenTitle: $gardenTitle, gardenColor: $gardenColor, bookStatus: $bookStatus, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookPublisher: $bookPublisher, bookInfo: $bookInfo, bookImageUrl: $bookImageUrl, bookTree: $bookTree, bookCurrentPage: $bookCurrentPage, bookPage: $bookPage, bookReadList: $bookReadList, memoList: $memoList)';
}


}

/// @nodoc
abstract mixin class $BookDetailEntityCopyWith<$Res>  {
  factory $BookDetailEntityCopyWith(BookDetailEntity value, $Res Function(BookDetailEntity) _then) = _$BookDetailEntityCopyWithImpl;
@useResult
$Res call({
 int? bookNo, int? userNo, int? gardenNo, String gardenTitle, String gardenColor, int bookStatus, String bookTitle, String bookAuthor, String bookPublisher, String bookInfo, String? bookImageUrl, String bookTree, int bookCurrentPage, int bookPage, List<BookReadHistoryEntity> bookReadList, List<BookMemoSummaryEntity> memoList
});




}
/// @nodoc
class _$BookDetailEntityCopyWithImpl<$Res>
    implements $BookDetailEntityCopyWith<$Res> {
  _$BookDetailEntityCopyWithImpl(this._self, this._then);

  final BookDetailEntity _self;
  final $Res Function(BookDetailEntity) _then;

/// Create a copy of BookDetailEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookNo = freezed,Object? userNo = freezed,Object? gardenNo = freezed,Object? gardenTitle = null,Object? gardenColor = null,Object? bookStatus = null,Object? bookTitle = null,Object? bookAuthor = null,Object? bookPublisher = null,Object? bookInfo = null,Object? bookImageUrl = freezed,Object? bookTree = null,Object? bookCurrentPage = null,Object? bookPage = null,Object? bookReadList = null,Object? memoList = null,}) {
  return _then(_self.copyWith(
bookNo: freezed == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int?,userNo: freezed == userNo ? _self.userNo : userNo // ignore: cast_nullable_to_non_nullable
as int?,gardenNo: freezed == gardenNo ? _self.gardenNo : gardenNo // ignore: cast_nullable_to_non_nullable
as int?,gardenTitle: null == gardenTitle ? _self.gardenTitle : gardenTitle // ignore: cast_nullable_to_non_nullable
as String,gardenColor: null == gardenColor ? _self.gardenColor : gardenColor // ignore: cast_nullable_to_non_nullable
as String,bookStatus: null == bookStatus ? _self.bookStatus : bookStatus // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookAuthor: null == bookAuthor ? _self.bookAuthor : bookAuthor // ignore: cast_nullable_to_non_nullable
as String,bookPublisher: null == bookPublisher ? _self.bookPublisher : bookPublisher // ignore: cast_nullable_to_non_nullable
as String,bookInfo: null == bookInfo ? _self.bookInfo : bookInfo // ignore: cast_nullable_to_non_nullable
as String,bookImageUrl: freezed == bookImageUrl ? _self.bookImageUrl : bookImageUrl // ignore: cast_nullable_to_non_nullable
as String?,bookTree: null == bookTree ? _self.bookTree : bookTree // ignore: cast_nullable_to_non_nullable
as String,bookCurrentPage: null == bookCurrentPage ? _self.bookCurrentPage : bookCurrentPage // ignore: cast_nullable_to_non_nullable
as int,bookPage: null == bookPage ? _self.bookPage : bookPage // ignore: cast_nullable_to_non_nullable
as int,bookReadList: null == bookReadList ? _self.bookReadList : bookReadList // ignore: cast_nullable_to_non_nullable
as List<BookReadHistoryEntity>,memoList: null == memoList ? _self.memoList : memoList // ignore: cast_nullable_to_non_nullable
as List<BookMemoSummaryEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [BookDetailEntity].
extension BookDetailEntityPatterns on BookDetailEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookDetailEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookDetailEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookDetailEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookDetailEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookDetailEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookDetailEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? bookNo,  int? userNo,  int? gardenNo,  String gardenTitle,  String gardenColor,  int bookStatus,  String bookTitle,  String bookAuthor,  String bookPublisher,  String bookInfo,  String? bookImageUrl,  String bookTree,  int bookCurrentPage,  int bookPage,  List<BookReadHistoryEntity> bookReadList,  List<BookMemoSummaryEntity> memoList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookDetailEntity() when $default != null:
return $default(_that.bookNo,_that.userNo,_that.gardenNo,_that.gardenTitle,_that.gardenColor,_that.bookStatus,_that.bookTitle,_that.bookAuthor,_that.bookPublisher,_that.bookInfo,_that.bookImageUrl,_that.bookTree,_that.bookCurrentPage,_that.bookPage,_that.bookReadList,_that.memoList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? bookNo,  int? userNo,  int? gardenNo,  String gardenTitle,  String gardenColor,  int bookStatus,  String bookTitle,  String bookAuthor,  String bookPublisher,  String bookInfo,  String? bookImageUrl,  String bookTree,  int bookCurrentPage,  int bookPage,  List<BookReadHistoryEntity> bookReadList,  List<BookMemoSummaryEntity> memoList)  $default,) {final _that = this;
switch (_that) {
case _BookDetailEntity():
return $default(_that.bookNo,_that.userNo,_that.gardenNo,_that.gardenTitle,_that.gardenColor,_that.bookStatus,_that.bookTitle,_that.bookAuthor,_that.bookPublisher,_that.bookInfo,_that.bookImageUrl,_that.bookTree,_that.bookCurrentPage,_that.bookPage,_that.bookReadList,_that.memoList);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? bookNo,  int? userNo,  int? gardenNo,  String gardenTitle,  String gardenColor,  int bookStatus,  String bookTitle,  String bookAuthor,  String bookPublisher,  String bookInfo,  String? bookImageUrl,  String bookTree,  int bookCurrentPage,  int bookPage,  List<BookReadHistoryEntity> bookReadList,  List<BookMemoSummaryEntity> memoList)?  $default,) {final _that = this;
switch (_that) {
case _BookDetailEntity() when $default != null:
return $default(_that.bookNo,_that.userNo,_that.gardenNo,_that.gardenTitle,_that.gardenColor,_that.bookStatus,_that.bookTitle,_that.bookAuthor,_that.bookPublisher,_that.bookInfo,_that.bookImageUrl,_that.bookTree,_that.bookCurrentPage,_that.bookPage,_that.bookReadList,_that.memoList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookDetailEntity extends BookDetailEntity {
  const _BookDetailEntity({required this.bookNo, required this.userNo, required this.gardenNo, required this.gardenTitle, required this.gardenColor, required this.bookStatus, required this.bookTitle, required this.bookAuthor, required this.bookPublisher, required this.bookInfo, required this.bookImageUrl, required this.bookTree, required this.bookCurrentPage, required this.bookPage, required final  List<BookReadHistoryEntity> bookReadList, required final  List<BookMemoSummaryEntity> memoList}): _bookReadList = bookReadList,_memoList = memoList,super._();
  factory _BookDetailEntity.fromJson(Map<String, dynamic> json) => _$BookDetailEntityFromJson(json);

@override final  int? bookNo;
@override final  int? userNo;
@override final  int? gardenNo;
@override final  String gardenTitle;
@override final  String gardenColor;
@override final  int bookStatus;
@override final  String bookTitle;
@override final  String bookAuthor;
@override final  String bookPublisher;
@override final  String bookInfo;
@override final  String? bookImageUrl;
@override final  String bookTree;
@override final  int bookCurrentPage;
@override final  int bookPage;
 final  List<BookReadHistoryEntity> _bookReadList;
@override List<BookReadHistoryEntity> get bookReadList {
  if (_bookReadList is EqualUnmodifiableListView) return _bookReadList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookReadList);
}

 final  List<BookMemoSummaryEntity> _memoList;
@override List<BookMemoSummaryEntity> get memoList {
  if (_memoList is EqualUnmodifiableListView) return _memoList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memoList);
}


/// Create a copy of BookDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookDetailEntityCopyWith<_BookDetailEntity> get copyWith => __$BookDetailEntityCopyWithImpl<_BookDetailEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookDetailEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookDetailEntity&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.userNo, userNo) || other.userNo == userNo)&&(identical(other.gardenNo, gardenNo) || other.gardenNo == gardenNo)&&(identical(other.gardenTitle, gardenTitle) || other.gardenTitle == gardenTitle)&&(identical(other.gardenColor, gardenColor) || other.gardenColor == gardenColor)&&(identical(other.bookStatus, bookStatus) || other.bookStatus == bookStatus)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookAuthor, bookAuthor) || other.bookAuthor == bookAuthor)&&(identical(other.bookPublisher, bookPublisher) || other.bookPublisher == bookPublisher)&&(identical(other.bookInfo, bookInfo) || other.bookInfo == bookInfo)&&(identical(other.bookImageUrl, bookImageUrl) || other.bookImageUrl == bookImageUrl)&&(identical(other.bookTree, bookTree) || other.bookTree == bookTree)&&(identical(other.bookCurrentPage, bookCurrentPage) || other.bookCurrentPage == bookCurrentPage)&&(identical(other.bookPage, bookPage) || other.bookPage == bookPage)&&const DeepCollectionEquality().equals(other._bookReadList, _bookReadList)&&const DeepCollectionEquality().equals(other._memoList, _memoList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookNo,userNo,gardenNo,gardenTitle,gardenColor,bookStatus,bookTitle,bookAuthor,bookPublisher,bookInfo,bookImageUrl,bookTree,bookCurrentPage,bookPage,const DeepCollectionEquality().hash(_bookReadList),const DeepCollectionEquality().hash(_memoList));

@override
String toString() {
  return 'BookDetailEntity(bookNo: $bookNo, userNo: $userNo, gardenNo: $gardenNo, gardenTitle: $gardenTitle, gardenColor: $gardenColor, bookStatus: $bookStatus, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookPublisher: $bookPublisher, bookInfo: $bookInfo, bookImageUrl: $bookImageUrl, bookTree: $bookTree, bookCurrentPage: $bookCurrentPage, bookPage: $bookPage, bookReadList: $bookReadList, memoList: $memoList)';
}


}

/// @nodoc
abstract mixin class _$BookDetailEntityCopyWith<$Res> implements $BookDetailEntityCopyWith<$Res> {
  factory _$BookDetailEntityCopyWith(_BookDetailEntity value, $Res Function(_BookDetailEntity) _then) = __$BookDetailEntityCopyWithImpl;
@override @useResult
$Res call({
 int? bookNo, int? userNo, int? gardenNo, String gardenTitle, String gardenColor, int bookStatus, String bookTitle, String bookAuthor, String bookPublisher, String bookInfo, String? bookImageUrl, String bookTree, int bookCurrentPage, int bookPage, List<BookReadHistoryEntity> bookReadList, List<BookMemoSummaryEntity> memoList
});




}
/// @nodoc
class __$BookDetailEntityCopyWithImpl<$Res>
    implements _$BookDetailEntityCopyWith<$Res> {
  __$BookDetailEntityCopyWithImpl(this._self, this._then);

  final _BookDetailEntity _self;
  final $Res Function(_BookDetailEntity) _then;

/// Create a copy of BookDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookNo = freezed,Object? userNo = freezed,Object? gardenNo = freezed,Object? gardenTitle = null,Object? gardenColor = null,Object? bookStatus = null,Object? bookTitle = null,Object? bookAuthor = null,Object? bookPublisher = null,Object? bookInfo = null,Object? bookImageUrl = freezed,Object? bookTree = null,Object? bookCurrentPage = null,Object? bookPage = null,Object? bookReadList = null,Object? memoList = null,}) {
  return _then(_BookDetailEntity(
bookNo: freezed == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int?,userNo: freezed == userNo ? _self.userNo : userNo // ignore: cast_nullable_to_non_nullable
as int?,gardenNo: freezed == gardenNo ? _self.gardenNo : gardenNo // ignore: cast_nullable_to_non_nullable
as int?,gardenTitle: null == gardenTitle ? _self.gardenTitle : gardenTitle // ignore: cast_nullable_to_non_nullable
as String,gardenColor: null == gardenColor ? _self.gardenColor : gardenColor // ignore: cast_nullable_to_non_nullable
as String,bookStatus: null == bookStatus ? _self.bookStatus : bookStatus // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookAuthor: null == bookAuthor ? _self.bookAuthor : bookAuthor // ignore: cast_nullable_to_non_nullable
as String,bookPublisher: null == bookPublisher ? _self.bookPublisher : bookPublisher // ignore: cast_nullable_to_non_nullable
as String,bookInfo: null == bookInfo ? _self.bookInfo : bookInfo // ignore: cast_nullable_to_non_nullable
as String,bookImageUrl: freezed == bookImageUrl ? _self.bookImageUrl : bookImageUrl // ignore: cast_nullable_to_non_nullable
as String?,bookTree: null == bookTree ? _self.bookTree : bookTree // ignore: cast_nullable_to_non_nullable
as String,bookCurrentPage: null == bookCurrentPage ? _self.bookCurrentPage : bookCurrentPage // ignore: cast_nullable_to_non_nullable
as int,bookPage: null == bookPage ? _self.bookPage : bookPage // ignore: cast_nullable_to_non_nullable
as int,bookReadList: null == bookReadList ? _self._bookReadList : bookReadList // ignore: cast_nullable_to_non_nullable
as List<BookReadHistoryEntity>,memoList: null == memoList ? _self._memoList : memoList // ignore: cast_nullable_to_non_nullable
as List<BookMemoSummaryEntity>,
  ));
}


}

// dart format on
