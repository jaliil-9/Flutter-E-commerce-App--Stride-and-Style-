import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBShimmerLoader extends StatelessWidget {
  const JBShimmerLoader(
      {super.key,
      required this.width,
      required this.height,
      required this.radius,
      this.color});

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color ?? Colors.grey[300]!,
      highlightColor: color ?? Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? JBStyles.whiteCream,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
