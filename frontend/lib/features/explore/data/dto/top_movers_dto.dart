import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_talk/features/explore/domain/entities/top_movers_entities.dart';

part 'top_movers_dto.freezed.dart';
part 'top_movers_dto.g.dart';

@freezed
abstract class TopMoversDto with _$TopMoversDto {
  const TopMoversDto._();

  const factory TopMoversDto({
    required List<StockItemDto> up,
    required List<StockItemDto> down,
    required List<StockItemDto> popular,
    required List<StockItemDto> buy,
    required List<StockItemDto> sell,
  }) = _TopMoversDto;

  factory TopMoversDto.fromJson(Map<String, dynamic> json) =>
      _$TopMoversDtoFromJson(json);

  TopMovers toEntity() {
    return TopMovers(
      up: up.map((dto) => dto.toEntity()).toList(),
      down: down.map((dto) => dto.toEntity()).toList(),
      popular: popular.map((dto) => dto.toEntity()).toList(),
      buy: buy.map((dto) => dto.toEntity()).toList(),
      sell: sell.map((dto) => dto.toEntity()).toList(),
    );
  }
}

@freezed
abstract class StockItemDto with _$StockItemDto {
  const StockItemDto._();

  const factory StockItemDto({
    // 카테고리별로 제공되는 필드가 달라서 일단 모두 optional 처리
    // 상승/하락/인기 카테고리에서는 등락률(rate)과 가격(price) 제공
    // 기관 순매수/순매도 카테고리에서는 가격 아닌 거래량 관련 필드 제공
    // 일단 현재 도메인 엔티티 변환 시에는 등락률과 가격만 사용하고, 나머지 필드는 무시
    // TODO: 도메인 엔티티에 거래량 관련 필드 추가
    required String name,
    String? rate,
    String? price,
    String? rank,
    String? code,
    @JsonKey(name: 'net_amount') String? netAmount,
    @JsonKey(name: 'buy_qty') String? buyQty,
    @JsonKey(name: 'sel_qty') String? selQty,
  }) = _StockItemDto;

  factory StockItemDto.fromJson(Map<String, dynamic> json) =>
      _$StockItemDtoFromJson(json);

  StockItem toEntity() {
    // Parse rate string (e.g., "+30.00" or "-21.41")
    final rateValue = rate != null
        ? (double.tryParse(rate!.replaceAll('+', '')) ?? 0.0)
        : 0.0;

    // Parse price string (e.g., "52000")
    final priceValue = price != null
        ? (double.tryParse(price!.replaceAll(',', '')) ?? 0.0)
        : 0.0;

    final changeValue = priceValue * (rateValue / 100);

    return StockItem(
      name: name,
      ticker: code ?? '', // 티커 정보 못 받으면 일단 빈 문자열로 처리
      price: priceValue,
      change: changeValue,
      changeRate: rateValue,
    );
  }
}
