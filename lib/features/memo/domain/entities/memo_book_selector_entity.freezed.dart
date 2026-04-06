// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memo_book_selector_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemoBookSelectorEntity {

 int get bookNo; String get bookTitle; String get bookAuthor; String? get bookImageUrl; int? get gardenNo;
/// Create a copy of MemoBookSelectorEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemoBookSelectorEntityCopyWith<MemoBookSelectorEntity> get copyWith => _$MemoBookSelectorEntityCopyWithImpl<MemoBookSelectorEntity>(this as MemoBookSelectorEntity, _$identity);

  /// Serializes this MemoBookSelectorEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoBookSelectorEntity&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookAuthor, bookAuthor) || other.bookAuthor == bookAuthor)&&(identical(other.bookImageUrl, bookImageUrl) || other.bookImageUrl == bookImageUrl)&&(identical(other.gardenNo, gardenNo) || other.gardenNo == gardenNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookNo,bookTitle,bookAuthor,bookImageUrl,gardenNo);

@override
String toString() {
  return 'MemoBookSelectorEntity(bookNo: $bookNo, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookImageUrl: $bookImageUrl, gardenNo: $gardenNo)';
}


}

/// @nodoc
abstract mixin class $MemoBookSelectorEntityCopyWith<$Res>  {
  factory $MemoBookSelectorEntityCopyWith(MemoBookSelectorEntity value, $Res Function(MemoBookSelectorEntity) _then) = _$MemoBookSelectorEntityCopyWithImpl;
@useResult
$Res call({
 int bookNo, String bookTitle, String bookAuthor, String? bookImageUrl, int? gardenNo
});




}
/// @nodoc
class _$MemoBookSelectorEntityCopyWithImpl<$Res>
    implements $MemoBookSelectorEntityCopyWith<$Res> {
  _$MemoBookSelectorEntityCopyWithImpl(this._self, this._then);

  final MemoBookSelectorEntity _self;
  final $Res Function(MemoBookSelectorEntity) _then;

/// Create a copy of MemoBookSelectorEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookNo = null,Object? bookTitle = null,Object? bookAuthor = null,Object? bookImageUrl = freezed,Object? gardenNo = freezed,}) {
  return _then(_self.copyWith(
bookNo: null == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookAuthor: null == bookAuthor ? _self.bookAuthor : bookAuthor // ignore: cast_nullable_to_non_nullable
as String,bookImageUrl: freezed == bookImageUrl ? _self.bookImageUrl : bookImageUrl // ignore: cast_nullable_to_non_nullable
as String?,gardenNo: freezed == gardenNo ? _self.gardenNo : gardenNo // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MemoBookSelectorEntity].
extension MemoBookSelectorEntityPatterns on MemoBookSelectorEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemoBookSelectorEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemoBookSelectorEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemoBookSelectorEntity value)  $default,){
final _that = this;
switch (_that) {
case _MemoBookSelectorEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemoBookSelectorEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MemoBookSelectorEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int bookNo,  String bookTitle,  String bookAuthor,  String? bookImageUrl,  int? gardenNo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemoBookSelectorEntity() when $default != null:
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.gardenNo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int bookNo,  String bookTitle,  String bookAuthor,  String? bookImageUrl,  int? gardenNo)  $default,) {final _that = this;
switch (_that) {
case _MemoBookSelectorEntity():
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.gardenNo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int bookNo,  String bookTitle,  String bookAuthor,  String? bookImageUrl,  int? gardenNo)?  $default,) {final _that = this;
switch (_that) {
case _MemoBookSelectorEntity() when $default != null:
return $default(_that.bookNo,_that.bookTitle,_that.bookAuthor,_that.bookImageUrl,_that.gardenNo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemoBookSelectorEntity extends MemoBookSelectorEntity {
  const _MemoBookSelectorEntity({required this.bookNo, required this.bookTitle, required this.bookAuthor, required this.bookImageUrl, required this.gardenNo}): super._();
  factory _MemoBookSelectorEntity.fromJson(Map<String, dynamic> json) => _$MemoBookSelectorEntityFromJson(json);

@override final  int bookNo;
@override final  String bookTitle;
@override final  String bookAuthor;
@override final  String? bookImageUrl;
@override final  int? gardenNo;

/// Create a copy of MemoBookSelectorEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemoBookSelectorEntityCopyWith<_MemoBookSelectorEntity> get copyWith => __$MemoBookSelectorEntityCopyWithImpl<_MemoBookSelectorEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemoBookSelectorEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemoBookSelectorEntity&&(identical(other.bookNo, bookNo) || other.bookNo == bookNo)&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookAuthor, bookAuthor) || other.bookAuthor == bookAuthor)&&(identical(other.bookImageUrl, bookImageUrl) || other.bookImageUrl == bookImageUrl)&&(identical(other.gardenNo, gardenNo) || other.gardenNo == gardenNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookNo,bookTitle,bookAuthor,bookImageUrl,gardenNo);

@override
String toString() {
  return 'MemoBookSelectorEntity(bookNo: $bookNo, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookImageUrl: $bookImageUrl, gardenNo: $gardenNo)';
}


}

/// @nodoc
abstract mixin class _$MemoBookSelectorEntityCopyWith<$Res> implements $MemoBookSelectorEntityCopyWith<$Res> {
  factory _$MemoBookSelectorEntityCopyWith(_MemoBookSelectorEntity value, $Res Function(_MemoBookSelectorEntity) _then) = __$MemoBookSelectorEntityCopyWithImpl;
@override @useResult
$Res call({
 int bookNo, String bookTitle, String bookAuthor, String? bookImageUrl, int? gardenNo
});




}
/// @nodoc
class __$MemoBookSelectorEntityCopyWithImpl<$Res>
    implements _$MemoBookSelectorEntityCopyWith<$Res> {
  __$MemoBookSelectorEntityCopyWithImpl(this._self, this._then);

  final _MemoBookSelectorEntity _self;
  final $Res Function(_MemoBookSelectorEntity) _then;

/// Create a copy of MemoBookSelectorEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookNo = null,Object? bookTitle = null,Object? bookAuthor = null,Object? bookImageUrl = freezed,Object? gardenNo = freezed,}) {
  return _then(_MemoBookSelectorEntity(
bookNo: null == bookNo ? _self.bookNo : bookNo // ignore: cast_nullable_to_non_nullable
as int,bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookAuthor: null == bookAuthor ? _self.bookAuthor : bookAuthor // ignore: cast_nullable_to_non_nullable
as String,bookImageUrl: freezed == bookImageUrl ? _self.bookImageUrl : bookImageUrl // ignore: cast_nullable_to_non_nullable
as String?,gardenNo: freezed == gardenNo ? _self.gardenNo : gardenNo // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
