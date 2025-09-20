import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';

class MyCardDetailPageController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void onInit() {
    showInterstitialAd();
    intMethod();
    super.onInit();
  }

  RxString image = ''.obs;
  RxString text = ''.obs;
  RxString fontString = ''.obs;
  RxInt index = 0.obs;
  RxBool isOpen = false.obs;
  var greetingsController = TextEditingController().obs;

  void intMethod() {
    text.value = Get.arguments['greetings'];
    image.value = Get.arguments['image'];
    index.value = Get.arguments['index'];
    fontString.value = Get.arguments['fontString'];
    greetingsController.value = TextEditingController(text: text.value);
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

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

  TextStyle changeFontsFamilyOfTextField() {
    switch (index.value) {
      case 1:
        return GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        );
      case 2:
        return GoogleFonts.lato(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        );
      case 3:
        return GoogleFonts.alegreya(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        );
      case 4:
        return GoogleFonts.oswald(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        );
      case 5:
        return GoogleFonts.asap(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        );
      case 6:
        return GoogleFonts.playfairDisplaySc(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        );
      case 7:
        return GoogleFonts.satisfy(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        );
      case 8:
        return GoogleFonts.sairaCondensed(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        );
      case 9:
        return GoogleFonts.kaushanScript(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        );
      default:
        return GoogleFonts.roboto(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        );
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
