import 'package:birthday_reminder/helper/common_import.dart';
import 'package:intl/intl.dart';

class CalenderPageController extends GetxController {
  @override
  void onInit() {
    fetchBirthDayData();
    super.onInit();
  }

  DateTime now = DateTime.now();

  RxString oldString = ''.obs;
  RxList<DateTime> selectedDates = <DateTime>[].obs;
  RxList<BirthDayListModel> birthdayList = <BirthDayListModel>[].obs;
  RxList<BirthDayListModel> sortedBirthdayList = <BirthDayListModel>[].obs;
  RxList onlyBirthday = [].obs;
  RxBool isVisible = false.obs;

  Future<void> fetchBirthDayData() async {
    birthdayList.clear();
    List<BirthDayListModel> data = await DatabaseHelper().getBirthDayData();
    birthdayList.addAll(data);
    for (var element in birthdayList) {
      debugPrint("birthdayList ==> ${element.birthDate}");
      DateFormat dateFormat = DateFormat('MMMM d, y');
      DateTime aDate = dateFormat.parse(element.birthDate!);
      DateTime date = DateTime(aDate.year, aDate.month, aDate.day);
      onlyBirthday.add(date);
    }
    DateTime time = DateTime(now.year, now.month, now.day);
    selectedDates.value = [time];
    calenderBirthDay(time);
    /*debugPrint('Length of filter list $onlyBirthday');*/
    Get.back();
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
    String formattedDate = DateFormat("MMM d, EEE").format(parsedDate);
    return formattedDate;
  }

  void calenderBirthDay(DateTime date) {
    debugPrint('----------------------- $date?????????????????????');
    sortedBirthdayList.value = birthdayList.where(
      (birthday) {
        try {
          DateTime birthdayDate = DateFormat('MMMM d, y').parse(birthday.birthDate ?? '');
          DateTime currentYearBirthDay = DateTime(date.year >= birthdayDate.year ? date.year : now.year, birthdayDate.month, birthdayDate.day);
          return currentYearBirthDay == date;
        } catch (e) {
          debugPrint('Error parsing date: $e');
          return false;
        }
      },
    ).toList();
    sortedBirthdayList.refresh();
    debugPrint('Filtered List: $sortedBirthdayList');
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
}
