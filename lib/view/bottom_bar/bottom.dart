import 'package:birthday_reminder/helper/common_import.dart';

class BottomPage extends GetView<BottomPageController> {
  const BottomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 40.h),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                onPageChanged: (value) {
                  var cardPageController = Get.put(CardPageController());
                  cardPageController.index.value = 0;
                  cardPageController.greetingCardIndex.value = 0;
                  if (value == 1 && Get.isRegistered<CalenderPageController>()) {
                    var calenderController = Get.find<CalenderPageController>();
                    calenderController.fetchBirthDayData();
                  }
                },
                children: const [
                  HomePage(),
                  CalenderPage(),
                  CardPage(),
                  ProfilePage(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.10),
                  blurRadius: 1.3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            height: isiOSDevice() ? 85.w : 70.w,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildBottomBarItem(I.home, "Home", 0, context),
                buildBottomBarItem(I.calender, "Calender", 1, context),
                buildBottomBarItem(I.card, "Card", 2, context),
                buildBottomBarItem(I.setting, "Setting", 3, context),
              ],
            )),
      );
    });
  }

  Widget buildBottomBarItem(
    String icon,
    String label,
    int index,
    BuildContext context,
  ) {
    var isSelected = controller.selectedIndex.value == index;
    return GestureDetector(
      onTap: () {
        controller.onItemTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            height: 25.w,
            color: isSelected ? blue : Theme.of(context).colorScheme.onPrimary.withOpacity(0.20),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: customTextStyle(
              14.sp,
              FontWeight.normal,
              color: isSelected ? blue : Theme.of(context).colorScheme.onPrimary.withOpacity(0.20),
            ),
          ).pOnly(bottom: isiOSDevice() ? 10 : 0),
        ],
      ),
    );
  }
}
