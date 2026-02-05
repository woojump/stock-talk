import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/core/di/injection.dart';
import 'package:stock_talk/features/chat/presentation/providers/chat_provider.dart';
import 'package:stock_talk/features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:stock_talk/features/chat/presentation/widgets/chat_history_drawer.dart';
import 'package:stock_talk/features/chat/presentation/widgets/chat_input_field.dart';
import 'package:stock_talk/features/chat/presentation/widgets/chat_landing_view.dart';
import 'package:stock_talk/features/chat/presentation/widgets/chat_message_list.dart';

@RoutePage()
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<ChatProvider>(),
      child: const _ChatPageView(),
    );
  }
}

class _ChatPageView extends StatelessWidget {
  const _ChatPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: const ChatHistoryDrawer(),
      drawerEnableOpenDragGesture: false,
      body: Consumer<ChatProvider>(
        builder: (context, provider, _) {
          return Stack(
            children: [
              // 그라데이션 배경
              _buildGradientBackground(),

              // 메인 콘텐츠
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 앱바
                    Builder(
                      builder: (context) => ChatAppBar(
                        onMenuTap: () => Scaffold.of(context).openDrawer(),
                        onNewChatTap: provider.startNewConversation,
                      ),
                    ),

                    // 메시지 영역
                    Expanded(
                      child: provider.viewState == ChatViewState.landing
                          ? const ChatLandingView()
                          : const ChatMessageList(),
                    ),

                    // 에러 메시지
                    if (provider.error != null)
                      _ErrorBanner(
                        message: provider.error!,
                        onDismiss: provider.clearError,
                      ),

                    // 입력 필드
                    const ChatInputField(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 400,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.2,
            colors: [
              AppColors.blue300.withValues(alpha: 0.3),
              AppColors.white.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}

/// 에러 배너
class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message, required this.onDismiss});

  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.red.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.red),
            ),
          ),
          GestureDetector(
            onTap: onDismiss,
            child: const Icon(Icons.close, size: 18, color: AppColors.red),
          ),
        ],
      ),
    );
  }
}
