import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/toast_snack_bar.dart';
import '../routes/app_routes.dart';
import '../widgets/rect_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "MCQUIZ ADMIN",
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  _displayLogOutDialog();
                },
                icon: const Icon(Icons.exit_to_app_rounded))
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text("Home",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                RectButton(
                    name: "Category & SUbCategory",
                    icon: Icons.category_outlined,
                    ontap: () => Get.toNamed(AppRoutes.getCategoryRoute())),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                RectButton(
                    name: "Subject & Topic",
                    icon: Icons.topic_outlined,
                    ontap: () => Get.toNamed(AppRoutes.getSubjectRoute())),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                RectButton(
                    name: "Create Tests",
                    icon: Icons.newspaper,
                    ontap: () => Get.toNamed(AppRoutes.getCreateTestRoute())),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                RectButton(
                    name: "Upload",
                    icon: Icons.cloud_upload_outlined,
                    ontap: () {
                      // Get.toNamed(AppRoutes.getUploadRoute());
                    }),
              ],
            ),
          ),
        ));
  }

  void _displayLogOutDialog() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(AppRoutes.getSplashRoute());
      AppSnackBar.success("Logged Out SuccessFully");
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
  }
}
