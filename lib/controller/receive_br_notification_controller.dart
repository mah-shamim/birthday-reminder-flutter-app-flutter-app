import 'dart:io';

import 'package:birthday_reminder/helper/common_import.dart';

class ReceiveBirthDayNotificationPageController extends GetxController {
  Future<void> getNotificationPermission() async {
    if (Platform.isIOS) {
      var permission = await Permission.accessNotificationPolicy.request();
      if (permission.isGranted) {
        debugPrint('hello ---------------------');
        debugPrint('Permission is granted');
      }
    } else {
      var permission = await Permission.notification.request();
      if (permission.isGranted) {
        debugPrint('hello ---------------------');
        debugPrint('Permission is granted');
      }
    }
  }
}
