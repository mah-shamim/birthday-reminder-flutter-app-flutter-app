import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';

class SendGreetingCardPageController extends GetxController {
  RxString greeting = ''.obs;
  RxString image = ''.obs;
  RxInt index = 0.obs;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    showInterstitialAd();
    greeting.value = Get.arguments;
    super.onInit();
  }

  RxList colorList = [
    0xffFFFFFF,
    0xffFFAF8D,
    0xffFF8D8D,
    0xff8DBBFF,
    0xffA48DFF,
    0xffC68DFF,
    0xff91D052,
    0xff52D085,
    0xffC5466C,
    0xffD08C25,
    0xff429999,
    0xffD04425,
  ].obs;
}
