import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:mcquizadmin/res/app_theme.dart';
import 'package:mcquizadmin/res/theme_data.dart';
import 'package:mcquizadmin/routes/app_routes.dart';
import 'package:get/get.dart';

import 'controllers/premission_contoller.dart';
import 'controllers/upload_progress_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  Get.put(PermissionController());
  Get.put(UploadProgressController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "McQuiz Admin",
      theme: lightTheme, // Use the light theme
      darkTheme: darkTheme, // Use the dark theme
      themeMode:
          ThemeMode.system, // Uncomment this line to use system theme mode
      initialRoute: AppRoutes.getHomeRoute(),
      getPages: AppRoutes.routes,
      // theme: AppTheme.themeData,
    );
  }
}
