import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';

class JBHomeImage extends StatelessWidget {
  const JBHomeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: const Image(
          image: AssetImage(JBImage.homeImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
