import 'package:birthday_reminder/helper/common_import.dart';

class ReceiveBirthDayNotificationPage extends GetView<ReceiveBirthDayNotificationPageController> {
  const ReceiveBirthDayNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width(context),
        height: height(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(I.bgImage),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 35.h),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: white,
                ),
              ),
            ).onTap(() {
              Settings.isSkip = true;
              Get.offNamed(Routes.bottomPage);
            }),
            SizedBox(height: 40.h),
            Image.asset(
              I.receiveNotification,
              height: 200.w,
            ),
            const Spacer(),
            Text(
              'Receive Birthday Notification',
              textAlign: TextAlign.center,
              style: customTextStyle(35.sp, FontWeight.w800, color: white),
            ),
            SizedBox(height: 10.h),
            Text(
              'Make sure you never forget a birthday by having Birthday Reminder send you notifications about upcoming birthdays.',
              textAlign: TextAlign.center,
              style: customTextStyle(
                14.sp,
                FontWeight.w400,
                color: white,
              ),
            ),
            Text(
              'Do you want Birthday Reminder to send you notification for upcoming birthdays?',
              textAlign: TextAlign.center,
              style: customTextStyle(
                14.sp,
                FontWeight.w400,
                color: white,
              ),
            ).pSymmetric(h: 20, v: 10),
            SizedBox(height: 30.h),
            Container(
              height: 60.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: white,
              ),
              child: Text(
                'Allow',
                style: customTextStyle(
                  17.sp,
                  FontWeight.w600,
                  color: blue,
                ),
              ),
            ).onTap(() {
              controller.getNotificationPermission().then((value) {
                Get.offNamed(Routes.addExistingContacts);
              });
            }).pSymmetric(h: 25, v: 20)
          ],
        ).pSymmetric(v: 15, h: 15),
      ),
    );
  }
}
