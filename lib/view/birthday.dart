import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';

class BirthdayPage extends GetView<BirthdayPageController> {
  const BirthdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        controller.image.value;
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: height(context) * 0.5,
                      width: width(context),
                      decoration: BoxDecoration(
                        color: controller.model.anniversary == 'Anniversary'
                            ? anniversaryEventColor
                            : controller.model.anniversary == 'Birthday'
                                ? birthaEventColor
                                : otherEventColor,
                        image: controller.imageBytes != null
                            ? DecorationImage(
                                image: MemoryImage(
                                  controller.imageBytes!,
                                ),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: width(context),
                              height: height(context) * 0.5,
                              decoration: BoxDecoration(
                                gradient: controller.imageBytes != null
                                    ? LinearGradient(
                                        colors: [
                                          const Color(0xff000000).withOpacity(0),
                                          const Color(0xff000000).withOpacity(0.40),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )
                                    : null,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 60.h),
                                  Visibility(
                                    visible: controller.imageBytes == null,
                                    child: Image.asset(
                                      I.birthday,
                                      height: 115.w,
                                    ),
                                  ),
                                  SizedBox(
                                    height: controller.imageBytes == null ? 20.h : 190.h,
                                  ),
                                  Text(
                                    controller.model.name.toString(),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: customTextStyle(
                                      20.sp,
                                      FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    controller.formatedDate(),
                                    // '22, August, 1997',
                                    style: customTextStyle(
                                      14.sp,
                                      FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    height: 40.w,
                                    width: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      'Just Turned ${controller.turned.value}',
                                      style: customTextStyle(
                                        16.sp,
                                        FontWeight.w500,
                                        color: blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ).pSymmetric(v: 15, h: 15),
                            ),
                          ),
                          Visibility(
                              visible: controller.isBirthdayIsToday(controller.model.birthDate!),
                              child: Image.asset(
                                I.heartBalloonsGif,
                              )),
                          Positioned(
                            left: 15,
                            right: 15,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 20.sp,
                                  color: Colors.white,
                                ).onTap(() {
                                  Get.back();
                                }),
                                const Spacer(),
                                Text(
                                  'Edit',
                                  style: customTextStyle(
                                    17.sp,
                                    FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ).onTap(() {
                                  controller.model.greetings = controller.addedGreetingsList.join('\n');
                                  Get.toNamed(Routes.editEventPage, arguments: controller.model);
                                })
                              ],
                            ).pOnly(top: 50),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Visibility(
                          visible: controller.model.anniversary == 'Birthday',
                          child: Column(
                            children: [
                              showBannerAds(),
                              SizedBox(height: 5.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Card',
                                  style: customTextStyle(
                                    16.sp,
                                    FontWeight.normal,
                                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.430),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Container(
                                height: 80.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xff5EC14E),
                                      Color(0xff8CCF81),
                                    ],
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      I.birthdayCardGif,
                                      height: 150.w,
                                    ),
                                    Text(
                                      'Send ${controller.model.anniversary} Card',
                                      style: customTextStyle(
                                        18.sp,
                                        FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ).onTap(() {
                                sendBottomSheet(context);
                              }),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Visibility(
                          visible: controller.addedGreetingsList.isNotEmpty,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Greeting',
                              style: customTextStyle(
                                16.sp,
                                FontWeight.normal,
                                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.330),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Visibility(
                          visible: controller.addedGreetingsList.isNotEmpty,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.primaryContainer,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.20),
                              ),
                            ),
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.addedGreetingsList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Text(
                                          controller.addedGreetingsList[index],
                                          textAlign: TextAlign.center,
                                          style: customTextStyle(
                                            16.sp,
                                            FontWeight.w500,
                                          ),
                                        ).pOnly(bottom: 5, left: 15, right: 15),
                                        Divider(
                                          thickness: 1,
                                          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
                                        )
                                      ],
                                    ).pOnly(top: 10);
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          I.copyIcon,
                                          height: 30.w,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          'Copy',
                                          style: customTextStyle(
                                            14.sp,
                                            FontWeight.normal,
                                            color: blue,
                                          ),
                                        ),
                                      ],
                                    ).onTap(() {
                                      controller.copyTextListToClipboard(context);
                                    }),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          size: 25.sp,
                                          color: blue,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          'Add More',
                                          style: customTextStyle(
                                            14.sp,
                                            FontWeight.normal,
                                            color: blue,
                                          ),
                                        ),
                                      ],
                                    ).onTap(() {
                                      Get.toNamed(Routes.greetingPage, arguments: 1);
                                    }),
                                    Row(
                                      children: [
                                        Image.asset(
                                          I.sendIcon,
                                          height: 20.w,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          'Send',
                                          style: customTextStyle(
                                            14.sp,
                                            FontWeight.normal,
                                            color: blue,
                                          ),
                                        ),
                                      ],
                                    ).onTap(() {
                                      controller.sherText(context);
                                    }),
                                  ],
                                ),
                              ],
                            ).pOnly(top: 10, bottom: 10),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Container(
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.primaryContainer,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.20),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Reminder',
                                    style: customTextStyle(
                                      16.sp,
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
                                      if (!controller.isReminder.value) {
                                        controller.deleteReminder();
                                      }
                                    },
                                  ),
                                ],
                              ).pOnly(left: 15, right: 15),
                              Visibility(
                                visible: controller.rList.isNotEmpty || controller.addedReminderList.isNotEmpty,
                                child: Divider(
                                  thickness: 1,
                                  height: 1.5,
                                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
                                ),
                              ),
                              Visibility(
                                visible: controller.rList.isNotEmpty || controller.addedReminderList.isNotEmpty,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.rList.isNotEmpty ? controller.rList.length : controller.addedReminderList.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.rList.isNotEmpty ? controller.rList[index].reminder : controller.addedReminderList[index],
                                          style: customTextStyle(
                                            16.sp,
                                            FontWeight.w500,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              controller.formattedTime.value,
                                              style: customTextStyle(
                                                16.sp,
                                                FontWeight.w500,
                                                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.30),
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 16.sp,
                                              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.30),
                                            ),
                                          ],
                                        )
                                      ],
                                    ).pOnly(left: 15, right: 10, top: 15);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 70.h),
                      ],
                    ).pSymmetric(v: 15, h: 15),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                child: Container(
                  alignment: Alignment.center,
                  height: 50.w,
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: controller.isReminder.value ? blue : blue.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle,
                        size: 25.sp,
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
                      ),
                    ],
                  ),
                ).onTap(() {
                  if (controller.model.anniversary == 'Birthday' && Settings.isBirthdayNotification ||
                      controller.model.anniversary == 'Anniversary' && Settings.isAnniversaryNotification ||
                      controller.model.anniversary == 'Other' && Settings.isOtherNotification) {
                    if (controller.isReminder.value) {
                      bottomSheet(context);
                    }
                  } else {
                    showAlertDialog(context, 'Alert', 'Please allow permission', i: 1);
                  }
                }),
              ),
            ],
          ),
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
                        if (controller.addedReminderList.isNotEmpty && controller.formattedTime.isNotEmpty) {
                          controller.addReminder().then((value) {
                            controller.getReminder(0);
                            controller.validation(context);
                          });
                        } else {
                          showAlertDialog(context, 'Alert', controller.formattedTime.isNotEmpty ? 'Please select the reminder day' : 'Please select the reminder time');
                        }
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
                                  controller.formattedTime.isEmpty ? controller.formatTime(TimeOfDay(hour: controller.now.hour, minute: controller.now.minute)) : controller.formattedTime.value,
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

  Future sendBottomSheet(BuildContext context) {
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
                          'Card',
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
                      ).onTap(() {}),
                    ),
                  ],
                ).pOnly(top: 20, right: 15, left: 15),
                Divider(
                  thickness: 1.5,
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
                ),
                /*SizedBox(height: 10.h),
                showBannerAds(),
                SizedBox(height: 10.h),*/
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    itemCount: controller.cardList.length,
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: isTab(context) ? height(context) * 0.400 : height(context) * 0.250,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(
                              controller.cardList[index],
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ).onTap(() {
                        Get.toNamed(Routes.sendCardBottomSheetPage, arguments: {
                          'image': controller.cardList[index],
                          'greetings': controller.addedGreetingsList.isEmpty ? '' : controller.addedGreetingsList[0],
                        })?.then((value) {
                          Get.back();
                        });
                      });
                    },
                  ),
                )
              ],
            );
          }),
        );
      },
    );
  }
}
