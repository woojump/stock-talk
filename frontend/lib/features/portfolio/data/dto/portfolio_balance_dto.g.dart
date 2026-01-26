// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_balance_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PortfolioBalanceDto _$PortfolioBalanceDtoFromJson(Map<String, dynamic> json) =>
    _PortfolioBalanceDto(
      summary: PortfolioSummaryDto.fromJson(
        json['summary'] as Map<String, dynamic>,
      ),
      holdings: (json['holdings'] as List<dynamic>)
          .map((e) => PortfolioHoldingDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PortfolioBalanceDtoToJson(
  _PortfolioBalanceDto instance,
) => <String, dynamic>{
  'summary': instance.summary,
  'holdings': instance.holdings,
};

_PortfolioSummaryDto _$PortfolioSummaryDtoFromJson(Map<String, dynamic> json) =>
    _PortfolioSummaryDto(
      totalAsset: (json['total_asset'] as num).toInt(),
      availableCash: (json['available_cash'] as num).toInt(),
      totalProfitLoss: (json['total_profit_loss'] as num).toInt(),
      totalReturnRate: (json['total_return_rate'] as num).toDouble(),
    );

Map<String, dynamic> _$PortfolioSummaryDtoToJson(
  _PortfolioSummaryDto instance,
) => <String, dynamic>{
  'total_asset': instance.totalAsset,
  'available_cash': instance.availableCash,
  'total_profit_loss': instance.totalProfitLoss,
  'total_return_rate': instance.totalReturnRate,
};

_PortfolioHoldingDto _$PortfolioHoldingDtoFromJson(Map<String, dynamic> json) =>
    _PortfolioHoldingDto(
      ticker: json['ticker'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      purchasePrice: (json['purchase_price'] as num).toInt(),
      currentPrice: (json['current_price'] as num).toInt(),
      profitLossRate: (json['profit_loss_rate'] as num).toDouble(),
    );

Map<String, dynamic> _$PortfolioHoldingDtoToJson(
  _PortfolioHoldingDto instance,
) => <String, dynamic>{
  'ticker': instance.ticker,
  'name': instance.name,
  'quantity': instance.quantity,
  'purchase_price': instance.purchasePrice,
  'current_price': instance.currentPrice,
  'profit_loss_rate': instance.profitLossRate,
};
