import 'package:flutter/material.dart';


extension ThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

class EcoColors {
  static const Color light = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF000000);
  static const Color grey = Color(0xFFF3F3F3);
  static const Color primary = Color(0xFF00E19D);
  static const Color secondary = Color(0xFFF9F9F9);
  static const Color inverted = Color(0xFF1A1A1A);
  static const Color neutral = Color(0xFF9AA6AC);
  static const Color neutralSubtitle = Color(0xFFAFB0B4);
  static const Color destructiveAccent = Color(0xFFE6483D);
  static const Color successAccent = Color(0xFF32C164);
}

class TezdaTheme {
  static const _ecoTextStyle = TextStyle(fontFamily: 'san_franscisco', color: EcoColors.inverted);
  static final TextTheme _textTheme = TextTheme(
    titleLarge: _ecoTextStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w700),
    titleMedium: _ecoTextStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
    titleSmall: _ecoTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: EcoColors.inverted.withOpacity(.3)),
    headlineLarge: _ecoTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
    headlineMedium: _ecoTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
    headlineSmall: _ecoTextStyle.copyWith(fontSize: 16),
    bodyLarge: _ecoTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
    bodyMedium: _ecoTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: EcoColors.inverted.withOpacity(.3)),
    bodySmall: _ecoTextStyle.copyWith(fontSize: 14),
  );
  static final ThemeData themeData = ThemeData(
    unselectedWidgetColor: EcoColors.inverted.withOpacity(.3),
    disabledColor: EcoColors.inverted.withOpacity(.3),
    fontFamily: 'san_franscisco',
    brightness: Brightness.light,
    primaryColor: EcoColors.primary,
    scaffoldBackgroundColor: EcoColors.light,
    colorScheme: const ColorScheme.light().copyWith(
      primary: EcoColors.primary,
      secondary: EcoColors.inverted,
      error: EcoColors.destructiveAccent,
      surface: EcoColors.light,
    ),
    iconTheme: IconThemeData(color: EcoColors.inverted.withOpacity(.3)),
    textTheme: _textTheme,
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: EcoColors.inverted.withOpacity(.3),
      suffixIconColor: EcoColors.inverted.withOpacity(.3),
      hintStyle: _textTheme.bodySmall?.copyWith(color: EcoColors.inverted.withOpacity(.3)),
      filled: true,
      fillColor: EcoColors.secondary,
      contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.baseSingleHalf, vertical: Sizes.baseSingleHalf),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(Sizes.baseSingleHalf), borderSide: BorderSide.none),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: WidgetStateProperty.all(EcoColors.inverted.withOpacity(.1)),
        foregroundColor: WidgetStateProperty.all(EcoColors.light),
        iconSize: WidgetStateProperty.all(16),
        padding: WidgetStateProperty.all(const EdgeInsets.all(6)),
        minimumSize: WidgetStateProperty.all(const Size(20, 20)),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.comfortable,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      side: BorderSide(width: .5, color: EcoColors.inverted.withOpacity(.4)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 52)),
        textStyle: WidgetStateProperty.all(_ecoTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
        foregroundColor: WidgetStateProperty.all(EcoColors.dark),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return EcoColors.inverted.withOpacity(.02);
          }
          return EcoColors.inverted.withOpacity(.1);
        }),
        shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Sizes.baseSingleHalf)))),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 52)),
        textStyle: WidgetStateProperty.all(_ecoTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return EcoColors.inverted.withOpacity(.1);
          }
          return EcoColors.primary;
        }),
        foregroundColor: WidgetStateProperty.all(EcoColors.light),
        shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Sizes.baseSingleHalf)))),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: EcoColors.primary),
    radioTheme: RadioThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      fillColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return EcoColors.primary;
        }
        return EcoColors.inverted.withOpacity(.3);
      }),
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: EcoColors.inverted.withOpacity(0.05),
      selectedTileColor: EcoColors.primary.withOpacity(.2),
      contentPadding: const EdgeInsets.only(left: Sizes.baseDouble, right: Sizes.baseSingle),
    ),
  );
}

class Sizes {
  static const baseNone = 0.00;
  static const baseQuarter = 2.00;
  static const baseHalf = 4.00;
  static const baseSingle = 8.00;
  static const baseSingleQuarter = 10.00;
  static const baseSingleHalf = 12.00;
  static const baseDouble = 16.00;
  static const baseDoubleQuarter = 18.00;
  static const baseDoubleHalf = 20.00;
  static const baseTriple = 24.00;
  static const baseQuadruple = 32.00;
  static const baseQuadrupleHalf = 36.00;
  static const baseFivefold = 40.00;
}
