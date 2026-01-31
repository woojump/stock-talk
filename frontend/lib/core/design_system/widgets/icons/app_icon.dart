import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// SVG 아이콘을 쉽게 사용하기 위한 래퍼 위젯
class AppIcon extends StatelessWidget {
  const AppIcon(this.name, {super.key, this.size = 24.0, this.color})
    : _isNavIcon = false;

  /// Navigation 아이콘용 Named constructor
  const AppIcon.nav(
    String name, {
    required bool active,
    super.key,
    this.size = 24.0,
    this.color,
  }) : name = 'ic_${name}_${active ? 'active' : 'inactive'}',
       _isNavIcon = true;

  /// Action 아이콘용 Named constructor
  const AppIcon.action(String name, {super.key, this.size = 24.0, this.color})
    : name = 'ic_$name',
      _isNavIcon = false;

  final String name;
  final double size;
  final Color? color;
  final bool _isNavIcon;

  String get _assetPath {
    if (name.startsWith('ic_')) {
      // 이미 ic_ 접두사가 있는 경우
      if (_isNavIcon) {
        return 'assets/icons/nav/$name.svg';
      } else {
        return 'assets/icons/actions/$name.svg';
      }
    }
    // 접두사가 없는 경우 (기본 동작)
    return 'assets/icons/actions/ic_$name.svg';
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _assetPath,
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}
