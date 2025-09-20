import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';

class GreetingPage extends GetView<GreetingsPageController> {
  const GreetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 40.h),
            Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20.sp,
                  color: Theme.of(context).colorScheme.secondary,
                ).onTap(() {
                  Get.back();
                }),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'Greetings',
                      style: customTextStyle(
                        18.sp,
                        FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: controller.id.value != 3 ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 45.h,
                  width: 95.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: controller.greetingCardIndex.value == 0 ? blue : Colors.transparent,
                    border: Border.all(
                      color: controller.greetingCardIndex.value == 0 ? Colors.transparent : blue,
                    ),
                  ),
                  child: Text(
                    'Birthday',
                    style: customTextStyle(
                      14.sp,
                      FontWeight.w500,
                      color: controller.greetingCardIndex.value == 0 ? Colors.white : Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ).onTap(() {
                  controller.greetingCardIndex.value = 0;
                }),
                SizedBox(width: 15.w),
                Visibility(
                  visible: controller.id.value != 3,
                  child: Container(
                    alignment: Alignment.center,
                    height: 45.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: controller.greetingCardIndex.value == 1 ? blue : Colors.transparent,
                      border: Border.all(
                        color: controller.greetingCardIndex.value == 1 ? Colors.transparent : blue,
                      ),
                    ),
                    child: Text(
                      'Anniversary',
                      style: customTextStyle(
                        14.sp,
                        FontWeight.w500,
                        color: controller.greetingCardIndex.value == 1 ? Colors.white : Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ).onTap(() {
                    controller.greetingCardIndex.value = 1;
                  }),
                ),
                SizedBox(width: 15.w),
                Visibility(
                  visible: controller.id.value != 3,
                  child: Container(
                    alignment: Alignment.center,
                    height: 45.h,
                    width: 77.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: controller.greetingCardIndex.value == 2 ? blue : Colors.transparent,
                      border: Border.all(
                        color: controller.greetingCardIndex.value == 2 ? Colors.transparent : blue,
                      ),
                    ),
                    child: Text(
                      'Other',
                      style: customTextStyle(
                        14.sp,
                        FontWeight.w500,
                        color: controller.greetingCardIndex.value == 2 ? Colors.white : Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ).onTap(() {
                    controller.greetingCardIndex.value = 2;
                  }),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            showBannerAds(),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.builder(
                itemCount: controller.greetingCardIndex.value == 1 ? controller.anniversaryGreeting.length : controller.birthDayGreeting.length,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 5.h,
                            width: 5.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: Text(
                              controller.greetingCardIndex.value == 1 ? controller.anniversaryGreeting[index] : controller.birthDayGreeting[index],
                              style: customTextStyle(
                                14.sp,
                                FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            // color: black,
                            size: 20.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Divider(
                        thickness: 1,
                        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
                      ),
                    ],
                  ).onTap(() {
                    if (controller.id.value == 0) {
                      // Card greetings
                      controller.setData(index, 0);
                    } else if (controller.id.value == 2) {
                      // Add event greetings
                      controller.setData(index, 1);
                    } else if (controller.id.value == 3) {
                      // Add event greetings
                      controller.setData(index, 3);
                    } else if (controller.id.value == 4) {
                      // Add event greetings
                      controller.setData(index, 4);
                    } else {
                      // Birthday greetings
                      controller.addGreetings(index);
                    }
                  }).pOnly(top: 15);
                },
              ),
            )
          ],
        ).pOnly(top: 20, left: 20, right: 20),
      );
    });
  }
}
