// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_add_done_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookAddDoneEntity {

 String get bookTitle; String get bookTree; String get bookStartDate; String get bookEndDate;
/// Create a copy of BookAddDoneEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookAddDoneEntityCopyWith<BookAddDoneEntity> get copyWith => _$BookAddDoneEntityCopyWithImpl<BookAddDoneEntity>(this as BookAddDoneEntity, _$identity);

  /// Serializes this BookAddDoneEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookAddDoneEntity&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookTree, bookTree) || other.bookTree == bookTree)&&(identical(other.bookStartDate, bookStartDate) || other.bookStartDate == bookStartDate)&&(identical(other.bookEndDate, bookEndDate) || other.bookEndDate == bookEndDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookTitle,bookTree,bookStartDate,bookEndDate);

@override
String toString() {
  return 'BookAddDoneEntity(bookTitle: $bookTitle, bookTree: $bookTree, bookStartDate: $bookStartDate, bookEndDate: $bookEndDate)';
}


}

/// @nodoc
abstract mixin class $BookAddDoneEntityCopyWith<$Res>  {
  factory $BookAddDoneEntityCopyWith(BookAddDoneEntity value, $Res Function(BookAddDoneEntity) _then) = _$BookAddDoneEntityCopyWithImpl;
@useResult
$Res call({
 String bookTitle, String bookTree, String bookStartDate, String bookEndDate
});




}
/// @nodoc
class _$BookAddDoneEntityCopyWithImpl<$Res>
    implements $BookAddDoneEntityCopyWith<$Res> {
  _$BookAddDoneEntityCopyWithImpl(this._self, this._then);

  final BookAddDoneEntity _self;
  final $Res Function(BookAddDoneEntity) _then;

/// Create a copy of BookAddDoneEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookTitle = null,Object? bookTree = null,Object? bookStartDate = null,Object? bookEndDate = null,}) {
  return _then(_self.copyWith(
bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookTree: null == bookTree ? _self.bookTree : bookTree // ignore: cast_nullable_to_non_nullable
as String,bookStartDate: null == bookStartDate ? _self.bookStartDate : bookStartDate // ignore: cast_nullable_to_non_nullable
as String,bookEndDate: null == bookEndDate ? _self.bookEndDate : bookEndDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BookAddDoneEntity].
extension BookAddDoneEntityPatterns on BookAddDoneEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookAddDoneEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookAddDoneEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookAddDoneEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookAddDoneEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookAddDoneEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookAddDoneEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bookTitle,  String bookTree,  String bookStartDate,  String bookEndDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookAddDoneEntity() when $default != null:
return $default(_that.bookTitle,_that.bookTree,_that.bookStartDate,_that.bookEndDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bookTitle,  String bookTree,  String bookStartDate,  String bookEndDate)  $default,) {final _that = this;
switch (_that) {
case _BookAddDoneEntity():
return $default(_that.bookTitle,_that.bookTree,_that.bookStartDate,_that.bookEndDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bookTitle,  String bookTree,  String bookStartDate,  String bookEndDate)?  $default,) {final _that = this;
switch (_that) {
case _BookAddDoneEntity() when $default != null:
return $default(_that.bookTitle,_that.bookTree,_that.bookStartDate,_that.bookEndDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookAddDoneEntity implements BookAddDoneEntity {
  const _BookAddDoneEntity({this.bookTitle = '', this.bookTree = '', this.bookStartDate = '', this.bookEndDate = ''});
  factory _BookAddDoneEntity.fromJson(Map<String, dynamic> json) => _$BookAddDoneEntityFromJson(json);

@override@JsonKey() final  String bookTitle;
@override@JsonKey() final  String bookTree;
@override@JsonKey() final  String bookStartDate;
@override@JsonKey() final  String bookEndDate;

/// Create a copy of BookAddDoneEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookAddDoneEntityCopyWith<_BookAddDoneEntity> get copyWith => __$BookAddDoneEntityCopyWithImpl<_BookAddDoneEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookAddDoneEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookAddDoneEntity&&(identical(other.bookTitle, bookTitle) || other.bookTitle == bookTitle)&&(identical(other.bookTree, bookTree) || other.bookTree == bookTree)&&(identical(other.bookStartDate, bookStartDate) || other.bookStartDate == bookStartDate)&&(identical(other.bookEndDate, bookEndDate) || other.bookEndDate == bookEndDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookTitle,bookTree,bookStartDate,bookEndDate);

@override
String toString() {
  return 'BookAddDoneEntity(bookTitle: $bookTitle, bookTree: $bookTree, bookStartDate: $bookStartDate, bookEndDate: $bookEndDate)';
}


}

/// @nodoc
abstract mixin class _$BookAddDoneEntityCopyWith<$Res> implements $BookAddDoneEntityCopyWith<$Res> {
  factory _$BookAddDoneEntityCopyWith(_BookAddDoneEntity value, $Res Function(_BookAddDoneEntity) _then) = __$BookAddDoneEntityCopyWithImpl;
@override @useResult
$Res call({
 String bookTitle, String bookTree, String bookStartDate, String bookEndDate
});




}
/// @nodoc
class __$BookAddDoneEntityCopyWithImpl<$Res>
    implements _$BookAddDoneEntityCopyWith<$Res> {
  __$BookAddDoneEntityCopyWithImpl(this._self, this._then);

  final _BookAddDoneEntity _self;
  final $Res Function(_BookAddDoneEntity) _then;

/// Create a copy of BookAddDoneEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookTitle = null,Object? bookTree = null,Object? bookStartDate = null,Object? bookEndDate = null,}) {
  return _then(_BookAddDoneEntity(
bookTitle: null == bookTitle ? _self.bookTitle : bookTitle // ignore: cast_nullable_to_non_nullable
as String,bookTree: null == bookTree ? _self.bookTree : bookTree // ignore: cast_nullable_to_non_nullable
as String,bookStartDate: null == bookStartDate ? _self.bookStartDate : bookStartDate // ignore: cast_nullable_to_non_nullable
as String,bookEndDate: null == bookEndDate ? _self.bookEndDate : bookEndDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
