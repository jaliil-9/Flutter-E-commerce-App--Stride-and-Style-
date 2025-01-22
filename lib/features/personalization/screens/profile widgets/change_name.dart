import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';
import 'package:stride_style_ecom/utils/helpers/validation.dart';

import '../../controllers/update_name_controller.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      backgroundColor: JBStyles.cream,

      // AppBar
      appBar: const JBAppBar(title: "Change Name", showBackArrow: true),

      // Change Name Formfield
      body: Padding(
        padding: const EdgeInsets.all(JBSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text('Use real name for easy verification',
                style: JBStyles.bodyLight),
            const SizedBox(height: JBSizes.spaceBtwItems),

            // Form Field
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        JBValidator.validateEmptyText("First name", value),
                    decoration: JBStyles.inputDecoration(context,
                        labelText: "First name",
                        prefixIcon: const Icon(Icons.person)),
                  ),
                  const SizedBox(height: JBSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        JBValidator.validateEmptyText("Last name", value),
                    decoration: JBStyles.inputDecoration(context,
                        labelText: "Last name",
                        prefixIcon: const Icon(Icons.person)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: JBSizes.spaceBtwSections),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                style: JBStyles.primaryButtonStyle(context),
                child: Text("Save", style: JBStyles.buttonLight),
              ),
            )
          ],
        ),
      ),
    );
  }
}
