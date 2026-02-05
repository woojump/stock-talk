// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_detail_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StockDetailResponseDto {

 String get ticker;@JsonKey(name: 'stock_info') StockInfoDto get stockInfo; List<CandleDto> get candles;
/// Create a copy of StockDetailResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockDetailResponseDtoCopyWith<StockDetailResponseDto> get copyWith => _$StockDetailResponseDtoCopyWithImpl<StockDetailResponseDto>(this as StockDetailResponseDto, _$identity);

  /// Serializes this StockDetailResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockDetailResponseDto&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.stockInfo, stockInfo) || other.stockInfo == stockInfo)&&const DeepCollectionEquality().equals(other.candles, candles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticker,stockInfo,const DeepCollectionEquality().hash(candles));

@override
String toString() {
  return 'StockDetailResponseDto(ticker: $ticker, stockInfo: $stockInfo, candles: $candles)';
}


}

/// @nodoc
abstract mixin class $StockDetailResponseDtoCopyWith<$Res>  {
  factory $StockDetailResponseDtoCopyWith(StockDetailResponseDto value, $Res Function(StockDetailResponseDto) _then) = _$StockDetailResponseDtoCopyWithImpl;
@useResult
$Res call({
 String ticker,@JsonKey(name: 'stock_info') StockInfoDto stockInfo, List<CandleDto> candles
});


$StockInfoDtoCopyWith<$Res> get stockInfo;

}
/// @nodoc
class _$StockDetailResponseDtoCopyWithImpl<$Res>
    implements $StockDetailResponseDtoCopyWith<$Res> {
  _$StockDetailResponseDtoCopyWithImpl(this._self, this._then);

  final StockDetailResponseDto _self;
  final $Res Function(StockDetailResponseDto) _then;

/// Create a copy of StockDetailResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? stockInfo = null,Object? candles = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,stockInfo: null == stockInfo ? _self.stockInfo : stockInfo // ignore: cast_nullable_to_non_nullable
as StockInfoDto,candles: null == candles ? _self.candles : candles // ignore: cast_nullable_to_non_nullable
as List<CandleDto>,
  ));
}
/// Create a copy of StockDetailResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockInfoDtoCopyWith<$Res> get stockInfo {
  
  return $StockInfoDtoCopyWith<$Res>(_self.stockInfo, (value) {
    return _then(_self.copyWith(stockInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [StockDetailResponseDto].
extension StockDetailResponseDtoPatterns on StockDetailResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockDetailResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockDetailResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockDetailResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _StockDetailResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockDetailResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _StockDetailResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker, @JsonKey(name: 'stock_info')  StockInfoDto stockInfo,  List<CandleDto> candles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockDetailResponseDto() when $default != null:
return $default(_that.ticker,_that.stockInfo,_that.candles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker, @JsonKey(name: 'stock_info')  StockInfoDto stockInfo,  List<CandleDto> candles)  $default,) {final _that = this;
switch (_that) {
case _StockDetailResponseDto():
return $default(_that.ticker,_that.stockInfo,_that.candles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker, @JsonKey(name: 'stock_info')  StockInfoDto stockInfo,  List<CandleDto> candles)?  $default,) {final _that = this;
switch (_that) {
case _StockDetailResponseDto() when $default != null:
return $default(_that.ticker,_that.stockInfo,_that.candles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockDetailResponseDto extends StockDetailResponseDto {
  const _StockDetailResponseDto({required this.ticker, @JsonKey(name: 'stock_info') required this.stockInfo, required final  List<CandleDto> candles}): _candles = candles,super._();
  factory _StockDetailResponseDto.fromJson(Map<String, dynamic> json) => _$StockDetailResponseDtoFromJson(json);

@override final  String ticker;
@override@JsonKey(name: 'stock_info') final  StockInfoDto stockInfo;
 final  List<CandleDto> _candles;
@override List<CandleDto> get candles {
  if (_candles is EqualUnmodifiableListView) return _candles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candles);
}


/// Create a copy of StockDetailResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockDetailResponseDtoCopyWith<_StockDetailResponseDto> get copyWith => __$StockDetailResponseDtoCopyWithImpl<_StockDetailResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockDetailResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockDetailResponseDto&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.stockInfo, stockInfo) || other.stockInfo == stockInfo)&&const DeepCollectionEquality().equals(other._candles, _candles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticker,stockInfo,const DeepCollectionEquality().hash(_candles));

@override
String toString() {
  return 'StockDetailResponseDto(ticker: $ticker, stockInfo: $stockInfo, candles: $candles)';
}


}

/// @nodoc
abstract mixin class _$StockDetailResponseDtoCopyWith<$Res> implements $StockDetailResponseDtoCopyWith<$Res> {
  factory _$StockDetailResponseDtoCopyWith(_StockDetailResponseDto value, $Res Function(_StockDetailResponseDto) _then) = __$StockDetailResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String ticker,@JsonKey(name: 'stock_info') StockInfoDto stockInfo, List<CandleDto> candles
});


@override $StockInfoDtoCopyWith<$Res> get stockInfo;

}
/// @nodoc
class __$StockDetailResponseDtoCopyWithImpl<$Res>
    implements _$StockDetailResponseDtoCopyWith<$Res> {
  __$StockDetailResponseDtoCopyWithImpl(this._self, this._then);

  final _StockDetailResponseDto _self;
  final $Res Function(_StockDetailResponseDto) _then;

/// Create a copy of StockDetailResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? stockInfo = null,Object? candles = null,}) {
  return _then(_StockDetailResponseDto(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,stockInfo: null == stockInfo ? _self.stockInfo : stockInfo // ignore: cast_nullable_to_non_nullable
as StockInfoDto,candles: null == candles ? _self._candles : candles // ignore: cast_nullable_to_non_nullable
as List<CandleDto>,
  ));
}

/// Create a copy of StockDetailResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockInfoDtoCopyWith<$Res> get stockInfo {
  
  return $StockInfoDtoCopyWith<$Res>(_self.stockInfo, (value) {
    return _then(_self.copyWith(stockInfo: value));
  });
}
}


/// @nodoc
mixin _$StockInfoDto {

@JsonKey(name: 'current_price') dynamic get currentPrice;@JsonKey(name: 'total_ask_qty') dynamic get totalAskQty;@JsonKey(name: 'total_bid_qty') dynamic get totalBidQty;
/// Create a copy of StockInfoDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockInfoDtoCopyWith<StockInfoDto> get copyWith => _$StockInfoDtoCopyWithImpl<StockInfoDto>(this as StockInfoDto, _$identity);

  /// Serializes this StockInfoDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockInfoDto&&const DeepCollectionEquality().equals(other.currentPrice, currentPrice)&&const DeepCollectionEquality().equals(other.totalAskQty, totalAskQty)&&const DeepCollectionEquality().equals(other.totalBidQty, totalBidQty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(currentPrice),const DeepCollectionEquality().hash(totalAskQty),const DeepCollectionEquality().hash(totalBidQty));

@override
String toString() {
  return 'StockInfoDto(currentPrice: $currentPrice, totalAskQty: $totalAskQty, totalBidQty: $totalBidQty)';
}


}

/// @nodoc
abstract mixin class $StockInfoDtoCopyWith<$Res>  {
  factory $StockInfoDtoCopyWith(StockInfoDto value, $Res Function(StockInfoDto) _then) = _$StockInfoDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'current_price') dynamic currentPrice,@JsonKey(name: 'total_ask_qty') dynamic totalAskQty,@JsonKey(name: 'total_bid_qty') dynamic totalBidQty
});




}
/// @nodoc
class _$StockInfoDtoCopyWithImpl<$Res>
    implements $StockInfoDtoCopyWith<$Res> {
  _$StockInfoDtoCopyWithImpl(this._self, this._then);

  final StockInfoDto _self;
  final $Res Function(StockInfoDto) _then;

/// Create a copy of StockInfoDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPrice = freezed,Object? totalAskQty = freezed,Object? totalBidQty = freezed,}) {
  return _then(_self.copyWith(
currentPrice: freezed == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as dynamic,totalAskQty: freezed == totalAskQty ? _self.totalAskQty : totalAskQty // ignore: cast_nullable_to_non_nullable
as dynamic,totalBidQty: freezed == totalBidQty ? _self.totalBidQty : totalBidQty // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [StockInfoDto].
extension StockInfoDtoPatterns on StockInfoDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockInfoDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockInfoDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockInfoDto value)  $default,){
final _that = this;
switch (_that) {
case _StockInfoDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockInfoDto value)?  $default,){
final _that = this;
switch (_that) {
case _StockInfoDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'current_price')  dynamic currentPrice, @JsonKey(name: 'total_ask_qty')  dynamic totalAskQty, @JsonKey(name: 'total_bid_qty')  dynamic totalBidQty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockInfoDto() when $default != null:
return $default(_that.currentPrice,_that.totalAskQty,_that.totalBidQty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'current_price')  dynamic currentPrice, @JsonKey(name: 'total_ask_qty')  dynamic totalAskQty, @JsonKey(name: 'total_bid_qty')  dynamic totalBidQty)  $default,) {final _that = this;
switch (_that) {
case _StockInfoDto():
return $default(_that.currentPrice,_that.totalAskQty,_that.totalBidQty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'current_price')  dynamic currentPrice, @JsonKey(name: 'total_ask_qty')  dynamic totalAskQty, @JsonKey(name: 'total_bid_qty')  dynamic totalBidQty)?  $default,) {final _that = this;
switch (_that) {
case _StockInfoDto() when $default != null:
return $default(_that.currentPrice,_that.totalAskQty,_that.totalBidQty);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockInfoDto extends StockInfoDto {
  const _StockInfoDto({@JsonKey(name: 'current_price') required this.currentPrice, @JsonKey(name: 'total_ask_qty') required this.totalAskQty, @JsonKey(name: 'total_bid_qty') required this.totalBidQty}): super._();
  factory _StockInfoDto.fromJson(Map<String, dynamic> json) => _$StockInfoDtoFromJson(json);

@override@JsonKey(name: 'current_price') final  dynamic currentPrice;
@override@JsonKey(name: 'total_ask_qty') final  dynamic totalAskQty;
@override@JsonKey(name: 'total_bid_qty') final  dynamic totalBidQty;

/// Create a copy of StockInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockInfoDtoCopyWith<_StockInfoDto> get copyWith => __$StockInfoDtoCopyWithImpl<_StockInfoDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockInfoDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockInfoDto&&const DeepCollectionEquality().equals(other.currentPrice, currentPrice)&&const DeepCollectionEquality().equals(other.totalAskQty, totalAskQty)&&const DeepCollectionEquality().equals(other.totalBidQty, totalBidQty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(currentPrice),const DeepCollectionEquality().hash(totalAskQty),const DeepCollectionEquality().hash(totalBidQty));

@override
String toString() {
  return 'StockInfoDto(currentPrice: $currentPrice, totalAskQty: $totalAskQty, totalBidQty: $totalBidQty)';
}


}

/// @nodoc
abstract mixin class _$StockInfoDtoCopyWith<$Res> implements $StockInfoDtoCopyWith<$Res> {
  factory _$StockInfoDtoCopyWith(_StockInfoDto value, $Res Function(_StockInfoDto) _then) = __$StockInfoDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'current_price') dynamic currentPrice,@JsonKey(name: 'total_ask_qty') dynamic totalAskQty,@JsonKey(name: 'total_bid_qty') dynamic totalBidQty
});




}
/// @nodoc
class __$StockInfoDtoCopyWithImpl<$Res>
    implements _$StockInfoDtoCopyWith<$Res> {
  __$StockInfoDtoCopyWithImpl(this._self, this._then);

  final _StockInfoDto _self;
  final $Res Function(_StockInfoDto) _then;

/// Create a copy of StockInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPrice = freezed,Object? totalAskQty = freezed,Object? totalBidQty = freezed,}) {
  return _then(_StockInfoDto(
currentPrice: freezed == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as dynamic,totalAskQty: freezed == totalAskQty ? _self.totalAskQty : totalAskQty // ignore: cast_nullable_to_non_nullable
as dynamic,totalBidQty: freezed == totalBidQty ? _self.totalBidQty : totalBidQty // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}


/// @nodoc
mixin _$CandleDto {

 String get time; dynamic get open; dynamic get high; dynamic get low; dynamic get close; dynamic get volume;
/// Create a copy of CandleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandleDtoCopyWith<CandleDto> get copyWith => _$CandleDtoCopyWithImpl<CandleDto>(this as CandleDto, _$identity);

  /// Serializes this CandleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandleDto&&(identical(other.time, time) || other.time == time)&&const DeepCollectionEquality().equals(other.open, open)&&const DeepCollectionEquality().equals(other.high, high)&&const DeepCollectionEquality().equals(other.low, low)&&const DeepCollectionEquality().equals(other.close, close)&&const DeepCollectionEquality().equals(other.volume, volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,const DeepCollectionEquality().hash(open),const DeepCollectionEquality().hash(high),const DeepCollectionEquality().hash(low),const DeepCollectionEquality().hash(close),const DeepCollectionEquality().hash(volume));

@override
String toString() {
  return 'CandleDto(time: $time, open: $open, high: $high, low: $low, close: $close, volume: $volume)';
}


}

/// @nodoc
abstract mixin class $CandleDtoCopyWith<$Res>  {
  factory $CandleDtoCopyWith(CandleDto value, $Res Function(CandleDto) _then) = _$CandleDtoCopyWithImpl;
@useResult
$Res call({
 String time, dynamic open, dynamic high, dynamic low, dynamic close, dynamic volume
});




}
/// @nodoc
class _$CandleDtoCopyWithImpl<$Res>
    implements $CandleDtoCopyWith<$Res> {
  _$CandleDtoCopyWithImpl(this._self, this._then);

  final CandleDto _self;
  final $Res Function(CandleDto) _then;

/// Create a copy of CandleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? open = freezed,Object? high = freezed,Object? low = freezed,Object? close = freezed,Object? volume = freezed,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,open: freezed == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as dynamic,high: freezed == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as dynamic,low: freezed == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as dynamic,close: freezed == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as dynamic,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [CandleDto].
extension CandleDtoPatterns on CandleDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CandleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CandleDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CandleDto value)  $default,){
final _that = this;
switch (_that) {
case _CandleDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CandleDto value)?  $default,){
final _that = this;
switch (_that) {
case _CandleDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String time,  dynamic open,  dynamic high,  dynamic low,  dynamic close,  dynamic volume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CandleDto() when $default != null:
return $default(_that.time,_that.open,_that.high,_that.low,_that.close,_that.volume);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String time,  dynamic open,  dynamic high,  dynamic low,  dynamic close,  dynamic volume)  $default,) {final _that = this;
switch (_that) {
case _CandleDto():
return $default(_that.time,_that.open,_that.high,_that.low,_that.close,_that.volume);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String time,  dynamic open,  dynamic high,  dynamic low,  dynamic close,  dynamic volume)?  $default,) {final _that = this;
switch (_that) {
case _CandleDto() when $default != null:
return $default(_that.time,_that.open,_that.high,_that.low,_that.close,_that.volume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CandleDto extends CandleDto {
  const _CandleDto({required this.time, required this.open, required this.high, required this.low, required this.close, required this.volume}): super._();
  factory _CandleDto.fromJson(Map<String, dynamic> json) => _$CandleDtoFromJson(json);

@override final  String time;
@override final  dynamic open;
@override final  dynamic high;
@override final  dynamic low;
@override final  dynamic close;
@override final  dynamic volume;

/// Create a copy of CandleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandleDtoCopyWith<_CandleDto> get copyWith => __$CandleDtoCopyWithImpl<_CandleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CandleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandleDto&&(identical(other.time, time) || other.time == time)&&const DeepCollectionEquality().equals(other.open, open)&&const DeepCollectionEquality().equals(other.high, high)&&const DeepCollectionEquality().equals(other.low, low)&&const DeepCollectionEquality().equals(other.close, close)&&const DeepCollectionEquality().equals(other.volume, volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,const DeepCollectionEquality().hash(open),const DeepCollectionEquality().hash(high),const DeepCollectionEquality().hash(low),const DeepCollectionEquality().hash(close),const DeepCollectionEquality().hash(volume));

@override
String toString() {
  return 'CandleDto(time: $time, open: $open, high: $high, low: $low, close: $close, volume: $volume)';
}


}

/// @nodoc
abstract mixin class _$CandleDtoCopyWith<$Res> implements $CandleDtoCopyWith<$Res> {
  factory _$CandleDtoCopyWith(_CandleDto value, $Res Function(_CandleDto) _then) = __$CandleDtoCopyWithImpl;
@override @useResult
$Res call({
 String time, dynamic open, dynamic high, dynamic low, dynamic close, dynamic volume
});




}
/// @nodoc
class __$CandleDtoCopyWithImpl<$Res>
    implements _$CandleDtoCopyWith<$Res> {
  __$CandleDtoCopyWithImpl(this._self, this._then);

  final _CandleDto _self;
  final $Res Function(_CandleDto) _then;

/// Create a copy of CandleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? open = freezed,Object? high = freezed,Object? low = freezed,Object? close = freezed,Object? volume = freezed,}) {
  return _then(_CandleDto(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,open: freezed == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as dynamic,high: freezed == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as dynamic,low: freezed == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as dynamic,close: freezed == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as dynamic,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc
mixin _$StockNewsResponseDto {

 List<StockNewsItemDto> get news;
/// Create a copy of StockNewsResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockNewsResponseDtoCopyWith<StockNewsResponseDto> get copyWith => _$StockNewsResponseDtoCopyWithImpl<StockNewsResponseDto>(this as StockNewsResponseDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockNewsResponseDto&&const DeepCollectionEquality().equals(other.news, news));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(news));

@override
String toString() {
  return 'StockNewsResponseDto(news: $news)';
}


}

/// @nodoc
abstract mixin class $StockNewsResponseDtoCopyWith<$Res>  {
  factory $StockNewsResponseDtoCopyWith(StockNewsResponseDto value, $Res Function(StockNewsResponseDto) _then) = _$StockNewsResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<StockNewsItemDto> news
});




}
/// @nodoc
class _$StockNewsResponseDtoCopyWithImpl<$Res>
    implements $StockNewsResponseDtoCopyWith<$Res> {
  _$StockNewsResponseDtoCopyWithImpl(this._self, this._then);

  final StockNewsResponseDto _self;
  final $Res Function(StockNewsResponseDto) _then;

/// Create a copy of StockNewsResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? news = null,}) {
  return _then(_self.copyWith(
news: null == news ? _self.news : news // ignore: cast_nullable_to_non_nullable
as List<StockNewsItemDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [StockNewsResponseDto].
extension StockNewsResponseDtoPatterns on StockNewsResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockNewsResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockNewsResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockNewsResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _StockNewsResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockNewsResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _StockNewsResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StockNewsItemDto> news)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockNewsResponseDto() when $default != null:
return $default(_that.news);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StockNewsItemDto> news)  $default,) {final _that = this;
switch (_that) {
case _StockNewsResponseDto():
return $default(_that.news);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StockNewsItemDto> news)?  $default,) {final _that = this;
switch (_that) {
case _StockNewsResponseDto() when $default != null:
return $default(_that.news);case _:
  return null;

}
}

}

/// @nodoc


class _StockNewsResponseDto extends StockNewsResponseDto {
  const _StockNewsResponseDto({required final  List<StockNewsItemDto> news}): _news = news,super._();
  

 final  List<StockNewsItemDto> _news;
@override List<StockNewsItemDto> get news {
  if (_news is EqualUnmodifiableListView) return _news;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_news);
}


/// Create a copy of StockNewsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockNewsResponseDtoCopyWith<_StockNewsResponseDto> get copyWith => __$StockNewsResponseDtoCopyWithImpl<_StockNewsResponseDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockNewsResponseDto&&const DeepCollectionEquality().equals(other._news, _news));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_news));

@override
String toString() {
  return 'StockNewsResponseDto(news: $news)';
}


}

/// @nodoc
abstract mixin class _$StockNewsResponseDtoCopyWith<$Res> implements $StockNewsResponseDtoCopyWith<$Res> {
  factory _$StockNewsResponseDtoCopyWith(_StockNewsResponseDto value, $Res Function(_StockNewsResponseDto) _then) = __$StockNewsResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<StockNewsItemDto> news
});




}
/// @nodoc
class __$StockNewsResponseDtoCopyWithImpl<$Res>
    implements _$StockNewsResponseDtoCopyWith<$Res> {
  __$StockNewsResponseDtoCopyWithImpl(this._self, this._then);

  final _StockNewsResponseDto _self;
  final $Res Function(_StockNewsResponseDto) _then;

/// Create a copy of StockNewsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? news = null,}) {
  return _then(_StockNewsResponseDto(
news: null == news ? _self._news : news // ignore: cast_nullable_to_non_nullable
as List<StockNewsItemDto>,
  ));
}


}


/// @nodoc
mixin _$StockNewsItemDto {

 String get title; String? get link; String? get description; String? get pubDate;
/// Create a copy of StockNewsItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockNewsItemDtoCopyWith<StockNewsItemDto> get copyWith => _$StockNewsItemDtoCopyWithImpl<StockNewsItemDto>(this as StockNewsItemDto, _$identity);

  /// Serializes this StockNewsItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockNewsItemDto&&(identical(other.title, title) || other.title == title)&&(identical(other.link, link) || other.link == link)&&(identical(other.description, description) || other.description == description)&&(identical(other.pubDate, pubDate) || other.pubDate == pubDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,link,description,pubDate);

@override
String toString() {
  return 'StockNewsItemDto(title: $title, link: $link, description: $description, pubDate: $pubDate)';
}


}

/// @nodoc
abstract mixin class $StockNewsItemDtoCopyWith<$Res>  {
  factory $StockNewsItemDtoCopyWith(StockNewsItemDto value, $Res Function(StockNewsItemDto) _then) = _$StockNewsItemDtoCopyWithImpl;
@useResult
$Res call({
 String title, String? link, String? description, String? pubDate
});




}
/// @nodoc
class _$StockNewsItemDtoCopyWithImpl<$Res>
    implements $StockNewsItemDtoCopyWith<$Res> {
  _$StockNewsItemDtoCopyWithImpl(this._self, this._then);

  final StockNewsItemDto _self;
  final $Res Function(StockNewsItemDto) _then;

/// Create a copy of StockNewsItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? link = freezed,Object? description = freezed,Object? pubDate = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,pubDate: freezed == pubDate ? _self.pubDate : pubDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StockNewsItemDto].
extension StockNewsItemDtoPatterns on StockNewsItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockNewsItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockNewsItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockNewsItemDto value)  $default,){
final _that = this;
switch (_that) {
case _StockNewsItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockNewsItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _StockNewsItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? link,  String? description,  String? pubDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockNewsItemDto() when $default != null:
return $default(_that.title,_that.link,_that.description,_that.pubDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? link,  String? description,  String? pubDate)  $default,) {final _that = this;
switch (_that) {
case _StockNewsItemDto():
return $default(_that.title,_that.link,_that.description,_that.pubDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? link,  String? description,  String? pubDate)?  $default,) {final _that = this;
switch (_that) {
case _StockNewsItemDto() when $default != null:
return $default(_that.title,_that.link,_that.description,_that.pubDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockNewsItemDto extends StockNewsItemDto {
  const _StockNewsItemDto({required this.title, this.link, this.description, this.pubDate}): super._();
  factory _StockNewsItemDto.fromJson(Map<String, dynamic> json) => _$StockNewsItemDtoFromJson(json);

@override final  String title;
@override final  String? link;
@override final  String? description;
@override final  String? pubDate;

/// Create a copy of StockNewsItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockNewsItemDtoCopyWith<_StockNewsItemDto> get copyWith => __$StockNewsItemDtoCopyWithImpl<_StockNewsItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockNewsItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockNewsItemDto&&(identical(other.title, title) || other.title == title)&&(identical(other.link, link) || other.link == link)&&(identical(other.description, description) || other.description == description)&&(identical(other.pubDate, pubDate) || other.pubDate == pubDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,link,description,pubDate);

@override
String toString() {
  return 'StockNewsItemDto(title: $title, link: $link, description: $description, pubDate: $pubDate)';
}


}

/// @nodoc
abstract mixin class _$StockNewsItemDtoCopyWith<$Res> implements $StockNewsItemDtoCopyWith<$Res> {
  factory _$StockNewsItemDtoCopyWith(_StockNewsItemDto value, $Res Function(_StockNewsItemDto) _then) = __$StockNewsItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String title, String? link, String? description, String? pubDate
});




}
/// @nodoc
class __$StockNewsItemDtoCopyWithImpl<$Res>
    implements _$StockNewsItemDtoCopyWith<$Res> {
  __$StockNewsItemDtoCopyWithImpl(this._self, this._then);

  final _StockNewsItemDto _self;
  final $Res Function(_StockNewsItemDto) _then;

/// Create a copy of StockNewsItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? link = freezed,Object? description = freezed,Object? pubDate = freezed,}) {
  return _then(_StockNewsItemDto(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,pubDate: freezed == pubDate ? _self.pubDate : pubDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
