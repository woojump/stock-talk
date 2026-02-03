// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recently_viewed_stock_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecentlyViewedStockDto {

 String get ticker; String get name; String get viewedAt;
/// Create a copy of RecentlyViewedStockDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentlyViewedStockDtoCopyWith<RecentlyViewedStockDto> get copyWith => _$RecentlyViewedStockDtoCopyWithImpl<RecentlyViewedStockDto>(this as RecentlyViewedStockDto, _$identity);

  /// Serializes this RecentlyViewedStockDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentlyViewedStockDto&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.name, name) || other.name == name)&&(identical(other.viewedAt, viewedAt) || other.viewedAt == viewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticker,name,viewedAt);

@override
String toString() {
  return 'RecentlyViewedStockDto(ticker: $ticker, name: $name, viewedAt: $viewedAt)';
}


}

/// @nodoc
abstract mixin class $RecentlyViewedStockDtoCopyWith<$Res>  {
  factory $RecentlyViewedStockDtoCopyWith(RecentlyViewedStockDto value, $Res Function(RecentlyViewedStockDto) _then) = _$RecentlyViewedStockDtoCopyWithImpl;
@useResult
$Res call({
 String ticker, String name, String viewedAt
});




}
/// @nodoc
class _$RecentlyViewedStockDtoCopyWithImpl<$Res>
    implements $RecentlyViewedStockDtoCopyWith<$Res> {
  _$RecentlyViewedStockDtoCopyWithImpl(this._self, this._then);

  final RecentlyViewedStockDto _self;
  final $Res Function(RecentlyViewedStockDto) _then;

/// Create a copy of RecentlyViewedStockDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? name = null,Object? viewedAt = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,viewedAt: null == viewedAt ? _self.viewedAt : viewedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentlyViewedStockDto].
extension RecentlyViewedStockDtoPatterns on RecentlyViewedStockDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentlyViewedStockDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentlyViewedStockDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentlyViewedStockDto value)  $default,){
final _that = this;
switch (_that) {
case _RecentlyViewedStockDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentlyViewedStockDto value)?  $default,){
final _that = this;
switch (_that) {
case _RecentlyViewedStockDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String name,  String viewedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentlyViewedStockDto() when $default != null:
return $default(_that.ticker,_that.name,_that.viewedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String name,  String viewedAt)  $default,) {final _that = this;
switch (_that) {
case _RecentlyViewedStockDto():
return $default(_that.ticker,_that.name,_that.viewedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String name,  String viewedAt)?  $default,) {final _that = this;
switch (_that) {
case _RecentlyViewedStockDto() when $default != null:
return $default(_that.ticker,_that.name,_that.viewedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecentlyViewedStockDto extends RecentlyViewedStockDto {
  const _RecentlyViewedStockDto({required this.ticker, required this.name, required this.viewedAt}): super._();
  factory _RecentlyViewedStockDto.fromJson(Map<String, dynamic> json) => _$RecentlyViewedStockDtoFromJson(json);

@override final  String ticker;
@override final  String name;
@override final  String viewedAt;

/// Create a copy of RecentlyViewedStockDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentlyViewedStockDtoCopyWith<_RecentlyViewedStockDto> get copyWith => __$RecentlyViewedStockDtoCopyWithImpl<_RecentlyViewedStockDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecentlyViewedStockDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentlyViewedStockDto&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.name, name) || other.name == name)&&(identical(other.viewedAt, viewedAt) || other.viewedAt == viewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticker,name,viewedAt);

@override
String toString() {
  return 'RecentlyViewedStockDto(ticker: $ticker, name: $name, viewedAt: $viewedAt)';
}


}

/// @nodoc
abstract mixin class _$RecentlyViewedStockDtoCopyWith<$Res> implements $RecentlyViewedStockDtoCopyWith<$Res> {
  factory _$RecentlyViewedStockDtoCopyWith(_RecentlyViewedStockDto value, $Res Function(_RecentlyViewedStockDto) _then) = __$RecentlyViewedStockDtoCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String name, String viewedAt
});




}
/// @nodoc
class __$RecentlyViewedStockDtoCopyWithImpl<$Res>
    implements _$RecentlyViewedStockDtoCopyWith<$Res> {
  __$RecentlyViewedStockDtoCopyWithImpl(this._self, this._then);

  final _RecentlyViewedStockDto _self;
  final $Res Function(_RecentlyViewedStockDto) _then;

/// Create a copy of RecentlyViewedStockDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? name = null,Object? viewedAt = null,}) {
  return _then(_RecentlyViewedStockDto(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,viewedAt: null == viewedAt ? _self.viewedAt : viewedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
