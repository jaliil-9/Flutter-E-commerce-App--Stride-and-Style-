import 'package:flutter/material.dart';

import '../../../../../utils/constants/style.dart';

class JBSearchBar extends StatelessWidget {
  const JBSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      hintText: "Search...",
      hintStyle: JBStyles.getStyle(
          context, JBStyles.secondaryLight, JBStyles.secondaryDark),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: JBStyles.coolGray.withOpacity(0.2),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: JBStyles.cognacBrown,
        ),
      ),
      filled: true,
      fillColor: JBStyles.whiteCream,
      suffixIcon: const Icon(Icons.search),
    ));
  }
}
