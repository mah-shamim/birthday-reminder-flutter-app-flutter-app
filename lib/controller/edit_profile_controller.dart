import 'dart:io';
import 'package:birthday_reminder/helper/common_import.dart';
import 'package:intl/intl.dart';

class EditProfilePageController extends GetxController {
  @override
  void onInit() {
    nameController.value = TextEditingController(text: Settings.name);
    getDate();
    if (Settings.data.isNotEmpty) {
      imageBytes = Settings.data;
    }
    gender.value = Settings.gender;
    super.onInit();
  }

  RxString day = ''.obs;
  RxString month = ''.obs;
  RxString year = ''.obs;
  RxString gender = ''.obs;
  DateTime? birthdate;
  Uint8List? imageBytes;
  var image = ''.obs;
  var nameController = TextEditingController().obs;
  ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);
  RxBool requestPermission = false.obs;
  var picker = ImagePicker();

  Future getImageFromGallery(int i) async {
    if (i == 1 && !requestPermission.value) {
      showToast('Please allow camera permission');
    } else {
      showLoadingDialog(Get.context!);
      var pickedFile = await picker.pickImage(source: i == 0 ? ImageSource.gallery : ImageSource.camera, imageQuality: 70);
      if (pickedFile != null) {
        bool isToBig = getImageSize(File(pickedFile.path));
        if ((!isToBig && i == 0) || i == 1) {
          imageNotifier.value = File(pickedFile.path);
          File imageFile = File(pickedFile.path);
          imageBytes = await imageFile.readAsBytes();
          image.value = imageBytes.toString();
          Get.back();
        } else {
          Get.back();
          showAlertDialog(Get.context!, 'Alert', 'Please reduce the image size then after upload the image');
        }
      } else {
        Get.back();
        debugPrint('No image selected.');
      }
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
    }
  }

  Future<void> getDate() async {
    DateTime birthDay = DateFormat('dd/MM/yyyy').parse(Settings.birthDate);
    String bDay = DateFormat('dd').format(birthDay);
    String bMonth = DateFormat('MM').format(birthDay);
    String bYear = DateFormat('y').format(birthDay);
    debugPrint('Date ------ is ->  $bDay/$bMonth/$bYear');
    birthdate = birthDay;
    day.value = bDay;
    month.value = bMonth;
    year.value = bYear;
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
    if (Settings.name != nameController.value.text || Settings.birthDate != '$day/$month/$year' || Settings.gender != gender.value || (imageBytes != null && Settings.data != imageBytes!)) {
      Settings.name = nameController.value.text;
      Settings.birthDate = '$day/$month/$year';
      Settings.gender = gender.value;
      debugPrint('User edit Data :- ${Settings.name},${Settings.birthDate}, ${Settings.gender}');
      if (imageBytes != null) {
        Settings.data = imageBytes!;
        debugPrint('Image saved successfully |||||||- - ->');
      }
      debugPrint('Edit Profile successfully |||||||- - ->');
      showToast('Update Profile successfully');
      Get.back(result: true);
    } else {
      Get.back(result: false);
    }
  }

  String getInitials() {
    if (Settings.name == null || Settings.name.trim().isEmpty) {
      return "";
    }
    List<String> names = Settings.name.trim().split(" ");
    if (names.length > 1) {
      return names[0][0].toUpperCase() + names[1][0].toUpperCase();
    } else {
      String firstName = names[0];
      return firstName.length > 1 ? firstName.substring(0, 2).toUpperCase() : firstName[0].toUpperCase();
    }
  }

  Future<bool> requestPermissions() async {
    PermissionStatus status = await Permission.camera.request();
    return status.isGranted;
  }
}
