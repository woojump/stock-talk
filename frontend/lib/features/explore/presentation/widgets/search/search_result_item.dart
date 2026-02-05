import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/explore/domain/entities/search_entities.dart';

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({
    super.key,
    required this.result,
    required this.query,
    required this.onTap,
  });

  final SearchResult result;
  final String query;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHighlightedText(context, result.name, query),
            const SizedBox(height: AppSpacing.xs),
            Text(
              result.ticker,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.gray500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedText(
    BuildContext context,
    String text,
    String query,
  ) {
    if (query.isEmpty) {
      return Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: AppTypography.semiBold,
          color: AppColors.black,
        ),
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final matchIndex = lowerText.indexOf(lowerQuery);

    if (matchIndex == -1) {
      return Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: AppTypography.semiBold,
          color: AppColors.black,
        ),
      );
    }

    final beforeMatch = text.substring(0, matchIndex);
    final match = text.substring(matchIndex, matchIndex + query.length);
    final afterMatch = text.substring(matchIndex + query.length);

    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: AppTypography.semiBold,
          color: AppColors.black,
        ),
        children: [
          TextSpan(
            text: beforeMatch,
            style: const TextStyle(color: AppColors.black),
          ),
          TextSpan(
            text: match,
            style: const TextStyle(color: AppColors.blue400),
          ),
          TextSpan(
            text: afterMatch,
            style: const TextStyle(color: AppColors.black),
          ),
        ],
      ),
    );
  }
}
