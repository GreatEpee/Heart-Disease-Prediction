import 'package:get/get.dart';
import 'package:heart_disease_predicion_app/screens/home_screen.dart';
import 'package:heart_disease_predicion_app/screens/input_screen.dart';
import 'package:heart_disease_predicion_app/screens/welcome_screen.dart';

class AppRoutes {
  static const welcomeScreen = '/welcomeScreen';
  static const homeScreen = '/homeScreen';
  static const inputScreen = '/inputScreen';

  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<dynamic>(name: welcomeScreen, page: () => const WelcomeScreen()),
    GetPage<dynamic>(name: homeScreen, page: () => const HomeScreen()),
    GetPage<dynamic>(name: inputScreen, page: () => const InputScreen()),
  ];
}
