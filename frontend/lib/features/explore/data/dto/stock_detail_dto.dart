import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_talk/core/utils/parse_utils.dart';
import 'package:stock_talk/features/explore/domain/entities/stock_detail_entities.dart';

part 'stock_detail_dto.freezed.dart';
part 'stock_detail_dto.g.dart';

@freezed
abstract class StockDetailResponseDto with _$StockDetailResponseDto {
  const StockDetailResponseDto._();

  const factory StockDetailResponseDto({
    required String ticker,
    @JsonKey(name: 'stock_info') required StockInfoDto stockInfo,
    required List<CandleDto> candles,
  }) = _StockDetailResponseDto;

  factory StockDetailResponseDto.fromJson(Map<String, dynamic> json) =>
      _$StockDetailResponseDtoFromJson(json);

  StockDetail toEntity() {
    return StockDetail(
      ticker: ticker,
      stockInfo: stockInfo.toEntity(),
      candles: candles.map((dto) => dto.toEntity()).toList(),
    );
  }
}

@freezed
abstract class StockInfoDto with _$StockInfoDto {
  const StockInfoDto._();

  const factory StockInfoDto({
    @JsonKey(name: 'current_price') required dynamic currentPrice,
    @JsonKey(name: 'total_ask_qty') required dynamic totalAskQty,
    @JsonKey(name: 'total_bid_qty') required dynamic totalBidQty,
  }) = _StockInfoDto;

  factory StockInfoDto.fromJson(Map<String, dynamic> json) =>
      _$StockInfoDtoFromJson(json);

  StockInfo toEntity() {
    return StockInfo(
      currentPrice: ParseUtils.parseDouble(currentPrice),
      totalAskQty: ParseUtils.parseInt(totalAskQty),
      totalBidQty: ParseUtils.parseInt(totalBidQty),
    );
  }
}

@freezed
abstract class CandleDto with _$CandleDto {
  const CandleDto._();

  const factory CandleDto({
    required String time,
    required dynamic open,
    required dynamic high,
    required dynamic low,
    required dynamic close,
    required dynamic volume,
  }) = _CandleDto;

  factory CandleDto.fromJson(Map<String, dynamic> json) =>
      _$CandleDtoFromJson(json);

  Candle toEntity() {
    return Candle(
      time: ParseUtils.parseDateTime(time),
      open: ParseUtils.parseDouble(open),
      high: ParseUtils.parseDouble(high),
      low: ParseUtils.parseDouble(low),
      close: ParseUtils.parseDouble(close),
      volume: ParseUtils.parseInt(volume),
    );
  }
}

@freezed
abstract class StockNewsResponseDto with _$StockNewsResponseDto {
  const StockNewsResponseDto._();

  const factory StockNewsResponseDto({required List<StockNewsItemDto> news}) =
      _StockNewsResponseDto;

  factory StockNewsResponseDto.fromJson(List<dynamic> json) {
    return StockNewsResponseDto(
      news: json
          .map(
            (item) => StockNewsItemDto.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

@freezed
abstract class StockNewsItemDto with _$StockNewsItemDto {
  const StockNewsItemDto._();

  const factory StockNewsItemDto({
    required String title,
    String? link,
    String? description,
    String? pubDate,
  }) = _StockNewsItemDto;

  factory StockNewsItemDto.fromJson(Map<String, dynamic> json) =>
      _$StockNewsItemDtoFromJson(json);
}
