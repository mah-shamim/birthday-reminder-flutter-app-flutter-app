import 'package:birthday_reminder/helper/common_import.dart';
import 'package:intl/intl.dart';

class HomePageController extends GetxController {
  @override
  void onInit() {
    fetchBirthDayData(0);
    greetingsText.value = getGreetingMessage();
    super.onInit();
  }

  DateTime now = DateTime.now();
  RxString greetingsText = ''.obs;
  RxList<BirthDayListModel> birthdayList = <BirthDayListModel>[].obs;
  RxList<BirthDayListModel> sortedBirthdayList = <BirthDayListModel>[].obs;
  RxString oldString = ''.obs;

  Future<void> fetchBirthDayData(int id) async {
    birthdayList.clear();
    List<BirthDayListModel> data = await DatabaseHelper().getBirthDayData();
    birthdayList.addAll(data);
    for (var element in birthdayList) {
      debugPrint("birthdayList ==> ${element.birthDate}");
      debugPrint("Events  ==> ${element.anniversary}");
    }
    filterBirthdays();
    Get.back();
    debugPrint('------------------------ length :- ${birthdayList.length} ---------------------');
    if (id == 0) {
      Get.back();
    } else {
      Get.offAllNamed(Routes.bottomPage);
    }
  }

  String getInitials(String fullName) {
    List<String> names = fullName.trim().split(" ");
    if (names.length > 1) {
      return names[0][0].toUpperCase() + names[1][0].toUpperCase();
    } else {
      return names[0].substring(0, 2).toUpperCase();
    }
  }

  String formatDate(String dateString) {
    DateTime parsedDate = DateFormat("MMMM d, yyyy").parse(dateString);
    DateTime currentYearDate = DateTime(
      DateTime.now().year,
      parsedDate.month,
      parsedDate.day,
    );
    String formattedDate = DateFormat("MMM d, EEE").format(currentYearDate);
    return formattedDate;
  }

  void filterBirthdays() {
    sortedBirthdayList.value = birthdayList
      ..sort((a, b) {
        if (a.birthDate == null && b.birthDate == null) {
          return 0;
        } else if (a.birthDate == null) {
          return 1;
        } else if (b.birthDate == null) {
          return -1;
        }

        // Parse birthDate strings into DateTime objects
        DateFormat dateFormat = DateFormat('MMMM d, y');
        DateTime aDate = dateFormat.parse(a.birthDate!);
        DateTime bDate = dateFormat.parse(b.birthDate!);
        DateTime now = DateTime.now();

        // Remove year for comparison
        DateTime aWithoutYear = DateTime(now.year, aDate.month, aDate.day);
        DateTime bWithoutYear = DateTime(now.year, bDate.month, bDate.day);

        // Step 1: Prioritize birthdays today
        if (aWithoutYear.month == now.month && aWithoutYear.day == now.day) {
          return -1; // a comes before b
        }
        if (bWithoutYear.month == now.month && bWithoutYear.day == now.day) {
          return 1; // b comes before a
        }

        // Step 2: Prioritize upcoming birthdays (after today)
        if (aWithoutYear.isAfter(now) && bWithoutYear.isBefore(now)) {
          return -1; // a comes before b
        }
        if (bWithoutYear.isAfter(now) && aWithoutYear.isBefore(now)) {
          return 1; // b comes before a
        }
        if (aWithoutYear.isAfter(now) && bWithoutYear.isAfter(now)) {
          return aWithoutYear.compareTo(bWithoutYear); // Ascending order
        }

        // Step 3: Past birthdays (before today) in ascending order by month/day
        DateTime aNextYear = DateTime(now.year + 1, aDate.month, aDate.day);
        DateTime bNextYear = DateTime(now.year + 1, bDate.month, bDate.day);
        return aNextYear.compareTo(bNextYear);
      });

    debugPrint('Length of filter list ${sortedBirthdayList.length}');
  }

  int calculate(String dateString) {
    try {
      DateTime birthDate = DateFormat("MMMM d, yyyy").parse(dateString);
      DateTime now = DateTime.now();

      int years = now.year - birthDate.year;
      int months = (now.year - birthDate.year) * 12 + (now.month - birthDate.month);
      if (now.day < birthDate.day) {
        months--; // Adjust months if the day has not yet occurred this month
      }
      int days = now.difference(birthDate).inDays;
      if (years > 0) {
        if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
          years--;
        }
        oldString.value = 'Years old';
        return years;
      }
      if (months > 0) {
        oldString.value = 'Months old';
        return months;
      }
      oldString.value = 'Day old';
      return days;
    } catch (e) {
      return -1;
    }
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

  String getGreetingMessage() {
    final hour = now.hour;

    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 18) {
      return 'Good Afternoon!';
    } else {
      return 'Good Night!';
    }
  }

  void closeNotificationByID(int id) {
    List<PreferencesModel> canselId = [];
    List<PreferencesModel> list = Settings.preferencesList;
    canselId = list.where((element) => element.id == id).toList();
    for (var e in canselId) {
      closeNotification(e.notificationID!);
    }
    list.removeWhere((r) => r.id == id);
    Settings.savePreferencesList(list);
    debugPrint('${Settings.preferencesList.length}');
  }
}
