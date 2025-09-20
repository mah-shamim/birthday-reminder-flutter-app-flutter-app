import 'package:birthday_reminder/helper/common_import.dart';
import 'package:intl/intl.dart';

class InformationPageController extends GetxController {
  RxInt i = 0.obs;
  RxInt j = 1.obs;
  RxInt gender = 3.obs;
  RxString day = ''.obs;
  RxString month = ''.obs;
  RxString year = ''.obs;
  var nameController = TextEditingController().obs;
  PageController pageController = PageController(initialPage: 0);

  goToNextPage() {
    if (i.value < 2) {
      i.value++;
      j.value++;
      pageController.jumpToPage(i.value);
    }
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: blue.withOpacity(0.7), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: blue, // body text color
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      day.value = date.day.toString().padLeft(2, '0');
      month.value = date.month.toString().padLeft(2, '0');
      year.value = date.year.toString();
      debugPrint('----------------------------- $day - $month - $year ===================================');
    }
  }

  void validation(BuildContext context) {
    switch (j.value) {
      case 1:
        if (nameController.value.text.isNotEmpty) {
          goToNextPage();
        } else {
          showAlertDialog(context, 'Alert', 'Please enter your name');
        }
        break;

      case 2:
        if (day.isNotEmpty) {
          goToNextPage();
        } else {
          showAlertDialog(context, 'Alert', 'Please enter the day');
        }
        break;

      case 3:
        if (gender.value == 1 || gender.value == 2) {
          addUserData();
        } else {
          showAlertDialog(context, 'Alert', 'Please select a gender');
        }
        break;

      default:
        showAlertDialog(context, 'Alert', 'Invalid selection');
    }
  }

  addUserData() async {
    Settings.name = nameController.value.text;
    Settings.gender = gender.value == 1 ? 'Male' : 'Female';
    Settings.birthDate = '$day/$month/$year';
    Settings.isEnter = true;
    Get.offNamed(Routes.receiveBirthDayNotificationPage);
  }

  String formattedDate() {
    String dateString = '$day/$month/$year';
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    DateTime dateTime = inputFormat.parse(dateString);
    String formattedDate = DateFormat('MMMM d, y').format(dateTime);
    return formattedDate;
  }

  int getYear() {
    String birthDateString = '$day/$month/$year';
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    DateTime birthDate = inputFormat.parse(birthDateString);
    DateTime now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
