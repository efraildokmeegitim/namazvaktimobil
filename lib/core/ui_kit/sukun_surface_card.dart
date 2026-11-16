import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/sukun_theme.dart';

class SukunSurfaceCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onTap;
  final bool enableGlass;
  final Color? customBackground;
  final Color? borderColor;
  final double borderRadius;

  const SukunSurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.onTap,
    this.enableGlass = false,
    this.customBackground,
    this.borderColor,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBg = isDark
        ? (enableGlass ? SukunColors.carbonGlassSurface : SukunColors.carbonCardSurface)
        : SukunColors.nurCardSurface;
    final defaultBorder = borderColor ?? (isDark ? SukunColors.carbonBorder : SukunColors.nurBorder);

    Widget content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: customBackground ?? defaultBg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: defaultBorder,
          width: 1,
        ),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: child,
    );

    if (enableGlass) {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: content,
        ),
      );
    }

    if (onTap != null) {
      return Padding(
        padding: margin,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: content,
        ),
      );
    }

    return Padding(
      padding: margin,
      child: content,
    );
  }
}
