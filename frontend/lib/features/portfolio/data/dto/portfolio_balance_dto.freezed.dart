// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio_balance_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PortfolioBalanceDto {

 PortfolioSummaryDto get summary; List<PortfolioHoldingDto> get holdings;
/// Create a copy of PortfolioBalanceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioBalanceDtoCopyWith<PortfolioBalanceDto> get copyWith => _$PortfolioBalanceDtoCopyWithImpl<PortfolioBalanceDto>(this as PortfolioBalanceDto, _$identity);

  /// Serializes this PortfolioBalanceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioBalanceDto&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.holdings, holdings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(holdings));

@override
String toString() {
  return 'PortfolioBalanceDto(summary: $summary, holdings: $holdings)';
}


}

/// @nodoc
abstract mixin class $PortfolioBalanceDtoCopyWith<$Res>  {
  factory $PortfolioBalanceDtoCopyWith(PortfolioBalanceDto value, $Res Function(PortfolioBalanceDto) _then) = _$PortfolioBalanceDtoCopyWithImpl;
@useResult
$Res call({
 PortfolioSummaryDto summary, List<PortfolioHoldingDto> holdings
});


$PortfolioSummaryDtoCopyWith<$Res> get summary;

}
/// @nodoc
class _$PortfolioBalanceDtoCopyWithImpl<$Res>
    implements $PortfolioBalanceDtoCopyWith<$Res> {
  _$PortfolioBalanceDtoCopyWithImpl(this._self, this._then);

  final PortfolioBalanceDto _self;
  final $Res Function(PortfolioBalanceDto) _then;

/// Create a copy of PortfolioBalanceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? holdings = null,}) {
  return _then(_self.copyWith(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as PortfolioSummaryDto,holdings: null == holdings ? _self.holdings : holdings // ignore: cast_nullable_to_non_nullable
as List<PortfolioHoldingDto>,
  ));
}
/// Create a copy of PortfolioBalanceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PortfolioSummaryDtoCopyWith<$Res> get summary {
  
  return $PortfolioSummaryDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [PortfolioBalanceDto].
