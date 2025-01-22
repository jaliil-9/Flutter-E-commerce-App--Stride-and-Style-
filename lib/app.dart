import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:stride_style_ecom/commons/bindings.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import 'utils/routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      home: const Scaffold(
          backgroundColor: JBStyles.deepNavy,
          body: Center(
            child: CircularProgressIndicator(color: JBStyles.burnishedGold),
          )),
    );
  }
}
