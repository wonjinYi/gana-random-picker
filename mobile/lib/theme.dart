import 'package:flutter/material.dart';

const int lightPrimaryColor = 0xff280071;
const int lightSecondaryColor = 0xffcfd3ff;
const Color lightBackground = Colors.white;
const Color lightError = Color.fromARGB(255, 255, 121, 121);
const Color lightSurface = Color.fromARGB(255, 236, 236, 236);
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: Color(lightPrimaryColor),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 222, 224, 251),
    onSecondary: Color(lightPrimaryColor),
    tertiary: Color.fromARGB(255, 208, 208, 208),
    error: lightError,
    onError: Colors.black,
    background: Colors.white,
    surface: lightSurface,
  ),
  textTheme: const TextTheme(
    // labelMedium: TextStyle(
    //   fontSize: 50,
    //   color: Colors.black,
    // ),
    bodyMedium: TextStyle(
      fontSize: 18,
    ),
    displayMedium: TextStyle(
      fontSize: 18,
    ),
    displayLarge: TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.w200,
    ),
  ),
);

const Color darkPrimaryColor = Color.fromARGB(255, 72, 72, 212);
const Color darkSecondaryColor = Color.fromARGB(220, 220, 212, 255);
const Color dartTertiaryColor = Color.fromARGB(255, 205, 205, 205);
const Color darkBackground = Color.fromARGB(255, 31, 31, 31);
const Color dartSurface = Color.fromARGB(255, 57, 57, 57);
const Color darkError = Color.fromARGB(255, 100, 27, 27);
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    primary: darkPrimaryColor,
    onPrimary: Colors.white,
    secondary: darkSecondaryColor,
    onSecondary: darkPrimaryColor,
    tertiary: dartTertiaryColor,
    error: darkError,
    onError: Colors.white,
    background: darkBackground,
    surface: dartSurface,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
    displayLarge: TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.w200,
      color: Colors.white,
    ),
  ),
);
