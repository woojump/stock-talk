import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  final Function(String) onSend;
  final bool enabled;

  const ChatInputField({
    super.key,
    required this.onSend,
    this.enabled = true,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  bool get _canSend => _controller.text.trim().isNotEmpty && widget.enabled;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (!_canSend) return;

    final text = _controller.text.trim();
    _controller.clear();
    widget.onSend(text);
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: widget.enabled,
                maxLines: 4,
                minLines: 1,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _handleSend(),
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: '메시지를 입력하세요...',
                  hintStyle: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: IconButton.filled(
                onPressed: _canSend ? _handleSend : null,
                icon: const Icon(Icons.send_rounded),
                style: IconButton.styleFrom(
                  backgroundColor: _canSend
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surfaceContainerHighest,
                  foregroundColor: _canSend
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
