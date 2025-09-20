import 'dart:async';

import 'package:birthday_reminder/helper/common_import.dart';

class SplashPageController extends GetxController {
  @override
  void onInit() {
    Timer(const Duration(seconds: 7), () {
      Get.offNamed(Settings.isEnter
          ? Settings.isSkip
              ? Routes.bottomPage
              : Routes.receiveBirthDayNotificationPage
          : Routes.onBoarding);
    });
    super.onInit();
  }
}
