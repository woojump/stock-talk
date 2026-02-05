import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/chat/domain/entities/chat_entities.dart';
import 'package:stock_talk/features/chat/presentation/providers/chat_provider.dart';
import 'package:stock_talk/features/chat/presentation/widgets/chat_message_bubble.dart';
import 'package:stock_talk/features/chat/presentation/widgets/stock_info_card.dart';

/// 채팅 메시지 목록
class ChatMessageList extends StatefulWidget {
  const ChatMessageList({super.key});

  @override
  State<ChatMessageList> createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, _) {
        // 메시지가 변경되면 스크롤
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (provider.messages.isNotEmpty) {
            _scrollToBottom();
          }
        });

        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          itemCount: provider.messages.length + (provider.isSending ? 1 : 0),
          itemBuilder: (context, index) {
            // 로딩 인디케이터
            if (index == provider.messages.length && provider.isSending) {
              return const _TypingIndicator();
            }

            final message = provider.messages[index];
            return _buildMessageWidget(message);
          },
        );
      },
    );
  }

  Widget _buildMessageWidget(ChatMessage message) {
    if (message.isUser) {
      return ChatMessageBubble(message: message.content, isUser: true);
    }

    // AI 응답
    if (message.isCard && message.cardPayload != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.content.isNotEmpty)
            ChatMessageBubble(message: message.content, isUser: false),
          StockInfoCard(payload: message.cardPayload!),
          const SizedBox(height: AppSpacing.xl),
        ],
      );
    }

    return ChatMessageBubble(message: message.content, isUser: false);
  }
}

/// 타이핑 인디케이터 (AI가 응답 중)
class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.gray100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(0),
                const SizedBox(width: 4),
                _buildDot(1),
                const SizedBox(width: 4),
                _buildDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 200)),
      builder: (context, value, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.gray500.withValues(alpha: 0.4 + (value * 0.6)),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
