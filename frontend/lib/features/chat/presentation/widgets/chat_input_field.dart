import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/chat/presentation/providers/chat_provider.dart';

/// 채팅 메시지 입력 필드
class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSend(ChatProvider provider) {
    if (!provider.canSend) return;
    provider.sendMessage(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, _) {
        final isActive = provider.inputText.isNotEmpty;

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.white.withOpacity(0), AppColors.white],
              stops: const [0.0, 0.2],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 입력 필드
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 120),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(
                      color: isActive ? AppColors.gray300 : AppColors.gray200,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: 4,
                    minLines: 1,
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: AppTypography.bodyMedium,
                      fontWeight: AppTypography.medium,
                      color: AppColors.gray800,
                    ),
                    decoration: const InputDecoration(
                      hintText: '궁금한 내용을 입력하세요',
                      hintStyle: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: AppTypography.titleMedium,
                        fontWeight: AppTypography.medium,
                        color: AppColors.gray500,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                    ),
                    onChanged: provider.updateInputText,
                    onSubmitted: provider.canSend
                        ? (_) => _onSend(provider)
                        : null,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // 전송 버튼
              _SendButton(
                isActive: provider.canSend,
                isSending: provider.isSending,
                onTap: () => _onSend(provider),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// 전송 버튼
class _SendButton extends StatelessWidget {
  const _SendButton({
    required this.isActive,
    required this.isSending,
    required this.onTap,
  });

  final bool isActive;
  final bool isSending;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.gray700
              : AppColors.gray500.withOpacity(0.4),
          borderRadius: BorderRadius.circular(80),
        ),
        child: Center(
          child: isSending
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                )
              : const AppIcon.action('send', color: AppColors.white),
        ),
      ),
    );
  }
}
