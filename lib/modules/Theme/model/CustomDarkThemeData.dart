import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.teal, // Primary seed color
    primary: Colors.teal, // Primary color
    secondary: Colors.deepOrange, // Secondary color
    // Additional colors for your app
    background: Colors.black,
    surface: Colors.black,
    onBackground: Colors.white,
    onSurface: Colors.white,
  ),

  // Text styles
  textTheme: TextTheme(
    displayLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 32), // Title
    displayMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24), // Subtitle
    displaySmall: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20), // Section title

    bodyLarge: TextStyle(color: Colors.white70, fontSize: 16), // Regular text
    bodyMedium:
        TextStyle(color: Colors.white54, fontSize: 14), // Secondary text
    bodySmall:
        TextStyle(color: Colors.white54, fontSize: 12), // Caption or small text

    labelLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold), // Button text
  ),

  // Button styles
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal, // Background color
      foregroundColor: Colors.white, // Text color
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)), // Rounded corners
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Padding
    ),
  ),

  // TextButton styles
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.deepOrange, // Text color
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Padding
      textStyle: TextStyle(fontSize: 16), // Button text style
    ),
  ),

  // AppBar styles
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white, // Text and icon color
    elevation: 2,
  ),

  // Bottom navigation bar styles
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black54,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
  ),

  // TabBar styles
  tabBarTheme: TabBarTheme(
    labelColor: Colors.white,
    unselectedLabelColor: Colors.grey,
    indicatorColor: Colors.teal,
  ),
);
