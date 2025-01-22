import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/personalization/controllers/user_controller.dart';
import 'package:stride_style_ecom/utils/helpers/loaders.dart';
import 'package:stride_style_ecom/utils/helpers/network_manager.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../screens/profile.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get to => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  // Initialize user data
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  // Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstname;
    lastName.text = userController.user.value.lastname;
  }

  // Update user name
  Future<void> updateUserName() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        return;
      }

      // Update user first & last name in Firestore
      Map<String, dynamic> name = {
        "firstname": firstName.text.trim(),
        "lastname": lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      // Update user first & last name values
      userController.user.value.firstname = firstName.text.trim();
      userController.user.value.lastname = lastName.text.trim();

      // Show Success Message
      JBLoaders.successSnackBar(
          title: "Updated!", message: "Name updated successfully");

      // Move to previous screen
      Get.off(() => const UserProfile());
    } catch (e) {
      // Show Error Message
      JBLoaders.errorSnackBar(
          title: "Error!",
          message: "An error occurred. Please try again later");
    }
  }
}
