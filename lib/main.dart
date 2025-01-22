import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stride_style_ecom/app.dart';
import 'package:stride_style_ecom/data/repositories/authentication/authentication_repository.dart';
import 'package:stride_style_ecom/firebase_options.dart';
import 'data/supabase_config.dart';

Future<void> main() async {
  // Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Initialize Local Storage
  await GetStorage.init();

  // Await Splash Screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Supabase
  await SupabaseConfig.instance.initialize();

  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const App());
}
