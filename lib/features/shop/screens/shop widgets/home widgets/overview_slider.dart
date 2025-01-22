import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/home%20widgets/overview_image.dart';
import 'package:stride_style_ecom/utils/constants/image_strings.dart';

class JBOverviewSlider extends StatelessWidget {
  const JBOverviewSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 0.46,
        height: 200,
        enableInfiniteScroll: false,
        padEnds: false,
      ),
      items: const [
        JBOverviewImage(
            width: 150,
            fit: BoxFit.cover,
            imageUrl: JBImage.overview1,
            isNetworkImage: false),
        JBOverviewImage(
            width: 150,
            fit: BoxFit.cover,
            imageUrl: JBImage.overview2,
            isNetworkImage: false),
        JBOverviewImage(
            width: 150,
            fit: BoxFit.cover,
            imageUrl: JBImage.overview3,
            isNetworkImage: false),
      ],
    );
  }
}
