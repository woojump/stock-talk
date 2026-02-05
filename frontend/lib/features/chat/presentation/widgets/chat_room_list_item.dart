import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/chat/domain/entities/chat_entities.dart';

/// 채팅방 목록 아이템 (스와이프 삭제 지원)
class ChatRoomListItem extends StatefulWidget {
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
  State<ChatRoomListItem> createState() => _ChatRoomListItemState();
}

class _ChatRoomListItemState extends State<ChatRoomListItem> {
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('chat_room_${widget.room.roomId}'),
      direction: DismissDirection.endToStart,
      onUpdate: (details) {
        setState(() {
          _progress = details.progress;
        });
      },
      confirmDismiss: (_) async {
        return await _showDeleteConfirmDialog(context);
      },
      onDismissed: (_) => widget.onDelete(),
      background: Container(),
      secondaryBackground: LayoutBuilder(
        builder: (context, constraints) {
          final revealedWidth = constraints.maxWidth * _progress;
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: (revealedWidth - AppSpacing.sm).clamp(
                0.0,
                constraints.maxWidth,
              ),
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: AppIcon.action(
                  'trash',
                  color: AppColors.white,
                  size: 24,
                ),
              ),
            ),
          );
        },
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
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: widget.isSelected ? AppColors.gray200 : AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.room.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: AppTypography.semiBold,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
