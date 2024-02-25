import 'package:flutter/material.dart';

// Main
const primaryColorValue = 0xFFF29C38;
const secondaryColorValue = 0xFF3CA2F2;

// Greyscale
const greyScaleColorValue = 0xFF212121;

// Alert & Status
Color kSuccessColor = const Color(0xFF00C247);
Color kInFoColor = const Color(0xFF004CE8);
Color kWarningColor = const Color(0xFFFFE16A);
Color kErrorColor = const Color(0xFFFF3333);
Color kDisabledColor = const Color(0xFFD8D8D8);
Color kDisableButtonColor = const Color(0xFF879AC1);

// Dark Colors
Color kDarkColor1 = const Color(0xFF1D3767);
Color kDarkColor2 = const Color(0xFF0F2244);
Color kDarkColor3 = const Color(0xFF1F3B6F);

// Others
Color white = const Color(0xFFFFFFFF);
Color black = const Color(0xFF2B2B2B);
Color red = const Color(0xFFF44336);
Color pink = const Color(0xFFE91E63);
Color purple = const Color(0xFF9C27B0);
Color deepPurple = const Color(0xFF673AB7);
Color indigo = const Color(0xFF1D3767);
Color blue = const Color(0xFF2196F3);
Color lightBlue = const Color(0xFF03A9F4);
Color cyan = const Color(0xFF00BCD4);
Color teal = const Color(0xFF009688);
Color green = const Color(0xFF4CAF50);
Color lightGreen = const Color(0xFF8BC34A);
Color lime = const Color(0xFFCDDC39);
Color yellow = const Color(0xFFFFEB3B);
Color amber = const Color(0xFFFFC107);
Color orange = const Color(0xFFFF9800);
Color deepOrange = const Color(0xFFFF5722);
Color brown = const Color(0xFF795548);
Color blueGrey = const Color(0xFF607D8B);

// Background
Color blueBackground = const Color(0xFFF1F8FE);
Color redBackground = const Color(0xFFFFF5F5);
Color greenBackground = const Color(0xFFE7FFEC);
Color greyBackground = const Color(0xFFFCFCFD);

const MaterialColor kPrimaryColor = MaterialColor(
  primaryColorValue,
  <int, Color>{
    20: Color(0xFFFCEBD7),
    40: Color(0xFFFAD7AF),
    60: Color(0xFFF7C488),
    80: Color(0xFFF5B060),
  },
);

const MaterialColor kSecondaryColor = MaterialColor(
  secondaryColorValue,
  <int, Color>{
    20: Color(0xFFD8ECFC),
    40: Color(0xFFB1DAFA),
    60: Color(0xFF8AC7F7),
    80: Color(0xFF63B5F5),
  },
);

const MaterialColor kGreyScaleColor = MaterialColor(
  greyScaleColorValue,
  <int, Color>{
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF5F5F5),
    200: Color(0xFFEEEEEE),
    300: Color(0xFFE0E0E0),
    400: Color(0xFFBDBDBD),
    500: Color(0xFF9E9E9E),
    600: Color(0xFF757575),
    700: Color(0xFF616161),
    800: Color(0xFF424242),
  },
);
