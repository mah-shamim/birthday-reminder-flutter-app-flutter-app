import 'package:birthday_reminder/helper/common_import.dart';

class EditCardPageController extends GetxController {
  var greetingsController = TextEditingController().obs;
  RxInt currentIndex = 0.obs;
  int maxLength = 300;
  RxInt currentLength = 0.obs;
  RxBool isDone = false.obs;
  RxList alignmentSvg = [
    I.leftAlign,
    I.centerAlign,
    I.rightAlign,
  ].obs;
  RxInt currentImageIndex = 0.obs;
  RxList googleFonts = [
    ProfileModel(images: 'roboto', title: 'Roboto'),
    ProfileModel(images: 'poppins', title: 'Poppins'),
    ProfileModel(images: 'lato', title: 'Lato'),
    ProfileModel(images: 'alegreya', title: 'Alegreya'),
    ProfileModel(images: 'oswald', title: 'Oswald'),
    ProfileModel(images: 'asap', title: 'Asap'),
    ProfileModel(images: 'playfairDisplaySc', title: 'Play'),
    ProfileModel(images: 'satisfy', title: 'Satisfy'),
    ProfileModel(images: 'sairaCondensed', title: 'Saira'),
    ProfileModel(images: 'kaushanScript', title: 'Kaushan'),
  ].obs;

  TextStyle changeFontsFamily(int index, BuildContext context) {
    switch (index) {
      case 1:
        return GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: currentIndex.value == index ? Theme.of(context).colorScheme.onPrimary : lightGreen ,
        );
      case 2:
        return GoogleFonts.lato(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: currentIndex.value == index ? Theme.of(context).colorScheme.onPrimary : lightGreen ,
        );
      case 3:
        return GoogleFonts.alegreya(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: currentIndex.value == index ? Theme.of(context).colorScheme.onPrimary : lightGreen ,
        );
      case 4:
        return GoogleFonts.oswald(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: currentIndex.value == index ? Theme.of(context).colorScheme.onPrimary : lightGreen ,
        );
      case 5:
        return GoogleFonts.asap(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: currentIndex.value == index ? Theme.of(context).colorScheme.onPrimary : lightGreen ,
        );
      case 6:
        return GoogleFonts.playfairDisplaySc(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: currentIndex.value == index ? Theme.of(context).colorScheme.onPrimary : lightGreen ,
        );
      case 7:
        return GoogleFonts.satisfy(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: currentIndex.value == index ? Theme.of(context).colorScheme.onPrimary : lightGreen ,
        );
      case 8:
        return GoogleFonts.sairaCondensed(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: currentIndex.value == index ? Theme.of(context).colorScheme.onPrimary : lightGreen ,
        );
      case 9:
        return GoogleFonts.kaushanScript(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: currentIndex.value == index ? Theme.of(context).colorScheme.onPrimary : lightGreen ,
        );
      default:
        return GoogleFonts.roboto(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: currentIndex.value == index ? Theme.of(context).colorScheme.onPrimary : lightGreen ,
        );
    }
  }

  TextStyle changeFontsFamilyOfTextField(int index) {
    switch (index) {
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
  void onInit() {
    super.onInit();
    currentImageIndex.value = Settings.textAlignment;
    greetingsController.value.addListener(_updateText);
  }

  @override
  void dispose() {
    greetingsController.value.removeListener(_updateText);
    greetingsController.value.dispose();
    super.dispose();
  }

  void _updateText() {
    final text = greetingsController.value.text;
    if (text.isNotEmpty && (!text.startsWith('" ') || !text.endsWith('"'))) {
      final newText = '" ${text.replaceAll('"', '')}"';
      greetingsController.value.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length - 1),
      );
    }
    currentLength.value = greetingsController.value.text.length;
  }

  void showNextSvg() {
    currentImageIndex.value = (currentImageIndex.value + 1) % alignmentSvg.length;
    Settings.textAlignment = currentImageIndex.value;
    debugPrint('********** $currentImageIndex ***********');
    debugPrint('********** ${Settings.textAlignment} ***********');
  }
}
