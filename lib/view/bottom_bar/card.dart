import 'package:birthday_reminder/ads/admob_ads.dart';
import 'package:birthday_reminder/helper/common_import.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CardPageController());
    return Obx(() {
      return Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: controller.index.value == 0 ? blue : Colors.transparent,
                      border: Border.all(
                        color: controller.index.value == 0 ? Colors.transparent : blue,
                      ),
                    ),
                    child: Text(
                      'Birthday Card',
                      style: customTextStyle(
                        14.sp,
                        FontWeight.w500,
                        color: controller.index.value == 0 ? Colors.white : blue,
                      ),
                    ),
                  ).onTap(() {
                    controller.index.value = 0;
                    controller.pageController.jumpToPage(0);
                  }),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: controller.index.value == 1 ? blue : Colors.transparent,
                      border: Border.all(
                        color: controller.index.value == 1 ? Colors.transparent : blue,
                      ),
                    ),
                    child: Text(
                      'Greeting',
                      style: customTextStyle(
                        14.sp,
                        FontWeight.w500,
                        color: controller.index.value == 1 ? Colors.white : blue,
                      ),
                    ),
                  ).onTap(() {
                    controller.index.value = 1;
                    controller.pageController.jumpToPage(1);
                  }),
                ),
              ],
            ).pSymmetric(v: 15, h: 15),
            SizedBox(height: 5.h),
            Divider(
              thickness: 1.5,
              color: const Color(0xff181818).withOpacity(0.10),
            ),
            SizedBox(height: 5.h),
            showBannerAds(),
            SizedBox(height: 10.h),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                children: [
                  BirthDayCard(controller),
                  GreetingCard(controller),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

class BirthDayCard extends StatelessWidget {
  final CardPageController controller;

  const BirthDayCard(
    this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      itemCount: controller.cardList.length,
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: isTab(context) ? height(context) * 0.400 : height(context) * 0.250,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: AssetImage(
                  controller.cardList[index],
                ),
                fit: BoxFit.fill),
          ),
        ).onTap(() {
          Get.toNamed(Routes.cardDetailsPage, arguments: controller.cardList[index]);
        });
      },
    );
  }
}

class GreetingCard extends StatelessWidget {
  final CardPageController controller;

  const GreetingCard(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 45.h,
                width: 95.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: controller.greetingCardIndex.value == 0 ? blue : Colors.transparent,
                  border: Border.all(
                    color: controller.greetingCardIndex.value == 0 ? Colors.transparent : blue,
                  ),
                ),
                child: Text(
                  'Birthday',
                  style: customTextStyle(
                    14.sp,
                    FontWeight.w500,
                    color: controller.greetingCardIndex.value == 0 ? Colors.white : Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ).onTap(() {
                controller.greetingCardIndex.value = 0;
              }),
              SizedBox(width: 15.w),
              Container(
                alignment: Alignment.center,
                height: 45.h,
                width: 110.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: controller.greetingCardIndex.value == 1 ? blue : Colors.transparent,
                  border: Border.all(
                    color: controller.greetingCardIndex.value == 1 ? Colors.transparent : blue,
                  ),
                ),
                child: Text(
                  'Anniversary',
                  style: customTextStyle(
                    14.sp,
                    FontWeight.w500,
                    color: controller.greetingCardIndex.value == 1 ? Colors.white : Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ).onTap(() {
                controller.greetingCardIndex.value = 1;
              }),
              SizedBox(width: 15.w),
              Container(
                alignment: Alignment.center,
                height: 45.h,
                width: 77.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: controller.greetingCardIndex.value == 2 ? blue : Colors.transparent,
                  border: Border.all(
                    color: controller.greetingCardIndex.value == 2 ? Colors.transparent : blue,
                  ),
                ),
                child: Text(
                  'Other',
                  style: customTextStyle(
                    14.sp,
                    FontWeight.w500,
                    color: controller.greetingCardIndex.value == 2 ? Colors.white : Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ).onTap(() {
                controller.greetingCardIndex.value = 2;
              }),
            ],
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.builder(
              itemCount: controller.greetingCardIndex.value == 0
                  ? controller.birthDayGreeting.length
                  : controller.greetingCardIndex.value == 1
                      ? controller.anniversaryGreeting.length
                      : controller.othersGreeting.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 5.h,
                          width: 5.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Text(
                            controller.greetingCardIndex.value == 0
                                ? controller.birthDayGreeting[index]
                                : controller.greetingCardIndex.value == 1
                                    ? controller.anniversaryGreeting[index]
                                    : controller.othersGreeting[index],
                            style: customTextStyle(
                              14.sp,
                              FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          // color: black,
                          size: 20.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Divider(
                      thickness: 1,
                      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
                    ),
                  ],
                ).onTap(() {
                  Get.toNamed(Routes.sendGreetingCardPage,
                      arguments: controller.greetingCardIndex.value == 0
                          ? controller.birthDayGreeting[index]
                          : controller.greetingCardIndex.value == 1
                              ? controller.anniversaryGreeting[index]
                              : controller.othersGreeting[index]);
                }).pOnly(top: 15);
              },
            ),
          )
        ],
      );
    }).pSymmetric(v: 15, h: 15);
  }
}
