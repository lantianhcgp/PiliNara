import 'dart:ui';

import 'package:PiliPlus/common/glass/glass_theme.dart';
import 'package:flutter/material.dart';

/// 液态玻璃容器 Widget
/// 自动应用毛玻璃模糊效果
class GlassContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final double blurSigma;
  final double opacity;
  final Color? tintColor;
  final List<BoxShadow>? shadows;
  final BoxDecoration? decoration;

  const GlassContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.radius = GlassTheme.standardRadius,
    this.blurSigma = GlassTheme.blurSigma,
    this.opacity = 0,
    this.tintColor,
    this.shadows,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurSigma,
          sigmaY: blurSigma,
        ),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          margin: margin,
          decoration: decoration ??
              GlassTheme.glassDecoration(
                brightness: brightness,
                tintColor: tintColor,
                radius: radius,
                opacity: opacity,
                shadows: shadows,
              ),
          child: child,
        ),
      ),
    );
  }
}

/// 液态玻璃渐变容器
class GradientGlassContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final double blurSigma;
  final double opacity;

  const GradientGlassContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.radius = GlassTheme.standardRadius,
    this.blurSigma = GlassTheme.blurSigma,
    this.opacity = 0,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurSigma,
          sigmaY: blurSigma,
        ),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          margin: margin,
          decoration: GlassTheme.gradientGlassDecoration(
            brightness: brightness,
            radius: radius,
            opacity: opacity,
          ),
          child: child,
        ),
      ),
    );
  }
}

/// 液态玻璃 Scaffold 背景包装器
/// 提供渐变背景以衬托玻璃效果
class GlassScaffoldBackground extends StatelessWidget {
  final Widget child;
  final LinearGradient? gradient;

  const GlassScaffoldBackground({
    super.key,
    required this.child,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? GlassTheme.scaffoldBackgroundGradient(brightness),
      ),
      child: child,
    );
  }
}

/// 液态玻璃 AppBar
class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final double? toolbarHeight;
  final PreferredSizeWidget? bottom;
  final double blurSigma;
  final double opacity;

  const GlassAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.toolbarHeight,
    this.bottom,
    this.blurSigma = GlassTheme.blurSigma,
    this.opacity = 0,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        (toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurSigma,
          sigmaY: blurSigma,
        ),
        child: AppBar(
          title: title,
          leading: leading,
          actions: actions,
          toolbarHeight: toolbarHeight,
          bottom: bottom,
          backgroundColor: GlassTheme.glassSurfaceColor(
            brightness,
            opacity: opacity,
          ),
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
        ),
      ),
    );
  }
}

/// 液态玻璃卡片
class GlassCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final double blurSigma;
  final VoidCallback? onTap;
  final double opacity;

  const GlassCard({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.radius = GlassTheme.standardRadius,
    this.blurSigma = GlassTheme.lightBlurSigma,
    this.onTap,
    this.opacity = 0,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    Widget card = GlassContainer(
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin,
      radius: radius,
      blurSigma: blurSigma,
      opacity: opacity,
      child: child,
    );

    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          splashColor: (brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black)
              .withValues(alpha: 0.1),
          highlightColor: (brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black)
              .withValues(alpha: 0.05),
          child: card,
        ),
      );
    }

    return card;
  }
}

/// 液态玻璃底部导航栏装饰
class GlassNavigationBarDecoration extends StatelessWidget {
  final Widget child;

  const GlassNavigationBarDecoration({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(GlassTheme.capsuleRadius),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: GlassTheme.blurSigma,
          sigmaY: GlassTheme.blurSigma,
        ),
        child: child,
      ),
    );
  }
}

/// 液态玻璃搜索框
class GlassSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final String? hintText;
  final double radius;

  const GlassSearchBar({
    super.key,
    this.onTap,
    this.hintText,
    this.radius = GlassTheme.capsuleRadius,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final theme = Theme.of(context);

    return GlassContainer(
      blurSigma: GlassTheme.lightBlurSigma,
      radius: radius,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          splashColor: theme.colorScheme.primaryContainer
              .withValues(alpha: brightness == Brightness.dark ? 0.2 : 0.15),
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Icon(
                  Icons.search_outlined,
                  color: theme.colorScheme.onSurface
                      .withValues(alpha: 0.5),
                  semanticLabel: '搜索',
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    hintText ?? '搜索',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface
                          .withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 液态玻璃底部面板包装器
class GlassBottomSheet extends StatelessWidget {
  final Widget child;
  final double blurSigma;

  const GlassBottomSheet({
    super.key,
    required this.child,
    this.blurSigma = GlassTheme.heavyBlurSigma,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(GlassTheme.largeRadius),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurSigma,
          sigmaY: blurSigma,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: GlassTheme.glassSurfaceColor(brightness),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(GlassTheme.largeRadius),
            ),
            border: Border(
              top: BorderSide(
                color: GlassTheme.glassBorderColor(brightness),
                width: 0.5,
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
