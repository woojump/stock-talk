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

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 상단 블러 그라데이션
            Container(
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.white.withValues(alpha: 0),
                    AppColors.white,
                  ],
                ),
              ),
            ),
            // 입력창 컨테이너
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 입력 필드
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 120),
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        border: Border.all(
                          color: isActive
                              ? AppColors.gray300
                              : AppColors.gray200,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _controller,
                        maxLines: 4,
                        minLines: 1,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.black,
                          height: 1.3,
                        ),
                        decoration: InputDecoration(
                          hintText: '궁금한 내용을 입력하세요',
                          hintStyle: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.gray500, height: 1.3),
                          filled: false,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
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
            ),
          ],
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
          color: isActive ? AppColors.black : AppColors.gray200,
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
              : AppIcon.action(
                  'send',
                  color: isActive ? AppColors.white : AppColors.gray400,
                  size: 24,
                ),
        ),
      ),
    );
  }
}
