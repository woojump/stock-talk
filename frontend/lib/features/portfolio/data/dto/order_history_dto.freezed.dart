// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_history_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderHistoryDto {

 String get status; int get count; List<OrderHistoryItemDto> get data;
/// Create a copy of OrderHistoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderHistoryDtoCopyWith<OrderHistoryDto> get copyWith => _$OrderHistoryDtoCopyWithImpl<OrderHistoryDto>(this as OrderHistoryDto, _$identity);

  /// Serializes this OrderHistoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderHistoryDto&&(identical(other.status, status) || other.status == status)&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,count,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'OrderHistoryDto(status: $status, count: $count, data: $data)';
}


}

/// @nodoc
abstract mixin class $OrderHistoryDtoCopyWith<$Res>  {
  factory $OrderHistoryDtoCopyWith(OrderHistoryDto value, $Res Function(OrderHistoryDto) _then) = _$OrderHistoryDtoCopyWithImpl;
@useResult
$Res call({
 String status, int count, List<OrderHistoryItemDto> data
});




}
/// @nodoc
class _$OrderHistoryDtoCopyWithImpl<$Res>
    implements $OrderHistoryDtoCopyWith<$Res> {
  _$OrderHistoryDtoCopyWithImpl(this._self, this._then);

  final OrderHistoryDto _self;
  final $Res Function(OrderHistoryDto) _then;

/// Create a copy of OrderHistoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? count = null,Object? data = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<OrderHistoryItemDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderHistoryDto].
extension OrderHistoryDtoPatterns on OrderHistoryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderHistoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderHistoryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderHistoryDto value)  $default,){
final _that = this;
switch (_that) {
case _OrderHistoryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderHistoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _OrderHistoryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  int count,  List<OrderHistoryItemDto> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderHistoryDto() when $default != null:
return $default(_that.status,_that.count,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  int count,  List<OrderHistoryItemDto> data)  $default,) {final _that = this;
switch (_that) {
case _OrderHistoryDto():
return $default(_that.status,_that.count,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  int count,  List<OrderHistoryItemDto> data)?  $default,) {final _that = this;
switch (_that) {
case _OrderHistoryDto() when $default != null:
return $default(_that.status,_that.count,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderHistoryDto extends OrderHistoryDto {
  const _OrderHistoryDto({required this.status, required this.count, required final  List<OrderHistoryItemDto> data}): _data = data,super._();
  factory _OrderHistoryDto.fromJson(Map<String, dynamic> json) => _$OrderHistoryDtoFromJson(json);

@override final  String status;
@override final  int count;
 final  List<OrderHistoryItemDto> _data;
@override List<OrderHistoryItemDto> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of OrderHistoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderHistoryDtoCopyWith<_OrderHistoryDto> get copyWith => __$OrderHistoryDtoCopyWithImpl<_OrderHistoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderHistoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderHistoryDto&&(identical(other.status, status) || other.status == status)&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,count,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'OrderHistoryDto(status: $status, count: $count, data: $data)';
}


}

/// @nodoc
abstract mixin class _$OrderHistoryDtoCopyWith<$Res> implements $OrderHistoryDtoCopyWith<$Res> {
  factory _$OrderHistoryDtoCopyWith(_OrderHistoryDto value, $Res Function(_OrderHistoryDto) _then) = __$OrderHistoryDtoCopyWithImpl;
@override @useResult
$Res call({
 String status, int count, List<OrderHistoryItemDto> data
});




}
/// @nodoc
class __$OrderHistoryDtoCopyWithImpl<$Res>
    implements _$OrderHistoryDtoCopyWith<$Res> {
  __$OrderHistoryDtoCopyWithImpl(this._self, this._then);

  final _OrderHistoryDto _self;
  final $Res Function(_OrderHistoryDto) _then;

/// Create a copy of OrderHistoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? count = null,Object? data = null,}) {
  return _then(_OrderHistoryDto(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<OrderHistoryItemDto>,
  ));
}


}


/// @nodoc
mixin _$OrderHistoryItemDto {

@JsonKey(name: 'ord_no') String get ordNo; String get ticker; String get name;@JsonKey(name: 'ord_qty') int get ordQty;@JsonKey(name: 'ord_price') int get ordPrice;@JsonKey(name: 'cntr_qty') int get cntrQty;@JsonKey(name: 'remnq_qty') int get remnqQty; String get side;@JsonKey(name: 'ord_tm') String get ordTm; String get status;
/// Create a copy of OrderHistoryItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderHistoryItemDtoCopyWith<OrderHistoryItemDto> get copyWith => _$OrderHistoryItemDtoCopyWithImpl<OrderHistoryItemDto>(this as OrderHistoryItemDto, _$identity);

  /// Serializes this OrderHistoryItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderHistoryItemDto&&(identical(other.ordNo, ordNo) || other.ordNo == ordNo)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.name, name) || other.name == name)&&(identical(other.ordQty, ordQty) || other.ordQty == ordQty)&&(identical(other.ordPrice, ordPrice) || other.ordPrice == ordPrice)&&(identical(other.cntrQty, cntrQty) || other.cntrQty == cntrQty)&&(identical(other.remnqQty, remnqQty) || other.remnqQty == remnqQty)&&(identical(other.side, side) || other.side == side)&&(identical(other.ordTm, ordTm) || other.ordTm == ordTm)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ordNo,ticker,name,ordQty,ordPrice,cntrQty,remnqQty,side,ordTm,status);

@override
String toString() {
  return 'OrderHistoryItemDto(ordNo: $ordNo, ticker: $ticker, name: $name, ordQty: $ordQty, ordPrice: $ordPrice, cntrQty: $cntrQty, remnqQty: $remnqQty, side: $side, ordTm: $ordTm, status: $status)';
}


}

/// @nodoc
abstract mixin class $OrderHistoryItemDtoCopyWith<$Res>  {
  factory $OrderHistoryItemDtoCopyWith(OrderHistoryItemDto value, $Res Function(OrderHistoryItemDto) _then) = _$OrderHistoryItemDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'ord_no') String ordNo, String ticker, String name,@JsonKey(name: 'ord_qty') int ordQty,@JsonKey(name: 'ord_price') int ordPrice,@JsonKey(name: 'cntr_qty') int cntrQty,@JsonKey(name: 'remnq_qty') int remnqQty, String side,@JsonKey(name: 'ord_tm') String ordTm, String status
});




}
/// @nodoc
class _$OrderHistoryItemDtoCopyWithImpl<$Res>
    implements $OrderHistoryItemDtoCopyWith<$Res> {
  _$OrderHistoryItemDtoCopyWithImpl(this._self, this._then);

  final OrderHistoryItemDto _self;
  final $Res Function(OrderHistoryItemDto) _then;

/// Create a copy of OrderHistoryItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ordNo = null,Object? ticker = null,Object? name = null,Object? ordQty = null,Object? ordPrice = null,Object? cntrQty = null,Object? remnqQty = null,Object? side = null,Object? ordTm = null,Object? status = null,}) {
  return _then(_self.copyWith(
ordNo: null == ordNo ? _self.ordNo : ordNo // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ordQty: null == ordQty ? _self.ordQty : ordQty // ignore: cast_nullable_to_non_nullable
as int,ordPrice: null == ordPrice ? _self.ordPrice : ordPrice // ignore: cast_nullable_to_non_nullable
as int,cntrQty: null == cntrQty ? _self.cntrQty : cntrQty // ignore: cast_nullable_to_non_nullable
as int,remnqQty: null == remnqQty ? _self.remnqQty : remnqQty // ignore: cast_nullable_to_non_nullable
as int,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as String,ordTm: null == ordTm ? _self.ordTm : ordTm // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderHistoryItemDto].
extension OrderHistoryItemDtoPatterns on OrderHistoryItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderHistoryItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderHistoryItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderHistoryItemDto value)  $default,){
final _that = this;
switch (_that) {
case _OrderHistoryItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderHistoryItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _OrderHistoryItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'ord_no')  String ordNo,  String ticker,  String name, @JsonKey(name: 'ord_qty')  int ordQty, @JsonKey(name: 'ord_price')  int ordPrice, @JsonKey(name: 'cntr_qty')  int cntrQty, @JsonKey(name: 'remnq_qty')  int remnqQty,  String side, @JsonKey(name: 'ord_tm')  String ordTm,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderHistoryItemDto() when $default != null:
return $default(_that.ordNo,_that.ticker,_that.name,_that.ordQty,_that.ordPrice,_that.cntrQty,_that.remnqQty,_that.side,_that.ordTm,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'ord_no')  String ordNo,  String ticker,  String name, @JsonKey(name: 'ord_qty')  int ordQty, @JsonKey(name: 'ord_price')  int ordPrice, @JsonKey(name: 'cntr_qty')  int cntrQty, @JsonKey(name: 'remnq_qty')  int remnqQty,  String side, @JsonKey(name: 'ord_tm')  String ordTm,  String status)  $default,) {final _that = this;
switch (_that) {
case _OrderHistoryItemDto():
return $default(_that.ordNo,_that.ticker,_that.name,_that.ordQty,_that.ordPrice,_that.cntrQty,_that.remnqQty,_that.side,_that.ordTm,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'ord_no')  String ordNo,  String ticker,  String name, @JsonKey(name: 'ord_qty')  int ordQty, @JsonKey(name: 'ord_price')  int ordPrice, @JsonKey(name: 'cntr_qty')  int cntrQty, @JsonKey(name: 'remnq_qty')  int remnqQty,  String side, @JsonKey(name: 'ord_tm')  String ordTm,  String status)?  $default,) {final _that = this;
switch (_that) {
case _OrderHistoryItemDto() when $default != null:
return $default(_that.ordNo,_that.ticker,_that.name,_that.ordQty,_that.ordPrice,_that.cntrQty,_that.remnqQty,_that.side,_that.ordTm,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderHistoryItemDto extends OrderHistoryItemDto {
  const _OrderHistoryItemDto({@JsonKey(name: 'ord_no') required this.ordNo, required this.ticker, required this.name, @JsonKey(name: 'ord_qty') required this.ordQty, @JsonKey(name: 'ord_price') required this.ordPrice, @JsonKey(name: 'cntr_qty') required this.cntrQty, @JsonKey(name: 'remnq_qty') required this.remnqQty, required this.side, @JsonKey(name: 'ord_tm') required this.ordTm, required this.status}): super._();
  factory _OrderHistoryItemDto.fromJson(Map<String, dynamic> json) => _$OrderHistoryItemDtoFromJson(json);

@override@JsonKey(name: 'ord_no') final  String ordNo;
@override final  String ticker;
@override final  String name;
@override@JsonKey(name: 'ord_qty') final  int ordQty;
@override@JsonKey(name: 'ord_price') final  int ordPrice;
@override@JsonKey(name: 'cntr_qty') final  int cntrQty;
@override@JsonKey(name: 'remnq_qty') final  int remnqQty;
@override final  String side;
@override@JsonKey(name: 'ord_tm') final  String ordTm;
@override final  String status;

/// Create a copy of OrderHistoryItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderHistoryItemDtoCopyWith<_OrderHistoryItemDto> get copyWith => __$OrderHistoryItemDtoCopyWithImpl<_OrderHistoryItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderHistoryItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderHistoryItemDto&&(identical(other.ordNo, ordNo) || other.ordNo == ordNo)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.name, name) || other.name == name)&&(identical(other.ordQty, ordQty) || other.ordQty == ordQty)&&(identical(other.ordPrice, ordPrice) || other.ordPrice == ordPrice)&&(identical(other.cntrQty, cntrQty) || other.cntrQty == cntrQty)&&(identical(other.remnqQty, remnqQty) || other.remnqQty == remnqQty)&&(identical(other.side, side) || other.side == side)&&(identical(other.ordTm, ordTm) || other.ordTm == ordTm)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ordNo,ticker,name,ordQty,ordPrice,cntrQty,remnqQty,side,ordTm,status);

@override
String toString() {
  return 'OrderHistoryItemDto(ordNo: $ordNo, ticker: $ticker, name: $name, ordQty: $ordQty, ordPrice: $ordPrice, cntrQty: $cntrQty, remnqQty: $remnqQty, side: $side, ordTm: $ordTm, status: $status)';
}


}

/// @nodoc
abstract mixin class _$OrderHistoryItemDtoCopyWith<$Res> implements $OrderHistoryItemDtoCopyWith<$Res> {
  factory _$OrderHistoryItemDtoCopyWith(_OrderHistoryItemDto value, $Res Function(_OrderHistoryItemDto) _then) = __$OrderHistoryItemDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'ord_no') String ordNo, String ticker, String name,@JsonKey(name: 'ord_qty') int ordQty,@JsonKey(name: 'ord_price') int ordPrice,@JsonKey(name: 'cntr_qty') int cntrQty,@JsonKey(name: 'remnq_qty') int remnqQty, String side,@JsonKey(name: 'ord_tm') String ordTm, String status
});




}
/// @nodoc
class __$OrderHistoryItemDtoCopyWithImpl<$Res>
    implements _$OrderHistoryItemDtoCopyWith<$Res> {
  __$OrderHistoryItemDtoCopyWithImpl(this._self, this._then);

  final _OrderHistoryItemDto _self;
  final $Res Function(_OrderHistoryItemDto) _then;

/// Create a copy of OrderHistoryItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ordNo = null,Object? ticker = null,Object? name = null,Object? ordQty = null,Object? ordPrice = null,Object? cntrQty = null,Object? remnqQty = null,Object? side = null,Object? ordTm = null,Object? status = null,}) {
  return _then(_OrderHistoryItemDto(
ordNo: null == ordNo ? _self.ordNo : ordNo // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ordQty: null == ordQty ? _self.ordQty : ordQty // ignore: cast_nullable_to_non_nullable
as int,ordPrice: null == ordPrice ? _self.ordPrice : ordPrice // ignore: cast_nullable_to_non_nullable
as int,cntrQty: null == cntrQty ? _self.cntrQty : cntrQty // ignore: cast_nullable_to_non_nullable
as int,remnqQty: null == remnqQty ? _self.remnqQty : remnqQty // ignore: cast_nullable_to_non_nullable
as int,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as String,ordTm: null == ordTm ? _self.ordTm : ordTm // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
