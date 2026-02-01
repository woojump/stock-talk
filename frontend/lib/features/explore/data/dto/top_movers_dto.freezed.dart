// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'top_movers_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TopMoversDto {

 List<StockItemDto> get up; List<StockItemDto> get down; List<StockItemDto> get popular; List<StockItemDto> get buy; List<StockItemDto> get sell;
/// Create a copy of TopMoversDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopMoversDtoCopyWith<TopMoversDto> get copyWith => _$TopMoversDtoCopyWithImpl<TopMoversDto>(this as TopMoversDto, _$identity);

  /// Serializes this TopMoversDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopMoversDto&&const DeepCollectionEquality().equals(other.up, up)&&const DeepCollectionEquality().equals(other.down, down)&&const DeepCollectionEquality().equals(other.popular, popular)&&const DeepCollectionEquality().equals(other.buy, buy)&&const DeepCollectionEquality().equals(other.sell, sell));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(up),const DeepCollectionEquality().hash(down),const DeepCollectionEquality().hash(popular),const DeepCollectionEquality().hash(buy),const DeepCollectionEquality().hash(sell));

@override
String toString() {
  return 'TopMoversDto(up: $up, down: $down, popular: $popular, buy: $buy, sell: $sell)';
}


}

/// @nodoc
abstract mixin class $TopMoversDtoCopyWith<$Res>  {
  factory $TopMoversDtoCopyWith(TopMoversDto value, $Res Function(TopMoversDto) _then) = _$TopMoversDtoCopyWithImpl;
@useResult
$Res call({
 List<StockItemDto> up, List<StockItemDto> down, List<StockItemDto> popular, List<StockItemDto> buy, List<StockItemDto> sell
});




}
/// @nodoc
class _$TopMoversDtoCopyWithImpl<$Res>
    implements $TopMoversDtoCopyWith<$Res> {
  _$TopMoversDtoCopyWithImpl(this._self, this._then);

  final TopMoversDto _self;
  final $Res Function(TopMoversDto) _then;

/// Create a copy of TopMoversDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? up = null,Object? down = null,Object? popular = null,Object? buy = null,Object? sell = null,}) {
  return _then(_self.copyWith(
up: null == up ? _self.up : up // ignore: cast_nullable_to_non_nullable
as List<StockItemDto>,down: null == down ? _self.down : down // ignore: cast_nullable_to_non_nullable
as List<StockItemDto>,popular: null == popular ? _self.popular : popular // ignore: cast_nullable_to_non_nullable
as List<StockItemDto>,buy: null == buy ? _self.buy : buy // ignore: cast_nullable_to_non_nullable
as List<StockItemDto>,sell: null == sell ? _self.sell : sell // ignore: cast_nullable_to_non_nullable
as List<StockItemDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [TopMoversDto].
extension TopMoversDtoPatterns on TopMoversDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopMoversDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopMoversDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopMoversDto value)  $default,){
final _that = this;
switch (_that) {
case _TopMoversDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopMoversDto value)?  $default,){
final _that = this;
switch (_that) {
case _TopMoversDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StockItemDto> up,  List<StockItemDto> down,  List<StockItemDto> popular,  List<StockItemDto> buy,  List<StockItemDto> sell)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopMoversDto() when $default != null:
return $default(_that.up,_that.down,_that.popular,_that.buy,_that.sell);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StockItemDto> up,  List<StockItemDto> down,  List<StockItemDto> popular,  List<StockItemDto> buy,  List<StockItemDto> sell)  $default,) {final _that = this;
switch (_that) {
case _TopMoversDto():
return $default(_that.up,_that.down,_that.popular,_that.buy,_that.sell);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StockItemDto> up,  List<StockItemDto> down,  List<StockItemDto> popular,  List<StockItemDto> buy,  List<StockItemDto> sell)?  $default,) {final _that = this;
switch (_that) {
case _TopMoversDto() when $default != null:
return $default(_that.up,_that.down,_that.popular,_that.buy,_that.sell);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopMoversDto extends TopMoversDto {
  const _TopMoversDto({required final  List<StockItemDto> up, required final  List<StockItemDto> down, required final  List<StockItemDto> popular, required final  List<StockItemDto> buy, required final  List<StockItemDto> sell}): _up = up,_down = down,_popular = popular,_buy = buy,_sell = sell,super._();
  factory _TopMoversDto.fromJson(Map<String, dynamic> json) => _$TopMoversDtoFromJson(json);

 final  List<StockItemDto> _up;
@override List<StockItemDto> get up {
  if (_up is EqualUnmodifiableListView) return _up;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_up);
}

 final  List<StockItemDto> _down;
@override List<StockItemDto> get down {
  if (_down is EqualUnmodifiableListView) return _down;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_down);
}

 final  List<StockItemDto> _popular;
@override List<StockItemDto> get popular {
  if (_popular is EqualUnmodifiableListView) return _popular;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_popular);
}

 final  List<StockItemDto> _buy;
@override List<StockItemDto> get buy {
  if (_buy is EqualUnmodifiableListView) return _buy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_buy);
}

 final  List<StockItemDto> _sell;
