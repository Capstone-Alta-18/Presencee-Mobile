import 'package:flutter/material.dart';

class AppTheme {
  // Primaries colors
  static const Color primaryTheme = Color(0xFFFE7968);
  static const Color primaryTheme_2 = Color(0xFFFE9486);
  static const Color primaryTheme_3 = Color(0xFFFEAFA4);
  static const Color primaryTheme_4 = Color(0xFFFFC9C3);
  static const Color primaryTheme_5 = Color(0xFFFFE4E1);

  // Secondaries colors
  static const Color success = Color(0xFF34B139);
  static const Color error = Color(0xFFAE3838);
  static const Color disabled = Color(0xFFDBDBDB);
  static const Color warning = Color(0xFFF4E34B);

  // White and Grays
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFFF5F5F5);
  static const Color gray_2 = Color(0xFFD1D1D1);
  static const Color gray_3 = Color(0xFFA4A4A4);
  static const Color gray_4 = Color(0xFFA4A4A4);
  static const Color gray_5 = Color(0xFF767676);
  static const Color greyText = Color.fromRGBO(0, 0, 0, 0.247);

  // Black and grays
  static const Color black = Color(0xFF242424);
  static const Color black_2 = Color(0xFF424242);
  static const Color black_3 = Color(0xFF616161);
  static const Color black_4 = Color(0xFF888888);
  static const Color black_5 = Color(0xFF999999);

  // Gradients
  static const Color gradient_1 = Color(0xFFCD4F3F);
  static const Color gradient_2 = Color(0xFFFE9486);
  static const Color gradient_3 = Color(0xFFFE7968);

  // cards
  static const Color greenCard = Color(0xFFE1FFE6);
}

class AppTextStyle {
  // Normal font poppins
  // defaul poppins customize font weight, size, and color
  static TextStyle poppinsTextStyle({Color? color, double? fontSize, FontWeight? fontsWeight}) {
    return TextStyle(
      fontFamily: "Poppins",
      color: color,
      fontSize: fontSize,
      fontWeight: fontsWeight,
    );
  }
}
