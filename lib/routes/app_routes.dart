import 'package:get/get.dart';

import '../screens/category_screen.dart';
import '../screens/create_test_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/subcategory_screen.dart';
import '../screens/subject_screen.dart';
import '../screens/test_screen.dart';
import '../screens/topic_screen.dart';
import '../screens/upload_question_screen.dart';
import '../screens/upload_screen.dart';

class AppRoutes {
  static String home = "/";
  static String category = "/category";
  static String subcategory = "/subcategory";
  static String upload = "/upload";
  static String subject = "/subject";
  static String topic = "/topic";
  static String uploadQuestion = "/uploadQuestion";
  static String createTest = "/createTest";
  static String tests = "/tests";
  static String login = "/login";
  static String splash = "/splash";

  static String getHomeRoute() => home;
  static String getCategoryRoute() => category;
  static String getSubCategoryRoute() => subcategory;
  static String getUploadRoute() => upload;
  static String getSubjectRoute() => subject;
  static String getTopicRoute() => topic;
  static String getUploadQuestionRoute() => uploadQuestion;
  static String getCreateTestRoute() => createTest;

  static String getTestRoute() => tests;

  static String getLoginRoute() => login;

  static String getSplashRoute() => splash;

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: category, page: () => CategoryScreen()),
    GetPage(name: subcategory, page: () => SubCategoryScreen()),
    GetPage(name: upload, page: () => UploadScreen()),
    GetPage(name: subject, page: () => SubjectScreen()),
    GetPage(name: topic, page: () => TopicScreen()),
    GetPage(name: uploadQuestion, page: () => UploadQuestionScreen()),
    GetPage(name: createTest, page: () => CreateTestScreen()),
    GetPage(name: tests, page: () => TestScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: splash, page: () => SplashScreen()),
  ];
}
