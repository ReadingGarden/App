// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_edit_history_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookEditHistoryEntity {

 int get id; String? get bookStartDate; String? get bookEndDate;
/// Create a copy of BookEditHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookEditHistoryEntityCopyWith<BookEditHistoryEntity> get copyWith => _$BookEditHistoryEntityCopyWithImpl<BookEditHistoryEntity>(this as BookEditHistoryEntity, _$identity);

  /// Serializes this BookEditHistoryEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookEditHistoryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.bookStartDate, bookStartDate) || other.bookStartDate == bookStartDate)&&(identical(other.bookEndDate, bookEndDate) || other.bookEndDate == bookEndDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bookStartDate,bookEndDate);

@override
String toString() {
  return 'BookEditHistoryEntity(id: $id, bookStartDate: $bookStartDate, bookEndDate: $bookEndDate)';
}


}

/// @nodoc
abstract mixin class $BookEditHistoryEntityCopyWith<$Res>  {
  factory $BookEditHistoryEntityCopyWith(BookEditHistoryEntity value, $Res Function(BookEditHistoryEntity) _then) = _$BookEditHistoryEntityCopyWithImpl;
@useResult
$Res call({
 int id, String? bookStartDate, String? bookEndDate
});




}
/// @nodoc
class _$BookEditHistoryEntityCopyWithImpl<$Res>
    implements $BookEditHistoryEntityCopyWith<$Res> {
  _$BookEditHistoryEntityCopyWithImpl(this._self, this._then);

  final BookEditHistoryEntity _self;
  final $Res Function(BookEditHistoryEntity) _then;

/// Create a copy of BookEditHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookStartDate = freezed,Object? bookEndDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,bookStartDate: freezed == bookStartDate ? _self.bookStartDate : bookStartDate // ignore: cast_nullable_to_non_nullable
as String?,bookEndDate: freezed == bookEndDate ? _self.bookEndDate : bookEndDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookEditHistoryEntity].
extension BookEditHistoryEntityPatterns on BookEditHistoryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookEditHistoryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookEditHistoryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookEditHistoryEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookEditHistoryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookEditHistoryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookEditHistoryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? bookStartDate,  String? bookEndDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookEditHistoryEntity() when $default != null:
return $default(_that.id,_that.bookStartDate,_that.bookEndDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? bookStartDate,  String? bookEndDate)  $default,) {final _that = this;
switch (_that) {
case _BookEditHistoryEntity():
return $default(_that.id,_that.bookStartDate,_that.bookEndDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? bookStartDate,  String? bookEndDate)?  $default,) {final _that = this;
switch (_that) {
case _BookEditHistoryEntity() when $default != null:
return $default(_that.id,_that.bookStartDate,_that.bookEndDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookEditHistoryEntity implements BookEditHistoryEntity {
  const _BookEditHistoryEntity({required this.id, required this.bookStartDate, required this.bookEndDate});
  factory _BookEditHistoryEntity.fromJson(Map<String, dynamic> json) => _$BookEditHistoryEntityFromJson(json);

@override final  int id;
@override final  String? bookStartDate;
@override final  String? bookEndDate;

/// Create a copy of BookEditHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookEditHistoryEntityCopyWith<_BookEditHistoryEntity> get copyWith => __$BookEditHistoryEntityCopyWithImpl<_BookEditHistoryEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookEditHistoryEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookEditHistoryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.bookStartDate, bookStartDate) || other.bookStartDate == bookStartDate)&&(identical(other.bookEndDate, bookEndDate) || other.bookEndDate == bookEndDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bookStartDate,bookEndDate);

@override
String toString() {
  return 'BookEditHistoryEntity(id: $id, bookStartDate: $bookStartDate, bookEndDate: $bookEndDate)';
}


}

/// @nodoc
abstract mixin class _$BookEditHistoryEntityCopyWith<$Res> implements $BookEditHistoryEntityCopyWith<$Res> {
  factory _$BookEditHistoryEntityCopyWith(_BookEditHistoryEntity value, $Res Function(_BookEditHistoryEntity) _then) = __$BookEditHistoryEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String? bookStartDate, String? bookEndDate
});




}
/// @nodoc
class __$BookEditHistoryEntityCopyWithImpl<$Res>
    implements _$BookEditHistoryEntityCopyWith<$Res> {
  __$BookEditHistoryEntityCopyWithImpl(this._self, this._then);

  final _BookEditHistoryEntity _self;
  final $Res Function(_BookEditHistoryEntity) _then;

/// Create a copy of BookEditHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookStartDate = freezed,Object? bookEndDate = freezed,}) {
  return _then(_BookEditHistoryEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,bookStartDate: freezed == bookStartDate ? _self.bookStartDate : bookStartDate // ignore: cast_nullable_to_non_nullable
as String?,bookEndDate: freezed == bookEndDate ? _self.bookEndDate : bookEndDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
