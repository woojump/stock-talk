// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatResponseDto _$ChatResponseDtoFromJson(Map<String, dynamic> json) =>
    _ChatResponseDto(
      status: json['status'] as String?,
      roomId: (json['room_id'] as num).toInt(),
      answer: json['answer'] as String?,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => ChatMessageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatResponseDtoToJson(_ChatResponseDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'room_id': instance.roomId,
      'answer': instance.answer,
      'messages': instance.messages,
    };

_ChatMessageDto _$ChatMessageDtoFromJson(Map<String, dynamic> json) =>
    _ChatMessageDto(
      messageId: (json['message_id'] as num?)?.toInt(),
      roomId: (json['room_id'] as num?)?.toInt(),
      role: json['role'] as String?,
      msgType: json['msg_type'] as String?,
      content: json['content'] as String?,
      payloadJson: json['payload_json'] as Map<String, dynamic>?,
      parentId: (json['parent_id'] as num?)?.toInt(),
      status: json['status'] as String?,
      sentAt: json['sent_at'] as String?,
    );

Map<String, dynamic> _$ChatMessageDtoToJson(_ChatMessageDto instance) =>
    <String, dynamic>{
      'message_id': instance.messageId,
      'room_id': instance.roomId,
      'role': instance.role,
      'msg_type': instance.msgType,
      'content': instance.content,
      'payload_json': instance.payloadJson,
      'parent_id': instance.parentId,
      'status': instance.status,
      'sent_at': instance.sentAt,
    };

_StockCardPayloadDto _$StockCardPayloadDtoFromJson(Map<String, dynamic> json) =>
    _StockCardPayloadDto(
      cardType: json['card_type'] as String?,
      title: json['title'] as String?,
      ticker: json['ticker'] as String?,
      range: json['range'] as String?,
      interval: json['interval'] as String?,
      summary: json['summary'] as Map<String, dynamic>?,
      candles: (json['candles'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$StockCardPayloadDtoToJson(
  _StockCardPayloadDto instance,
) => <String, dynamic>{
  'card_type': instance.cardType,
  'title': instance.title,
  'ticker': instance.ticker,
  'range': instance.range,
  'interval': instance.interval,
  'summary': instance.summary,
  'candles': instance.candles,
};

_StockSummaryDto _$StockSummaryDtoFromJson(Map<String, dynamic> json) =>
    _StockSummaryDto(
      stockName: json['stock_name'] as String?,
      ticker: json['ticker'] as String?,
      currentPrice: (json['current_price'] as num?)?.toDouble(),
      priceChange: (json['price_change'] as num?)?.toDouble(),
      priceChangePercent: (json['price_change_percent'] as num?)?.toDouble(),
      openPrice: (json['open_price'] as num?)?.toDouble(),
      highPrice: (json['high_price'] as num?)?.toDouble(),
      lowPrice: (json['low_price'] as num?)?.toDouble(),
      volume: (json['volume'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StockSummaryDtoToJson(_StockSummaryDto instance) =>
    <String, dynamic>{
      'stock_name': instance.stockName,
      'ticker': instance.ticker,
      'current_price': instance.currentPrice,
      'price_change': instance.priceChange,
      'price_change_percent': instance.priceChangePercent,
      'open_price': instance.openPrice,
      'high_price': instance.highPrice,
      'low_price': instance.lowPrice,
      'volume': instance.volume,
    };

_CandleDataDto _$CandleDataDtoFromJson(Map<String, dynamic> json) =>
    _CandleDataDto(
      time: json['time'] as String?,
      open: (json['open'] as num?)?.toDouble(),
      high: (json['high'] as num?)?.toDouble(),
      low: (json['low'] as num?)?.toDouble(),
      close: (json['close'] as num?)?.toDouble(),
      volume: (json['volume'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CandleDataDtoToJson(_CandleDataDto instance) =>
    <String, dynamic>{
      'time': instance.time,
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'close': instance.close,
      'volume': instance.volume,
    };

_ChatRoomDto _$ChatRoomDtoFromJson(Map<String, dynamic> json) => _ChatRoomDto(
  roomId: (json['room_id'] as num).toInt(),
  ownerUserId: (json['owner_user_id'] as num?)?.toInt(),
  title: json['title'] as String?,
  lastPreview: json['last_preview'] as String?,
  lastMessageId: (json['last_message_id'] as num?)?.toInt(),
  lastSentAt: json['last_sent_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$ChatRoomDtoToJson(_ChatRoomDto instance) =>
    <String, dynamic>{
      'room_id': instance.roomId,
      'owner_user_id': instance.ownerUserId,
      'title': instance.title,
      'last_preview': instance.lastPreview,
      'last_message_id': instance.lastMessageId,
      'last_sent_at': instance.lastSentAt,
      'updated_at': instance.updatedAt,
    };

_ChatRoomsResponseDto _$ChatRoomsResponseDtoFromJson(
  Map<String, dynamic> json,
) => _ChatRoomsResponseDto(
  status: json['status'] as String?,
  data: (json['data'] as List<dynamic>)
      .map((e) => ChatRoomDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ChatRoomsResponseDtoToJson(
  _ChatRoomsResponseDto instance,
) => <String, dynamic>{'status': instance.status, 'data': instance.data};

_ChatMessagesResponseDto _$ChatMessagesResponseDtoFromJson(
  Map<String, dynamic> json,
) => _ChatMessagesResponseDto(
  status: json['status'] as String?,
  roomId: (json['room_id'] as num).toInt(),
  messages: (json['messages'] as List<dynamic>)
      .map((e) => ChatMessageDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ChatMessagesResponseDtoToJson(
  _ChatMessagesResponseDto instance,
) => <String, dynamic>{
  'status': instance.status,
  'room_id': instance.roomId,
  'messages': instance.messages,
};
