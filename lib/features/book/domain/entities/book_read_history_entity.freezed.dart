// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_read_history_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookReadHistoryEntity {

 int get bookCurrentPage; String? get bookCreatedAt; String? get bookStartDate; String? get bookEndDate;
/// Create a copy of BookReadHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookReadHistoryEntityCopyWith<BookReadHistoryEntity> get copyWith => _$BookReadHistoryEntityCopyWithImpl<BookReadHistoryEntity>(this as BookReadHistoryEntity, _$identity);

  /// Serializes this BookReadHistoryEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookReadHistoryEntity&&(identical(other.bookCurrentPage, bookCurrentPage) || other.bookCurrentPage == bookCurrentPage)&&(identical(other.bookCreatedAt, bookCreatedAt) || other.bookCreatedAt == bookCreatedAt)&&(identical(other.bookStartDate, bookStartDate) || other.bookStartDate == bookStartDate)&&(identical(other.bookEndDate, bookEndDate) || other.bookEndDate == bookEndDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookCurrentPage,bookCreatedAt,bookStartDate,bookEndDate);

@override
String toString() {
  return 'BookReadHistoryEntity(bookCurrentPage: $bookCurrentPage, bookCreatedAt: $bookCreatedAt, bookStartDate: $bookStartDate, bookEndDate: $bookEndDate)';
}


}

/// @nodoc
abstract mixin class $BookReadHistoryEntityCopyWith<$Res>  {
  factory $BookReadHistoryEntityCopyWith(BookReadHistoryEntity value, $Res Function(BookReadHistoryEntity) _then) = _$BookReadHistoryEntityCopyWithImpl;
@useResult
$Res call({
 int bookCurrentPage, String? bookCreatedAt, String? bookStartDate, String? bookEndDate
});




}
/// @nodoc
class _$BookReadHistoryEntityCopyWithImpl<$Res>
    implements $BookReadHistoryEntityCopyWith<$Res> {
  _$BookReadHistoryEntityCopyWithImpl(this._self, this._then);

  final BookReadHistoryEntity _self;
  final $Res Function(BookReadHistoryEntity) _then;

/// Create a copy of BookReadHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookCurrentPage = null,Object? bookCreatedAt = freezed,Object? bookStartDate = freezed,Object? bookEndDate = freezed,}) {
  return _then(_self.copyWith(
bookCurrentPage: null == bookCurrentPage ? _self.bookCurrentPage : bookCurrentPage // ignore: cast_nullable_to_non_nullable
as int,bookCreatedAt: freezed == bookCreatedAt ? _self.bookCreatedAt : bookCreatedAt // ignore: cast_nullable_to_non_nullable
as String?,bookStartDate: freezed == bookStartDate ? _self.bookStartDate : bookStartDate // ignore: cast_nullable_to_non_nullable
as String?,bookEndDate: freezed == bookEndDate ? _self.bookEndDate : bookEndDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookReadHistoryEntity].
extension BookReadHistoryEntityPatterns on BookReadHistoryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookReadHistoryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookReadHistoryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookReadHistoryEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookReadHistoryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookReadHistoryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookReadHistoryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int bookCurrentPage,  String? bookCreatedAt,  String? bookStartDate,  String? bookEndDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookReadHistoryEntity() when $default != null:
return $default(_that.bookCurrentPage,_that.bookCreatedAt,_that.bookStartDate,_that.bookEndDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int bookCurrentPage,  String? bookCreatedAt,  String? bookStartDate,  String? bookEndDate)  $default,) {final _that = this;
switch (_that) {
case _BookReadHistoryEntity():
return $default(_that.bookCurrentPage,_that.bookCreatedAt,_that.bookStartDate,_that.bookEndDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int bookCurrentPage,  String? bookCreatedAt,  String? bookStartDate,  String? bookEndDate)?  $default,) {final _that = this;
switch (_that) {
case _BookReadHistoryEntity() when $default != null:
return $default(_that.bookCurrentPage,_that.bookCreatedAt,_that.bookStartDate,_that.bookEndDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookReadHistoryEntity implements BookReadHistoryEntity {
  const _BookReadHistoryEntity({required this.bookCurrentPage, required this.bookCreatedAt, required this.bookStartDate, required this.bookEndDate});
  factory _BookReadHistoryEntity.fromJson(Map<String, dynamic> json) => _$BookReadHistoryEntityFromJson(json);

@override final  int bookCurrentPage;
@override final  String? bookCreatedAt;
@override final  String? bookStartDate;
@override final  String? bookEndDate;

/// Create a copy of BookReadHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookReadHistoryEntityCopyWith<_BookReadHistoryEntity> get copyWith => __$BookReadHistoryEntityCopyWithImpl<_BookReadHistoryEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookReadHistoryEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookReadHistoryEntity&&(identical(other.bookCurrentPage, bookCurrentPage) || other.bookCurrentPage == bookCurrentPage)&&(identical(other.bookCreatedAt, bookCreatedAt) || other.bookCreatedAt == bookCreatedAt)&&(identical(other.bookStartDate, bookStartDate) || other.bookStartDate == bookStartDate)&&(identical(other.bookEndDate, bookEndDate) || other.bookEndDate == bookEndDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookCurrentPage,bookCreatedAt,bookStartDate,bookEndDate);

@override
String toString() {
  return 'BookReadHistoryEntity(bookCurrentPage: $bookCurrentPage, bookCreatedAt: $bookCreatedAt, bookStartDate: $bookStartDate, bookEndDate: $bookEndDate)';
}


}

/// @nodoc
abstract mixin class _$BookReadHistoryEntityCopyWith<$Res> implements $BookReadHistoryEntityCopyWith<$Res> {
  factory _$BookReadHistoryEntityCopyWith(_BookReadHistoryEntity value, $Res Function(_BookReadHistoryEntity) _then) = __$BookReadHistoryEntityCopyWithImpl;
@override @useResult
$Res call({
 int bookCurrentPage, String? bookCreatedAt, String? bookStartDate, String? bookEndDate
});




}
/// @nodoc
class __$BookReadHistoryEntityCopyWithImpl<$Res>
    implements _$BookReadHistoryEntityCopyWith<$Res> {
  __$BookReadHistoryEntityCopyWithImpl(this._self, this._then);

  final _BookReadHistoryEntity _self;
  final $Res Function(_BookReadHistoryEntity) _then;

/// Create a copy of BookReadHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookCurrentPage = null,Object? bookCreatedAt = freezed,Object? bookStartDate = freezed,Object? bookEndDate = freezed,}) {
  return _then(_BookReadHistoryEntity(
bookCurrentPage: null == bookCurrentPage ? _self.bookCurrentPage : bookCurrentPage // ignore: cast_nullable_to_non_nullable
as int,bookCreatedAt: freezed == bookCreatedAt ? _self.bookCreatedAt : bookCreatedAt // ignore: cast_nullable_to_non_nullable
as String?,bookStartDate: freezed == bookStartDate ? _self.bookStartDate : bookStartDate // ignore: cast_nullable_to_non_nullable
as String?,bookEndDate: freezed == bookEndDate ? _self.bookEndDate : bookEndDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
