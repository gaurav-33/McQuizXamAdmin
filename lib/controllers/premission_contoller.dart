import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  // Observable variables to track permission statuses
  var isStoragePermissionGranted = false.obs;
  var isManageStoragePermissionGranted = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAndRequestPermissions();
  }

  // Method to check and request storage permissions
  Future<void> checkAndRequestPermissions() async {
    // Check if the storage permission is already granted
    isStoragePermissionGranted.value = await Permission.storage.isGranted;

    if (!isStoragePermissionGranted.value) {
      // Request storage permission
      final storagePermission = await Permission.storage.request();
      isStoragePermissionGranted.value = storagePermission.isGranted;
    }

    // Only request Manage External Storage permission on Android 11 and above
    if (GetPlatform.isAndroid &&
        await Permission.manageExternalStorage.isGranted) {
      if (await Permission.manageExternalStorage.isRestricted ||
          await Permission.manageExternalStorage.isDenied) {
        final manageStoragePermission =
            await Permission.manageExternalStorage.request();
        isManageStoragePermissionGranted.value =
            manageStoragePermission.isGranted;
      }
    }
  }
}
