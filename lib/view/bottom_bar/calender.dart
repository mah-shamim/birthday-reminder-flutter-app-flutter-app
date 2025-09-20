import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CalenderPageController());
    return Obx(() {
      return Scaffold(
        body: Column(
          children: [
            showBannerAds(),
            CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
                selectedDayTextStyle: const TextStyle(color: Colors.white),
                selectedDayHighlightColor: blue,
                dayBuilder: ({required date, decoration, isDisabled, isSelected, isToday, textStyle}) {
                  DateTime now = DateTime.now();
                  final isBirthDate = controller.onlyBirthday
                      .any((birthDate) => birthDate.year <= date.year && birthDate.month == date.month && birthDate.day == date.day);
                  final isCurrentDate = date.month == now.month && date.day == now.day && date.year == now.year;
                  final isSelected = controller.selectedDates.contains(date);
                  final isSame = isSelected == isCurrentDate;

                  return GestureDetector(
                    onTap: () {
                      controller.selectedDates.value = [date];
                      controller.calenderBirthDay(date);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: isCurrentDate
                              ? isSame
                                  ? blue
                                  : null
                              : isSelected
                                  ? blue.withOpacity(0.9)
                                  : null,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isCurrentDate ? blue : Colors.transparent,
                          )),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${date.day}',
                            style: TextStyle(
                              color: isCurrentDate
                                  ? isSame
                                      ? Colors.white
                                      : null
                                  : isSelected
                                      ? Colors.white
                                      : null,
                            ),
                          ),
                          if (isBirthDate && !isSelected)
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: blue, // Dot color
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              value: controller.selectedDates,
              onValueChanged: (value) {
                controller.selectedDates.value = value;
                debugPrint('${controller.selectedDates}');
              },
            ),
            Divider(
              thickness: 1.5,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
            ),
            SizedBox(height: 10.w),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                itemCount: controller.sortedBirthdayList.length,
                itemBuilder: (context, index) {
                  var birthday = controller.sortedBirthdayList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BirthdayCalenderListItem(
                        birthday: birthday,
                        controller: controller,
                      ),
                    ],
                  );
                },
              ).pOnly(left: 15, right: 15),
            ),
          ],
        ),
      );
    });
  }
}

class BirthdayCalenderListItem extends StatelessWidget {
  final BirthDayListModel birthday;
  final CalenderPageController controller;

  const BirthdayCalenderListItem({
    super.key,
    required this.birthday,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      height: 95.w,
      decoration: BoxDecoration(
        color: birthday.anniversary == 'Birthday'
            ? birthaEventColor.withOpacity(0.20)
            : birthday.anniversary == 'Anniversary'
                ? anniversaryEventColor.withOpacity(0.30)
                : otherEventColor.withOpacity(0.20),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                      height: 60.w,
                      width: 60.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: birthday.anniversary == 'Birthday'
                            ? birthaEventColor
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
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 172.w,
                    child: Text(
                      birthday.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: customTextStyle(
                        18.sp,
                        FontWeight.bold,
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
      Get.toNamed(Routes.birthDayPage, arguments: {
        'birthdayModel': birthday,
        'isNextYear': false,
      });
    }).pOnly(top: 10);
  }
}
