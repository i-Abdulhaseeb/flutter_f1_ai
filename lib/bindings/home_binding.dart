import 'package:get/get.dart';
import '../navigation/home_controller.dart';
import '../controllers/analytics_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AnalyticsController>(() => AnalyticsController());
  }
}
