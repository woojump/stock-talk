import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

/// 주요 액션을 위한 Primary Button
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    final button = Opacity(
      opacity: isDisabled ? 0.4 : 1.0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Ink(
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.blue400,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.white,
                        ),
                      ),
                    )
                  : DefaultTextStyle(
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.white,
                        height: 1.5, // Approx lineHeightBody / titleLarge
                      ),
                      child: child,
                    ),
            ),
          ),
        ),
      ),
    );

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
