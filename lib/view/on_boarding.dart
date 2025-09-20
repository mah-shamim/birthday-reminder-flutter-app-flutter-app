import 'package:birthday_reminder/helper/common_import.dart';

class OnBoardingPage extends GetView<OnBoardingPageController> {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Expanded(
              child: PageView(
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                controller: controller.pageController,
                onPageChanged: (value) {
                  controller.cIndex.value = value;
                },
                children: <Widget>[
                  customContain(
                    'Never Miss\na Birthday\nAgain',
                    'Keep track of all your important event in one app.',
                    I.boardingPage1,
                  ),
                  customContain(
                    'Get Timely\nReminders',
                    'Receive notifications before\neach event.',
                    I.boardingPage2,
                  ),
                  customContain(
                    'Create Stunning\nCards',
                    'Send customized cards instantly by\nemail or text message.',
                    I.boardingPage3,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) {
                  return Container(
                    height: 10.w,
                    width: 10.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.cIndex.value == index ? lightGreen : white,
                    ),
                  ).pOnly(right: 5);
                },
              ),
            ),
            SizedBox(height: 40.w),
            Container(
              alignment: Alignment.center,
              height: 60.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: lightGreen,
              ),
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: black,
                ),
              ),
            ).onTap(() {
              Get.offNamed(Routes.information);
            })
          ],
        ).pSymmetric(v: 15, h: 20),
      );
    });
  }

  Widget customContain(String title, String subTitle, String image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 40.sp,
            color: lightGreen,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 18.sp,
            color: white,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
