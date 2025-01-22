import 'package:get/get.dart';
import 'package:stride_style_ecom/data/repositories/banners/banner_repository.dart';

import '../../../utils/helpers/loaders.dart';
import '../models/banner_model.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  final isLoading = false.obs;
  final _bannerRepo = Get.put(BannerRepository());
  final banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  // Fetch Banners
  Future<void> fetchBanners() async {
    try {
      // Show loader
      isLoading.value = true;

      // Fetch banners from source
      final banners = await _bannerRepo.fetchBanners();

      // Assign banners
      this.banners.assignAll(banners);
    } catch (e) {
      JBLoaders.errorSnackBar(title: "Oops..", message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }
}
