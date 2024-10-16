import 'package:get/get.dart';

class IntroVCController extends GetxController {
  //TODO: Implement IntroVCController

  final count = 0.obs;

  var brightness = true.obs;
  void toggleBrightness() {
    brightness.value = !brightness.value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
