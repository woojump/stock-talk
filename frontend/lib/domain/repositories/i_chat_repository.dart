import '../entities/chat_message.dart';

abstract class IChatRepository {
  Stream<String> sendMessage(String message, List<ChatMessage> history);
  Future<List<ChatMessage>> getChatHistory();
  Future<void> clearHistory();
}
