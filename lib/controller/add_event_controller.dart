import 'dart:io';
import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';
import 'package:intl/intl.dart';

class AddEventPageController extends GetxController {
  @override
  void onInit() {
    showInterstitialAd();
    onInitMethod();
    super.onInit();
  }

  DateTime? birthDay;
  var nameController = TextEditingController().obs;
  var greetingsController = TextEditingController().obs;
  ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);

  RxBool isImagePicked = false.obs;
  var picker = ImagePicker();
  RxInt selectedIndex = 0.obs;
  RxString day = ''.obs;
  RxString month = ''.obs;
  RxString year = ''.obs;

  void onInitMethod() {
    if (Get.arguments != null) {
      var name = Get.arguments['name'];
      birthDay = Get.arguments['birthday'];
      if (Get.arguments['image'] != null) {
        imageNotifier.value = Get.arguments['image'];
        isImagePicked.value = true;
      }
      debugPrint('$birthDay--- Birth day');
      debugPrint('${Get.arguments['image']} --- Images day');
      nameController.value = TextEditingController(text: name);
      getDate();
    }
  }

  Future getImageFromGallery(BuildContext context) async {
    showLoadingDialog(context);
    var pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) {
      bool isToBig = getImageSize(File(pickedFile.path));
      if (!isToBig) {
        imageNotifier.value = File(pickedFile.path);
        debugPrint(pickedFile.path);
        isImagePicked.value = pickedFile != null;
        Get.back();
      } else {
        Get.back();
        showAlertDialog(context, 'Alert', 'Please reduce the image size then after upload the image');
      }
    } else {
      Get.back();
      debugPrint('No image selected.');
    }
  }

  bool getImageSize(File selectedImage) {
    final bytes = selectedImage.readAsBytesSync().lengthInBytes;
    final kb = bytes / 1024;
    if (kb < 3000.0) {
      debugPrint("Image is Less than 3MB");
      return false;
    } else {
      debugPrint("Image is More than 3MB...!!! $kb");
      return true;
    }
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: blue.withOpacity(0.7),
              onPrimary: Colors.white,
              onSurface: blue,
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: birthDay ?? DateTime.now(),
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
    if (nameController.value.text.isEmpty) {
      showAlertDialog(context, 'Alert', 'Please enter your name');
    } else if (day.isEmpty) {
      showAlertDialog(context, 'Alert', 'Please enter the day');
    } else {
      addBirthDayData(context);
    }
  }

  Future<void> addBirthDayData(BuildContext context) async {
    var controller = Get.put(HomePageController());
    var con = Get.put(ReminderPageController());
    if (selectedIndex.value != 0) {
      greetingsController.value.text = '';
    }
    controller.refresh();
    Uint8List? bytes;
    if (imageNotifier.value != null) {
      bytes = await imageNotifier.value!.readAsBytes();
    }
    var data = BirthDayListModel(
      name: nameController.value.text.trim(),
      birthDate: formattedDate().toString(),
      image: bytes,
      year: getYear().toString(),
      greetings: greetingsController.value.text.trim(),
      anniversary: selectedIndex.value == 0
          ? 'Birthday'
          : selectedIndex.value == 1
              ? 'Anniversary'
              : 'Other',
    );
    bool isSame = false;
    for (var element in controller.sortedBirthdayList) {
      if (element.name == data.name && element.birthDate == data.birthDate && element.anniversary == data.anniversary && element.year == data.year) {
        isSame = true;
        break;
      }
    }

    if (isSame == true) {
      showAlertDialog(context, 'Alert', 'This Data already added');
    } else {
      debugPrint('Else Part is running');
      DatabaseHelper().addBirthDayData(data).then((value) async {
        con.fetchBirthDayData().then((value) {
          con.validation(context);
        });

        await controller.fetchBirthDayData(birthDay == null ? 0 : 1);
      });
    }
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

  void getDate() {
    if (birthDay != null) {
      String bDay = DateFormat('dd').format(birthDay!);
      String bMonth = DateFormat('MM').format(birthDay!);
      String bYear = DateFormat('y').format(birthDay!);
      debugPrint('Date ------ is ->  $bDay/$bMonth/$bYear');
      day.value = bDay;
      month.value = bMonth;
      year.value = bYear;
    }
  }
}
