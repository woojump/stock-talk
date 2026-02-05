class OrderHistory {
  const OrderHistory({
    required this.status,
    required this.count,
    required this.data,
  });

  final String status;
  final int count;
  final List<OrderHistoryItem> data;
}

class OrderHistoryItem {
  const OrderHistoryItem({
    required this.ordNo,
    required this.ticker,
    required this.name,
    required this.ordQty,
    required this.ordPrice,
    required this.cntrQty,
    required this.remnqQty,
    required this.side,
    required this.ordTm,
    required this.status,
  });

  final String ordNo;
  final String ticker;
  final String name;
  final int ordQty;
  final int ordPrice;
  final int cntrQty;
  final int remnqQty;
  final String side;
  final String ordTm;
  final String status;
}
