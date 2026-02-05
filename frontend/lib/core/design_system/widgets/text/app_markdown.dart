import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

/// 앱 전역에서 사용하는 마크다운 렌더링 위젯
class AppMarkdown extends StatelessWidget {
  const AppMarkdown({super.key, required this.data, this.selectable = true});

  final String data;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MarkdownBody(
      data: data,
      selectable: selectable,
      shrinkWrap: true,
      styleSheet: MarkdownStyleSheet(
        p: textTheme.bodySmall?.copyWith(color: AppColors.black, height: 1.5),
        strong: textTheme.bodySmall?.copyWith(
          color: AppColors.black,
          fontWeight: AppTypography.semiBold,
        ),
        h1: textTheme.titleMedium?.copyWith(color: AppColors.black),
        h2: textTheme.titleSmall?.copyWith(color: AppColors.black),
        h3: textTheme.bodyMedium?.copyWith(
          color: AppColors.black,
          fontWeight: AppTypography.semiBold,
        ),
        tableHead: textTheme.bodySmall?.copyWith(
          color: AppColors.black,
          fontWeight: AppTypography.semiBold,
        ),
        tableBody: textTheme.bodySmall?.copyWith(color: AppColors.black),
        tableBorder: TableBorder.all(color: AppColors.gray200, width: 1),
        tableCellsPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        tableCellsDecoration: const BoxDecoration(color: AppColors.white),
        listBullet: textTheme.bodySmall?.copyWith(color: AppColors.black),
        code: textTheme.bodySmall?.copyWith(
          backgroundColor: AppColors.gray100,
          fontFamily: 'monospace',
        ),
        blockquote: textTheme.bodySmall?.copyWith(
          color: AppColors.gray600,
          fontStyle: FontStyle.italic,
        ),
        blockquoteDecoration: BoxDecoration(
          color: AppColors.gray100,
          border: const Border(
            left: BorderSide(color: AppColors.gray300, width: 4),
          ),
        ),
      ),
    );
  }
}
