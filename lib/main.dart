import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/premission_contoller.dart';
import '../controllers/upload_progress_controller.dart';
import '../res/theme_data.dart';
import '../routes/app_routes.dart';

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
      initialRoute: AppRoutes.getSplashRoute(),
      getPages: AppRoutes.routes,
    );
  }
}
