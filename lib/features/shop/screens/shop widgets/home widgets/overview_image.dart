import 'package:flutter/material.dart';

class JBOverviewImage extends StatelessWidget {
  const JBOverviewImage({
    super.key,
    this.height,
    this.width,
    required this.imageUrl,
    this.fit,
    required this.isNetworkImage,
    this.onPressed,
  });

  final double? height, width;
  final String imageUrl;
  final BoxFit? fit;
  final bool isNetworkImage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                  image: isNetworkImage
                      ? NetworkImage(imageUrl)
                      : AssetImage(imageUrl) as ImageProvider,
                  fit: fit))),
    );
  }
}
