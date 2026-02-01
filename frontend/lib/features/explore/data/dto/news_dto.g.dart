// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PopularNewsResponseDto _$PopularNewsResponseDtoFromJson(
  Map<String, dynamic> json,
) => _PopularNewsResponseDto(
  targetStocks: (json['target_stocks'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  news: (json['news'] as List<dynamic>)
      .map((e) => NewsItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PopularNewsResponseDtoToJson(
  _PopularNewsResponseDto instance,
) => <String, dynamic>{
  'target_stocks': instance.targetStocks,
  'news': instance.news,
};

_NewsItemDto _$NewsItemDtoFromJson(Map<String, dynamic> json) => _NewsItemDto(
  title: json['title'] as String,
  pubDate: json['pubDate'] as String,
  stockName: json['stock_name'] as String,
  description: json['description'] as String?,
  link: json['link'] as String?,
);

Map<String, dynamic> _$NewsItemDtoToJson(_NewsItemDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'pubDate': instance.pubDate,
      'stock_name': instance.stockName,
      'description': instance.description,
      'link': instance.link,
    };
