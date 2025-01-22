import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/controllers/banner_controller.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/home%20widgets/overview_image.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBBestSellersSlider extends StatelessWidget {
  const JBBestSellersSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(
            color: JBStyles.burnishedGold,
          ),
        );
      }
      if (controller.banners.isEmpty) {
        return Center(
          child: Text(
            "No Data Available at the moment",
            style: JBStyles.h2Light,
          ),
        );
      }
      return CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            height: 180,
            enableInfiniteScroll: false,
            padEnds: false,
          ),
          items: controller.banners
              .map(
                (banner) => JBOverviewImage(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: banner.imageUrl,
                  isNetworkImage: true,
                  onPressed: () => Get.toNamed(banner.targetScreen),
                ),
              )
              .toList());
    });
  }
}
