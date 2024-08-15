import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (isLogin()) {
      Get.offNamed(AppRoutes.getHomeRoute()); // Replace with your home screen route
    } else {
      Get.offNamed(AppRoutes.getLoginRoute());
    }
  }

  bool isLogin() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
