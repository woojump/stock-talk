import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_talk/features/explore/domain/entities/search_entities.dart';

part 'recently_viewed_stock_dto.freezed.dart';
part 'recently_viewed_stock_dto.g.dart';

@freezed
abstract class RecentlyViewedStockDto with _$RecentlyViewedStockDto {
  const RecentlyViewedStockDto._();

  const factory RecentlyViewedStockDto({
    required String ticker,
    required String name,
    required String viewedAt,
  }) = _RecentlyViewedStockDto;

  factory RecentlyViewedStockDto.fromJson(Map<String, dynamic> json) =>
      _$RecentlyViewedStockDtoFromJson(json);

  RecentlyViewedStock toEntity() {
    return RecentlyViewedStock(
      ticker: ticker,
      name: name,
      viewedAt: DateTime.parse(viewedAt),
    );
  }
}
