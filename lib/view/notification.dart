import 'package:birthday_reminder/helper/common_import.dart';

class NotificationPage extends GetView<NotificationPageController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 40.h),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: blue,
                      size: 20.sp,
                    ),
                    Text(
                      'Back',
                      style: customTextStyle(
                        16.sp,
                        FontWeight.normal,
                        color: blue,
                      ),
                    ),
                  ],
                ).onTap(() {
                  Get.back();
                }),
                SizedBox(width: 80.h),
                Text(
                  'Notification',
                  style: customTextStyle(
                    18.sp,
                    FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notification',
                  style: customTextStyle(
                    17.sp,
                    FontWeight.w500,
                  ),
                ),
                Switch(
                  activeColor: const Color(0xff34C759),
                  thumbColor: WidgetStateProperty.all(Colors.white),
                  inactiveTrackColor: const Color(0xff787880).withOpacity(0.16),
                  value: controller.isNotificationPermission.value,
                  onChanged: (value) {
                    if (!controller.isNotificationPermission.value) {
                      controller.requestNotificationPermission();
                    }
                    Settings.isNotification = value;
                  },
                ),
              ],
            ).pOnly(left: 10, right: 10),
            Divider(
              thickness: 1.5,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Birthday',
                  style: customTextStyle(
                    16.sp,
                    FontWeight.w500,
                  ),
                ),
                Switch(
                  activeColor: const Color(0xff34C759),
                  thumbColor: WidgetStateProperty.all(Colors.white),
                  inactiveTrackColor: const Color(0xff787880).withOpacity(0.16),
                  value: controller.isBirthDayNotification.value,
                  onChanged: (value) {
                    controller.isBirthDayNotification.value = value;
                    Settings.isBirthdayNotification = value;
                  },
                ),
              ],
            ).pOnly(left: 20, right: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Anniversary',
                  style: customTextStyle(
                    16.sp,
                    FontWeight.w500,
                  ),
                ),
                Switch(
                  activeColor: const Color(0xff34C759),
                  thumbColor: WidgetStateProperty.all(Colors.white),
                  inactiveTrackColor: const Color(0xff787880).withOpacity(0.16),
                  value: controller.isAnniversaryNotification.value,
                  onChanged: (value) {
                    controller.isAnniversaryNotification.value = value;
                    Settings.isAnniversaryNotification = value;
                  },
                ),
              ],
            ).pOnly(left: 20, right: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Other',
                  style: customTextStyle(
                    16.sp,
                    FontWeight.w500,
                  ),
                ),
                Switch(
                  activeColor: const Color(0xff34C759),
                  thumbColor: WidgetStateProperty.all(Colors.white),
                  inactiveTrackColor: const Color(0xff787880).withOpacity(0.16),
                  value: controller.isOtherNotification.value,
                  onChanged: (value) {
                    controller.isOtherNotification.value = value;
                    Settings.isOtherNotification = value;
                  },
                ),
              ],
            ).pOnly(left: 20, right: 20),
          ],
        ).pSymmetric(v: 15, h: 15),
      );
    });
  }
}
