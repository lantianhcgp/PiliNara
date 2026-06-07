import 'dart:ui';

import 'package:flutter/material.dart';

/// 液态玻璃主题配置
/// 提供毛玻璃效果的核心样式和装饰
abstract final class GlassTheme {
  // ── 玻璃透明度 ──
  /// 浅色模式下玻璃底板透明度
  static const double _lightGlassOpacity = 0.72;

  /// 深色模式下玻璃底板透明度
  static const double _darkGlassOpacity = 0.58;

  /// 浅色模式边框透明度
  static const double _lightBorderOpacity = 0.18;

  /// 深色模式边框透明度
  static const double _darkBorderOpacity = 0.12;

  // ── 模糊强度 ──
  /// 标准玻璃模糊强度
  static const double blurSigma = 20.0;

  /// 轻量模糊（用于小元素）
  static const double lightBlurSigma = 12.0;

  /// 重量模糊（用于大面板）
  static const double heavyBlurSigma = 30.0;

  // ── 圆角 ──
  /// 标准玻璃圆角
  static const double standardRadius = 20.0;

  /// 大圆角（面板/卡片）
  static const double largeRadius = 28.0;

  /// 胶囊圆角（按钮/导航）
  static const double capsuleRadius = 36.0;

  /// 小圆角
  static const double smallRadius = 14.0;

  // ── 阴影 ──
  /// 玻璃阴影列表
  static List<BoxShadow> glassShadow(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return [
      BoxShadow(
        color: isDark
            ? Colors.black.withValues(alpha: 0.5)
            : Colors.black.withValues(alpha: 0.12),
        blurRadius: 30,
        spreadRadius: -4,
        offset: const Offset(0, 12),
      ),
      BoxShadow(
        color: isDark
            ? Colors.black.withValues(alpha: 0.3)
            : Colors.black.withValues(alpha: 0.06),
        blurRadius: 12,
        spreadRadius: -2,
        offset: const Offset(0, 4),
      ),
      BoxShadow(
        color: isDark
            ? Colors.white.withValues(alpha: 0.03)
            : Colors.white.withValues(alpha: 0.8),
        blurRadius: 1,
        spreadRadius: 0,
        offset: const Offset(0, 1),
      ),
    ];
  }

  // ── 装饰方法 ──
  /// 创建标准玻璃装饰
  static BoxDecoration glassDecoration({
    required Brightness brightness,
    Color? tintColor,
    double radius = standardRadius,
    double borderOpacity = 0,
    double opacity = 0,
    List<BoxShadow>? shadows,
  }) {
    final isDark = brightness == Brightness.dark;
    final effectiveOpacity =
        opacity > 0 ? opacity : (isDark ? _darkGlassOpacity : _lightGlassOpacity);
    final effectiveBorder =
        borderOpacity > 0 ? borderOpacity : (isDark ? _darkBorderOpacity : _lightBorderOpacity);

    final baseColor = tintColor ??
        (isDark ? Colors.white : Colors.black);

    return BoxDecoration(
      color: baseColor.withValues(alpha: effectiveOpacity),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: (isDark ? Colors.white : Colors.black)
            .withValues(alpha: effectiveBorder),
        width: 0.5,
      ),
      boxShadow: shadows ?? glassShadow(brightness),
    );
  }

  /// 创建渐变玻璃装饰（更丰富的视觉效果）
  static BoxDecoration gradientGlassDecoration({
    required Brightness brightness,
    double radius = standardRadius,
    double opacity = 0,
  }) {
    final isDark = brightness == Brightness.dark;
    final effectiveOpacity =
        opacity > 0 ? opacity : (isDark ? _darkGlassOpacity : _lightGlassOpacity);

    final colors = isDark
        ? [
            Colors.white.withValues(alpha: effectiveOpacity),
            Colors.white.withValues(alpha: effectiveOpacity * 0.6),
          ]
        : [
            Colors.white.withValues(alpha: effectiveOpacity),
            Colors.white.withValues(alpha: effectiveOpacity * 0.3),
          ];

    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: (isDark ? Colors.white : Colors.black)
            .withValues(alpha: isDark ? _darkBorderOpacity : _lightBorderOpacity),
        width: 0.5,
      ),
      boxShadow: glassShadow(brightness),
    );
  }

  /// 获取玻璃表面颜色
  static Color glassSurfaceColor(Brightness brightness, {double opacity = 0}) {
    final isDark = brightness == Brightness.dark;
    final effectiveOpacity =
        opacity > 0 ? opacity : (isDark ? _darkGlassOpacity : _lightGlassOpacity);
    return (isDark ? Colors.white : Colors.black)
        .withValues(alpha: effectiveOpacity);
  }

  /// 获取玻璃边框颜色
  static Color glassBorderColor(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return (isDark ? Colors.white : Colors.black)
        .withValues(alpha: isDark ? _darkBorderOpacity : _lightBorderOpacity);
  }

  /// 获取适用于玻璃效果的 Scaffold 背景渐变
  static LinearGradient scaffoldBackgroundGradient(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF1A0533), // 深紫
          Color(0xFF0D1B3E), // 深蓝
          Color(0xFF1A0A2E), // 暗紫
          Color(0xFF0B1A30), // 深蓝黑
          Color(0xFF150528), // 暗紫罗兰
        ],
        stops: [0.0, 0.3, 0.5, 0.75, 1.0],
      );
    }
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFC8E0FF), // 天空蓝
        Color(0xFFE0D0FF), // 薰衣草
        Color(0xFFC8E8FF), // 浅天蓝
        Color(0xFFFFD0E8), // 粉红
        Color(0xFFD8D0FF), // 淡紫
      ],
      stops: [0.0, 0.25, 0.5, 0.75, 1.0],
    );
  }

  /// 创建液态玻璃按钮样式
  static ButtonStyle glassButtonStyle(Brightness brightness, {Color? tintColor}) {
    final isDark = brightness == Brightness.dark;
    final baseColor = tintColor ??
        (isDark ? Colors.white : Colors.black);

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return baseColor.withValues(alpha: isDark ? 0.25 : 0.15);
        }
        return baseColor.withValues(alpha: isDark ? 0.15 : 0.08);
      }),
      foregroundColor: WidgetStateProperty.all(
        isDark ? Colors.white : Colors.black87,
      ),
      overlayColor: WidgetStateProperty.all(
        baseColor.withValues(alpha: isDark ? 0.15 : 0.1),
      ),
      elevation: WidgetStateProperty.all(0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(capsuleRadius),
          side: BorderSide(
            color: (isDark ? Colors.white : Colors.black)
                .withValues(alpha: isDark ? 0.15 : 0.1),
            width: 0.5,
          ),
        ),
      ),
    );
  }

  /// 创建液态玻璃 IconButton 样式
  static ButtonStyle glassIconButtonStyle(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return (isDark ? Colors.white : Colors.black)
              .withValues(alpha: isDark ? 0.2 : 0.12);
        }
        return (isDark ? Colors.white : Colors.black)
            .withValues(alpha: isDark ? 0.1 : 0.06);
      }),
      overlayColor: WidgetStateProperty.all(
        (isDark ? Colors.white : Colors.black)
            .withValues(alpha: isDark ? 0.1 : 0.08),
      ),
      elevation: WidgetStateProperty.all(0),
      shape: WidgetStateProperty.all(const CircleBorder()),
    );
  }
}
