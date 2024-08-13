import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../Utils/tost_snackbar.dart';
import '../routes/app_routes.dart';

class LoginController extends GetxController {
  // Text controllers to capture email and password
  RxString emailController = ''.obs;
  RxString passwordController = ''.obs;

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Loading state
  RxBool isLoading = false.obs;

  // Visibility State
  RxBool visible = false.obs;

  // Login method
  Future<void> login() async {
    isLoading.value = true;
    print("gettting Loggingg");
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.value.trim(),
        password: passwordController.value.trim(),
      );
      AppSnackBar.success("Logged in successfully!");
      // Navigate to home or any other screen after login
      Get.toNamed(AppRoutes.getHomeRoute());
    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
