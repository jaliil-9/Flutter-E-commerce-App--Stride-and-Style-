import 'package:flutter/material.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBPromoCode extends StatelessWidget {
  const JBPromoCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 16),
      decoration: BoxDecoration(
          color: JBStyles.whiteCream,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: JBStyles.burnishedGold.withOpacity(0.4))),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: "Enter promo code", border: InputBorder.none),
            ),
          ),

          // Promo Code Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: JBStyles.coolGray.withOpacity(0.1),
            ),
            child: Text("Apply", style: JBStyles.buttonLight),
          )
        ],
      ),
    );
  }
}
