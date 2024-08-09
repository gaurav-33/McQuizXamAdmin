import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CreateTestController extends GetxController{

  RxList categoryList = [].obs;
  RxString selectedCategory = "".obs;
  RxString selectedCategoryId = "".obs;
  RxString selectedSubCat = "".obs;
  RxString selectedSubCatId = "".obs;
  RxString selectedSubject = "".obs;
  RxString selectedSubjectId = "".obs;
  RxString selectedTopic = "".obs;
  RxString selectedTopicId = "".obs;
  RxInt selectedNoOfQues = 0.obs;



  void setSelectedCategory(String category, String categoryId){
    selectedCategory.value = category;
    selectedCategoryId.value = categoryId;
    update();
  }

  void setSelectedSubCat(String subcategory, String subcategoryId){
    selectedSubCat.value = subcategory;
    selectedSubCatId.value = subcategoryId;
    update();
  }

  void setSelectedSubject(String subject, String subjectId){
    selectedSubject.value = subject;
    selectedSubjectId.value = subjectId;
    update();
  }

  void setSelectedTopic(String topic, String topicId){
    selectedTopic.value = topic;
    selectedTopicId.value = topicId;
    update();
  }



}