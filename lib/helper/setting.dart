import 'dart:convert';
import 'package:birthday_reminder/helper/common_import.dart';

class Settings {
  static Future<SharedPreferences> get _instance async => _prefInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefInstance;
  static Future<SharedPreferences?> init() async {
    _prefInstance = await _instance;
    return _prefInstance;
  }

  static Future<void> clear() async {
    await _prefInstance?.clear();
  }

  static bool get isEnter => _prefInstance?.getBool('isEnter') ?? false;
  static set isEnter(bool value) {
    _prefInstance?.setBool('isEnter', value);
  }

  static int get id => _prefInstance?.getInt('id') ?? 0;
  static set id(int value) {
    _prefInstance?.setInt('id', value);
  }

  static bool get isSkip => _prefInstance?.getBool('isSkip') ?? false;
  static set isSkip(bool value) {
    _prefInstance?.setBool('isSkip', value);
  }

  static String get name => _prefInstance?.getString('name') ?? '';
  static set name(String value) {
    _prefInstance?.setString('name', value);
  }

  static String get gender => _prefInstance?.getString('gender') ?? '';
  static set gender(String value) {
    _prefInstance?.setString('gender', value);
  }

  static String get birthDate => _prefInstance?.getString('birthDate') ?? '';
  static set birthDate(String value) {
    _prefInstance?.setString('birthDate', value);
  }

  static String get selectedLanguageCode => _prefInstance?.getString('selectedLanguageCode') ?? '';
  static set selectedLanguageCode(String value) {
    _prefInstance?.setString('selectedLanguageCode', value);
  }

  static String get selectedLanguageCountryCode => _prefInstance?.getString('selectedLanguageCountryCode') ?? '';
  static set selectedLanguageCountryCode(String value) {
    _prefInstance?.setString('selectedLanguageCountryCode', value);
  }

  static int get selectedLanguageIndex => _prefInstance?.getInt('selectedLanguageIndex') ?? 1;
  static set selectedLanguageIndex(int value) {
    _prefInstance?.setInt('selectedLanguageIndex', value);
  }

  static bool get isStorage => _prefInstance?.getBool('isStorage') ?? false;
  static set isStorage(bool value) {
    _prefInstance?.setBool('isStorage', value);
  }

  static Uint8List get data {
    final base64String = _prefInstance?.getString('data') ?? '';
    return base64String.isEmpty ? Uint8List(0) : base64.decode(base64String);
  }

  static set data(Uint8List value) {
    final base64String = base64.encode(value);
    _prefInstance?.setString('data', base64String);
  }

  static String get fcmToken => _prefInstance?.getString('fcmToken') ?? '';
  static set fcmToken(String value) {
    _prefInstance?.setString('fcmToken', value);
  }

  static String get mode => _prefInstance?.getString('mode') ?? '';
  static set mode(String value) {
    _prefInstance?.setString('mode', value);
  }

  static bool get isNotification => _prefInstance?.getBool('isNotification') ?? false;
  static set isNotification(bool value) {
    _prefInstance?.setBool('isNotification', value);
  }

  static bool get isBirthdayNotification => _prefInstance?.getBool('isBirthdayNotification') ?? false;
  static set isBirthdayNotification(bool value) {
    _prefInstance?.setBool('isBirthdayNotification', value);
  }

  static bool get isAnniversaryNotification => _prefInstance?.getBool('isAnniversaryNotification') ?? false;
  static set isAnniversaryNotification(bool value) {
    _prefInstance?.setBool('isAnniversaryNotification', value);
  }

  static bool get isOtherNotification => _prefInstance?.getBool('isOtherNotification') ?? false;
  static set isOtherNotification(bool value) {
    _prefInstance?.setBool('isOtherNotification', value);
  }

  static String get scheduleTime => _prefInstance?.getString('scheduleTime') ?? '';
  static set scheduleTime(String value) {
    _prefInstance?.setString('scheduleTime', value);
  }

  static int get scheduleHours => _prefInstance?.getInt('scheduleHours') ?? 1;
  static set scheduleHours(int value) {
    _prefInstance?.setInt('scheduleHours', value);
  }

  static int get scheduleMinute => _prefInstance?.getInt('scheduleMinute') ?? 1;
  static set scheduleMinute(int value) {
    _prefInstance?.setInt('scheduleMinute', value);
  }

  static int get textAlignment => _prefInstance?.getInt('textAlignment') ?? 1;
  static set textAlignment(int value) {
    _prefInstance?.setInt('textAlignment', value);
  }

  static int get textStyleIndex => _prefInstance?.getInt('textStyleIndex') ?? 1;
  static set textStyleIndex(int value) {
    _prefInstance?.setInt('textStyleIndex', value);
  }

  static Future<void> savePreferencesList(List<PreferencesModel> models) async {
    String jsonString = jsonEncode(models.map((model) => model.toMap()).toList());
    await _prefInstance?.setString('preferencesList', jsonString);
  }

  // Get PreferencesModel List
  static List<PreferencesModel> get preferencesList {
    String? jsonString = _prefInstance?.getString('preferencesList');
    if (jsonString != null) {
      List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((item) => PreferencesModel.fromJson(item)).toList();
    }
    return [];
  }
}
