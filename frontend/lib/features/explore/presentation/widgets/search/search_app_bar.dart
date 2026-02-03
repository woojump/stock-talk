import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onClear,
    required this.onBack,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final VoidCallback onBack;

  @override
  Size get preferredSize => const Size.fromHeight(44);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Row(
          children: [
            GestureDetector(
              onTap: widget.onBack,
              behavior: HitTestBehavior.opaque,
              child: const SizedBox(
                width: 24,
                height: 24,
                child: AppIcon.action('back', size: 24),
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(child: _buildSearchField()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    final hasText = widget.controller.text.isNotEmpty;

    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.gray200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              autofocus: true,
              onChanged: widget.onChanged,
              style: const TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: AppTypography.titleMedium,
                fontWeight: AppTypography.medium,
                color: AppColors.black,
              ),
              decoration: const InputDecoration(
                hintText: '어떤 주식을 찾고 있나요?',
                hintStyle: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: AppTypography.titleMedium,
                  fontWeight: AppTypography.medium,
                  color: AppColors.gray500,
                ),
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                isDense: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: hasText
                ? GestureDetector(
                    onTap: widget.onClear,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: AppColors.gray400,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 12,
                        color: AppColors.white,
                      ),
                    ),
                  )
                : const AppIcon.action(
                    'search',
                    size: 24,
                    color: AppColors.gray400,
                  ),
          ),
        ],
      ),
    );
  }
}
