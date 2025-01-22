import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JBStyles {
  // Colors
  static const Color cognacBrown = Color(0xFF703F15);
  static const Color deepNavy = Color(0xFF1B264F);
  static const Color cream = Color(0xFFF5F2EA);
  static const Color burnishedGold = Color(0xFFC3A343);
  static const Color coolGray = Color(0xFF8C8C8C);
  static const Color whiteCream = Color.fromARGB(255, 250, 249, 247);

  // Status Colors
  static const Color successLight = Color(0xFF2E7D32);
  static const Color successDark = Color(0xFF81C784);
  static const Color errorLight = Color(0xFFC62828);
  static const Color errorDark = Color(0xFFFF8A80);
  static const Color infoLight = deepNavy;
  static const Color infoDark = Color(0xFF90CAF9);

  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color darkCardBackground = Color(0xFF2D2D2D);

  // Typography Styles - Light Mode
  static TextStyle h1Light = GoogleFonts.playfairDisplay(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: deepNavy,
  );

  static TextStyle h2Light = GoogleFonts.playfairDisplay(
    fontSize: 22,
    fontWeight: FontWeight.normal,
    color: deepNavy,
  );

  static TextStyle productTitleLight = GoogleFonts.lato(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: deepNavy,
  );

  static TextStyle priceLight = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: deepNavy,
  );

  static TextStyle bodyLight = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: deepNavy,
  );

  static TextStyle secondaryLight = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: coolGray,
  );

  static TextStyle buttonLight = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: cream,
  );

  // Typography Styles - Dark Mode
  static TextStyle h1Dark = GoogleFonts.playfairDisplay(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: cream,
  );

  static TextStyle h2Dark = GoogleFonts.playfairDisplay(
    fontSize: 22,
    fontWeight: FontWeight.normal,
    color: cream,
  );

  static TextStyle productTitleDark = GoogleFonts.lato(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: cream,
  );

  static TextStyle priceDark = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: cream,
  );

  static TextStyle bodyDark = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: cream,
  );

  static TextStyle secondaryDark = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: coolGray.withOpacity(0.8),
  );

  static TextStyle buttonDark = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: cream,
  );

  // Helper method to get text style based on current theme
  static TextStyle getStyle(
      BuildContext context, TextStyle lightStyle, TextStyle darkStyle) {
    return Theme.of(context).brightness == Brightness.light
        ? lightStyle
        : darkStyle;
  }

  // Button Styles
  static ButtonStyle primaryButtonStyle(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return ElevatedButton.styleFrom(
      backgroundColor: isDark ? cognacBrown : deepNavy,
      foregroundColor: cream,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static ButtonStyle secondaryButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: burnishedGold,
      foregroundColor: cream,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  // Card Decoration
  static BoxDecoration cardDecoration(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? darkCardBackground : Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: coolGray.withOpacity(isDark ? 0.2 : 0.1),
      ),
      boxShadow: [
        BoxShadow(
          color: isDark
              ? Colors.black.withOpacity(0.1)
              : coolGray.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  // Input Decoration
  static InputDecoration inputDecoration(BuildContext context,
      {String? labelText,
      String? hintText,
      Widget? prefixIcon,
      Widget? suffixIcon}) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InputDecoration(
      labelText: labelText,
      labelStyle: getStyle(context, secondaryLight, secondaryDark),
      hintText: hintText,
      hintStyle: getStyle(context, secondaryLight, secondaryDark),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: coolGray.withOpacity(0.2),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: burnishedGold,
        ),
      ),
      filled: true,
      fillColor: isDark ? darkCardBackground : Colors.white,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
}
