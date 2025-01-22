import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/personalization/screens/profile.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import '../../controllers/user_controller.dart';

class JBUserProfileCard extends StatelessWidget {
  const JBUserProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return ListTile(
      // Profile Picture
      leading:

          /// Profile Picture
          Obx(() {
        final networkImage = controller.user.value.profilePicture;
        final bool isNetworkImage = networkImage.isNotEmpty;
        final image = networkImage.isNotEmpty
            ? networkImage
            : "assets/images/unknown_user.png";
        return controller.isLoading.value
            ? const CircularProgressIndicator(
                color: JBStyles.burnishedGold,
              )
            : Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: isNetworkImage
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: image,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : Image(image: AssetImage(image), fit: BoxFit.cover)),
              );
      }),
      title: Text(controller.user.value.fullName, style: JBStyles.h2Light),
      subtitle: Text(controller.user.value.email, style: JBStyles.priceLight),

      trailing: IconButton(
        onPressed: () => Get.to(() => const UserProfile()),
        icon: const Icon(Icons.edit_note_outlined, size: JBSizes.iconLg),
      ),
    );
  }
}
