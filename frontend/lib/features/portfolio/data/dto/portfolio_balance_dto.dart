import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_talk/features/portfolio/domain/entities/portfolio_entities.dart';

part 'portfolio_balance_dto.freezed.dart';
part 'portfolio_balance_dto.g.dart';

@freezed
abstract class PortfolioBalanceDto with _$PortfolioBalanceDto {
  const PortfolioBalanceDto._();

  const factory PortfolioBalanceDto({
    required PortfolioSummaryDto summary,
    required List<PortfolioHoldingDto> holdings,
  }) = _PortfolioBalanceDto;

  factory PortfolioBalanceDto.fromJson(Map<String, dynamic> json) =>
      _$PortfolioBalanceDtoFromJson(json);

  PortfolioBalance toEntity() => PortfolioBalance(
    summary: summary.toEntity(),
    holdings: holdings.map((holding) => holding.toEntity()).toList(),
  );
}

@freezed
abstract class PortfolioSummaryDto with _$PortfolioSummaryDto {
  const PortfolioSummaryDto._();

  const factory PortfolioSummaryDto({
    @JsonKey(name: 'total_asset') required int totalAsset,
    @JsonKey(name: 'available_cash') required int availableCash,
    @JsonKey(name: 'total_profit_loss') required int totalProfitLoss,
    @JsonKey(name: 'total_return_rate') required double totalReturnRate,
  }) = _PortfolioSummaryDto;

  factory PortfolioSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$PortfolioSummaryDtoFromJson(json);

  PortfolioSummary toEntity() => PortfolioSummary(
    totalAsset: totalAsset,
    availableCash: availableCash,
    totalProfitLoss: totalProfitLoss,
    totalReturnRate: totalReturnRate,
  );
}

@freezed
abstract class PortfolioHoldingDto with _$PortfolioHoldingDto {
  const PortfolioHoldingDto._();

  const factory PortfolioHoldingDto({
    required String ticker,
    required String name,
    required int quantity,
    @JsonKey(name: 'purchase_price') required int purchasePrice,
    @JsonKey(name: 'current_price') required int currentPrice,
    @JsonKey(name: 'profit_loss_rate') required double profitLossRate,
  }) = _PortfolioHoldingDto;

  factory PortfolioHoldingDto.fromJson(Map<String, dynamic> json) =>
      _$PortfolioHoldingDtoFromJson(json);

  PortfolioHolding toEntity() => PortfolioHolding(
    ticker: ticker,
    name: name,
    quantity: quantity,
    purchasePrice: purchasePrice,
    currentPrice: currentPrice,
    profitLossRate: profitLossRate,
  );
}
