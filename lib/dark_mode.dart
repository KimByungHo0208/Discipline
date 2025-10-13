import 'package:flutter/material.dart';
import 'package:discipline/designs.dart';

class DarkMode extends ChangeNotifier{
  bool _isDarkMode = false;
  bool get isDark => _isDarkMode;

  void changeDarkMode(){
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

}

class DarkModeTheme{
  // light mode
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme:AppBarTheme(
        backgroundColor: mainColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: mainColor,
          foregroundColor: Colors.white54,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      )
  );
  // dark mode
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: mainColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white54,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white54,
          foregroundColor: mainColor,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: mainColor,
      )
  );
}