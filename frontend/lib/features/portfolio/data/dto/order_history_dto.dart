import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_talk/features/portfolio/domain/entities/order_history_entities.dart';

part 'order_history_dto.freezed.dart';
part 'order_history_dto.g.dart';

@freezed
abstract class OrderHistoryDto with _$OrderHistoryDto {
  const OrderHistoryDto._();

  const factory OrderHistoryDto({
    required String status,
    required int count,
    required List<OrderHistoryItemDto> data,
  }) = _OrderHistoryDto;

  factory OrderHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryDtoFromJson(json);

  OrderHistory toEntity() => OrderHistory(
    status: status,
    count: count,
    data: data.map((item) => item.toEntity()).toList(),
  );
}

@freezed
abstract class OrderHistoryItemDto with _$OrderHistoryItemDto {
  const OrderHistoryItemDto._();

  const factory OrderHistoryItemDto({
    @JsonKey(name: 'ord_no') required String ordNo,
    required String ticker,
    required String name,
    @JsonKey(name: 'ord_qty') required int ordQty,
    @JsonKey(name: 'ord_price') required int ordPrice,
    @JsonKey(name: 'cntr_qty') required int cntrQty,
    @JsonKey(name: 'remnq_qty') required int remnqQty,
    required String side,
    @JsonKey(name: 'ord_tm') required String ordTm,
    required String status,
  }) = _OrderHistoryItemDto;

  factory OrderHistoryItemDto.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryItemDtoFromJson(json);

  OrderHistoryItem toEntity() => OrderHistoryItem(
    ordNo: ordNo,
    ticker: ticker,
    name: name,
    ordQty: ordQty,
    ordPrice: ordPrice,
    cntrQty: cntrQty,
    remnqQty: remnqQty,
    side: side,
    ordTm: ordTm,
    status: status,
  );
}
