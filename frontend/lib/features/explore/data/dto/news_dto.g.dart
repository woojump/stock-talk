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
  stockName: json['stock_name'] as String?,
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

_NewsDetailDto _$NewsDetailDtoFromJson(Map<String, dynamic> json) =>
    _NewsDetailDto(
      status: json['status'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      topImage: json['top_image'] as String?,
      publishedDate: json['published_date'] as String,
    );

Map<String, dynamic> _$NewsDetailDtoToJson(_NewsDetailDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'title': instance.title,
      'content': instance.content,
      'top_image': instance.topImage,
      'published_date': instance.publishedDate,
    };

_NewsSummaryDto _$NewsSummaryDtoFromJson(Map<String, dynamic> json) =>
    _NewsSummaryDto(aiSummary: json['ai_summary'] as String);

Map<String, dynamic> _$NewsSummaryDtoToJson(_NewsSummaryDto instance) =>
    <String, dynamic>{'ai_summary': instance.aiSummary};
