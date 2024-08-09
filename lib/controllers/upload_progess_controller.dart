import 'package:get/get.dart';

class UploadProgressController extends GetxController {
  RxDouble progress = 0.0.obs;
  RxString fileName = "".obs;
  RxString filePath = "".obs;
  RxBool isUploaded = false.obs;
  RxString quesId = "".obs;

  void updateProgress(double val) {
    val > 1 ? progress.value = 1.0 : progress.value = val;
    update();
  }

  void resetProgress() {
    progress.value = 0.0;
    update();
  }

  void setFileName(String filename) {
    fileName.value = filename;
    update();
  }

  void setFilePath(String filepath) {
    filePath.value = filepath;
    update();
  }

  void setQuesId(String quesid) {
    quesId.value = quesid;
    update();
  }

  void resetQuesId() {
    quesId.value = "";
    update();
  }

  void resetAll() {
    isUploaded.value = !isUploaded.value;
    if (isUploaded.value == true) {
      fileName.value = "";
      filePath.value = "";
      resetProgress();
      update();
      isUploaded.value = false;
    }
  }
}
