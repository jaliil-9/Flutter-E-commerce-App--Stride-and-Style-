import 'package:flutter/material.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class GoogleSignInCard extends StatelessWidget {
  final VoidCallback onTap;

  const GoogleSignInCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: isDarkMode ? JBStyles.darkCardBackground : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: JBStyles.coolGray.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: JBStyles.coolGray.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google Logo
                  Image.asset(
                    'assets/logo/google_logo.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 12),
                  // Sign in text
                  Text(
                    'Continue with Google',
                    style: JBStyles.getStyle(
                      context,
                      JBStyles.bodyLight.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      JBStyles.bodyDark.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
