class ChatRoom {
  final int roomId;
  final int? ownerUserId;
  final String title;
  final String? lastPreview;
  final int? lastMessageId;
  final DateTime? lastSentAt;
  final DateTime? updatedAt;

  const ChatRoom({
    required this.roomId,
    this.ownerUserId,
    required this.title,
    this.lastPreview,
    this.lastMessageId,
    this.lastSentAt,
    this.updatedAt,
  });
}

/// text: 텍스트 메시지, card: 종목 시세 차트 카드 메시지
enum MessageType { text, card }

enum MessageRole { user, assistant }

class ChatMessage {
  final int? messageId;
  final int roomId;
  final MessageRole role;
  final MessageType msgType;
  final String content;
  final StockCardPayload? cardPayload;
  final DateTime sentAt;

  const ChatMessage({
    this.messageId,
    required this.roomId,
    required this.role,
    required this.msgType,
    required this.content,
    this.cardPayload,
    required this.sentAt,
  });

  bool get isUser => role == MessageRole.user;
  bool get isCard => msgType == MessageType.card;
}

/// 종목 시세 차트 카드 데이터
class StockCardPayload {
  final String cardType;
  final String title;
  final String ticker;
  final String range;
  final String interval;
  final StockSummary? summary;
  final List<CandleData>? candles;

  const StockCardPayload({
    required this.cardType,
    required this.title,
    required this.ticker,
    required this.range,
    required this.interval,
    this.summary,
    this.candles,
  });
}

class StockSummary {
  final String stockName;
  final String ticker;
  final double currentPrice;
  final double priceChange;
  final double priceChangePercent;
  final double? openPrice;
  final double? highPrice;
  final double? lowPrice;
  final int? volume;

  const StockSummary({
    required this.stockName,
    required this.ticker,
    required this.currentPrice,
    required this.priceChange,
    required this.priceChangePercent,
    this.openPrice,
    this.highPrice,
    this.lowPrice,
    this.volume,
  });

  bool get isPositive => priceChange >= 0;
}

class CandleData {
  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;

  const CandleData({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });
}

/// 채팅 API 응답
class ChatResponse {
  final String status;
  final int roomId;
  final String answer;
  final List<ChatMessage> messages;

  const ChatResponse({
    required this.status,
    required this.roomId,
    required this.answer,
    required this.messages,
  });

  bool get isSuccess => status == 'success';
}
