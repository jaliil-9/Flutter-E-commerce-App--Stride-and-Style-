import 'package:flutter/material.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBChipTheme {
  JBChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: JBStyles.cognacBrown,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: Colors.white,
  );
}
