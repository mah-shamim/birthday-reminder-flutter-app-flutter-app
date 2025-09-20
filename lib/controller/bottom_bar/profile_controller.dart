import 'package:birthday_reminder/helper/common_import.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePageController extends GetxController {
  @override
  void onInit() {
    name.value = Settings.name;
    if (Settings.data.isNotEmpty) {
      sImage = Settings.data;
      image.value = sImage.toString();
    }
    super.onInit();
  }

  RxString name = ''.obs;
  RxString image = ''.obs;
  Uint8List? sImage;
  RxList profileList = [
    ProfileModel(
      title: 'From Contact',
      images: I.contact,
    ),
    ProfileModel(
      title: 'My Cards',
      images: I.cardIcon,
    ),
    ProfileModel(
      title: 'Notification',
      images: I.notification,
    ),
    /* ProfileModel(
      title: 'Reminders',
      images: I.reminder,
    ),*/
    ProfileModel(
      title: 'Light And Dark Mode',
      images: I.themMode,
    ),
    ProfileModel(
      title: 'Privacy Policy',
      images: I.privacy,
    ),
    ProfileModel(
      title: 'Terms & Condition',
      images: I.termsCondition,
    ),
    ProfileModel(
      title: 'Share App',
      images: I.share,
    ),
    ProfileModel(
      title: 'Rate App',
      images: I.rateApp,
    ),
  ].obs;

  void navigation(int index, BuildContext context) {
    switch (index) {
      case 0:
        Get.toNamed(Routes.fromContactPage);
        break;
      case 1:
        Get.toNamed(Routes.myCardsPage);
        break;
      case 2:
        Get.toNamed(Routes.notificationPage);
        break;
      case 3:
        Get.toNamed(Routes.darkLightModePage);
        break;
      case 4:
        Uri url = Uri.parse('https://vocsyapp.com/Privacy%20Policy/birthdayReminder/PrivacyPolicy.php');
        launchUrl(url, mode: LaunchMode.externalApplication);
        break;
      case 5:
        Uri url = Uri.parse('https://vocsyapp.com/Privacy%20Policy/birthdayReminder/TermsConditions.php');
        launchUrl(url, mode: LaunchMode.externalApplication);
        break;
      case 6:
        Share.share('check out my website https://example.com',
            sharePositionOrigin: Rect.fromLTWH(0, 0, MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height / 2));
        break;
      case 7:
        Uri url = Uri.parse(appShare);
        launchUrl(url, mode: LaunchMode.platformDefault);
        break;
      default:
    }
  }

  String formatedDate() {
    String dateString = Settings.birthDate;
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    DateTime dateTime = inputFormat.parse(dateString);
    String formattedDate = DateFormat('MMMM d, y').format(dateTime);
    return formattedDate;
  }

  String getInitials() {
    if (Settings.name.isEmpty || Settings.name.trim().isEmpty) {
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
}
