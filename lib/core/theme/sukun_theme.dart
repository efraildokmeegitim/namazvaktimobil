import 'package:flutter/material.dart';

class SukunColors {
  // Karbon & Zümrüt (Varsayılan Koyu Tema - OLED Dostu)
  static const Color carbonBackground = Color(0xFF080C0B);
  static const Color carbonCardSurface = Color(0xFF111816);
  static const Color carbonGlassSurface = Color(0xBF16211E); // %75 opacity
  static const Color carbonBorder = Color(0xFF1F2E2A);
  static const Color emeraldPrimary = Color(0xFF1FA87C);
  static const Color goldAccent = Color(0xFFD4AF6A);
  static const Color carbonTextPrimary = Color(0xFFF0EFEA);
  static const Color carbonTextSecondary = Color(0xFF96A5A0);

  // Nur & Fildişi (Aydınlık Tema)
  static const Color nurBackground = Color(0xFFFAF7F2);
  static const Color nurCardSurface = Color(0xFFFFFFFF);
  static const Color nurBorder = Color(0xFFE8E2D7);
  static const Color tileGreenPrimary = Color(0xFF0D5C46);
  static const Color leafAmberAccent = Color(0xFFB8893D);
  static const Color nurTextPrimary = Color(0xFF16201D);
  static const Color nurTextSecondary = Color(0xFF5C6B66);

  // Sepya / Kitap Kağıdı Modu
  static const Color sepiaBackground = Color(0xFFF3EACB);
  static const Color sepiaInkText = Color(0xFF2B241B);

  // Vakte Duyarlı Dinamik Başlık Gradyanları
  static const List<Color> gradientFajr = [Color(0xFF141E30), Color(0xFF6B495B)];
  static const List<Color> gradientDhuhr = [Color(0xFF0F4C5C), Color(0xFF1B6B5A)];
  static const List<Color> gradientAsr = [Color(0xFF3D4E42), Color(0xFF8C6A43)];
  static const List<Color> gradientMaghrib = [Color(0xFF2B1B3D), Color(0xFF7A3E3E)];
  static const List<Color> gradientIsha = [Color(0xFF070B0E), Color(0xFF102027)];
}

class SukunTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: SukunColors.carbonBackground,
      primaryColor: SukunColors.emeraldPrimary,
      cardColor: SukunColors.carbonCardSurface,
      colorScheme: const ColorScheme.dark(
        primary: SukunColors.emeraldPrimary,
        secondary: SukunColors.goldAccent,
        surface: SukunColors.carbonCardSurface,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: SukunColors.carbonTextPrimary),
        bodyMedium: TextStyle(color: SukunColors.carbonTextSecondary),
        titleLarge: TextStyle(
          color: SukunColors.carbonTextPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: SukunColors.carbonTextPrimary,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: SukunColors.nurBackground,
      primaryColor: SukunColors.tileGreenPrimary,
      cardColor: SukunColors.nurCardSurface,
      colorScheme: const ColorScheme.light(
        primary: SukunColors.tileGreenPrimary,
        secondary: SukunColors.leafAmberAccent,
        surface: SukunColors.nurCardSurface,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: SukunColors.nurTextPrimary),
        bodyMedium: TextStyle(color: SukunColors.nurTextSecondary),
        titleLarge: TextStyle(
          color: SukunColors.nurTextPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: SukunColors.nurTextPrimary,
      ),
    );
  }

  // Hayrat Neşriyat Hattı Typography Tokens
  static const List<String> hayratFontFamilyFallback = [
    'HayratNesih',
    'ScheherazadeNew',
    'KFGQPC Uthmanic Script HAFS',
    'Amiri',
    'DejaVu Sans',
  ];

  static TextStyle arabicQuranStyle({
    double fontSize = 24.0,
    FontWeight fontWeight = FontWeight.w600,
    double height = 2.2,
    double letterSpacing = 0.5,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: 'HayratNesih',
      fontFamilyFallback: hayratFontFamilyFallback,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
    );
  }
}
