// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_read_input_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookReadInputEntity {

 int get bookNo; String get bookTitle; String get bookTree; int get bookPage; int get bookCurrentPage; List<Map<String, dynamic>> get bookReadList;
/// Create a copy of BookReadInputEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookReadInputEntityCopyWith<BookReadInputEntity> get copyWith => _$BookReadInputEntityCopyWithImpl<BookReadInputEntity>(this as BookReadInputEntity, _$identity);

  /// Serializes this BookReadInputEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookReadInputEntity&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookTree, bookTree) || other.bookTree == bookTree)&&(identical(other.bookPage, bookPage) || other.bookPage == bookPage)&&(identical(other.bookCurrentPage, bookCurrentPage) || other.bookCurrentPage == bookCurrentPage)&&const DeepCollectionEquality().equals(other.bookReadList, bookReadList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookNo,bookTitle,bookTree,bookPage,bookCurrentPage,const DeepCollectionEquality().hash(bookReadList));

@override
String toString() {
  return 'BookReadInputEntity(bookNo: $bookNo, bookTitle: $bookTitle, bookTree: $bookTree, bookPage: $bookPage, bookCurrentPage: $bookCurrentPage, bookReadList: $bookReadList)';
}


}

/// @nodoc
abstract mixin class $BookReadInputEntityCopyWith<$Res>  {
  factory $BookReadInputEntityCopyWith(BookReadInputEntity value, $Res Function(BookReadInputEntity) _then) = _$BookReadInputEntityCopyWithImpl;
@useResult
$Res call({
 int bookNo, String bookTitle, String bookTree, int bookPage, int bookCurrentPage, List<Map<String, dynamic>> bookReadList
});




}
/// @nodoc
class _$BookReadInputEntityCopyWithImpl<$Res>
    implements $BookReadInputEntityCopyWith<$Res> {
  _$BookReadInputEntityCopyWithImpl(this._self, this._then);

  final BookReadInputEntity _self;
  final $Res Function(BookReadInputEntity) _then;

/// Create a copy of BookReadInputEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookNo = null,Object? bookTitle = null,Object? bookTree = null,Object? bookPage = null,Object? bookCurrentPage = null,Object? bookReadList = null,}) {
  return _then(_self.copyWith(
bookNo: null == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookTree: null == bookTree ? _self.bookTree : bookTree // ignore: cast_nullable_to_non_nullable
as String,bookPage: null == bookPage ? _self.bookPage : bookPage // ignore: cast_nullable_to_non_nullable
as int,bookCurrentPage: null == bookCurrentPage ? _self.bookCurrentPage : bookCurrentPage // ignore: cast_nullable_to_non_nullable
as int,bookReadList: null == bookReadList ? _self.bookReadList : bookReadList // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}

}


/// Adds pattern-matching-related methods to [BookReadInputEntity].
extension BookReadInputEntityPatterns on BookReadInputEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookReadInputEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookReadInputEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookReadInputEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookReadInputEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookReadInputEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookReadInputEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int bookNo,  String bookTitle,  String bookTree,  int bookPage,  int bookCurrentPage,  List<Map<String, dynamic>> bookReadList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookReadInputEntity() when $default != null:
return $default(_that.bookNo,_that.bookTitle,_that.bookTree,_that.bookPage,_that.bookCurrentPage,_that.bookReadList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int bookNo,  String bookTitle,  String bookTree,  int bookPage,  int bookCurrentPage,  List<Map<String, dynamic>> bookReadList)  $default,) {final _that = this;
switch (_that) {
case _BookReadInputEntity():
return $default(_that.bookNo,_that.bookTitle,_that.bookTree,_that.bookPage,_that.bookCurrentPage,_that.bookReadList);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int bookNo,  String bookTitle,  String bookTree,  int bookPage,  int bookCurrentPage,  List<Map<String, dynamic>> bookReadList)?  $default,) {final _that = this;
switch (_that) {
case _BookReadInputEntity() when $default != null:
return $default(_that.bookNo,_that.bookTitle,_that.bookTree,_that.bookPage,_that.bookCurrentPage,_that.bookReadList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookReadInputEntity implements BookReadInputEntity {
  const _BookReadInputEntity({required this.bookNo, required this.bookTitle, required this.bookTree, required this.bookPage, required this.bookCurrentPage, required final  List<Map<String, dynamic>> bookReadList}): _bookReadList = bookReadList;
  factory _BookReadInputEntity.fromJson(Map<String, dynamic> json) => _$BookReadInputEntityFromJson(json);

@override final  int bookNo;
@override final  String bookTitle;
@override final  String bookTree;
@override final  int bookPage;
@override final  int bookCurrentPage;
 final  List<Map<String, dynamic>> _bookReadList;
@override List<Map<String, dynamic>> get bookReadList {
  if (_bookReadList is EqualUnmodifiableListView) return _bookReadList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookReadList);
}


/// Create a copy of BookReadInputEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookReadInputEntityCopyWith<_BookReadInputEntity> get copyWith => __$BookReadInputEntityCopyWithImpl<_BookReadInputEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookReadInputEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookReadInputEntity&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookTree, bookTree) || other.bookTree == bookTree)&&(identical(other.bookPage, bookPage) || other.bookPage == bookPage)&&(identical(other.bookCurrentPage, bookCurrentPage) || other.bookCurrentPage == bookCurrentPage)&&const DeepCollectionEquality().equals(other._bookReadList, _bookReadList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookNo,bookTitle,bookTree,bookPage,bookCurrentPage,const DeepCollectionEquality().hash(_bookReadList));

@override
String toString() {
  return 'BookReadInputEntity(bookNo: $bookNo, bookTitle: $bookTitle, bookTree: $bookTree, bookPage: $bookPage, bookCurrentPage: $bookCurrentPage, bookReadList: $bookReadList)';
}


}

/// @nodoc
abstract mixin class _$BookReadInputEntityCopyWith<$Res> implements $BookReadInputEntityCopyWith<$Res> {
  factory _$BookReadInputEntityCopyWith(_BookReadInputEntity value, $Res Function(_BookReadInputEntity) _then) = __$BookReadInputEntityCopyWithImpl;
@override @useResult
$Res call({
 int bookNo, String bookTitle, String bookTree, int bookPage, int bookCurrentPage, List<Map<String, dynamic>> bookReadList
});




}
/// @nodoc
class __$BookReadInputEntityCopyWithImpl<$Res>
    implements _$BookReadInputEntityCopyWith<$Res> {
  __$BookReadInputEntityCopyWithImpl(this._self, this._then);

  final _BookReadInputEntity _self;
  final $Res Function(_BookReadInputEntity) _then;

/// Create a copy of BookReadInputEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookNo = null,Object? bookTitle = null,Object? bookTree = null,Object? bookPage = null,Object? bookCurrentPage = null,Object? bookReadList = null,}) {
  return _then(_BookReadInputEntity(
bookNo: null == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookTree: null == bookTree ? _self.bookTree : bookTree // ignore: cast_nullable_to_non_nullable
as String,bookPage: null == bookPage ? _self.bookPage : bookPage // ignore: cast_nullable_to_non_nullable
as int,bookCurrentPage: null == bookCurrentPage ? _self.bookCurrentPage : bookCurrentPage // ignore: cast_nullable_to_non_nullable
as int,bookReadList: null == bookReadList ? _self._bookReadList : bookReadList // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}


}

// dart format on
