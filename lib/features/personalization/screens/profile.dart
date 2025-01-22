import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/features/personalization/screens/profile%20widgets/change_name.dart';
import 'package:stride_style_ecom/features/personalization/screens/profile%20widgets/user_param_card.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/section_heading.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import '../controllers/user_controller.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
        backgroundColor: JBStyles.cream,

        // AppBAr
        appBar: const JBAppBar(
          title: "Profile",
          showBackArrow: true,
        ),

        // Body
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(JBSizes.defaultSpace),
            child: Column(
              children: [
                // Profile Picture Section
                Center(
                  child: Column(
                    children: [
                      /// Profile Picture
                      Obx(() {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final bool isNetworkImage = networkImage.isNotEmpty;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : "assets/images/unknown_user.png";
                        return controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: JBStyles.burnishedGold,
                              )
                            : Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: isNetworkImage
                                        ? CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: image,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          )
                                        : Image(
                                            image: AssetImage(image),
                                            fit: BoxFit.cover)),
                              );
                      }),

                      /// Change Image button
                      TextButton(
                          onPressed: () =>
                              controller.uploadUserProfilePicture(),
                          child: Text("Modify profile image",
                              style: JBStyles.bodyLight))
                    ],
                  ),
                ),

                // Profile Details
                const SizedBox(
                  height: JBSizes.spaceBtwItems / 2,
                ),
                const Divider(),
                const SizedBox(
                  height: JBSizes.spaceBtwItems,
                ),

                // Section Heading
                const JBSectionHeading(
                  headingText: "Profile Information",
                  showActionButton: false,
                ),
                const SizedBox(height: JBSizes.spaceBtwItems),

                /// Parameters
                JBUserParamCard(
                  title: "Name",
                  value: controller.user.value.fullName,
                  icon: Icons.arrow_forward,
                  onPressed: () => Get.to(() => const ChangeNameScreen()),
                ),
                JBUserParamCard(
                  title: "Username",
                  value: controller.user.value.username,
                  icon: Icons.arrow_forward,
                  onPressed: () {},
                ),

                // Personal Profile Details
                const SizedBox(
                  height: JBSizes.spaceBtwItems / 2,
                ),
                const Divider(),
                const SizedBox(
                  height: JBSizes.spaceBtwItems,
                ),

                // Section Heading
                const JBSectionHeading(
                  headingText: "Personal Information",
                  showActionButton: false,
                ),
                const SizedBox(height: JBSizes.spaceBtwItems),

                /// Parameters
                JBUserParamCard(
                  title: "User ID",
                  value: controller.user.value.id,
                  icon: Icons.copy,
                  onPressed: () {},
                ),
                JBUserParamCard(
                  title: "Email",
                  value: controller.user.value.email,
                  icon: Icons.arrow_forward,
                  onPressed: () {},
                ),
                JBUserParamCard(
                  title: "Phone Number",
                  value: controller.user.value.phonenumber,
                  icon: Icons.arrow_forward,
                  onPressed: () {},
                ),
                JBUserParamCard(
                  title: "Date of Birth",
                  value: "01 Jan, 1999",
                  icon: Icons.arrow_forward,
                  onPressed: () {},
                ),
                JBUserParamCard(
                  title: "Gender",
                  value: "Male",
                  icon: Icons.arrow_forward,
                  onPressed: () {},
                ),

                const Divider(),
                const SizedBox(
                  height: JBSizes.spaceBtwItems,
                ),

                // Delete Account Button
                Center(
                  child: TextButton(
                      onPressed: () => controller.deleteAccountWarning(),
                      child: const Text("Delete Account",
                          style: TextStyle(color: Colors.red))),
                )
              ],
            ),
          ),
        ));
  }
}
