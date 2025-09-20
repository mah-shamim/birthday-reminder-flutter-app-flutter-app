import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';

class SaveMyCardPageController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  var greetingsController = TextEditingController().obs;
  var isSaved = false.obs;
  @override
  void onInit() {
    showInterstitialAd();
    greetings.value = Get.arguments;
    image = Get.put(CardDetailsPageController()).card;
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    greetingsController.value = TextEditingController(text: greetings.value);
    super.onInit();
  }

  RxString image = ''.obs;
  RxString greetings = ''.obs;
  RxBool isOpen = false.obs;

  void toggleAnimation(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (animationController.isCompleted) {
      animationController.reverse();
      isOpen.value = false;
    } else {
      animationController.forward().then((value) {
        isOpen.value = true;
      });
    }
  }

  String setFontFamily() {
    switch (Settings.textStyleIndex) {
      case 0:
        return 'assets/font/Roboto-Bold.ttf';
      case 1:
        return 'assets/font/Poppins-Bold.ttf';
      case 2:
        return 'assets/font/Lato-Bold.ttf';
      case 3:
        return 'assets/font/Alegreya-Bold.ttf';
      case 4:
        return 'assets/font/Oswald-Bold.ttf';
      case 5:
        return 'assets/font/Asap_Condensed-Bold.ttf';
      case 6:
        return 'assets/font/PlayfairDisplaySC-Bold.ttf';
      case 7:
        return 'assets/font/Satisfy-Regular.ttf';
      case 8:
        return 'assets/font/Saira-Bold.ttf';
      case 9:
        return 'assets/font/KaushanScript-Regular.ttf';
      default:
        return 'assets/font/Roboto-Bold.ttf';
    }
  }

  void saveCard() {
    var data = MyCardModel(
      image: image.value,
      greetings: greetings.value,
      uid: Settings.textStyleIndex,
      fontString: setFontFamily(),
    );
    DatabaseHelper().addMyCard(data);
    showToast('Save card successfully');
    isSaved.value = true;
    // Get.offAllNamed(Routes.bottomPage);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
