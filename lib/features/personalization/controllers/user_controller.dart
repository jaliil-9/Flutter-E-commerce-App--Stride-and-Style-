import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stride_style_ecom/data/repositories/authentication/authentication_repository.dart';
import 'package:stride_style_ecom/features/personalization/models/user_model.dart';
import 'package:stride_style_ecom/features/authentication/screens/login/login_page.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';
import 'package:stride_style_ecom/utils/helpers/loaders.dart';
import 'package:stride_style_ecom/utils/helpers/network_manager.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../screens/profile widgets/re_auth_user.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;
  final isLoading = false.obs;

  final hidePassword = false.obs;
  final verufyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Fetch user record from Firestore
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Save user record from any registratoin provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh user record
      await fetchUserRecord();

      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to first and last name
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');

          final username = UserModel.generateUserName(
              userCredentials.user!.displayName ?? '');

          // Map data
          final user = UserModel(
            id: userCredentials.user!.uid,
            email: userCredentials.user!.email ?? '',
            firstname: nameParts[0],
            lastname:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            phonenumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      JBLoaders.warningSnackBar(
          title: "Data not saved",
          message: "Something went wrong while saving your data.");
    }
  }

  // Delete Account warning
  void deleteAccountWarning() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(16),
      title: "Delete Account",
      middleText: "Are you sure you want to delete your account?",
      confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("Delete", style: TextStyle(color: Colors.white)),
          )),
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: JBStyles.deepNavy),
          )),
      confirmTextColor: Colors.white,
    );
  }

  // Delete Account
  Future<void> deleteUserAccount() async {
    try {
      // Re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.loginWithGoogle();
          await auth.deleteAccount();
        } else if (provider == 'password') {
          Get.to(() => const ReAuthUser());
        }
      }
    } catch (e) {
      JBLoaders.warningSnackBar(
          title: "Account not deleted",
          message: "Something went wrong while deleting your account.");
    }
  }

  // Re-authnenticate user before account deletion
  Future<void> reAuthenticateEmailPasswordUser() async {
    if (reAuthFormKey.currentState!.validate()) {
      try {
        // Check internet connection
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          return;
        }

        // Form Validation
        if (!reAuthFormKey.currentState!.validate()) {
          return;
        }

        // Re-authenticate then delete account
        await AuthenticationRepository.instance
            .reAuthenticateWithEmailAdnPassword(
                verufyEmail.text, verifyPassword.text);
        await AuthenticationRepository.instance.deleteAccount();

        // Move to login screen
        Get.offAll(() => const LoginScreen());
      } catch (e) {
        JBLoaders.warningSnackBar(
            title: "Re-Authentication Failed",
            message: "Please check your email and password and try again.");
      }
    }
  }

  // Upload profile image
  Future<void> uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);

      if (image != null) {
        isLoading.value = true;

        // Get current profile picture URL
        final oldImageUrl = user.value.profilePicture;

        // Upload new image and get URL (passing old URL for cleanup)
        final imageUrl = await userRepository.uploadImage(
            "Users/Images/Profile/", image,
            oldImageUrl: oldImageUrl);

        // Update user image record
        Map<String, dynamic> json = {'profilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        JBLoaders.successSnackBar(
            title: "Done!",
            message: "Your profile image has been updated successfully");
      }
    } catch (e) {
      JBLoaders.errorSnackBar(title: "Oops..", message: "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
