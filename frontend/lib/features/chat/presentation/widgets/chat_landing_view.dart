import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/chat/presentation/providers/chat_provider.dart';
import 'package:stock_talk/features/chat/presentation/widgets/suggestion_chip.dart';

/// 채팅 랜딩 화면 (새 대화 시작)
class ChatLandingView extends StatelessWidget {
  const ChatLandingView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ChatProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.xxxl),
            // 인사 문구
            const Text(
              '반가워요.\n무엇을 도와드릴까요?',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 20,
                fontWeight: AppTypography.semiBold,
                color: AppColors.gray800,
                height: 1.64,
              ),
            ),
            const SizedBox(height: AppSpacing.xxxl),
            // 제안 칩 목록
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ChatProvider.suggestions
                  .map(
                    (suggestion) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: SuggestionChip(
                        label: suggestion,
                        onTap: () => provider.sendMessage(suggestion),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
