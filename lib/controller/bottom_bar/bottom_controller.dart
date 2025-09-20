import 'package:birthday_reminder/helper/common_import.dart';

class BottomPageController extends GetxController {
  RxInt selectedIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  void onItemTapped(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}
