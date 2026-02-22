import 'package:flutter/material.dart';

class MyThemes {
  // ========== COLOR PAIRS ==========
  
  // Primary Colors
  static const Color primaryLight = Color(0xFF2196F3);
  static const Color primaryDark = Color(0xFF1976D2);
  
  static const Color onPrimaryLight = Colors.white;
  static const Color onPrimaryDark = Colors.white;
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);
  
  static const Color onBackgroundLight = Color(0xFF333333);
  static const Color onBackgroundDark = Color(0xFFE0E0E0);
  
  // Surface Colors
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF1E1E1E);
  
  static const Color onSurfaceLight = Color(0xFF333333);
  static const Color onSurfaceDark = Color(0xFFE0E0E0);
  
  // Card Colors
  static const Color cardLight = Colors.white;
  static const Color cardDark = Color(0xFF2C2C2C);
  
  // Text Colors
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textPrimaryDark = Color(0xFFF5F5F5);
  
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textSecondaryDark = Color(0xFFBDBDBD);
  
  // Divider Colors
  static const Color dividerLight = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF424242);
  
  // Error Colors
  static const Color errorLight = Color(0xFFD32F2F);
  static const Color errorDark = Color(0xFFCF6679);
  
  // Success Colors
  static const Color successLight = Color(0xFF388E3C);
  static const Color successDark = Color(0xFF81C784);
  
  // Warning Colors
  static const Color warningLight = Color(0xFFF57C00);
  static const Color warningDark = Color(0xFFFFB74D);
  
  // Info Colors
  static const Color infoLight = Color(0xFF1976D2);
  static const Color infoDark = Color(0xFF64B5F6);
  
  // Custom Colors for Genealogy App
  static const Color maleLight = Color(0xFF1976D2); // Blue for male
  static const Color maleDark = Color(0xFF64B5F6);
  
  static const Color femaleLight = Color(0xFFC2185B); // Pink for female
  static const Color femaleDark = Color(0xFFF06292);
  
  static const Color spouseLight = Color(0xFF7B1FA2); // Purple for spouse
  static const Color spouseDark = Color(0xFFBA68C8);
  
  static const Color childLight = Color(0xFF00796B); // Teal for children
  static const Color childDark = Color(0xFF4DB6AC);
  
  // ========== THEME DATA ==========
  
  static final ThemeData lightThemeData = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryLight,
      onPrimary: onPrimaryLight,
      surface: surfaceLight,
      onSurface: onSurfaceLight,
      error: errorLight,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    dividerColor: dividerLight,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textPrimaryLight,
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textPrimaryLight,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textPrimaryLight,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textPrimaryLight,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textSecondaryLight,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: textSecondaryLight,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
      foregroundColor: onPrimaryLight,
      elevation: 1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLight,
        foregroundColor: onPrimaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      foregroundColor: onPrimaryLight,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: primaryLight.withOpacity(0.1),
      selectedColor: primaryLight,
      labelStyle: TextStyle(color: textPrimaryLight),
      secondaryLabelStyle: TextStyle(color: onPrimaryLight),
    ),
  );

  static final ThemeData darkThemeData = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: primaryDark,
      onPrimary: onPrimaryDark,
      surface: surfaceDark,
      onSurface: onSurfaceDark,
      error: errorDark,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    dividerColor: dividerDark,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textPrimaryDark,
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textPrimaryDark,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textPrimaryDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textPrimaryDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textSecondaryDark,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: textSecondaryDark,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: onSurfaceDark,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryDark,
        foregroundColor: onPrimaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryDark,
      foregroundColor: onPrimaryDark,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: primaryDark.withOpacity(0.2),
      selectedColor: primaryDark,
      labelStyle: TextStyle(color: textPrimaryDark),
      secondaryLabelStyle: TextStyle(color: onPrimaryDark),
    ),
  );
}

// Extension for easy access to custom colors
extension CustomColors on ThemeData {
  Color get maleColor => brightness == Brightness.light 
      ? MyThemes.maleLight 
      : MyThemes.maleDark;
  
  Color get femaleColor => brightness == Brightness.light 
      ? MyThemes.femaleLight 
      : MyThemes.femaleDark;
  
  Color get spouseColor => brightness == Brightness.light 
      ? MyThemes.spouseLight 
      : MyThemes.spouseDark;
  
  Color get childColor => brightness == Brightness.light 
      ? MyThemes.childLight 
      : MyThemes.childDark;
  
  Color get successColor => brightness == Brightness.light 
      ? MyThemes.successLight 
      : MyThemes.successDark;
  
  Color get warningColor => brightness == Brightness.light 
      ? MyThemes.warningLight 
      : MyThemes.warningDark;
  
  Color get infoColor => brightness == Brightness.light 
      ? MyThemes.infoLight 
      : MyThemes.infoDark;
}

// Usage in widget:
// context.theme.maleColor
extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}