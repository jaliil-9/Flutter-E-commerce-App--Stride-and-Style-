import 'package:flutter/material.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBTabBar extends StatelessWidget implements PreferredSizeWidget {
  const JBTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: JBStyles.cream,
        child: TabBar(
          tabs: tabs,
          isScrollable: true,
          indicatorColor: JBStyles.deepNavy,
          labelColor: JBStyles.deepNavy,
          unselectedLabelColor: JBStyles.coolGray,
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
