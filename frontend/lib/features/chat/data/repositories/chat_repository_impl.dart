import 'package:stock_talk/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:stock_talk/features/chat/domain/entities/chat_entities.dart';
import 'package:stock_talk/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _remoteDataSource;

  ChatRepositoryImpl(this._remoteDataSource);

  @override
  Future<ChatResponse> sendMessage({required String query, int? roomId}) async {
    final dto = await _remoteDataSource.sendMessage(
      query: query,
      roomId: roomId,
    );
    return dto.toEntity();
  }

  @override
  Future<List<ChatRoom>> getChatRooms({int limit = 50, int offset = 0}) async {
    final dto = await _remoteDataSource.getChatRooms(
      limit: limit,
      offset: offset,
    );
    return dto.data.map((r) => r.toEntity()).toList();
  }

  @override
  Future<List<ChatMessage>> getRoomMessages(
    int roomId, {
    int limit = 200,
    int? beforeId,
  }) async {
    final dto = await _remoteDataSource.getRoomMessages(
      roomId,
      limit: limit,
      beforeId: beforeId,
    );

    return dto.messages.map((msg) => msg.toEntity(roomId)).toList();
  }

  @override
  Future<void> deleteChatRoom(int roomId) async {
    await _remoteDataSource.deleteChatRoom(roomId);
  }
}
