import 'package:flutter/material.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBSettingsCard extends StatelessWidget {
  const JBSettingsCard({
    super.key,
    required this.icon,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String? title, subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 30),
      title: Text(title!, style: JBStyles.priceLight),
      subtitle: Text(subtitle!, style: JBStyles.bodyLight),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
