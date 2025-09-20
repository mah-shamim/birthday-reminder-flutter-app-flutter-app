import 'dart:io';
import 'package:birthday_reminder/helper/common_import.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class BirthdayPageController extends GetxController {
  @override
  onInit() async {
    onInitMethod();
    super.onInit();
  }

  RxBool isReminder = false.obs;
  RxBool isSowGif = true.obs;
  RxBool isNexYear = false.obs;
  RxInt turned = 0.obs;
  DateTime now = DateTime.now().add(const Duration(seconds: 20));
  ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);

  Uint8List? imageBytes;
  var image = ''.obs;
  var picker = ImagePicker();
  BirthDayListModel model = BirthDayListModel();
  TimeOfDay? picked = TimeOfDay.now();
  TimeOfDay? selectedTime;
  RxInt pickedHour = DateTime.now().hour.obs;
  RxInt pickedMinute = DateTime.now().minute.obs;
  var formattedTime = ''.obs;
  RxList addedReminderList = [].obs;
  RxList<ReminderModel> rList = <ReminderModel>[].obs;
  RxList<String> addedGreetingsList = <String>[].obs;
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
  RxList cardList = [
    I.card1,
    I.card2,
    I.card3,
    I.card4,
    I.card5,
    I.card6,
    I.card7,
    I.card8,
    I.card9,
    I.card10,
    I.card11,
    I.card12,
    I.card13,
    I.card14,
    I.card15,
    I.card16,
  ].obs;
  RxString imagePath = I.birthday.obs;
  RxInt color = 0.obs;
  RxInt index = 0.obs;
  RxInt greetingCardIndex = 0.obs;

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

  Future<void> onInitMethod() async {
    model = Get.arguments['birthdayModel'];
    isNexYear.value = Get.arguments['isNextYear'];
    debugPrint('id =>>>>>>>> ${model.id} =>>>>>>>>>>>>');
    turned.value = int.parse(model.year.toString());
    turned.value++;
    if (model.image != null) {
      imageBytes = model.image;
      image.value = imageBytes.toString();
    }
    if (model.greetings!.isNotEmpty) {
      addedGreetingsList.add(model.greetings!);
    }
    imagePath.value = model.anniversary == 'Anniversary'
        ? I.anniversaryEvent
        : model.anniversary == 'Birthday'
            ? I.birthdayEvent
            : I.otherEvent;

    await getReminder(0);
  }

  Future getImageFromGallery() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageNotifier.value = File(pickedFile.path);
    } else {
      debugPrint('No image selected.');
    }
  }

  String formatedDate() {
    DateTime dateTime = DateFormat('MMMM dd, yyyy').parse(model.birthDate.toString());
    String outputDate = DateFormat('dd, MMMM, yyyy').format(dateTime);
    return outputDate;
  }

  void copyTextListToClipboard(BuildContext context) {
    if (addedGreetingsList.isNotEmpty) {
      String combinedText = addedGreetingsList.join('\n');
      Clipboard.setData(ClipboardData(text: combinedText));
      showToast('Copy Text Successfully');
      /* ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Text copied to clipboard'),
        ),
      );*/
    }
  }

  void sherText(BuildContext context) {
    if (addedGreetingsList.isNotEmpty) {
      String shareText = addedGreetingsList.join('\n');
      Share.share(shareText, sharePositionOrigin: Rect.fromLTWH(0, 0, MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height / 2));
    }
  }

  Future<void> addReminder() async {
    if (rList.isNotEmpty) {
      await DatabaseHelper().deleteRemindersData(model.id!);
      debugPrint('Data deleted successfully');
    }
    debugPrint('$addedReminderList');
    await Future.wait(
      addedReminderList.map((reminder) {
        return DatabaseHelper().addReminder(
          ReminderModel(
            uid: model.id,
            reminder: reminder,
            isActive: isReminder.value == true ? 1 : 0,
            reminderTime: formattedTime.value,
          ),
        );
      }),
    );
  }

  Future<void> deleteReminder() async {
    addedReminderList.clear();
    rList.clear();
    DatabaseHelper().deleteRemindersData(model.id!).then((value) {
      for (var item in reminderList) {
        if (item.isTrue) {
          item.isTrue = false;
        }
      }
      reminderList.refresh();
      getReminder(0);
      updatePreferencesAndCancelNotifications();
    });

    debugPrint('Data Delete successfully');
  }

  Future<void> getReminder(int i) async {
    rList.clear();
    List<ReminderModel> data = await DatabaseHelper().getAllReminder(model.id!);
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
        return a.reminder!.compareTo(b.reminder!);
      });
      for (var element in rList) {
        addedReminderList.add(element.reminder);
        isReminder.value = element.isActive == 1 ? true : false;
        formattedTime.value = element.reminderTime ?? '';
      }
      if (i == 1) {
        Get.back();
      }
    }
  }

  void validation(BuildContext context) {
    DateTime now = DateTime.now();
    if ((model.anniversary == 'Birthday' && Settings.isBirthdayNotification) ||
        (model.anniversary == 'Anniversary' && Settings.isAnniversaryNotification) ||
        (model.anniversary == 'Other' && Settings.isOtherNotification)) {
      updatePreferencesAndCancelNotifications();
      debugPrint('${picked!.hour} || ${picked!.minute}  ::::  ${now.hour} || ${now.minute} ');
      setNotification();
      Get.back();
    } else {
      Get.back();
      showAlertDialog(context, 'Alert', 'Please allow permission', i: 1);
    }
  }

  void setNotification() {
    DateTime now = DateTime.now().add(const Duration(seconds: 3));
    DateFormat inputFormat = DateFormat('MMMM d, y');
    DateTime firstDateTime = inputFormat.parse(model.birthDate!);
    // debugPrint('Hour :- ${pickedHour.value} >>>>> Minute :- ${pickedMinute.value} ');
    if (addedReminderList.isNotEmpty && now.month <= firstDateTime.month) {
      for (int i = 1; i <= 20; i++) {
        if (addedReminderList.contains('$i day before & the day of')) {
          debugPrint('Loop $i');
          setScheduleData(
            i,
            Settings.scheduleHours != 0 ? Settings.scheduleHours : pickedHour.value,
            Settings.scheduleHours != 0 ? Settings.scheduleMinute : pickedMinute.value,
            model,
          );
          setScheduleData(
            0,
            Settings.scheduleHours != 0 ? Settings.scheduleHours : pickedHour.value,
            Settings.scheduleHours != 0 ? Settings.scheduleMinute : pickedMinute.value,
            model,
          );
        }
      }
      if (addedReminderList.contains('One Day of Event')) {
        // debugPrint('Enter if parts');
        setScheduleData(
          0,
          Settings.scheduleHours != 0 ? Settings.scheduleHours : pickedHour.value,
          Settings.scheduleHours != 0 ? Settings.scheduleMinute : pickedMinute.value,
          model,
        );
      }
    } else {
      debugPrint('else part');
      setScheduleData(
        0,
        Settings.scheduleHours != 0 ? Settings.scheduleHours : pickedHour.value,
        Settings.scheduleHours != 0 ? Settings.scheduleMinute : pickedMinute.value,
        model,
      );
    }
  }

  Future<void> setScheduleData(int day, int hour, int minute, BirthDayListModel data) async {
    debugPrint('Day Subtract $day');
    debugPrint('Id -- ${data.id}');
    DateTime now = DateTime.now();
    DateFormat inputFormat = DateFormat('MMMM d, y');
    DateTime dateTime = inputFormat.parse(data.birthDate!).subtract(Duration(days: day));
    debugPrint('Date & Time ${dateTime.month} / ${dateTime.day} >> $hour:$minute');
    /*   debugPrint('user birthday //////////  ${data.birthDate} /// \n old Data ${data.toMap()} ');*/
    debugPrint('sub birthday //////////  $dateTime}');
    if (dateTime.day == now.day && picked!.minute < now.minute) {
      debugPrint('not Schedule Allow');
    } else {
      var notificationID = UniqueKey().hashCode;
      for (int j = 1; j <= 10; j++) {
        var scheduledDate = tz.TZDateTime.local(
          isNexYear.value ? now.year + 1 + j : now.year + j,
          dateTime.month,
          dateTime.day,
          hour,
          minute,
        );
        debugPrint('Scheduler Time is -> $scheduledDate');
        await zonedScheduleNotification(
          scheduledDate,
          data.anniversary == 'Anniversary'
              ? day == 0
                  ? 'Today is ${data.name}\'s Anniversary'
                  : 'Get ready to celebrate! ${data.name}\'s anniversary is just $day days away. 🎉'
              : data.anniversary == 'Other'
                  ? '${data.name}\'s Reminder is in $day day(s)! 🎉'
                  : day == 0
                      ? 'Today is ${data.name}Birthday'
                      : '${data.name}\'s birthday is just $day days away. 🎉',
          data.anniversary ?? '',
          data.id!,
          notificationID,
        );
      }
    }
  }

  bool isNumeric(String s) {
    return int.tryParse(s) != null;
  }

  bool isBirthdayIsToday(String dateString) {
    DateTime birthDate = DateFormat("MMMM d, yyyy").parse(dateString);
    DateTime now = DateTime.now();
    DateTime checkDate = DateTime(now.year, birthDate.month, birthDate.day);
    if (checkDate.month == now.month && checkDate.day == now.day) {
      return true;
    } else {
      return false;
    }
  }

  void updatePreferencesAndCancelNotifications() {
    List<PreferencesModel> canselId = [];
    List<PreferencesModel> list = Settings.preferencesList;
    canselId = list.where((element) => element.id == model.id).toList();
    for (var e in canselId) {
      closeNotification(e.notificationID!);
    }
    list.removeWhere((r) => r.id == model.id);
    Settings.savePreferencesList(list);
    debugPrint('${Settings.preferencesList.length}');
  }
}
