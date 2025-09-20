import 'package:birthday_reminder/helper/common_import.dart';

class DarkLightModePageController extends GetxController {
  @override
  void onInit() {
    onIntMethod();
    super.onInit();
  }

  RxList<String> modeList = <String>[
    'System Default',
    'Dark',
    'Light',
  ].obs;
  RxString selectedMode = 'System Default'.obs;

  ThemeMode themeMode = ThemeMode.system;
  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme(String mode) {
    selectedMode.value = mode;

    if (mode == 'System Default') {
      Get.changeThemeMode(ThemeMode.system);
    } else if (mode == 'Dark') {
      Get.changeThemeMode(ThemeMode.dark);
    } else if (mode == 'Light') {
      Get.changeThemeMode(ThemeMode.light);
    }
  }

  void onIntMethod() {
    if (Settings.mode.isNotEmpty) {
      selectedMode.value = Settings.mode;
    } else {
      Settings.mode = 'System Default';
    }
  }
}
