import 'dart:io';

import 'package:birthday_reminder/helper/common_import.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class FromContactsPageController extends GetxController {
  List<Contact>? contacts;
  RxList<Contact> contactsList = <Contact>[].obs;
  var selectedContactName = ''.obs;
  // RxInt selectedContact = 20000.obs;
  RxList<Contact> selectedContactList = <Contact>[].obs;
  DateTime? eventBirthDay;
  File? tempImageFile;
  RxBool isAllSelect = false.obs;
  RxBool isLoading = false.obs;
  var controller = Get.put(HomePageController());
  var con = Get.put(ReminderPageController());

  @override
  void onInit() {
    contactsPermission();
    super.onInit();
  }

  Future<bool> askPermission() async {
    PermissionStatus status = await Permission.contacts.request();
    if (status.isDenied == true) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> contactsPermission() async {
    bool status = await askPermission();
    if (status == true) {
      debugPrint('Permission is granted -----------------');
      isLoading.value = true;
      showLoadingDialog(Get.context!);
      await loadContacts(true);
    } else if (await Permission.speech.isPermanentlyDenied) {
      openAppSettings();
    } else {
      debugPrint('Permission is denied -----------------');
    }
  }

  Future<bool> initMethod(int index) async {
    for (var e in controller.sortedBirthdayList) {
      if (e.name == contactsList[index].displayName) {
        return true;
      }
    }
    return false;
  }

  Future loadContacts(bool withPhotos) async {
    var contacts1 = withPhotos
        ? (await FlutterContacts.getContacts(withThumbnail: true, withProperties: true, withPhoto: true)).toList()
        : (await FlutterContacts.getContacts(withProperties: true, withPhoto: true)).toList();
    contacts = contacts1;
    debugPrint('$contacts');
    contactsList.value = contacts?.where((contact) {
          return contact.events.isNotEmpty;
        }).toList() ??
        [];
    Get.back();
    isLoading.value = false;
    debugPrint('${contactsList.length}------------------------  Length');
  }

  String getInitials(String fullName) {
    if (fullName.isEmpty || fullName.trim().isEmpty) {
      return "";
    }
    List<String> names = fullName.trim().split(" ");
    if (names.length > 1) {
      return names[0][0].toUpperCase() + names[1][0].toUpperCase();
    } else {
      String firstName = names[0];
      return firstName.length > 1 ? firstName.substring(0, 2).toUpperCase() : firstName[0].toUpperCase();
    }
  }

  Future<void> validation(BuildContext context, String name) async {
    if (selectedContactList.isEmpty) {
      showAlertDialog(context, 'Alert', 'Please Select Contact');
    } else {
      for (var element in selectedContactList) {
        if (element.displayName.isNotEmpty && (element.photoOrThumbnail != null || element.photo != null || element.thumbnail != null)) {
          DateTime now = DateTime.now();
          Uint8List imageBytes = element.photoOrThumbnail == null ? element.thumbnail! : element.photoOrThumbnail!;

          final tempDir = await getTemporaryDirectory();
          final tempFile = File('${tempDir.path}/${now.month}_${now.day}_${now.hour}_${now.minute}_${now.second}.png');
          await tempFile.writeAsBytes(imageBytes);
          tempImageFile = tempFile;
          debugPrint('$tempImageFile  ------  TempImage ');
        }
        if (element.events.isNotEmpty) {
          for (var e in element.events) {
            var birthList = e;
            DateTime birthday = DateTime(
              birthList.year ?? 0,
              birthList.month,
              birthList.day,
            );
            eventBirthDay = birthday;
            debugPrint(
              '${element.displayName} - ${e.label}: ${eventBirthDay!.toLocal()}',
            );
            var event = e;
            var date = '${event.day}/${event.month}/${event.year}';
            debugPrint('Label name Print ${event.label.name}');
            addBirthDayData(
              context,
              element.displayName,
              date,
              event.label.name.toLowerCase() == 'birthday' || event.customLabel.toLowerCase() == 'birthday'
                  ? 'Birthday'
                  : event.label.name.toLowerCase() == 'anniversary' || event.customLabel.toLowerCase() == 'anniversary'
                      ? 'Anniversary'
                      : 'Other',
              image: element.photoOrThumbnail,
            );
          }
        } else {
          debugPrint('${element.displayName} has no birthday event.');
        }
      }
      showToast(selectedContactList.length == 1 ? 'Contact add successfully' : 'Contacts add successfully');
      await controller.fetchBirthDayData(0);
    }
  }

  String formattedDate(String dateString) {
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    DateTime dateTime = inputFormat.parse(dateString);
    String formattedDate = DateFormat('MMMM d, y').format(dateTime);

    return formattedDate;
  }

  int getYear(String birthDateString) {
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    DateTime birthDate = inputFormat.parse(birthDateString);
    DateTime now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<void> addBirthDayData(BuildContext context, String name, String eventBirthDay, String event, {Uint8List? image}) async {
    controller.refresh();
    var data = image != null
        ? BirthDayListModel(
            name: name,
            birthDate: formattedDate(eventBirthDay),
            image: image,
            year: getYear(eventBirthDay).toString(),
            greetings: '',
            anniversary: event,
          )
        : BirthDayListModel(
            name: name,
            birthDate: formattedDate(eventBirthDay),
            year: getYear(eventBirthDay).toString(),
            greetings: '',
            anniversary: event,
          );
    bool isSame = false;
    for (var element in controller.sortedBirthdayList) {
      if (element.name == data.name && element.birthDate == data.birthDate && element.anniversary == data.anniversary && element.year == data.year) {
        isSame = true;
        break;
      }
    }

    if (isSame == true) {
      Get.back();
    } else {
      DatabaseHelper().addBirthDayData(data).then((value) async {
        con.fetchBirthDayData().then((value) {
          con.validation(context, i: 1);
        });
      });
    }
  }
}
