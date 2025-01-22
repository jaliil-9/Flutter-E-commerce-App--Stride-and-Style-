import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class CurvedEdgesImage extends StatelessWidget {
  const CurvedEdgesImage(
      {super.key,
      this.onTap,
      this.width,
      this.height,
      required this.imageUrl,
      required this.border,
      this.isNetworkImage = false});

  final double? width, height;
  final String imageUrl;
  final BoxBorder border;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: JBStyles.whiteCream,
            borderRadius: BorderRadius.circular(8.0),
            border: border),
        child: Center(
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: isNetworkImage
                  ? CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover)
                  : Image(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    )),
        ),
      ),
    );
  }
}
