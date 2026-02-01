import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_talk/features/explore/domain/entities/explore_entities.dart';

part 'news_dto.freezed.dart';
part 'news_dto.g.dart';

@freezed
abstract class PopularNewsResponseDto with _$PopularNewsResponseDto {
  const PopularNewsResponseDto._();

  const factory PopularNewsResponseDto({
    @JsonKey(name: 'target_stocks') required List<String> targetStocks,
    required List<NewsItemDto> news,
  }) = _PopularNewsResponseDto;

  factory PopularNewsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PopularNewsResponseDtoFromJson(json);

  PopularNewsResponse toEntity() {
    return PopularNewsResponse(
      targetStocks: targetStocks,
      news: news.map((dto) => dto.toEntity()).toList(),
    );
  }
}

@freezed
abstract class NewsItemDto with _$NewsItemDto {
  const NewsItemDto._();

  const factory NewsItemDto({
    required String title,
    @JsonKey(name: 'pubDate') required String pubDate,
    @JsonKey(name: 'stock_name') String? stockName,
    String? description,
    String? link,
  }) = _NewsItemDto;

  factory NewsItemDto.fromJson(Map<String, dynamic> json) =>
      _$NewsItemDtoFromJson(json);

  NewsItem toEntity() {
    return NewsItem(
      title: title,
      pubDate: pubDate,
      stockName: stockName ?? '', // stock_name이 없으면 빈 문자열
      description: description,
      link: link,
    );
  }
}
