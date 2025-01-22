import 'package:flutter/material.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';
import 'package:stride_style_ecom/utils/helpers/get_color.dart';

class JBChoiceChip extends StatelessWidget {
  const JBChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = GetColor.getColor(text) != null;
    return ChoiceChip(
      label: isColor ? const SizedBox() : Text(text),
      selected: selected,
      onSelected: onSelected,
      selectedColor: JBStyles.deepNavy,
      checkmarkColor: JBStyles.whiteCream,
      labelStyle: TextStyle(color: selected ? Colors.white : null),
      avatar: isColor
          ? Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: GetColor.getColor(text)!,
              ),
            )
          : null,
      shape: isColor ? const CircleBorder() : null,
      labelPadding: isColor ? const EdgeInsets.all(0) : null,
      padding: isColor ? const EdgeInsets.all(0) : null,
      backgroundColor: isColor ? GetColor.getColor(text) : null,
    );
  }
}
