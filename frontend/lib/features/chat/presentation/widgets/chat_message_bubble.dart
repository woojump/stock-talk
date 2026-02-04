import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

/// 채팅 메시지 말풍선
class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isUser,
  });

  final String message;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    if (isUser) {
      return _UserBubble(message: message);
    }
    return _AssistantText(message: message);
  }
}

/// 사용자 메시지 말풍선
class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.65,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            decoration: const BoxDecoration(
              color: AppColors.gray200,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: AppTypography.titleMedium,
                fontWeight: AppTypography.medium,
                color: AppColors.black,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// AI 응답 텍스트
class _AssistantText extends StatelessWidget {
  const _AssistantText({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Text(
        message,
        style: const TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: AppTypography.titleMedium,
          fontWeight: AppTypography.medium,
          color: AppColors.gray800,
          height: 1.6,
        ),
      ),
    );
  }
}
