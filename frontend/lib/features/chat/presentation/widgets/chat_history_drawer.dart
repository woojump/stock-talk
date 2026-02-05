import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/chat/presentation/providers/chat_provider.dart';
import 'package:stock_talk/features/chat/presentation/widgets/chat_room_list_item.dart';

/// 채팅 내역 사이드바 (Drawer)
class ChatHistoryDrawer extends StatefulWidget {
  const ChatHistoryDrawer({super.key});

  @override
  State<ChatHistoryDrawer> createState() => _ChatHistoryDrawerState();
}

class _ChatHistoryDrawerState extends State<ChatHistoryDrawer> {
  @override
  void initState() {
    super.initState();
    // 드로어가 열릴 때 채팅방 목록 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatProvider>().loadChatRooms();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = (screenWidth * 0.8).clamp(280.0, 320.0);

    return Drawer(
      width: drawerWidth,
      backgroundColor: AppColors.white,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const Divider(height: 1, color: AppColors.gray200),
            Expanded(child: _buildRoomList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.gray800),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            '대화 내역',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: AppTypography.semiBold,
              color: AppColors.gray800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomList() {
    return Consumer<ChatProvider>(
      builder: (context, provider, _) {
        if (provider.isLoadingRooms) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.chatRooms.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 48,
                  color: AppColors.gray400,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  '대화 내역이 없어요',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: AppTypography.regular,
                    color: AppColors.gray500,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: provider.chatRooms.length,
          itemBuilder: (context, index) {
            final room = provider.chatRooms[index];
            return ChatRoomListItem(
              room: room,
              isSelected: room.roomId == provider.currentRoomId,
              onTap: () {
                provider.selectChatRoom(room.roomId);
                Navigator.of(context).pop();
              },
              onDelete: () => provider.deleteChatRoom(room.roomId),
            );
          },
        );
      },
    );
  }
}
