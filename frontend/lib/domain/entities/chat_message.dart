import 'package:equatable/equatable.dart';

enum MessageRole { user, assistant }

class ChatMessage extends Equatable {
  final String id;
  final MessageRole role;
  final String content;
  final DateTime timestamp;
  final bool isStreaming;

  const ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
    this.isStreaming = false,
  });

  ChatMessage copyWith({
    String? id,
    MessageRole? role,
    String? content,
    DateTime? timestamp,
    bool? isStreaming,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      role: role ?? this.role,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isStreaming: isStreaming ?? this.isStreaming,
    );
  }

  bool get isUser => role == MessageRole.user;
  bool get isAssistant => role == MessageRole.assistant;

  @override
  List<Object?> get props => [id, role, content, timestamp, isStreaming];
}
