import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String code;
  final String name;
  final int currentPrice;
  final int previousClose;
  final int change;
  final double changePercent;
  final int volume;
  final int high;
  final int low;
  final int open;

  const Stock({
    required this.code,
    required this.name,
    required this.currentPrice,
    required this.previousClose,
    required this.change,
    required this.changePercent,
    required this.volume,
    required this.high,
    required this.low,
    required this.open,
  });

  bool get isUp => change > 0;
  bool get isDown => change < 0;

  @override
  List<Object?> get props => [
        code,
        name,
        currentPrice,
        previousClose,
        change,
        changePercent,
        volume,
        high,
        low,
        open,
      ];
}
