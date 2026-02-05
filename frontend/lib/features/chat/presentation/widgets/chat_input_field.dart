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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                offset: const Offset(0, -1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 입력 필드
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 120),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(
                      color: isActive ? AppColors.gray400 : AppColors.gray300,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: 4,
                    minLines: 1,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.black,
                      fontWeight: AppTypography.medium,
                    ),
                    decoration: InputDecoration(
                      hintText: '궁금한 내용을 입력하세요',
                      hintStyle: Theme.of(context).textTheme.labelLarge
                          ?.copyWith(
                            color: AppColors.gray400,
                            fontWeight: AppTypography.medium,
                          ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
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
              const SizedBox(width: AppSpacing.md),
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
        decoration: const BoxDecoration(
          color: AppColors.black,
          shape: BoxShape.circle,
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
              : const Icon(
                  Icons.arrow_upward,
                  color: AppColors.white,
                  size: 24,
                ),
        ),
      ),
    );
  }
}
