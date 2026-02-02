// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_movers_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TopMoversDto _$TopMoversDtoFromJson(Map<String, dynamic> json) =>
    _TopMoversDto(
      up: (json['up'] as List<dynamic>)
          .map((e) => StockItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      down: (json['down'] as List<dynamic>)
          .map((e) => StockItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      popular: (json['popular'] as List<dynamic>)
          .map((e) => StockItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      buy: (json['buy'] as List<dynamic>)
          .map((e) => StockItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      sell: (json['sell'] as List<dynamic>)
          .map((e) => StockItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopMoversDtoToJson(_TopMoversDto instance) =>
    <String, dynamic>{
      'up': instance.up,
      'down': instance.down,
      'popular': instance.popular,
      'buy': instance.buy,
      'sell': instance.sell,
    };

_StockItemDto _$StockItemDtoFromJson(Map<String, dynamic> json) =>
    _StockItemDto(
      name: json['name'] as String,
      rate: json['rate'] as String?,
      price: json['price'] as String?,
      rank: json['rank'] as String?,
      code: json['code'] as String?,
      netAmount: json['net_amount'] as String?,
      buyQty: json['buy_qty'] as String?,
      selQty: json['sel_qty'] as String?,
    );

Map<String, dynamic> _$StockItemDtoToJson(_StockItemDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rate': instance.rate,
      'price': instance.price,
      'rank': instance.rank,
      'code': instance.code,
      'net_amount': instance.netAmount,
      'buy_qty': instance.buyQty,
      'sel_qty': instance.selQty,
    };
