import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_talk/features/chat/domain/entities/chat_entities.dart';

part 'chat_dto.freezed.dart';
part 'chat_dto.g.dart';

/// 채팅 API 응답 DTO
@freezed
abstract class ChatResponseDto with _$ChatResponseDto {
  const ChatResponseDto._();

  const factory ChatResponseDto({
    String? status,
    @JsonKey(name: 'room_id') required int roomId,
    String? answer,
    required List<ChatMessageDto> messages,
  }) = _ChatResponseDto;

  factory ChatResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseDtoFromJson(json);

  ChatResponse toEntity() {
    return ChatResponse(
      status: status ?? 'success',
      roomId: roomId,
      answer: answer ?? '',
      messages: messages.map((m) => m.toEntity(roomId)).toList(),
    );
  }
}

/// 채팅 메시지 DTO
@freezed
abstract class ChatMessageDto with _$ChatMessageDto {
  const ChatMessageDto._();

  const factory ChatMessageDto({
    @JsonKey(name: 'message_id') int? messageId,
    @JsonKey(name: 'room_id') int? roomId,
    String? role,
    @JsonKey(name: 'msg_type') String? msgType,
    String? content,
    @JsonKey(name: 'payload_json') Map<String, dynamic>? payloadJson,
    @JsonKey(name: 'parent_id') int? parentId,
    String? status,
    @JsonKey(name: 'sent_at') String? sentAt,
  }) = _ChatMessageDto;

  factory ChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageDtoFromJson(json);

  ChatMessage toEntity(int roomIdFallback) {
    StockCardPayload? cardPayload;
    final safeRole = role ?? 'assistant';
    final safeMsgType = msgType ?? 'TEXT';

    if (payloadJson != null && safeMsgType == 'CARD') {
      try {
        cardPayload = StockCardPayloadDto.fromJson(payloadJson!).toEntity();
      } catch (_) {
        // partial failure: ignore corrupted payload
      }
    }

    // sentAt 파싱: 실패 시 현재 시간
    final parsedSentAt = DateTime.tryParse(sentAt ?? '') ?? DateTime.now();

    return ChatMessage(
      messageId: messageId,
      roomId: roomId ?? roomIdFallback,
      role: safeRole == 'user' ? MessageRole.user : MessageRole.assistant,
      msgType: safeMsgType == 'CARD' ? MessageType.card : MessageType.text,
      content: content ?? '',
      cardPayload: cardPayload,
      sentAt: parsedSentAt,
    );
  }
}

/// 종목 카드 페이로드 DTO
@freezed
abstract class StockCardPayloadDto with _$StockCardPayloadDto {
  const StockCardPayloadDto._();

  const factory StockCardPayloadDto({
    @JsonKey(name: 'card_type') String? cardType,
    String? title,
    String? ticker,
    String? range,
    String? interval,
    Map<String, dynamic>? summary,
    List<Map<String, dynamic>>? candles,
  }) = _StockCardPayloadDto;

  factory StockCardPayloadDto.fromJson(Map<String, dynamic> json) =>
      _$StockCardPayloadDtoFromJson(json);

  StockCardPayload toEntity() {
    StockSummary? stockSummary;
    if (summary != null) {
      try {
        stockSummary = StockSummaryDto.fromJson(summary!).toEntity();
      } catch (_) {}
    }

    final candleList =
        candles
            ?.map((c) {
              try {
                return CandleDataDto.fromJson(c).toEntity();
              } catch (_) {
                return null;
              }
            })
            .whereType<CandleData>()
            .toList() ??
        [];

    return StockCardPayload(
      cardType: cardType ?? 'price_chart',
      title: title ?? '',
      ticker: ticker ?? '',
      range: range ?? '1M',
      interval: interval ?? '1D',
      summary: stockSummary,
      candles: candleList,
    );
  }
}

/// 종목 요약 정보 DTO
@freezed
abstract class StockSummaryDto with _$StockSummaryDto {
  const StockSummaryDto._();

