import 'package:birthday_reminder/helper/common_import.dart';

class PreviewCardPageController extends GetxController {
  RxString text = ''.obs;
  @override
  void onInit() {
    Get.arguments != null ? text.value = Get.arguments : null;
    super.onInit();
  }

  TextStyle changeFontsFamilyOfTextField() {
    switch (Settings.textStyleIndex) {
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
}
