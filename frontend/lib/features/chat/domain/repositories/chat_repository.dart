import 'package:stock_talk/features/chat/domain/entities/chat_entities.dart';

abstract class ChatRepository {
  /// 메시지 전송 및 AI 응답 받기
  Future<ChatResponse> sendMessage({required String query, int? roomId});

  /// 채팅방 목록 조회
  Future<List<ChatRoom>> getChatRooms({int limit = 50, int offset = 0});

  /// 채팅방 메시지 조회
  Future<List<ChatMessage>> getRoomMessages(
    int roomId, {
    int limit = 200,
    int? beforeId,
  });

  /// 채팅방 삭제
  Future<void> deleteChatRoom(int roomId);
}
