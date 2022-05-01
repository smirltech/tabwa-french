import 'package:get/get.dart';
import 'package:tabwa_french/app/middlewares/auth_middleware.dart';
import 'package:tabwa_french/app/views/home/home_screen.dart';
import 'package:tabwa_french/app/views/profile/profile_screen.dart';
import 'package:tabwa_french/app/views/settings/settings_screen.dart';
import 'package:tabwa_french/app/views/words/add_word/add_word_screen.dart';
import 'package:tabwa_french/app/views/words/show_word/show_word_screen.dart';

import '../views/about/about_screen.dart';
import '../views/auth/login/login_screen.dart';
import '../views/auth/register/register_screen.dart';

class Routes {
  static String home = '/';
  static String login = '/login';
  static String register = '/register';
  static String addWord = '/add-word';
  static String showWord = '/show-word';
  static String profile = '/profile';
  static String settings = '/settings';
  static String about = '/about';

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
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: showWord,
      page: () => ShowWordScreen(),
    ),
    GetPage(
      name: profile,
      page: () => ProfileScreen(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: settings,
      page: () => SettingsScreen(),
    ),
    GetPage(
      name: about,
      page: () => AboutScreen(),
    ),
  ];
}