extension PortfolioBalanceDtoPatterns on PortfolioBalanceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioBalanceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioBalanceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioBalanceDto value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioBalanceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioBalanceDto value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioBalanceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PortfolioSummaryDto summary,  List<PortfolioHoldingDto> holdings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioBalanceDto() when $default != null:
return $default(_that.summary,_that.holdings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PortfolioSummaryDto summary,  List<PortfolioHoldingDto> holdings)  $default,) {final _that = this;
switch (_that) {
case _PortfolioBalanceDto():
return $default(_that.summary,_that.holdings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PortfolioSummaryDto summary,  List<PortfolioHoldingDto> holdings)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioBalanceDto() when $default != null:
return $default(_that.summary,_that.holdings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PortfolioBalanceDto extends PortfolioBalanceDto {
  const _PortfolioBalanceDto({required this.summary, required final  List<PortfolioHoldingDto> holdings}): _holdings = holdings,super._();
  factory _PortfolioBalanceDto.fromJson(Map<String, dynamic> json) => _$PortfolioBalanceDtoFromJson(json);

@override final  PortfolioSummaryDto summary;
 final  List<PortfolioHoldingDto> _holdings;
@override List<PortfolioHoldingDto> get holdings {
  if (_holdings is EqualUnmodifiableListView) return _holdings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_holdings);
}


/// Create a copy of PortfolioBalanceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioBalanceDtoCopyWith<_PortfolioBalanceDto> get copyWith => __$PortfolioBalanceDtoCopyWithImpl<_PortfolioBalanceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PortfolioBalanceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioBalanceDto&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._holdings, _holdings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_holdings));

@override
String toString() {
  return 'PortfolioBalanceDto(summary: $summary, holdings: $holdings)';
}


}

/// @nodoc
abstract mixin class _$PortfolioBalanceDtoCopyWith<$Res> implements $PortfolioBalanceDtoCopyWith<$Res> {
  factory _$PortfolioBalanceDtoCopyWith(_PortfolioBalanceDto value, $Res Function(_PortfolioBalanceDto) _then) = __$PortfolioBalanceDtoCopyWithImpl;
@override @useResult
$Res call({
 PortfolioSummaryDto summary, List<PortfolioHoldingDto> holdings
});


@override $PortfolioSummaryDtoCopyWith<$Res> get summary;

}
/// @nodoc
class __$PortfolioBalanceDtoCopyWithImpl<$Res>
    implements _$PortfolioBalanceDtoCopyWith<$Res> {
  __$PortfolioBalanceDtoCopyWithImpl(this._self, this._then);

  final _PortfolioBalanceDto _self;
  final $Res Function(_PortfolioBalanceDto) _then;

/// Create a copy of PortfolioBalanceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? holdings = null,}) {
  return _then(_PortfolioBalanceDto(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as PortfolioSummaryDto,holdings: null == holdings ? _self._holdings : holdings // ignore: cast_nullable_to_non_nullable
as List<PortfolioHoldingDto>,
  ));
}

/// Create a copy of PortfolioBalanceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PortfolioSummaryDtoCopyWith<$Res> get summary {
  
  return $PortfolioSummaryDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// @nodoc
mixin _$PortfolioSummaryDto {

@JsonKey(name: 'total_asset') int get totalAsset;@JsonKey(name: 'available_cash') int get availableCash;@JsonKey(name: 'total_profit_loss') int get totalProfitLoss;@JsonKey(name: 'total_return_rate') double get totalReturnRate;
/// Create a copy of PortfolioSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioSummaryDtoCopyWith<PortfolioSummaryDto> get copyWith => _$PortfolioSummaryDtoCopyWithImpl<PortfolioSummaryDto>(this as PortfolioSummaryDto, _$identity);

  /// Serializes this PortfolioSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioSummaryDto&&(identical(other.totalAsset, totalAsset) || other.totalAsset == totalAsset)&&(identical(other.availableCash, availableCash) || other.availableCash == availableCash)&&(identical(other.totalProfitLoss, totalProfitLoss) || other.totalProfitLoss == totalProfitLoss)&&(identical(other.totalReturnRate, totalReturnRate) || other.totalReturnRate == totalReturnRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalAsset,availableCash,totalProfitLoss,totalReturnRate);

@override
String toString() {
  return 'PortfolioSummaryDto(totalAsset: $totalAsset, availableCash: $availableCash, totalProfitLoss: $totalProfitLoss, totalReturnRate: $totalReturnRate)';
}


}

/// @nodoc
abstract mixin class $PortfolioSummaryDtoCopyWith<$Res>  {
  factory $PortfolioSummaryDtoCopyWith(PortfolioSummaryDto value, $Res Function(PortfolioSummaryDto) _then) = _$PortfolioSummaryDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_asset') int totalAsset,@JsonKey(name: 'available_cash') int availableCash,@JsonKey(name: 'total_profit_loss') int totalProfitLoss,@JsonKey(name: 'total_return_rate') double totalReturnRate
});




}
/// @nodoc
class _$PortfolioSummaryDtoCopyWithImpl<$Res>
    implements $PortfolioSummaryDtoCopyWith<$Res> {
  _$PortfolioSummaryDtoCopyWithImpl(this._self, this._then);

  final PortfolioSummaryDto _self;
  final $Res Function(PortfolioSummaryDto) _then;

/// Create a copy of PortfolioSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalAsset = null,Object? availableCash = null,Object? totalProfitLoss = null,Object? totalReturnRate = null,}) {
  return _then(_self.copyWith(
totalAsset: null == totalAsset ? _self.totalAsset : totalAsset // ignore: cast_nullable_to_non_nullable
as int,availableCash: null == availableCash ? _self.availableCash : availableCash // ignore: cast_nullable_to_non_nullable
as int,totalProfitLoss: null == totalProfitLoss ? _self.totalProfitLoss : totalProfitLoss // ignore: cast_nullable_to_non_nullable
as int,totalReturnRate: null == totalReturnRate ? _self.totalReturnRate : totalReturnRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PortfolioSummaryDto].
extension PortfolioSummaryDtoPatterns on PortfolioSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_asset')  int totalAsset, @JsonKey(name: 'available_cash')  int availableCash, @JsonKey(name: 'total_profit_loss')  int totalProfitLoss, @JsonKey(name: 'total_return_rate')  double totalReturnRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioSummaryDto() when $default != null:
return $default(_that.totalAsset,_that.availableCash,_that.totalProfitLoss,_that.totalReturnRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_asset')  int totalAsset, @JsonKey(name: 'available_cash')  int availableCash, @JsonKey(name: 'total_profit_loss')  int totalProfitLoss, @JsonKey(name: 'total_return_rate')  double totalReturnRate)  $default,) {final _that = this;
switch (_that) {
case _PortfolioSummaryDto():
return $default(_that.totalAsset,_that.availableCash,_that.totalProfitLoss,_that.totalReturnRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_asset')  int totalAsset, @JsonKey(name: 'available_cash')  int availableCash, @JsonKey(name: 'total_profit_loss')  int totalProfitLoss, @JsonKey(name: 'total_return_rate')  double totalReturnRate)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioSummaryDto() when $default != null:
return $default(_that.totalAsset,_that.availableCash,_that.totalProfitLoss,_that.totalReturnRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PortfolioSummaryDto extends PortfolioSummaryDto {
  const _PortfolioSummaryDto({@JsonKey(name: 'total_asset') required this.totalAsset, @JsonKey(name: 'available_cash') required this.availableCash, @JsonKey(name: 'total_profit_loss') required this.totalProfitLoss, @JsonKey(name: 'total_return_rate') required this.totalReturnRate}): super._();
  factory _PortfolioSummaryDto.fromJson(Map<String, dynamic> json) => _$PortfolioSummaryDtoFromJson(json);

@override@JsonKey(name: 'total_asset') final  int totalAsset;
@override@JsonKey(name: 'available_cash') final  int availableCash;
@override@JsonKey(name: 'total_profit_loss') final  int totalProfitLoss;
@override@JsonKey(name: 'total_return_rate') final  double totalReturnRate;

/// Create a copy of PortfolioSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioSummaryDtoCopyWith<_PortfolioSummaryDto> get copyWith => __$PortfolioSummaryDtoCopyWithImpl<_PortfolioSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PortfolioSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioSummaryDto&&(identical(other.totalAsset, totalAsset) || other.totalAsset == totalAsset)&&(identical(other.availableCash, availableCash) || other.availableCash == availableCash)&&(identical(other.totalProfitLoss, totalProfitLoss) || other.totalProfitLoss == totalProfitLoss)&&(identical(other.totalReturnRate, totalReturnRate) || other.totalReturnRate == totalReturnRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalAsset,availableCash,totalProfitLoss,totalReturnRate);

@override
String toString() {
  return 'PortfolioSummaryDto(totalAsset: $totalAsset, availableCash: $availableCash, totalProfitLoss: $totalProfitLoss, totalReturnRate: $totalReturnRate)';
}


}

/// @nodoc
abstract mixin class _$PortfolioSummaryDtoCopyWith<$Res> implements $PortfolioSummaryDtoCopyWith<$Res> {
  factory _$PortfolioSummaryDtoCopyWith(_PortfolioSummaryDto value, $Res Function(_PortfolioSummaryDto) _then) = __$PortfolioSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_asset') int totalAsset,@JsonKey(name: 'available_cash') int availableCash,@JsonKey(name: 'total_profit_loss') int totalProfitLoss,@JsonKey(name: 'total_return_rate') double totalReturnRate
});




}
/// @nodoc
class __$PortfolioSummaryDtoCopyWithImpl<$Res>
    implements _$PortfolioSummaryDtoCopyWith<$Res> {
  __$PortfolioSummaryDtoCopyWithImpl(this._self, this._then);

  final _PortfolioSummaryDto _self;
  final $Res Function(_PortfolioSummaryDto) _then;

/// Create a copy of PortfolioSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalAsset = null,Object? availableCash = null,Object? totalProfitLoss = null,Object? totalReturnRate = null,}) {
  return _then(_PortfolioSummaryDto(
totalAsset: null == totalAsset ? _self.totalAsset : totalAsset // ignore: cast_nullable_to_non_nullable
as int,availableCash: null == availableCash ? _self.availableCash : availableCash // ignore: cast_nullable_to_non_nullable
as int,totalProfitLoss: null == totalProfitLoss ? _self.totalProfitLoss : totalProfitLoss // ignore: cast_nullable_to_non_nullable
as int,totalReturnRate: null == totalReturnRate ? _self.totalReturnRate : totalReturnRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PortfolioHoldingDto {

 String get ticker; String get name; int get quantity;@JsonKey(name: 'purchase_price') int get purchasePrice;@JsonKey(name: 'current_price') int get currentPrice;@JsonKey(name: 'profit_loss_rate') double get profitLossRate;
/// Create a copy of PortfolioHoldingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioHoldingDtoCopyWith<PortfolioHoldingDto> get copyWith => _$PortfolioHoldingDtoCopyWithImpl<PortfolioHoldingDto>(this as PortfolioHoldingDto, _$identity);

  /// Serializes this PortfolioHoldingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioHoldingDto&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.currentPrice, currentPrice) || other.currentPrice == currentPrice)&&(identical(other.profitLossRate, profitLossRate) || other.profitLossRate == profitLossRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticker,name,quantity,purchasePrice,currentPrice,profitLossRate);

@override
String toString() {
  return 'PortfolioHoldingDto(ticker: $ticker, name: $name, quantity: $quantity, purchasePrice: $purchasePrice, currentPrice: $currentPrice, profitLossRate: $profitLossRate)';
}


}

/// @nodoc
abstract mixin class $PortfolioHoldingDtoCopyWith<$Res>  {
  factory $PortfolioHoldingDtoCopyWith(PortfolioHoldingDto value, $Res Function(PortfolioHoldingDto) _then) = _$PortfolioHoldingDtoCopyWithImpl;
@useResult
$Res call({
 String ticker, String name, int quantity,@JsonKey(name: 'purchase_price') int purchasePrice,@JsonKey(name: 'current_price') int currentPrice,@JsonKey(name: 'profit_loss_rate') double profitLossRate
});




}
/// @nodoc
class _$PortfolioHoldingDtoCopyWithImpl<$Res>
    implements $PortfolioHoldingDtoCopyWith<$Res> {
  _$PortfolioHoldingDtoCopyWithImpl(this._self, this._then);

  final PortfolioHoldingDto _self;
  final $Res Function(PortfolioHoldingDto) _then;

/// Create a copy of PortfolioHoldingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? name = null,Object? quantity = null,Object? purchasePrice = null,Object? currentPrice = null,Object? profitLossRate = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,purchasePrice: null == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as int,currentPrice: null == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as int,profitLossRate: null == profitLossRate ? _self.profitLossRate : profitLossRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PortfolioHoldingDto].
extension PortfolioHoldingDtoPatterns on PortfolioHoldingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioHoldingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioHoldingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioHoldingDto value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioHoldingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioHoldingDto value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioHoldingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String name,  int quantity, @JsonKey(name: 'purchase_price')  int purchasePrice, @JsonKey(name: 'current_price')  int currentPrice, @JsonKey(name: 'profit_loss_rate')  double profitLossRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioHoldingDto() when $default != null:
return $default(_that.ticker,_that.name,_that.quantity,_that.purchasePrice,_that.currentPrice,_that.profitLossRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String name,  int quantity, @JsonKey(name: 'purchase_price')  int purchasePrice, @JsonKey(name: 'current_price')  int currentPrice, @JsonKey(name: 'profit_loss_rate')  double profitLossRate)  $default,) {final _that = this;
switch (_that) {
case _PortfolioHoldingDto():
return $default(_that.ticker,_that.name,_that.quantity,_that.purchasePrice,_that.currentPrice,_that.profitLossRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String name,  int quantity, @JsonKey(name: 'purchase_price')  int purchasePrice, @JsonKey(name: 'current_price')  int currentPrice, @JsonKey(name: 'profit_loss_rate')  double profitLossRate)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioHoldingDto() when $default != null:
return $default(_that.ticker,_that.name,_that.quantity,_that.purchasePrice,_that.currentPrice,_that.profitLossRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PortfolioHoldingDto extends PortfolioHoldingDto {
  const _PortfolioHoldingDto({required this.ticker, required this.name, required this.quantity, @JsonKey(name: 'purchase_price') required this.purchasePrice, @JsonKey(name: 'current_price') required this.currentPrice, @JsonKey(name: 'profit_loss_rate') required this.profitLossRate}): super._();
  factory _PortfolioHoldingDto.fromJson(Map<String, dynamic> json) => _$PortfolioHoldingDtoFromJson(json);

@override final  String ticker;
@override final  String name;
@override final  int quantity;
@override@JsonKey(name: 'purchase_price') final  int purchasePrice;
@override@JsonKey(name: 'current_price') final  int currentPrice;
@override@JsonKey(name: 'profit_loss_rate') final  double profitLossRate;

/// Create a copy of PortfolioHoldingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioHoldingDtoCopyWith<_PortfolioHoldingDto> get copyWith => __$PortfolioHoldingDtoCopyWithImpl<_PortfolioHoldingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PortfolioHoldingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioHoldingDto&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.currentPrice, currentPrice) || other.currentPrice == currentPrice)&&(identical(other.profitLossRate, profitLossRate) || other.profitLossRate == profitLossRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticker,name,quantity,purchasePrice,currentPrice,profitLossRate);

@override
String toString() {
  return 'PortfolioHoldingDto(ticker: $ticker, name: $name, quantity: $quantity, purchasePrice: $purchasePrice, currentPrice: $currentPrice, profitLossRate: $profitLossRate)';
}


}

/// @nodoc
abstract mixin class _$PortfolioHoldingDtoCopyWith<$Res> implements $PortfolioHoldingDtoCopyWith<$Res> {
  factory _$PortfolioHoldingDtoCopyWith(_PortfolioHoldingDto value, $Res Function(_PortfolioHoldingDto) _then) = __$PortfolioHoldingDtoCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String name, int quantity,@JsonKey(name: 'purchase_price') int purchasePrice,@JsonKey(name: 'current_price') int currentPrice,@JsonKey(name: 'profit_loss_rate') double profitLossRate
});




}
/// @nodoc
class __$PortfolioHoldingDtoCopyWithImpl<$Res>
    implements _$PortfolioHoldingDtoCopyWith<$Res> {
  __$PortfolioHoldingDtoCopyWithImpl(this._self, this._then);

  final _PortfolioHoldingDto _self;
  final $Res Function(_PortfolioHoldingDto) _then;

/// Create a copy of PortfolioHoldingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? name = null,Object? quantity = null,Object? purchasePrice = null,Object? currentPrice = null,Object? profitLossRate = null,}) {
  return _then(_PortfolioHoldingDto(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,purchasePrice: null == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as int,currentPrice: null == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as int,profitLossRate: null == profitLossRate ? _self.profitLossRate : profitLossRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
