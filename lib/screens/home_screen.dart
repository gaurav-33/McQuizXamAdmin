import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/counter_service.dart';
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
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.05,
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
}
