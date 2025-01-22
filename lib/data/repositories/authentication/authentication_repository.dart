import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stride_style_ecom/features/authentication/screens/login/login_page.dart';
import 'package:stride_style_ecom/features/authentication/screens/register/email_verification.dart';
import 'package:stride_style_ecom/features/authentication/screens/welcome/welcome.dart';
import 'package:stride_style_ecom/navigation.dart';
import 'package:stride_style_ecom/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:stride_style_ecom/utils/exceptions/firebase_exceptions.dart';
import 'package:stride_style_ecom/utils/exceptions/format_exceptions.dart';
import 'package:stride_style_ecom/utils/exceptions/platform_exceptions.dart';
import 'package:stride_style_ecom/utils/local_storage/storage.dart';

import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  // Called from main.dart on app launch
  @override
  void onReady() {
    // Remove Splash Screen
    FlutterNativeSplash.remove();

    // Redirect to the Appropriate Screen
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      // If user is logged in
      if (user.emailVerified) {
        // Initialize user specific storage
        await JBLocalStorage.init(user.uid);

        // If user email is verified, navigate to home page screen
        Get.offAll(() => const NavigationMenu());
      } else {
        // If user email is not verified, navigate to verification screen
        Get.offAll(() => EmailVerificationScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      // Local Storag
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() =>
              const LoginScreen()) // If not first time, navigate to login screen
          : Get.offAll(() =>
              const WelcomeScreen()); // If first time, navigate to welcome screen
    }
  }

  // Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw JBFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JBFirebaseException(e.code).message;
    } on JBFormatException catch (_) {
      throw const JBFormatException();
    } on JBPlatformException catch (e) {
      throw JBPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }

  // Email Verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw JBFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JBFirebaseException(e.code).message;
    } on JBFormatException catch (_) {
      throw const JBFormatException();
    } on JBPlatformException catch (e) {
      throw JBPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }

  // Login
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw JBFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JBFirebaseException(e.code).message;
    } on JBFormatException catch (_) {
      throw const JBFormatException();
    } on JBPlatformException catch (e) {
      throw JBPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }

  // Google Sign In
  Future<UserCredential> loginWithGoogle() async {
    try {
      // Trigger authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in with credential
      return await _auth.signInWithCredential(googleCredential);
    } on FirebaseAuthException catch (e) {
      throw JBFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JBFirebaseException(e.code).message;
    } on JBFormatException catch (_) {
      throw const JBFormatException();
    } on JBPlatformException catch (e) {
      throw JBPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }

  // Reset Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw JBFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JBFirebaseException(e.code).message;
    } on JBFormatException catch (_) {
      throw const JBFormatException();
    } on JBPlatformException catch (e) {
      throw JBPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw JBFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JBFirebaseException(e.code).message;
    } on JBFormatException catch (_) {
      throw const JBFormatException();
    } on JBPlatformException catch (e) {
      throw JBPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }

  // Re-authenticate with email and password
  Future<void> reAuthenticateWithEmailAdnPassword(
      String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(credential);
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw JBFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JBFirebaseException(e.code).message;
    } on JBFormatException catch (_) {
      throw const JBFormatException();
    } on JBPlatformException catch (e) {
      throw JBPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }

  // Delete Account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw JBFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JBFirebaseException(e.code).message;
    } on JBFormatException catch (_) {
      throw const JBFormatException();
    } on JBPlatformException catch (e) {
      throw JBPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }
}
