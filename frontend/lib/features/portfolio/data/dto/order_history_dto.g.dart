// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderHistoryDto _$OrderHistoryDtoFromJson(Map<String, dynamic> json) =>
    _OrderHistoryDto(
      status: json['status'] as String,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => OrderHistoryItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderHistoryDtoToJson(_OrderHistoryDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'count': instance.count,
      'data': instance.data,
    };

_OrderHistoryItemDto _$OrderHistoryItemDtoFromJson(Map<String, dynamic> json) =>
    _OrderHistoryItemDto(
      ordNo: json['ord_no'] as String,
      ticker: json['ticker'] as String,
      name: json['name'] as String,
      ordQty: (json['ord_qty'] as num).toInt(),
      ordPrice: (json['ord_price'] as num).toInt(),
      cntrQty: (json['cntr_qty'] as num).toInt(),
      remnqQty: (json['remnq_qty'] as num).toInt(),
      side: json['side'] as String,
      ordTm: json['ord_tm'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$OrderHistoryItemDtoToJson(
  _OrderHistoryItemDto instance,
) => <String, dynamic>{
  'ord_no': instance.ordNo,
  'ticker': instance.ticker,
  'name': instance.name,
  'ord_qty': instance.ordQty,
  'ord_price': instance.ordPrice,
  'cntr_qty': instance.cntrQty,
  'remnq_qty': instance.remnqQty,
  'side': instance.side,
  'ord_tm': instance.ordTm,
  'status': instance.status,
};
