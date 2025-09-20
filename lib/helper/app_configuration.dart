import 'dart:io';
import 'package:birthday_reminder/helper/common_import.dart';

const Color white = Color(0xffF0F5F4);
const Color lightGreen = Color(0xffBBFB4C);
const Color black = Color(0xff181818);
const Color blue = Color(0xff5285E8);
const Color birthaEventColor = Color(0xff5285E8);
const Color anniversaryEventColor = Color(0xffDBC6FD);
const Color otherEventColor = Color(0xffF9C4BC);

double height(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}

double width(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

void showAlertDialog(BuildContext context, String title, String content, {int i = 0}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
        ),
        actions: [
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: customTextStyle(
                    17.sp,
                    FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  content,
                  textAlign: TextAlign.left,
                  style: customTextStyle(
                    14.sp,
                    FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 35.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Ok',
                  style: customTextStyle(
                    15.sp,
                    FontWeight.w500,
                  ),
                ).onTap(() {
                  if (i == 1) {
                    Get.back();
                    Get.toNamed(Routes.notificationPage);
                  } else {
                    Get.back();
                  }
                }),
              )
            ],
          )
        ],
      );
    },
  );
}

TextStyle customTextStyle(double size, FontWeight weight, {Color? color}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: weight,
  );
}

void deleteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        actionsPadding: const EdgeInsets.only(top: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
        ),
        actions: [
          Column(
            children: [
              Column(
                children: [
                  Text(
                    'Delete Account',
                    style: customTextStyle(17.sp, FontWeight.w700),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Are you sure you want to delete your account? This action is irreversible, and all your data will be permanently deleted.',
                    textAlign: TextAlign.center,
                    style: customTextStyle(13.sp, FontWeight.normal),
                  ),
                ],
              ).pOnly(left: 20, right: 20),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.h,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer),
                          right: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: customTextStyle(
                          17.sp,
                          FontWeight.normal,
                          color: blue,
                        ),
                      ),
                    ).onTap(() {
                      Get.back();
                    }),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.h,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer),
                        ),
                      ),
                      child: Text(
                        'Delete',
                        style: customTextStyle(
                          17.sp,
                          FontWeight.normal,
                          color: blue,
                        ),
                      ),
                    ).onTap(() {
                      cancelAllNotifications();
                      Settings.clear();
                      DatabaseHelper().deleteAllReminderData();
                      DatabaseHelper().deleteBirthdayData();
                      DatabaseHelper().deleteCards();
                      Get.offAllNamed(Routes.onBoarding);
                    }),
                  )
                ],
              )
            ],
          )
        ],
      );
    },
  );
}

TextAlign textAlignment(int i) {
  switch (i) {
    case 0:
      return TextAlign.left;
    case 1:
      return TextAlign.center;
    default:
      return TextAlign.right;
  }
}

bool isTab(BuildContext context) {
  return MediaQuery.sizeOf(context).width >= 600 && MediaQuery.sizeOf(context).width < 2048;
}

bool isiOSDevice() {
  return Platform.isIOS;
}

void showToast(msg) {
  Fluttertoast.showToast(msg: msg, fontSize: 15.sp, gravity: ToastGravity.BOTTOM, textColor: Colors.white, toastLength: Toast.LENGTH_SHORT, backgroundColor: Colors.grey.shade700);
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5), // Semi-transparent background
    useSafeArea: true,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.blue, // Change to your preferred color
            ),
          ),
        ),
      );
    },
  );
}

void deleteBirthDataDialog(BuildContext context, {VoidCallback? onTap}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        actionsPadding: const EdgeInsets.only(top: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
        ),
        actions: [
          Column(
            children: [
              Column(
                children: [
                  Text(
                    'Delete Account',
                    style: customTextStyle(17.sp, FontWeight.w700),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'The data will be delete and can\'t be recovered',
                    textAlign: TextAlign.center,
                    style: customTextStyle(13.sp, FontWeight.normal),
                  ),
                ],
              ).pOnly(left: 20, right: 20),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.h,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer),
                          right: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: customTextStyle(
                          17.sp,
                          FontWeight.normal,
                          color: blue,
                        ),
                      ),
                    ).onTap(() {
                      Get.back();
                    }),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.h,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer),
                        ),
                      ),
                      child: Text(
                        'Delete',
                        style: customTextStyle(
                          17.sp,
                          FontWeight.normal,
                          color: blue,
                        ),
                      ),
                    ),
                  ))
                ],
              )
            ],
          )
        ],
      );
    },
  );
}

const String AndroidLink = 'https://play.google.com/store/apps/details?id=com.vocsy.birthdayReminder';
const String IOSLink = 'https://apps.apple.com/us/app/birthday-reminder-calendar/id6738855386';

String get appShare {
  if (Platform.isAndroid) {
    return AndroidLink;
  } else {
    return IOSLink;
  }
}
