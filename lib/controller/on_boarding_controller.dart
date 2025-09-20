import 'package:birthday_reminder/helper/common_import.dart';

class OnBoardingPageController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  RxInt cIndex = 0.obs;
  goToNextPage() {
    if (cIndex.value < 2) {
      cIndex.value++;
      pageController.jumpToPage(cIndex.value);
    }
  }
}
