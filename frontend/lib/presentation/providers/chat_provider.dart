import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../core/di/injection.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/i_chat_repository.dart';

class ChatProvider extends ChangeNotifier {
  final IChatRepository _chatRepository = getIt<IChatRepository>();

  List<ChatMessage> _messages = [];
  bool _isLoading = false;
  String? _error;
  StreamSubscription<String>? _streamSubscription;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isStreaming =>
      _messages.isNotEmpty && _messages.last.isStreaming;

  Future<void> loadHistory() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _messages = await _chatRepository.getChatHistory();
    } catch (e) {
      _error = '채팅 기록을 불러오는데 실패했습니다.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    _error = null;

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: MessageRole.user,
      content: content.trim(),
      timestamp: DateTime.now(),
    );

    _messages = [..._messages, userMessage];
    notifyListeners();

    final assistantMessageId =
        (DateTime.now().millisecondsSinceEpoch + 1).toString();
    final assistantMessage = ChatMessage(
      id: assistantMessageId,
      role: MessageRole.assistant,
      content: '',
      timestamp: DateTime.now(),
      isStreaming: true,
    );

    _messages = [..._messages, assistantMessage];
    notifyListeners();

    try {
      final stream = _chatRepository.sendMessage(content, _messages);

      await for (final chunk in stream) {
        _updateLastMessage(chunk, isStreaming: true);
      }

      _updateLastMessage(_messages.last.content, isStreaming: false);
    } catch (e) {
      _error = '메시지 전송에 실패했습니다.';
      _messages = _messages.where((m) => m.id != assistantMessageId).toList();
      notifyListeners();
    }
  }

  void _updateLastMessage(String content, {required bool isStreaming}) {
    if (_messages.isEmpty) return;

    final lastMessage = _messages.last;
    final updatedMessage = lastMessage.copyWith(
      content: content,
      isStreaming: isStreaming,
    );

    _messages = [
      ..._messages.sublist(0, _messages.length - 1),
      updatedMessage,
    ];
    notifyListeners();
  }

  void stopStreaming() {
    _streamSubscription?.cancel();
    _streamSubscription = null;

    if (_messages.isNotEmpty && _messages.last.isStreaming) {
      _updateLastMessage(_messages.last.content, isStreaming: false);
    }
  }

  Future<void> clearHistory() async {
    try {
      await _chatRepository.clearHistory();
      _messages = [];
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = '채팅 기록 삭제에 실패했습니다.';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
