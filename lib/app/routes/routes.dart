import 'package:get/get.dart';
import 'package:tabwa_french/app/views/home/home_screen.dart';
import 'package:tabwa_french/app/views/login/login_screen.dart';
import 'package:tabwa_french/app/views/register/register_screen.dart';
import 'package:tabwa_french/app/views/words/add_word/add_word_screen.dart';

class Routes {
  static String home = '/';
  static String login = '/login';
  static String register = '/register';
  static String addWord = '/add-word';

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: register,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: addWord,
      page: () => AddWordScreen(),
    ),
  ];
}
