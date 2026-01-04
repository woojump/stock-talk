import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/chat_message.dart';
import '../../providers/chat_provider.dart';
import '../../widgets/chat/assistant_bubble.dart';
import '../../widgets/chat/chat_input_field.dart';
import '../../widgets/chat/user_bubble.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatProvider>().loadHistory();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI 어시스턴트'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'clear') {
                _showClearConfirmDialog();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline),
                    SizedBox(width: 8),
                    Text('대화 기록 삭제'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<ChatProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.messages.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: provider.messages.isEmpty
                    ? _buildEmptyState()
                    : _buildMessageList(provider),
              ),
              ChatInputField(
                onSend: (text) {
                  provider.sendMessage(text);
                  Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
                },
                enabled: !provider.isStreaming,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.smart_toy_outlined,
              size: 40,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'AI 어시스턴트',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '주식 거래를 도와드립니다',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildSuggestionChip('삼성전자 시세 알려줘'),
              _buildSuggestionChip('내 잔고 확인해줘'),
              _buildSuggestionChip('추천 종목 알려줘'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        context.read<ChatProvider>().sendMessage(text);
      },
    );
  }

  Widget _buildMessageList(ChatProvider provider) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: provider.messages.length,
      itemBuilder: (context, index) {
        final message = provider.messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    if (message.isUser) {
      return UserBubble(message: message);
    } else {
      return AssistantBubble(message: message);
    }
  }

  void _showClearConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('대화 기록 삭제'),
        content: const Text('모든 대화 기록이 삭제됩니다. 계속하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              context.read<ChatProvider>().clearHistory();
              Navigator.pop(context);
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}
