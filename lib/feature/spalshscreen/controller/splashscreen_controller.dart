import 'package:get/get.dart';
import 'package:notes/feature/home/view/home_view.dart';
import 'package:notes/feature/login/view/login_view.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () => checkSession());
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  Future checkSession() async {
    Get.offAll(() => const LoginView());
  }
}
