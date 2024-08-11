import 'package:get/get.dart';

class UploadProgressController extends GetxController {
  RxDouble progress = 0.0.obs;
  RxString fileName = "".obs;
  RxString filePath = "".obs;
  RxBool isUploading = false.obs;
  RxString quesId = "".obs;


  void resetAll() {
    if (isUploading.value == true) {
      fileName.value = "";
      filePath.value = "";
      progress.value = 0.0;
    }
  }
}
