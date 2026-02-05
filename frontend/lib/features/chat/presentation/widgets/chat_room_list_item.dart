import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/chat/domain/entities/chat_entities.dart';

/// 채팅방 목록 아이템 (스와이프 삭제 지원)
class ChatRoomListItem extends StatelessWidget {
  const ChatRoomListItem({
    super.key,
    required this.room,
    required this.onTap,
    required this.onDelete,
    this.isSelected = false,
  });

  final ChatRoom room;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('chat_room_${room.roomId}'),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        return await _showDeleteConfirmDialog(context);
      },
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.xl),
        color: AppColors.red,
        child: const Icon(
          Icons.delete_outline,
          color: AppColors.white,
          size: 24,
        ),
      ),
      child: _buildContent(context),
    );
  }

  Future<bool> _showDeleteConfirmDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('대화 삭제'),
            content: const Text('이 대화를 삭제하시겠어요?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: AppColors.red),
                child: const Text('삭제'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget _buildContent(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gray100 : AppColors.white,
          border: const Border(
            bottom: BorderSide(color: AppColors.gray200, width: 1),
          ),
        ),
        child: Text(
          room.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: AppTypography.medium,
            color: AppColors.gray800,
          ),
        ),
      ),
    );
  }
}
