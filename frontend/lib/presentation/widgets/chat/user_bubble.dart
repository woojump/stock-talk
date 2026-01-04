import 'package:flutter/material.dart';

import '../../../domain/entities/chat_message.dart';

class UserBubble extends StatelessWidget {
  final ChatMessage message;

  const UserBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.only(
          left: 48,
          right: 16,
          top: 4,
          bottom: 4,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(4),
          ),
        ),
        child: Text(
          message.content,
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
