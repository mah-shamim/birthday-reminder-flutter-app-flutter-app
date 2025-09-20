import 'package:birthday_reminder/helper/common_import.dart';
import 'package:intl/intl.dart';

class ReminderPageController extends GetxController {
  @override
  void onInit() {
    onInitMethod();
    super.onInit();
  }

  RxBool isReminder = false.obs;
  RxList reminderList = [
    ReminderTime(
      title: 'One Day of Event',
      isTrue: false,
    ),
    ReminderTime(
      title: '1 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '2 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '3 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '4 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '5 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '6 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '7 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '8 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '9 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '10 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '11 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '12 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '13 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '14 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '15 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '16 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '17 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '18 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '19 day before & the day of',
      isTrue: false,
    ),
    ReminderTime(
      title: '20 day before & the day of',
      isTrue: false,
    ),
  ].obs;
  RxList addedReminderList = [].obs;
  RxList<ReminderModel> rList = <ReminderModel>[].obs;

  RxList<BirthDayListModel> birthdayList = <BirthDayListModel>[].obs;
  RxList<BirthDayListModel> sortedBirthdayList = <BirthDayListModel>[].obs;
  RxList birthdayDateList = [].obs;
  TimeOfDay? picked = TimeOfDay.now();
  TimeOfDay? selectedTime;
  RxInt pickedHour = DateTime.now().hour.obs;
  RxInt pickedMinute = DateTime.now().minute.obs;
  var formattedTime = ''.obs;

  Future<void> onInitMethod() async {
    fetchBirthDayData();
    await getReminder();
  }

  Future<void> selectTime(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: blue.withOpacity(0.9), // header background color
                onPrimary: Colors.white, // header text color
                onSurface: blue, // body text color
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      pickedHour.value = picked!.hour;
      pickedMinute.value = picked!.minute;
      formattedTime.value = formatTime(selectedTime!);
      Settings.scheduleTime = formattedTime.value;
    }
  }

  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final formatted = DateFormat('hh:mm a').format(
      DateTime(now.year, now.month, now.day, time.hour, time.minute),
    );
    Settings.scheduleHours = time.hour;
    Settings.scheduleMinute = time.minute;
    debugPrint('Selected Time is $formatted');
    return formatted;
  }

  void filterBirthdays() {
    DateTime currentDay = DateTime.now();
    DateTime today = DateTime(currentDay.year, currentDay.month, currentDay.day);
    sortedBirthdayList.value = birthdayList.where((birthday) {
      try {
        DateTime birthdayDate = DateFormat('MMMM d, y').parse(birthday.birthDate ?? '');
        DateTime birthdayThisYear = DateTime(today.year, birthdayDate.month, birthdayDate.day);
        return birthdayThisYear.isAtSameMomentAs(today) || birthdayThisYear.isAfter(today);
      } catch (e) {
        return false;
      }
    }).toList()
      ..sort((a, b) {
        if (a.birthDate == null && b.birthDate == null) {
          return 0;
        } else if (a.birthDate == null) {
          return 1;
        } else if (b.birthDate == null) {
          return -1;
        } else {
          DateFormat dateFormat = DateFormat('MMMM d, y');
          DateTime aDate = dateFormat.parse(a.birthDate!);
          DateTime bDate = dateFormat.parse(b.birthDate!);

          // Compare only the month and day
          int monthComparison = aDate.month.compareTo(bDate.month);
          if (monthComparison != 0) {
            return monthComparison;
          } else {
            return aDate.day.compareTo(bDate.day);
          }
        }
      });
    debugPrint('Length of filter list ${sortedBirthdayList.length}');
  }

  Future<void> fetchBirthDayData() async {
    birthdayList.clear();
    List<BirthDayListModel> data = await DatabaseHelper().getBirthDayData();
    birthdayList.addAll(data);
    filterBirthdays();
    for (var element in sortedBirthdayList) {
      /* debugPrint("birthdayList ==> ${element.birthDate}");
      debugPrint("Events  ==> ${element.anniversary}");*/

      birthdayDateList.add(element.birthDate);
    }
    debugPrint('$birthdayDateList');
  }

  // Add Reminder
  Future<void> addReminder() async {
    if (rList.isNotEmpty) {
      DatabaseHelper().deleteAllReminderData();
      debugPrint('Data deleted successfully');
    }
    debugPrint('$addedReminderList');
    await Future.wait(
      addedReminderList.map((reminder) {
        return DatabaseHelper().addReminder(
          ReminderModel(
            reminder: reminder,
            isActive: isReminder.value == true ? 1 : 0,
            reminderTime: formattedTime.value,
          ),
        );
      }),
    );
  }

  // Get Reminder
  Future<void> getReminder() async {
    rList.clear();
    List<ReminderModel> data = await DatabaseHelper().getReminder();
    rList.addAll(data);
    if (rList.isNotEmpty) {
      addedReminderList.clear();
      for (var element1 in reminderList) {
        element1.isTrue = rList.any((element) => element.reminder == element1.title);
      }
      rList.sort((a, b) {
        bool aIsSpecial = a.reminder.toString().contains('One Day of Event');
        bool bIsSpecial = b.reminder.toString().contains('One Day of Event');

        if (aIsSpecial && !bIsSpecial) return -1;
        if (!aIsSpecial && bIsSpecial) return 1;

        String aFirstPart = a.reminder.toString().split(' ')[0];
        String bFirstPart = b.reminder.toString().split(' ')[0];

        // Check if both are numeric
        if (isNumeric(aFirstPart) && isNumeric(bFirstPart)) {
          int aNum = int.parse(aFirstPart);
          int bNum = int.parse(bFirstPart);
          return aNum.compareTo(bNum);
        }

        // If non-numeric, fallback to string comparison
        return a.reminder!.compareTo(b.reminder!);
      });
      for (var element in rList) {
        addedReminderList.add(element.reminder);
        isReminder.value = element.isActive == 1 ? true : false;
        formattedTime.value = element.reminderTime ?? '';
      }
      debugPrint("Added Reminder ==> $addedReminderList");
    }
  }

  bool isNumeric(String s) {
    return int.tryParse(s) != null;
  }

  void validation(BuildContext contexts, {int i = 0}) {
    if (Settings.isNotification) {
      for (var element in sortedBirthdayList) {
        if ((element.anniversary == 'Birthday' && Settings.isBirthdayNotification) ||
            (element.anniversary == 'Anniversary' && Settings.isAnniversaryNotification) ||
            (element.anniversary == 'Other' && Settings.isOtherNotification)) {
          // setNotification(element);
          Get.back();
        } else {
          Get.back();
          i != 1 ? showAlertDialog(contexts, 'Alert', 'Please allow permission', i: 1) : null;
        }
      }
    } else {
      Get.back();
      i != 1 ? showAlertDialog(contexts, 'Alert', 'Please allow permission', i: 1) : null;
    }
  }
}
