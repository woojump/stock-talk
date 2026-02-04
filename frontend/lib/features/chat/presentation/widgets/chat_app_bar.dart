import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

/// 채팅 화면 앱바
class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key, this.onMenuTap, this.onNewChatTap});

  final VoidCallback? onMenuTap;
  final VoidCallback? onNewChatTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 메뉴 아이콘
          GestureDetector(
            onTap: onMenuTap,
            child: const SizedBox(
              width: 24,
              height: 24,
              child: AppIcon.action('menu'),
            ),
          ),
          // 타이틀
          const Text(
            '채팅하기',
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 17,
              fontWeight: AppTypography.semiBold,
              color: AppColors.black,
            ),
          ),
          // 새 대화 버튼
          GestureDetector(
            onTap: onNewChatTap,
            child: const Icon(
              Icons.edit_square,
              size: 24,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
