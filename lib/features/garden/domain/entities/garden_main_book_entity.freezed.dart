// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'garden_main_book_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GardenMainBookEntity {

 int get bookNo; String get bookTitle; String get bookAuthor; String get bookImageUrl; String get bookTree; double get percent; int get userNo;
/// Create a copy of GardenMainBookEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GardenMainBookEntityCopyWith<GardenMainBookEntity> get copyWith => _$GardenMainBookEntityCopyWithImpl<GardenMainBookEntity>(this as GardenMainBookEntity, _$identity);

  /// Serializes this GardenMainBookEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GardenMainBookEntity&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookAuthor, bookAuthor) || other.bookAuthor == bookAuthor)&&(identical(other.bookImageUrl, bookImageUrl) || other.bookImageUrl == bookImageUrl)&&(identical(other.bookTree, bookTree) || other.bookTree == bookTree)&&(identical(other.percent, percent) || other.percent == percent)&&(identical(other.userNo, userNo) || other.userNo == userNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookNo,bookTitle,bookAuthor,bookImageUrl,bookTree,percent,userNo);

@override
String toString() {
  return 'GardenMainBookEntity(bookNo: $bookNo, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookImageUrl: $bookImageUrl, bookTree: $bookTree, percent: $percent, userNo: $userNo)';
}


}

/// @nodoc
abstract mixin class $GardenMainBookEntityCopyWith<$Res>  {
  factory $GardenMainBookEntityCopyWith(GardenMainBookEntity value, $Res Function(GardenMainBookEntity) _then) = _$GardenMainBookEntityCopyWithImpl;
@useResult
$Res call({
 int bookNo, String bookTitle, String bookAuthor, String bookImageUrl, String bookTree, double percent, int userNo
});




}
/// @nodoc
class _$GardenMainBookEntityCopyWithImpl<$Res>
    implements $GardenMainBookEntityCopyWith<$Res> {
  _$GardenMainBookEntityCopyWithImpl(this._self, this._then);

  final GardenMainBookEntity _self;
  final $Res Function(GardenMainBookEntity) _then;

/// Create a copy of GardenMainBookEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookNo = null,Object? bookTitle = null,Object? bookAuthor = null,Object? bookImageUrl = null,Object? bookTree = null,Object? percent = null,Object? userNo = null,}) {
  return _then(_self.copyWith(
bookNo: null == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookAuthor: null == bookAuthor ? _self.bookAuthor : bookAuthor // ignore: cast_nullable_to_non_nullable
as String,bookImageUrl: null == bookImageUrl ? _self.bookImageUrl : bookImageUrl // ignore: cast_nullable_to_non_nullable
as String,bookTree: null == bookTree ? _self.bookTree : bookTree // ignore: cast_nullable_to_non_nullable
as String,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as double,userNo: null == userNo ? _self.userNo : userNo // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GardenMainBookEntity].
extension GardenMainBookEntityPatterns on GardenMainBookEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GardenMainBookEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GardenMainBookEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GardenMainBookEntity value)  $default,){
final _that = this;
switch (_that) {
case _GardenMainBookEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GardenMainBookEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GardenMainBookEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int bookNo,  String bookTitle,  String bookAuthor,  String bookImageUrl,  String bookTree,  double percent,  int userNo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GardenMainBookEntity() when $default != null:
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.bookTree,_that.percent,_that.userNo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int bookNo,  String bookTitle,  String bookAuthor,  String bookImageUrl,  String bookTree,  double percent,  int userNo)  $default,) {final _that = this;
switch (_that) {
case _GardenMainBookEntity():
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.bookTree,_that.percent,_that.userNo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int bookNo,  String bookTitle,  String bookAuthor,  String bookImageUrl,  String bookTree,  double percent,  int userNo)?  $default,) {final _that = this;
switch (_that) {
case _GardenMainBookEntity() when $default != null:
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.bookTree,_that.percent,_that.userNo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GardenMainBookEntity implements GardenMainBookEntity {
  const _GardenMainBookEntity({this.bookNo = 0, this.bookTitle = '', this.bookAuthor = '', this.bookImageUrl = '', this.bookTree = '', this.percent = 0, this.userNo = 0});
  factory _GardenMainBookEntity.fromJson(Map<String, dynamic> json) => _$GardenMainBookEntityFromJson(json);

@override@JsonKey() final  int bookNo;
@override@JsonKey() final  String bookTitle;
@override@JsonKey() final  String bookAuthor;
@override@JsonKey() final  String bookImageUrl;
@override@JsonKey() final  String bookTree;
@override@JsonKey() final  double percent;
@override@JsonKey() final  int userNo;

/// Create a copy of GardenMainBookEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GardenMainBookEntityCopyWith<_GardenMainBookEntity> get copyWith => __$GardenMainBookEntityCopyWithImpl<_GardenMainBookEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GardenMainBookEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GardenMainBookEntity&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookAuthor, bookAuthor) || other.bookAuthor == bookAuthor)&&(identical(other.bookImageUrl, bookImageUrl) || other.bookImageUrl == bookImageUrl)&&(identical(other.bookTree, bookTree) || other.bookTree == bookTree)&&(identical(other.percent, percent) || other.percent == percent)&&(identical(other.userNo, userNo) || other.userNo == userNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookNo,bookTitle,bookAuthor,bookImageUrl,bookTree,percent,userNo);

@override
String toString() {
  return 'GardenMainBookEntity(bookNo: $bookNo, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookImageUrl: $bookImageUrl, bookTree: $bookTree, percent: $percent, userNo: $userNo)';
}


}

/// @nodoc
abstract mixin class _$GardenMainBookEntityCopyWith<$Res> implements $GardenMainBookEntityCopyWith<$Res> {
  factory _$GardenMainBookEntityCopyWith(_GardenMainBookEntity value, $Res Function(_GardenMainBookEntity) _then) = __$GardenMainBookEntityCopyWithImpl;
@override @useResult
$Res call({
 int bookNo, String bookTitle, String bookAuthor, String bookImageUrl, String bookTree, double percent, int userNo
});




}
/// @nodoc
class __$GardenMainBookEntityCopyWithImpl<$Res>
    implements _$GardenMainBookEntityCopyWith<$Res> {
  __$GardenMainBookEntityCopyWithImpl(this._self, this._then);

  final _GardenMainBookEntity _self;
  final $Res Function(_GardenMainBookEntity) _then;

/// Create a copy of GardenMainBookEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookNo = null,Object? bookTitle = null,Object? bookAuthor = null,Object? bookImageUrl = null,Object? bookTree = null,Object? percent = null,Object? userNo = null,}) {
  return _then(_GardenMainBookEntity(
bookNo: null == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookAuthor: null == bookAuthor ? _self.bookAuthor : bookAuthor // ignore: cast_nullable_to_non_nullable
as String,bookImageUrl: null == bookImageUrl ? _self.bookImageUrl : bookImageUrl // ignore: cast_nullable_to_non_nullable
as String,bookTree: null == bookTree ? _self.bookTree : bookTree // ignore: cast_nullable_to_non_nullable
as String,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as double,userNo: null == userNo ? _self.userNo : userNo // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
