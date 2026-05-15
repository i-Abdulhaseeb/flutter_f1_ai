import 'package:get/get.dart';
import '../../views/splash_view.dart';
import '../../views/home_view.dart';
import '../../bindings/splash_binding.dart';
import '../../bindings/home_binding.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';

  static final List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 800),
    ),
  ];
}
