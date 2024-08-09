import 'package:get/get.dart';
import 'package:mcquizadmin/screens/create_test_screen.dart';
import 'package:mcquizadmin/screens/subject_screen.dart';
import 'package:mcquizadmin/screens/topic_screen.dart';
import 'package:mcquizadmin/screens/upload_question_screen.dart';
import 'package:mcquizadmin/screens/upload_screen.dart';
import '../screens/category_screen.dart';
import '../screens/home_screen.dart';
import '../screens/subcategory_screen.dart';

class AppRoutes {
  static String home = "/";
  static String category = "/category";
  static String subcategory = "/subcategory";
  static String upload = "/upload";
  static String subject = "/subject";
  static String topic = "/topic";
  static String uploadQuestion = "/uploadQuestion";
  static String createTest = "/createTest";

  static String getHomeRoute() => home;
  static String getCategoryRoute() => category;
  static String getSubCategoryRoute() => subcategory;
  static String getUploadRoute() => upload;
  static String getSubjectRoute() => subject;
  static String getTopicRoute() => topic;
  static String getUploadQuestionRoute() => uploadQuestion;
  static String getCreateTestRoute() => createTest;

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: category, page: () => CategoryScreen()),
    GetPage(name: subcategory, page: () => SubCategoryScreen()),
    GetPage(name: upload, page: () => UploadScreen()),
    GetPage(name: subject, page: () => SubjectScreen()),
    GetPage(name: topic, page: () => TopicScreen()),
    GetPage(name: uploadQuestion, page: () => UploadQuestionScreen()),
    GetPage(name: createTest, page: () => CreateTestScreen()),
  ];
}
