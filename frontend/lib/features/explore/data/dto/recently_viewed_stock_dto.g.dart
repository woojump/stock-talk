// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_viewed_stock_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecentlyViewedStockDto _$RecentlyViewedStockDtoFromJson(
  Map<String, dynamic> json,
) => _RecentlyViewedStockDto(
  ticker: json['ticker'] as String,
  name: json['name'] as String,
  viewedAt: json['viewedAt'] as String,
);

Map<String, dynamic> _$RecentlyViewedStockDtoToJson(
  _RecentlyViewedStockDto instance,
) => <String, dynamic>{
  'ticker': instance.ticker,
  'name': instance.name,
  'viewedAt': instance.viewedAt,
};
