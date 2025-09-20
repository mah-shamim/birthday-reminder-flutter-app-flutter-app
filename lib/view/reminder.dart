import 'package:birthday_reminder/helper/common_import.dart';

class ReminderPage extends GetView<ReminderPageController> {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
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
                    'Reminder',
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
                    'Reminder',
                    style: customTextStyle(
                      17.sp,
                      FontWeight.w500,
                    ),
                  ),
                  Switch(
                    activeColor: const Color(0xff34C759),
                    thumbColor: WidgetStateProperty.all(Colors.white),
                    inactiveTrackColor: const Color(0xff787880).withOpacity(0.16),
                    value: controller.isReminder.value,
                    onChanged: (value) {
                      controller.isReminder.value = value;
                    },
                  ),
                ],
              ).pOnly(left: 10, right: 10),
              Divider(
                thickness: 1.5,
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.addedReminderList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Column(
                  children: [
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            controller.addedReminderList[index],
                            overflow: TextOverflow.ellipsis,
                            style: customTextStyle(
                              16.sp,
                              FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          controller.formattedTime.isEmpty ? '8:00 AM' : controller.formattedTime.value,
                          style: customTextStyle(
                            16.sp,
                            FontWeight.w500,
                            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.25),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20.sp,
                          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.25),
                        ),
                      ],
                    ).pOnly(left: 10, right: 15, bottom: 5),
                    Divider(
                      thickness: 1.5,
                      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                height: 50.w,
                width: 190.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: controller.isReminder.value == true ? blue : blue.withOpacity(0.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_circle,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Add More Reminder',
                      style: customTextStyle(
                        14.sp,
                        FontWeight.normal,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ).onTap(() {
                if (controller.isReminder.value == true) {
                  bottomSheet(context);
                }
              }),
            ],
          ).pSymmetric(v: 15, h: 15),
        );
      },
    );
  }

  Future bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.primary,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.95,
            minHeight: MediaQuery.of(context).size.height * 0.95,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Obx(() {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20.sp,
                            color: blue,
                          ),
                          Text(
                            'Cancel',
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
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'Reminder',
                          style: customTextStyle(
                            18.sp,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Done',
                          style: customTextStyle(
                            16.sp,
                            FontWeight.normal,
                            color: blue,
                          ),
                        ),
                      ).onTap(() {
                        /*if (controller.addedReminderList.isNotEmpty) {
                          controller.addReminder().then((value) {
                            controller.getReminder().then((value) {
                              controller.validation(context);
                            });
                          });
                        }*/
                      }),
                    ),
                  ],
                ).pOnly(top: 20, right: 15, left: 15),
                Divider(
                  thickness: 1.5,
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Set Notification',
                            style: customTextStyle(
                              18.sp,
                              FontWeight.w500,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          StatefulBuilder(builder: (context, setState) {
                            return Container(
                              alignment: Alignment.center,
                              width: 120.w,
                              height: 45.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(10),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.85),
                                ),
                              ),
                              child: Obx(() {
                                controller.formattedTime.value;
                                return Text(
                                  controller.formattedTime.isEmpty ? '8:00 AM' : controller.formattedTime.value,
                                  style: customTextStyle(
                                    16.sp,
                                    FontWeight.w400,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                );
                              }),
                            ).onTap(() {
                              controller.selectTime(context);
                            });
                          })
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Divider(
                        thickness: 1.5,
                        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.reminderList.length,
                          itemBuilder: (context, index) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.reminderList[index].title,
                                          style: customTextStyle(16.sp, FontWeight.normal),
                                        ),
                                        Switch(
                                          activeColor: const Color(0xff34C759),
                                          thumbColor: WidgetStateProperty.all(Colors.white),
                                          inactiveTrackColor: const Color(0xff787880).withOpacity(0.16),
                                          value: controller.reminderList[index].isTrue,
                                          onChanged: (value) {
                                            setState(() {});
                                            controller.reminderList[index].isTrue = value;
                                            if (controller.reminderList[index].isTrue) {
                                              controller.addedReminderList.add(controller.reminderList[index].title);
                                            } else {
                                              controller.addedReminderList.remove(controller.reminderList[index].title);
                                              debugPrint('${controller.addedReminderList}');
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1.5,
                                      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ).pSymmetric(v: 10, h: 15),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
