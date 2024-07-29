import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFf7f9fa),
    onPrimary: Color(0xFF8e9191),
    secondary: Color(0xFFebf0ec),
  ),
  scaffoldBackgroundColor: Color(0xFFebeff0),
  appBarTheme: AppBarTheme(centerTitle: true, color: Color(0xFFebeff0)),
  // cardColor: Colors.black54
  listTileTheme: ListTileThemeData(titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
dropdownMenuTheme: DropdownMenuThemeData(),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color?>(Color(0xFFf7f9fa))))
);

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: Colors.black12,
    onPrimary: Colors.grey,
    secondary: Colors.grey,
    error: Colors.red,
    surface: Colors.black,
  ),
  scaffoldBackgroundColor: Color(0xFF465D82),
  appBarTheme: AppBarTheme(centerTitle: true, color: Color(0xFF465D82)),
  listTileTheme: ListTileThemeData(titleTextStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
  dropdownMenuTheme: DropdownMenuThemeData(),
  elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color?>(Colors.black12),))
);
