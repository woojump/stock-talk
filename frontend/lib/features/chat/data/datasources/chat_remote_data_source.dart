import 'package:dio/dio.dart';
import 'package:stock_talk/core/config/api_config.dart';
import 'package:stock_talk/features/chat/data/dto/chat_dto.dart';

class ChatRemoteDataSource {
  final Dio _dio;

  ChatRemoteDataSource(this._dio);

  /// 메시지 전송 및 AI 응답 받기
  Future<ChatResponseDto> sendMessage({
    required String query,
    int? roomId,
  }) async {
    final queryParams = <String, dynamic>{'query': query};
    if (roomId != null) {
      queryParams['room_id'] = roomId;
    }

    final response = await _dio.post(
      ApiConfig.chattingAskPath,
      queryParameters: queryParams,
    );

    if (response.data == null) {
      throw Exception('No data received from chatting endpoint');
    }

    return ChatResponseDto.fromJson(response.data as Map<String, dynamic>);
  }

  /// 채팅방 목록 조회
  Future<ChatRoomsResponseDto> getChatRooms({
    int limit = 50,
    int offset = 0,
  }) async {
    final response = await _dio.get(
      ApiConfig.chattingRoomsPath,
      queryParameters: {'limit': limit, 'offset': offset},
    );

    if (response.data == null) {
      throw Exception('No data received from chat rooms endpoint');
    }

    return ChatRoomsResponseDto.fromJson(response.data as Map<String, dynamic>);
  }

  /// 채팅방 메시지 조회
  Future<ChatMessagesResponseDto> getRoomMessages(
    int roomId, {
    int limit = 200,
    int? beforeId,
  }) async {
    final queryParams = <String, dynamic>{'limit': limit};
    if (beforeId != null) {
      queryParams['before_id'] = beforeId;
    }

    final response = await _dio.get(
      ApiConfig.chattingRoomMessagesPath(roomId),
      queryParameters: queryParams,
    );

    if (response.data == null) {
      throw Exception('No data received from room messages endpoint');
    }

    try {
      return ChatMessagesResponseDto.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// 채팅방 삭제
  Future<void> deleteChatRoom(int roomId) async {
    await _dio.delete(ApiConfig.chattingRoomDeletePath(roomId));
  }
}
