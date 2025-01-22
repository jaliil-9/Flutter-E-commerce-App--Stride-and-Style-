import 'package:flutter/material.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/commons/tab_bar.dart';
import 'package:stride_style_ecom/features/shop/controllers/category_controller.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/home%20widgets/bestsellers_slider.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/store%20widgets/category%20tab/category_tab.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/search_bar.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/section_heading.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';
import '../../../utils/constants/sizes.dart';

class StorePageScreen extends StatelessWidget {
  const StorePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryController.instance.featuredCategories;

    return DefaultTabController(
      length: categoryController.length,
      child: Scaffold(
          backgroundColor: JBStyles.cream,

          // AppBar
          appBar: const JBAppBar(
            title: 'Store',
            showCartIcon: true,
          ),
          body: NestedScrollView(
              headerSliverBuilder: (_, innerBoxIsScrollable) {
                return [
                  SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: JBStyles.cream,
                      pinned: true,
                      floating: true,
                      expandedHeight: 440,
                      flexibleSpace: Padding(
                          padding: const EdgeInsets.all(JBSizes.defaultSpace),
                          child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                // Search Bar
                                const SizedBox(height: JBSizes.spaceBtwItems),
                                const JBSearchBar(),
                                const SizedBox(height: JBSizes.spaceBtwItems),

                                // Best of the Month
                                JBSectionHeading(
                                  headingText: "Best of the Month",
                                  showActionButton: true,
                                  buttonText: "Learn More",
                                  onButtonPressed: () {},
                                ),
                                const SizedBox(height: JBSizes.spaceBtwItems),
                                const JBBestSellersSlider(),
                                const SizedBox(height: JBSizes.spaceBtwItems),
                              ])),

                      // Category Tabs
                      bottom: JBTabBar(
                          tabs: categoryController
                              .map(
                                  (category) => Tab(child: Text(category.name)))
                              .toList()))
                ];
              },
              body: TabBarView(
                  children: categoryController
                      .map(
                        (category) => JBCategoryTab(
                          category: category,
                        ),
                      )
                      .toList()))),
    );
  }
}