  const factory StockSummaryDto({
    @JsonKey(name: 'stock_name') String? stockName,
    String? ticker,
    @JsonKey(name: 'current_price') double? currentPrice,
    @JsonKey(name: 'price_change') double? priceChange,
    @JsonKey(name: 'price_change_percent') double? priceChangePercent,
    @JsonKey(name: 'open_price') double? openPrice,
    @JsonKey(name: 'high_price') double? highPrice,
    @JsonKey(name: 'low_price') double? lowPrice,
    int? volume,
  }) = _StockSummaryDto;

  factory StockSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$StockSummaryDtoFromJson(json);

  StockSummary toEntity() {
    return StockSummary(
      stockName: stockName ?? '',
      ticker: ticker ?? '',
      currentPrice: currentPrice ?? 0.0,
      priceChange: priceChange ?? 0.0,
      priceChangePercent: priceChangePercent ?? 0.0,
      openPrice: openPrice,
      highPrice: highPrice,
      lowPrice: lowPrice,
      volume: volume,
    );
  }
}

/// 캔들 데이터 DTO
@freezed
abstract class CandleDataDto with _$CandleDataDto {
  const CandleDataDto._();

  const factory CandleDataDto({
    String? time,
    double? open,
    double? high,
    double? low,
    double? close,
    int? volume,
  }) = _CandleDataDto;

  factory CandleDataDto.fromJson(Map<String, dynamic> json) =>
      _$CandleDataDtoFromJson(json);

  CandleData toEntity() {
    DateTime parsedTime = DateTime.tryParse(time ?? '') ?? DateTime.now();

    // YYYYMMDD 형식 처리
    if (time != null && time!.length == 8) {
      final year = int.tryParse(time!.substring(0, 4));
      final month = int.tryParse(time!.substring(4, 6));
      final day = int.tryParse(time!.substring(6, 8));
      if (year != null && month != null && day != null) {
        parsedTime = DateTime(year, month, day);
      }
    }

    return CandleData(
      time: parsedTime,
      open: open ?? 0.0,
      high: high ?? 0.0,
      low: low ?? 0.0,
      close: close ?? 0.0,
      volume: volume ?? 0,
    );
  }
}

/// 채팅방 DTO
@freezed
abstract class ChatRoomDto with _$ChatRoomDto {
  const ChatRoomDto._();

  const factory ChatRoomDto({
    @JsonKey(name: 'room_id') required int roomId,
    @JsonKey(name: 'owner_user_id') int? ownerUserId,
    String? title,
    @JsonKey(name: 'last_preview') String? lastPreview,
    @JsonKey(name: 'last_message_id') int? lastMessageId,
    @JsonKey(name: 'last_sent_at') String? lastSentAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _ChatRoomDto;

  factory ChatRoomDto.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomDtoFromJson(json);

  ChatRoom toEntity() {
    return ChatRoom(
      roomId: roomId,
      ownerUserId: ownerUserId,
      title: title ?? '새로운 대화',
      lastPreview: lastPreview,
      lastMessageId: lastMessageId,
      lastSentAt: lastSentAt != null ? DateTime.tryParse(lastSentAt!) : null,
      updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
    );
  }
}

/// 채팅방 목록 응답 DTO
@freezed
abstract class ChatRoomsResponseDto with _$ChatRoomsResponseDto {
  const ChatRoomsResponseDto._();

  const factory ChatRoomsResponseDto({
    String? status,
    required List<ChatRoomDto> data,
  }) = _ChatRoomsResponseDto;

  factory ChatRoomsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomsResponseDtoFromJson(json);
}

/// 채팅방 메시지 목록 응답 DTO
@freezed
abstract class ChatMessagesResponseDto with _$ChatMessagesResponseDto {
  const ChatMessagesResponseDto._();

  const factory ChatMessagesResponseDto({
    String? status,
    @JsonKey(name: 'room_id') required int roomId,
    required List<ChatMessageDto> messages,
  }) = _ChatMessagesResponseDto;

  factory ChatMessagesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ChatMessagesResponseDtoFromJson(json);

  List<ChatMessage> toEntityList() {
    return messages.map((m) => m.toEntity(roomId)).toList();
  }
}
