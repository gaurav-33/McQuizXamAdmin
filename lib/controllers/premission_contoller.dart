import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  // Observable variables to track permission statuses
  var isStoragePermissionGranted = false.obs;
  var isManageStoragePermissionGranted = false.obs;

  @override
  void onInit() {
    super.onInit();
    requestStoragePermissions();
  }

  // Method to request storage permissions
  Future<void> requestStoragePermissions() async {
    final storagePermission = await Permission.storage.request();
    isStoragePermissionGranted.value = storagePermission.isGranted;

    if (GetPlatform.isAndroid && await Permission.manageExternalStorage.isGranted) {
      final manageStoragePermission = await Permission.manageExternalStorage.request();
      isManageStoragePermissionGranted.value = manageStoragePermission.isGranted;
    }
  }
}
