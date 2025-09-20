import 'package:birthday_reminder/helper/common_import.dart';

class AddExistingContactsPageController extends GetxController {
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
    } else if (await Permission.speech.isPermanentlyDenied) {
      openAppSettings();
    } else {
      debugPrint('Permission is denied -----------------');
    }
  }
}
