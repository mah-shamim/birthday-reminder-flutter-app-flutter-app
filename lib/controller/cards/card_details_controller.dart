import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';

class CardDetailsPageController extends GetxController {
  String image = '';
  RxString card = ''.obs;
  @override
  void onInit() {
    showInterstitialAd();
    getArgumentData();
    super.onInit();
  }

  void getArgumentData() {
    image = Get.arguments;
    if (image.isNotEmpty) {
      card.value = image;
    }
  }
}
