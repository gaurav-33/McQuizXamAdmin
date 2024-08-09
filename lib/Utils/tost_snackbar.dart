import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
//   success
  static void success(String msg) {
    Get.snackbar("Success", msg,
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

// error
  static void error(String msg) {
    Get.snackbar("Error", msg,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }
}
