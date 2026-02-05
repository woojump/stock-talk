// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StockDetailResponseDto _$StockDetailResponseDtoFromJson(
  Map<String, dynamic> json,
) => _StockDetailResponseDto(
  ticker: json['ticker'] as String,
  stockInfo: StockInfoDto.fromJson(json['stock_info'] as Map<String, dynamic>),
  candles: (json['candles'] as List<dynamic>)
      .map((e) => CandleDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$StockDetailResponseDtoToJson(
  _StockDetailResponseDto instance,
) => <String, dynamic>{
  'ticker': instance.ticker,
  'stock_info': instance.stockInfo,
  'candles': instance.candles,
};

_StockInfoDto _$StockInfoDtoFromJson(Map<String, dynamic> json) =>
    _StockInfoDto(
      currentPrice: json['current_price'],
      totalAskQty: json['total_ask_qty'],
      totalBidQty: json['total_bid_qty'],
    );

Map<String, dynamic> _$StockInfoDtoToJson(_StockInfoDto instance) =>
    <String, dynamic>{
      'current_price': instance.currentPrice,
      'total_ask_qty': instance.totalAskQty,
      'total_bid_qty': instance.totalBidQty,
    };

_CandleDto _$CandleDtoFromJson(Map<String, dynamic> json) => _CandleDto(
  time: json['time'] as String,
  open: json['open'],
  high: json['high'],
  low: json['low'],
  close: json['close'],
  volume: json['volume'],
);

Map<String, dynamic> _$CandleDtoToJson(_CandleDto instance) =>
    <String, dynamic>{
      'time': instance.time,
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'close': instance.close,
      'volume': instance.volume,
    };

_StockNewsItemDto _$StockNewsItemDtoFromJson(Map<String, dynamic> json) =>
    _StockNewsItemDto(
      title: json['title'] as String,
      link: json['link'] as String?,
      description: json['description'] as String?,
      pubDate: json['pubDate'] as String?,
    );

Map<String, dynamic> _$StockNewsItemDtoToJson(_StockNewsItemDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'description': instance.description,
      'pubDate': instance.pubDate,
    };
