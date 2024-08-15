import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  var isStoragePermissionGranted = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAndRequestPermissions();
  }

  Future<void> checkAndRequestPermissions() async {
    if (GetPlatform.isAndroid && await Permission.storage.isGranted) {
      isStoragePermissionGranted.value = true;
    } else if (await Permission.storage.request().isGranted) {
      isStoragePermissionGranted.value = true;
    }
  }
}
