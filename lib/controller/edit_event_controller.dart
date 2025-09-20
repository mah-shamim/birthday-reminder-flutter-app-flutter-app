import 'dart:io';
import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';
import 'package:intl/intl.dart';

class EditEventPageController extends GetxController {
  @override
  void onInit() {
    showInterstitialAd();
    model = Get.arguments;
    getModelData();
    super.onInit();
  }

  BirthDayListModel model = BirthDayListModel();
  var nameController = TextEditingController().obs;
  var greetingsController = TextEditingController().obs;
  ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);
  // RxBool isImagePicked = false.obs;
  RxInt selectedIndex = 0.obs;
  var picker = ImagePicker();
  RxString day = ''.obs;
  RxString month = ''.obs;
  RxString year = ''.obs;
  Uint8List? imageBytes;
  var image = ''.obs;
  DateTime? birthdate;

  Future getImageFromGallery(BuildContext context) async {
    showLoadingDialog(context);
    var pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) {
      bool isToBig = getImageSize(File(pickedFile.path));
      if (!isToBig) {
        imageNotifier.value = File(pickedFile.path);
        // isImagePicked.value = pickedFile != null;
        File imageFile = File(pickedFile.path);
        imageBytes = await imageFile.readAsBytes();
        image.value = imageBytes.toString();
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
              primary: blue.withOpacity(0.7), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: blue, // body text color
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: birthdate,
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      day.value = date.day.toString().padLeft(2, '0');
      month.value = date.month.toString().padLeft(2, '0');
      year.value = date.year.toString();
      debugPrint('----------------------------- $day -> $month -> $year ===================================');
    }
  }

  void validation(BuildContext context) {
    if (nameController.value.text.isEmpty) {
      showAlertDialog(context, 'Alert', 'Please enter your name');
    } else if (day.isEmpty) {
      showAlertDialog(context, 'Alert', 'Please enter the day');
    } else {
      editProfile();
    }
  }

  Future<void> editProfile() async {
    if (selectedIndex.value != 0) {
      greetingsController.value.text = '';
    }
    if (model.name != nameController.value.text ||
        model.greetings != greetingsController.value.text ||
        model.image != imageBytes ||
        model.birthDate != formattedDate().toString()) {
      var data = BirthDayListModel(
        id: model.id,
        name: nameController.value.text,
        image: imageBytes,
        birthDate: formattedDate().toString(),
        year: getYear().toString(),
        gender: Settings.gender,
        greetings: greetingsController.value.text,
        anniversary: selectedIndex.value == 0
            ? 'Birthday'
            : selectedIndex.value == 1
                ? 'Anniversary'
                : 'Other',
      );
      DatabaseHelper().updateBirthDayData(data).then((value) {
        var controller = Get.put(HomePageController());
        controller.fetchBirthDayData(1);
      });
      debugPrint('Data Update successfully');
    } else {
      Get.back();
    }
  }

  void getModelData() {
    nameController.value = TextEditingController(text: model.name);
    greetingsController.value = TextEditingController(text: model.greetings);
    selectedIndex.value = model.anniversary == 'Birthday'
        ? 0
        : model.anniversary == 'Anniversary'
            ? 1
            : 2;
    if (model.image != null) {
      imageBytes = model.image;
      image.value = imageBytes.toString();
    }

    getDate();
  }

  void getDate() {
    DateTime birthDay = DateFormat('MMMM dd, yyyy').parse(model.birthDate.toString());
    String bDay = DateFormat('dd').format(birthDay);
    String bMonth = DateFormat('MM').format(birthDay);
    String bYear = DateFormat('y').format(birthDay);
    debugPrint('Date ------ is ->  $bDay/$bMonth/$bYear');
    birthdate = birthDay;
    day.value = bDay;
    month.value = bMonth;
    year.value = bYear;
  }

  String formattedDate() {
    String dateString = '$day/$month/$year}';
    debugPrint(' $dateString <-----ddd  mmm  yyyy');
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
