import 'dart:io';

import 'package:birthday_reminder/helper/common_import.dart';

class NotificationPageController extends GetxController {
  RxBool isNotificationPermission = false.obs;
  RxBool isBirthDayNotification = false.obs;
  RxBool isAnniversaryNotification = false.obs;
  RxBool isOtherNotification = false.obs;

  @override
  void onInit() {
    requestNotificationPermission();
    setNotification();
    super.onInit();
  }

  Future<void> requestNotificationPermission() async {
    if (Platform.isIOS) {
      debugPrint('Device is Ios');
      var permission = await Permission.notification.request();
      debugPrint('$permission Ios');
      if (permission.isGranted) {
        isNotificationPermission.value = true;
        Settings.isNotification = isNotificationPermission.value;
        debugPrint('hello ---------------------');
        debugPrint('Permission is granted');
      }
    } else {
      PermissionStatus status = await Permission.notification.status;
      debugPrint('Statue---> $status');
      if (status.isDenied || status.isPermanentlyDenied) {
        PermissionStatus newStatus = await Permission.notification.request();
        if (newStatus.isGranted) {
          debugPrint('Notification permission granted.');
          isNotificationPermission.value = true;
          Settings.isNotification = isNotificationPermission.value;
        } else {
          if (status.isGranted) {
            debugPrint('Notification permission granted.');
          } else {
            debugPrint('Notification permission denied.');
          }
        }
      } else {
        isNotificationPermission.value = true;
        Settings.isNotification = isNotificationPermission.value;
        debugPrint('Notification permission already granted.');
      }
    }
  }

  void setNotification() {
    isNotificationPermission.value = Settings.isNotification;
    isAnniversaryNotification.value = Settings.isAnniversaryNotification;
    isBirthDayNotification.value = Settings.isBirthdayNotification;
    isOtherNotification.value = Settings.isOtherNotification;
  }
}
