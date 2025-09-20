import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomePageController());
    return Obx(() {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.greetingsText.value,
                          style: customTextStyle(
                            24.sp,
                            FontWeight.bold,
                          ),
                        ),
                        Text(
                          Settings.name,
                          style: customTextStyle(
                            16.sp,
                            FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Transform.translate(
                      offset: const Offset(0, -15),
                      child: Image.asset(
                        I.congratulationsImage,
                        height: 55.w,
                      ),
                    ),
                  ],
                ),
                /* Image.asset(
                  I.filterIcon,
                  height: 30.w,
                  color: Theme.of(context).colorScheme.onPrimary,
                )*/
              ],
            ),
            SizedBox(height: 10.h),
            Center(child: showBannerAds()),
            SizedBox(height: 10.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Today, ',
                    style: customTextStyle(
                      20.sp,
                      FontWeight.w700,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  TextSpan(
                    text: DateFormat('EEE').format(controller.now).toUpperCase(), // e.g., "FRI"
                    style: customTextStyle(
                      18.sp,
                      FontWeight.w400,
                      color: blue,
                    ),
                  ),
                  TextSpan(
                    text: ' ${DateFormat('MMMM d').format(controller.now)}', // e.g., "August 16"
                    style: customTextStyle(
                      18.sp,
                      FontWeight.w400,
                      color: blue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            Expanded(
              child: RefreshIndicator(
                color: blue,
                onRefresh: () {
                  return Future.delayed(const Duration(milliseconds: 800), () async {
                    await controller.fetchBirthDayData(0);
                  });
                },
                child: Column(
                  children: [
                    Expanded(
                      child: controller.sortedBirthdayList.isEmpty
                          ? Center(
                              child: Text(
                                'No Data Found',
                                style: customTextStyle(
                                  18.sp,
                                  FontWeight.w500,
                                ),
                              ),
                            )
                          : AnimationLimiter(
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                                itemCount: controller.sortedBirthdayList.length,
                                itemBuilder: (context, index) {
                                  var birthday = controller.sortedBirthdayList[index];
                                  DateTime now = DateTime.now();
                                  DateTime currentDate = DateTime(now.year, now.month, now.day);
                                  DateTime birthdayDate = DateFormat('MMMM d, y').parse(birthday.birthDate!);
                                  DateTime isTodayBirthdayDate = DateTime(now.year, birthdayDate.month, birthdayDate.day);
                                  bool isBirthdayNextYear = isTodayBirthdayDate.isBefore(currentDate);
                                  if (isTodayBirthdayDate.isBefore(currentDate)) {
                                    isTodayBirthdayDate = DateTime(now.year + 1, birthdayDate.month, birthdayDate.day);
                                  }

                                  String currentMonthYear = "${DateFormat('MMMM').format(isTodayBirthdayDate)} ${isTodayBirthdayDate.year}";
                                  int i = 0;
                                  for (int j = 0; j < controller.sortedBirthdayList.length; j++) {
                                    DateTime birthdayDate1 = DateFormat('MMMM d, y').parse(controller.sortedBirthdayList[j].birthDate!);
                                    DateTime isTodayBirthdayDate1 = DateTime(now.year, birthdayDate1.month, birthdayDate1.day);
                                    if (currentDate != isTodayBirthdayDate1) {
                                      i = j;
                                      break;
                                    }
                                  }
                                  String previousMonthYear = index > i
                                      ? "${DateFormat('MMMM').format(DateFormat('MMMM d, y').parse(controller.sortedBirthdayList[index - 1].birthDate!))} "
                                          "${DateFormat('y').format(DateFormat('MMMM d, y').parse(controller.sortedBirthdayList[index - 1].birthDate!))}"
                                      : '';
                                  if (index > i) {
                                    DateTime prevBirthdayDate = DateFormat('MMMM d, y').parse(controller.sortedBirthdayList[index - 1].birthDate!);
                                    DateTime prevBirthdayDateAdjusted = DateTime(now.year, prevBirthdayDate.month, prevBirthdayDate.day);
                                    if (prevBirthdayDateAdjusted.isBefore(currentDate)) {
                                      prevBirthdayDateAdjusted = DateTime(now.year + 1, prevBirthdayDate.month, prevBirthdayDate.day);
                                    }
                                    previousMonthYear = "${DateFormat('MMMM').format(prevBirthdayDateAdjusted)} ${prevBirthdayDateAdjusted.year}";
                                  }
                                  bool showMonthHeader = currentMonthYear != previousMonthYear && currentDate != isTodayBirthdayDate;

                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (showMonthHeader)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                DateFormat('MMMM').format(isTodayBirthdayDate), // Display the month as the header
                                                style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              if (isBirthdayNextYear)
                                                Text(
                                                  DateFormat('y').format(isTodayBirthdayDate), // Display the month as the header
                                                  style: customTextStyle(
                                                    17.sp,
                                                    FontWeight.w400,
                                                  ),
                                                ),
                                            ],
                                          ).pOnly(top: 15),
                                        BirthdayListItem(
                                          birthday: birthday,
                                          controller: controller,
                                          isBirthDayIsNexYear: isBirthdayNextYear,
                                          index: index,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ).pSymmetric(v: 0, h: 15),
        floatingActionButton: Image.asset(
          I.floatingButton,
          height: 75.w,
        ).onTap(() async {
          Get.toNamed(Routes.addEventPage);
        }),
      );
    });
  }
}

class BirthdayListItem extends StatelessWidget {
  final BirthDayListModel birthday;
  final HomePageController controller;
  final bool isBirthDayIsNexYear;
  final int index;

  const BirthdayListItem({
    super.key,
    required this.birthday,
    required this.controller,
    required this.isBirthDayIsNexYear,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      horizontalOffset: 50,
      duration: const Duration(milliseconds: 375),
      child: FadeInAnimation(
        child: Slidable(
          endActionPane: ActionPane(
            dragDismissible: false,
            motion: const BehindMotion(),
            extentRatio: .3,
            children: [
              CustomSlidableAction(
                padding: EdgeInsets.only(top: 10.w),
                borderRadius: BorderRadius.circular(16.r),
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: (v) {
                  deleteBirthDataDialog(
                    context,
                    onTap: () async {
                      await DatabaseHelper().deleteBirthdaysData(birthday.id!);
                      controller.closeNotificationByID(birthday.id!);
                      controller.birthdayList.removeAt(index);
                      controller.birthdayList.refresh();
                      Get.back();
                    },
                  );
                },
                child: Container(
                  height: 95.w,
                  width: 95.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: const Color(0xffFF3B30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: SizedBox(height: 30.w, width: 30.w, child: Image.asset(I.deleteIcon, color: Colors.white, fit: BoxFit.cover)),
                  ),
                ),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            height: 95.w,
            decoration: BoxDecoration(
              color: birthday.anniversary == 'Birthday'
                  ? birthaEventColor.withOpacity(0.20)
                  : birthday.anniversary == 'Anniversary'
                      ? anniversaryEventColor.withOpacity(0.40)
                      : otherEventColor.withOpacity(0.40),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                                height: 60.w,
                                width: 60.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: birthday.anniversary == 'Birthday'
                                      ? const Color(0xffA1BDEE)
                                      : birthday.anniversary == 'Anniversary'
                                          ? anniversaryEventColor
                                          : otherEventColor,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                  image: birthday.image == null
                                      ? null
                                      : DecorationImage(
                                          image: MemoryImage(birthday.image!),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                child: birthday.image == null
                                    ? Text(
                                        controller.getInitials(birthday.name ?? ''),
                                        style: customTextStyle(
                                          17.sp,
                                          FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      )
                                    : null)
                            .pOnly(left: 15, right: 15),
                        Visibility(
                          visible: controller.isBirthdayIsToday(birthday.birthDate!),
                          child: Image.asset(I.heartBalloonsGif).pOnly(left: 15),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 170.w,
                          child: Text(
                            birthday.name ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: customTextStyle(
                              18.sp,
                              FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          controller.formatDate(birthday.birthDate ?? ''),
                          style: customTextStyle(
                            16.sp,
                            FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    birthday.anniversary == 'Anniversary'
                        ? RichText(
                            text: TextSpan(
                              text: birthday.year ?? '',
                              style: customTextStyle(
                                33.sp,
                                FontWeight.bold,
                                color: blue,
                              ),
                              children: [
                                WidgetSpan(
                                  child: Transform.translate(
                                    offset: const Offset(0, -20), // Adjust the position
                                    child: Text(
                                      'th',
                                      style: customTextStyle(
                                        15.sp,
                                        FontWeight.bold,
                                        color: blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            controller.calculate(birthday.birthDate!).toString(),
                            style: customTextStyle(
                              33.sp,
                              FontWeight.bold,
                              color: blue,
                            ),
                          ),
                    Text(
                      birthday.anniversary == 'Anniversary' ? 'Anniversary' : controller.oldString.value,
                      style: customTextStyle(
                        10.sp,
                        FontWeight.normal,
                        color: blue,
                      ),
                    ),
                  ],
                ),
              ],
            ).pOnly(right: 20),
          ).onTap(() {
            if (Get.isRegistered<BirthdayPageController>()) {
              Get.delete<BirthdayPageController>();
            }
            Get.toNamed(Routes.birthDayPage, arguments: {
              'birthdayModel': birthday,
              'isNextYear': isBirthDayIsNexYear,
            });
          }).pOnly(top: 10),
        ),
      ),
    );
  }
}