@override List<StockItemDto> get sell {
  if (_sell is EqualUnmodifiableListView) return _sell;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sell);
}


/// Create a copy of TopMoversDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopMoversDtoCopyWith<_TopMoversDto> get copyWith => __$TopMoversDtoCopyWithImpl<_TopMoversDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopMoversDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopMoversDto&&const DeepCollectionEquality().equals(other._up, _up)&&const DeepCollectionEquality().equals(other._down, _down)&&const DeepCollectionEquality().equals(other._popular, _popular)&&const DeepCollectionEquality().equals(other._buy, _buy)&&const DeepCollectionEquality().equals(other._sell, _sell));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_up),const DeepCollectionEquality().hash(_down),const DeepCollectionEquality().hash(_popular),const DeepCollectionEquality().hash(_buy),const DeepCollectionEquality().hash(_sell));

@override
String toString() {
  return 'TopMoversDto(up: $up, down: $down, popular: $popular, buy: $buy, sell: $sell)';
}


}

/// @nodoc
abstract mixin class _$TopMoversDtoCopyWith<$Res> implements $TopMoversDtoCopyWith<$Res> {
  factory _$TopMoversDtoCopyWith(_TopMoversDto value, $Res Function(_TopMoversDto) _then) = __$TopMoversDtoCopyWithImpl;
@override @useResult
$Res call({
 List<StockItemDto> up, List<StockItemDto> down, List<StockItemDto> popular, List<StockItemDto> buy, List<StockItemDto> sell
});




}
/// @nodoc
class __$TopMoversDtoCopyWithImpl<$Res>
    implements _$TopMoversDtoCopyWith<$Res> {
  __$TopMoversDtoCopyWithImpl(this._self, this._then);

  final _TopMoversDto _self;
  final $Res Function(_TopMoversDto) _then;

/// Create a copy of TopMoversDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? up = null,Object? down = null,Object? popular = null,Object? buy = null,Object? sell = null,}) {
  return _then(_TopMoversDto(
up: null == up ? _self._up : up // ignore: cast_nullable_to_non_nullable
as List<StockItemDto>,down: null == down ? _self._down : down // ignore: cast_nullable_to_non_nullable
as List<StockItemDto>,popular: null == popular ? _self._popular : popular // ignore: cast_nullable_to_non_nullable
as List<StockItemDto>,buy: null == buy ? _self._buy : buy // ignore: cast_nullable_to_non_nullable
as List<StockItemDto>,sell: null == sell ? _self._sell : sell // ignore: cast_nullable_to_non_nullable
as List<StockItemDto>,
  ));
}


}


/// @nodoc
mixin _$StockItemDto {

// 카테고리별로 제공되는 필드가 달라서 일단 모두 optional 처리
// 상승/하락/인기 카테고리에서는 등락률(rate)과 가격(price) 제공
// 기관 순매수/순매도 카테고리에서는 가격 아닌 거래량 관련 필드 제공
// 일단 현재 도메인 엔티티 변환 시에는 등락률과 가격만 사용하고, 나머지 필드는 무시
// TODO: 도메인 엔티티에 거래량 관련 필드 추가
 String get name; String? get rate; String? get price; String? get rank; String? get code;@JsonKey(name: 'net_amount') String? get netAmount;@JsonKey(name: 'buy_qty') String? get buyQty;@JsonKey(name: 'sel_qty') String? get selQty;
/// Create a copy of StockItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockItemDtoCopyWith<StockItemDto> get copyWith => _$StockItemDtoCopyWithImpl<StockItemDto>(this as StockItemDto, _$identity);

  /// Serializes this StockItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockItemDto&&(identical(other.name, name) || other.name == name)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.price, price) || other.price == price)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.code, code) || other.code == code)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.buyQty, buyQty) || other.buyQty == buyQty)&&(identical(other.selQty, selQty) || other.selQty == selQty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,rate,price,rank,code,netAmount,buyQty,selQty);

@override
String toString() {
  return 'StockItemDto(name: $name, rate: $rate, price: $price, rank: $rank, code: $code, netAmount: $netAmount, buyQty: $buyQty, selQty: $selQty)';
}


}

