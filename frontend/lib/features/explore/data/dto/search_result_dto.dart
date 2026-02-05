import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_talk/features/explore/domain/entities/search_entities.dart';

part 'search_result_dto.freezed.dart';
part 'search_result_dto.g.dart';

@freezed
abstract class SearchResultDto with _$SearchResultDto {
  const SearchResultDto._();

  const factory SearchResultDto({
    @JsonKey(name: 'srtnCd') required String ticker,
    @JsonKey(name: 'itmsNm') required String name,
  }) = _SearchResultDto;

  factory SearchResultDto.fromJson(Map<String, dynamic> json) =>
      _$SearchResultDtoFromJson(json);

  SearchResult toEntity() {
    return SearchResult(
      ticker: ticker,
      name: name,
    );
  }
}