/// @nodoc
abstract mixin class $StockItemDtoCopyWith<$Res>  {
  factory $StockItemDtoCopyWith(StockItemDto value, $Res Function(StockItemDto) _then) = _$StockItemDtoCopyWithImpl;
@useResult
$Res call({
 String name, String? rate, String? price, String? rank, String? code,@JsonKey(name: 'net_amount') String? netAmount,@JsonKey(name: 'buy_qty') String? buyQty,@JsonKey(name: 'sel_qty') String? selQty
});




}
/// @nodoc
class _$StockItemDtoCopyWithImpl<$Res>
    implements $StockItemDtoCopyWith<$Res> {
  _$StockItemDtoCopyWithImpl(this._self, this._then);

  final StockItemDto _self;
  final $Res Function(StockItemDto) _then;

/// Create a copy of StockItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? rate = freezed,Object? price = freezed,Object? rank = freezed,Object? code = freezed,Object? netAmount = freezed,Object? buyQty = freezed,Object? selQty = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String?,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as String?,buyQty: freezed == buyQty ? _self.buyQty : buyQty // ignore: cast_nullable_to_non_nullable
as String?,selQty: freezed == selQty ? _self.selQty : selQty // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StockItemDto].
extension StockItemDtoPatterns on StockItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockItemDto value)  $default,){
final _that = this;
switch (_that) {
case _StockItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _StockItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? rate,  String? price,  String? rank,  String? code, @JsonKey(name: 'net_amount')  String? netAmount, @JsonKey(name: 'buy_qty')  String? buyQty, @JsonKey(name: 'sel_qty')  String? selQty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockItemDto() when $default != null:
return $default(_that.name,_that.rate,_that.price,_that.rank,_that.code,_that.netAmount,_that.buyQty,_that.selQty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? rate,  String? price,  String? rank,  String? code, @JsonKey(name: 'net_amount')  String? netAmount, @JsonKey(name: 'buy_qty')  String? buyQty, @JsonKey(name: 'sel_qty')  String? selQty)  $default,) {final _that = this;
switch (_that) {
case _StockItemDto():
return $default(_that.name,_that.rate,_that.price,_that.rank,_that.code,_that.netAmount,_that.buyQty,_that.selQty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? rate,  String? price,  String? rank,  String? code, @JsonKey(name: 'net_amount')  String? netAmount, @JsonKey(name: 'buy_qty')  String? buyQty, @JsonKey(name: 'sel_qty')  String? selQty)?  $default,) {final _that = this;
switch (_that) {
case _StockItemDto() when $default != null:
return $default(_that.name,_that.rate,_that.price,_that.rank,_that.code,_that.netAmount,_that.buyQty,_that.selQty);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockItemDto extends StockItemDto {
  const _StockItemDto({required this.name, this.rate, this.price, this.rank, this.code, @JsonKey(name: 'net_amount') this.netAmount, @JsonKey(name: 'buy_qty') this.buyQty, @JsonKey(name: 'sel_qty') this.selQty}): super._();
  factory _StockItemDto.fromJson(Map<String, dynamic> json) => _$StockItemDtoFromJson(json);

// 카테고리별로 제공되는 필드가 달라서 일단 모두 optional 처리
// 상승/하락/인기 카테고리에서는 등락률(rate)과 가격(price) 제공
// 기관 순매수/순매도 카테고리에서는 가격 아닌 거래량 관련 필드 제공
// 일단 현재 도메인 엔티티 변환 시에는 등락률과 가격만 사용하고, 나머지 필드는 무시
// TODO: 도메인 엔티티에 거래량 관련 필드 추가
@override final  String name;
@override final  String? rate;
@override final  String? price;
@override final  String? rank;
@override final  String? code;
@override@JsonKey(name: 'net_amount') final  String? netAmount;
@override@JsonKey(name: 'buy_qty') final  String? buyQty;
@override@JsonKey(name: 'sel_qty') final  String? selQty;

/// Create a copy of StockItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockItemDtoCopyWith<_StockItemDto> get copyWith => __$StockItemDtoCopyWithImpl<_StockItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockItemDto&&(identical(other.name, name) || other.name == name)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.price, price) || other.price == price)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.code, code) || other.code == code)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.buyQty, buyQty) || other.buyQty == buyQty)&&(identical(other.selQty, selQty) || other.selQty == selQty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,rate,price,rank,code,netAmount,buyQty,selQty);

@override
String toString() {
  return 'StockItemDto(name: $name, rate: $rate, price: $price, rank: $rank, code: $code, netAmount: $netAmount, buyQty: $buyQty, selQty: $selQty)';
}


}

/// @nodoc
abstract mixin class _$StockItemDtoCopyWith<$Res> implements $StockItemDtoCopyWith<$Res> {
  factory _$StockItemDtoCopyWith(_StockItemDto value, $Res Function(_StockItemDto) _then) = __$StockItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, String? rate, String? price, String? rank, String? code,@JsonKey(name: 'net_amount') String? netAmount,@JsonKey(name: 'buy_qty') String? buyQty,@JsonKey(name: 'sel_qty') String? selQty
});




}
/// @nodoc
class __$StockItemDtoCopyWithImpl<$Res>
    implements _$StockItemDtoCopyWith<$Res> {
  __$StockItemDtoCopyWithImpl(this._self, this._then);

  final _StockItemDto _self;
  final $Res Function(_StockItemDto) _then;

/// Create a copy of StockItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? rate = freezed,Object? price = freezed,Object? rank = freezed,Object? code = freezed,Object? netAmount = freezed,Object? buyQty = freezed,Object? selQty = freezed,}) {
  return _then(_StockItemDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String?,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as String?,buyQty: freezed == buyQty ? _self.buyQty : buyQty // ignore: cast_nullable_to_non_nullable
as String?,selQty: freezed == selQty ? _self.selQty : selQty // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
